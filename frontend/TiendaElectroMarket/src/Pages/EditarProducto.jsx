import { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router-dom";
import Navbar from "../components/layout/Navbar";
import Footer from "../components/layout/Footer";
import { obtenerProductoPorId, actualizarProducto } from "../services/productService";

const EditarProducto = () => {
  const { id } = useParams();
  const navigate = useNavigate();

  const [producto, setProducto] = useState(null);
  const [cargando, setCargando] = useState(true);
  const [error, setError] = useState(null);

  // Obtener producto al cargar
  useEffect(() => {
    const fetchProducto = async () => {
      try {
        const data = await obtenerProductoPorId(id);
        setProducto(data);
      } catch (err) {
        setError("Error al cargar el producto");
      } finally {
        setCargando(false);
      }
    };
    fetchProducto();
  }, [id]);

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setProducto((prev) => ({
      ...prev,
      [name]: type === "checkbox" ? checked : value
    }));
  };

 const handleSubmit = async (e) => {
  e.preventDefault();
  try {
    const datosParaActualizar = {
      ...producto,
      precio: parseFloat(producto.precio),
      stock: parseInt(producto.stock),
      marca_id: parseInt(producto.marca_id),
      subcategoria_id: parseInt(producto.subcategoria_id),
      disponible: !!producto.disponible,
      destacado: !!producto.destacado
    };
    await actualizarProducto(id, datosParaActualizar);
    alert("Producto actualizado correctamente");
    navigate("/crud");
  } catch (err) {
    alert("Error al actualizar producto");
    console.error(err);
  }
};


  if (cargando) return <p>Cargando...</p>;
  if (error) return <p>{error}</p>;
  if (!producto) return <p>Producto no encontrado</p>;

  return (
    <div className="min-h-screen bg-gray-900 text-white">
      <div className="max-w-3xl mx-auto px-5 py-8">
        <h1 className="text-3xl font-bold mb-6">Editar Producto</h1>
        <form onSubmit={handleSubmit} className="grid gap-4">
          <input
            type="text"
            name="nombre"
            value={producto.nombre || ""}
            onChange={handleChange}
            placeholder="Nombre"
            className="p-2 rounded bg-gray-800"
          />
          <textarea
            name="descripcion"
            value={producto.descripcion || ""}
            onChange={handleChange}
            placeholder="Descripción"
            className="p-2 rounded bg-gray-800"
          />
          <input
            type="number"
            name="precio"
            value={producto.precio || 0}
            onChange={handleChange}
            placeholder="Precio"
            className="p-2 rounded bg-gray-800"
          />
          <input
            type="number"
            name="stock"
            value={producto.stock || 0}
            onChange={handleChange}
            placeholder="Stock"
            className="p-2 rounded bg-gray-800"
          />
          <label className="flex items-center gap-2">
            <input
              type="checkbox"
              name="disponible"
              checked={producto.disponible || false}
              onChange={handleChange}
            />
            Disponible
          </label>
          <input
            type="text"
            name="imagen_url"
            value={producto.imagen_url || ""}
            onChange={handleChange}
            placeholder="URL de imagen"
            className="p-2 rounded bg-gray-800"
          />
          <label className="flex items-center gap-2">
            <input
              type="checkbox"
              name="destacado"
              checked={producto.destacado || false}
              onChange={handleChange}
            />
            Destacado
          </label>
          <input
            type="date"
            name="fecha_creacion"
            value={producto.fecha_creacion?.split("T")[0] || ""}
            onChange={handleChange}
            className="p-2 rounded bg-gray-800"
          />
          <input
            type="date"
            name="fecha_actualizacion"
            value={producto.fecha_actualizacion?.split("T")[0] || ""}
            onChange={handleChange}
            className="p-2 rounded bg-gray-800"
          />
          <textarea
            name="especificaciones"
            value={producto.especificaciones || ""}
            onChange={handleChange}
            placeholder="Especificaciones"
            className="p-2 rounded bg-gray-800"
          />
          <textarea
            name="detalle_extenso"
            value={producto.detalle_extenso || ""}
            onChange={handleChange}
            placeholder="Detalle Extenso"
            className="p-2 rounded bg-gray-800"
          />
          <input
            type="number"
            name="marca_id"
            value={producto.marca_id || ""}
            onChange={handleChange}
            placeholder="ID Marca"
            className="p-2 rounded bg-gray-800"
          />
          <input
            type="number"
            name="subcategoria_id"
            value={producto.subcategoria_id || ""}
            onChange={handleChange}
            placeholder="ID Subcategoría"
            className="p-2 rounded bg-gray-800"
          />
          <button
            type="submit"
            className="bg-blue-500 hover:bg-blue-600 px-4 py-2 rounded"
          >
            Guardar Cambios
          </button>
        </form>
      </div>
      <Footer />
    </div>
  );
};

export default EditarProducto;
