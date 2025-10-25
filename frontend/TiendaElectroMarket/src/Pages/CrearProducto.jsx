import { useState } from "react";
import { useNavigate } from "react-router-dom";
import Navbar from "../components/layout/Navbar";
import Footer from "../components/layout/Footer";
import { crearProducto } from "../services/productService";

const CrearProducto = () => {
  const navigate = useNavigate();
  const [producto, setProducto] = useState({
    nombre: "",
    descripcion: "",
    precio: 0,
    stock: 0,
    disponible: false,
    imagen_url: "",
    destacado: false,
    fecha_creacion: "",
    fecha_actualizacion: "",
    especificaciones: "",
    detalle_extenso: "",
    marca_id: "",
    subcategoria_id: "",
  });

  const [error, setError] = useState(null);

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setProducto((prev) => ({
      ...prev,
      [name]: type === "checkbox" ? checked : value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const datosParaCrear = {
        ...producto,
        precio: parseFloat(producto.precio),
        stock: parseInt(producto.stock),
        marca_id: parseInt(producto.marca_id),
        subcategoria_id: parseInt(producto.subcategoria_id),
        disponible: !!producto.disponible,
        destacado: !!producto.destacado,
      };
      await crearProducto(datosParaCrear);
      alert("Producto creado correctamente");
      navigate("/crud"); // Volver al listado
    } catch (err) {
      console.error(err);
      setError("Error al crear producto");
    }
  };

  return (
    <div className="min-h-screen bg-gray-900 text-white">
      <div className="max-w-3xl mx-auto px-5 py-8">
        <h1 className="text-3xl font-bold mb-6">Crear Producto</h1>
        {error && <p className="text-red-500">{error}</p>}
        <form onSubmit={handleSubmit} className="grid gap-4">
          <input
            type="text"
            name="nombre"
            value={producto.nombre}
            onChange={handleChange}
            placeholder="Nombre"
            className="p-2 rounded bg-gray-800"
            required
          />
          <textarea
            name="descripcion"
            value={producto.descripcion}
            onChange={handleChange}
            placeholder="Descripción"
            className="p-2 rounded bg-gray-800"
          />
          <input
            type="number"
            name="precio"
            value={producto.precio}
            onChange={handleChange}
            placeholder="Precio"
            className="p-2 rounded bg-gray-800"
          />
          <input
            type="number"
            name="stock"
            value={producto.stock}
            onChange={handleChange}
            placeholder="Stock"
            className="p-2 rounded bg-gray-800"
          />
          <label className="flex items-center gap-2">
            <input
              type="checkbox"
              name="disponible"
              checked={producto.disponible}
              onChange={handleChange}
            />
            Disponible
          </label>
          <input
            type="text"
            name="imagen_url"
            value={producto.imagen_url}
            onChange={handleChange}
            placeholder="URL de imagen"
            className="p-2 rounded bg-gray-800"
          />
          <label className="flex items-center gap-2">
            <input
              type="checkbox"
              name="destacado"
              checked={producto.destacado}
              onChange={handleChange}
            />
            Destacado
          </label>
          <input
            type="date"
            name="fecha_creacion"
            value={producto.fecha_creacion}
            onChange={handleChange}
            className="p-2 rounded bg-gray-800"
          />
          <input
            type="date"
            name="fecha_actualizacion"
            value={producto.fecha_actualizacion}
            onChange={handleChange}
            className="p-2 rounded bg-gray-800"
          />
          <textarea
            name="especificaciones"
            value={producto.especificaciones}
            onChange={handleChange}
            placeholder="Especificaciones"
            className="p-2 rounded bg-gray-800"
          />
          <textarea
            name="detalle_extenso"
            value={producto.detalle_extenso}
            onChange={handleChange}
            placeholder="Detalle Extenso"
            className="p-2 rounded bg-gray-800"
          />
          <input
            type="number"
            name="marca_id"
            value={producto.marca_id}
            onChange={handleChange}
            placeholder="ID Marca"
            className="p-2 rounded bg-gray-800"
          />
          <input
            type="number"
            name="subcategoria_id"
            value={producto.subcategoria_id}
            onChange={handleChange}
            placeholder="ID Subcategoría"
            className="p-2 rounded bg-gray-800"
          />
          <button
            type="submit"
            className="bg-green-500 hover:bg-green-600 px-4 py-2 rounded"
          >
            Crear Producto
          </button>
        </form>
      </div>
      <Footer />
    </div>
  );
};

export default CrearProducto;
