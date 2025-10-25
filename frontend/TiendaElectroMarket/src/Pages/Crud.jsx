import { useEffect, useState, useMemo } from "react";
import Navbar from "../components/layout/Navbar";
import Footer from "../components/layout/Footer";
import { obtenerTodos, borrarProducto } from "../services/productService";
import { useNavigate } from "react-router-dom";

const Crud = () => {
  const [productos, setProductos] = useState([]);
  const [cargando, setCargando] = useState(false);
  const nf = useMemo(() => new Intl.NumberFormat("es-CO"), []);
  const navigate = useNavigate();

  // Cargar todos los productos desde la DB
  useEffect(() => {
    const fetchProductos = async () => {
      setCargando(true);
      const data = await obtenerTodos(); // Debes tener este endpoint en tu service
      setProductos(data);
      setCargando(false);
    };
    fetchProductos();
  }, []);

  // Función para borrar producto
  const handleBorrar = async (id) => {
    if (window.confirm("¿Estás seguro de borrar este producto?")) {
      await borrarProducto(id); // Endpoint para borrar
      setProductos((prev) => prev.filter((p) => p.id !== id));
    }
  };

  return (
    <div className="min-h-screen text-white bg-gray-900">

      <div className="max-w-7xl mx-auto px-5 py-8">
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-3xl font-extrabold">Administración de Productos</h1>
          <button
            onClick={() => navigate("/productos/crear")}
            className="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded"
          >
            Crear Producto
          </button>
        </div>

        {cargando ? (
          <p>Cargando productos...</p>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {productos.map((producto) => (
              <div
                key={producto.id}
                className="bg-gray-800 p-4 rounded shadow flex flex-col justify-between"
              >
                <div>
                  <h2 className="text-xl font-bold">{producto.nombre}</h2>
                  <p className="text-gray-300">{producto.descripcion}</p>
                  <p className="mt-2 font-semibold">
                    Precio: {nf.format(producto.precio)}
                  </p>
                  <p className="text-gray-400">
                    Categoria: {producto.categoria} / {producto.subcategoria}
                  </p>
                </div>

                <div className="mt-4 flex gap-2">
                  <button
                    onClick={() => navigate(`/productos/editar/${producto.id}`)}
                    className="bg-yellow-500 hover:bg-yellow-600 text-white px-3 py-1 rounded"
                  >
                    Editar
                  </button>
                  <button
                    onClick={() => handleBorrar(producto.id)}
                    className="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded"
                  >
                    Borrar
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      <Footer />
    </div>
  );
};

export default Crud;
