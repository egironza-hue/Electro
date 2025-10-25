import NavLink from "./NavLink";
import DropdownMenu from "./DropdownMenu";
import { useAuth } from '../../context/AuthContext';


const NavLinks = () => {
  let activo;
  const { user } = useAuth();
  if(user?.tipo === 'admin'){
     activo = false;
  }
  else{
     activo = true;
  }
  
  const links = [
  { label: "HOME", path: "/" },
  { label: "PRODUCTOS", isDropdown: activo,path: "/CRUD"}, // Aquí
  { label: "CONTACTO", path: "/contacto" },
  { label: "SOBRE NOSOTROS", path: "/about" },
];
if(activo === false){
{links.map(link =>
  link.isDropdown ? (
    // Aquí agregamos un Link que envuelva al botón
    <Link key={link.label} to={link.path}>
      <DropdownMenu label={link.label} />
    </Link>
  ) : (
    <NavLink key={link.path} {...link} />
  )
)}
}
return (
  <div className="flex-1 hidden  xl:flex pl-50 h-full gap-30 items-center " >
    {links.map(link =>
      link.isDropdown ? (
        <DropdownMenu key={link.label} label={link.label} />
      ) : (
        <NavLink key={link.path} {...link} />
      )
    )}
    
  </div>
);

};

export default NavLinks;
