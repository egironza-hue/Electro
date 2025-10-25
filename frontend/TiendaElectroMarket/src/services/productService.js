

// ===========================================================
// === FUNCIONES COMUNES DE FILTRADO =========================
// ===========================================================
function filtrarProductos(productos, { marcas = [], min = 0, max = Number.MAX_SAFE_INTEGER, disponible = false, q = "" } = {}) {
  const query = q.trim().toLowerCase();
  return productos.filter(p => {
    if (marcas.length && !marcas.includes(p.marca)) return false;
    if (p.precio < min || p.precio > max) return false;
    if (disponible && p.stock <= 0) return false;
    if (query && !(p.nombre.toLowerCase().includes(query) || p.marca.toLowerCase().includes(query))) return false;
    return true;
  });
}

// ===========================================================
// === MICROCONTROLADORES ====================================
// ===========================================================
export async function obtenerMarcasMicro() {
  return Array.from(new Set(MICRO.map(p => p.marca)));
}

export async function buscarMicrocontroladores(filtro) {
  return filtrarProductos(MICRO, filtro);
}

// ===========================================================
// === SENSORES ==============================================
// ===========================================================
export async function obtenerMarcasSensores() {
  return Array.from(new Set(SENSORES.map(p => p.marca)));
}

export async function buscarSensores(filtro) {
  return filtrarProductos(SENSORES, filtro);
}

// ===========================================================
// === ACTUADORES ============================================
// ===========================================================
export async function obtenerMarcasActuadores() {
  return Array.from(new Set(ACTUADORES.map(p => p.marca)));
}

export async function buscarActuadores(filtro) {
  return filtrarProductos(ACTUADORES, filtro);
}


const API_URL = "http://localhost:3000"; // cambia si usas otro puerto o dominio


const construirQueryString = (filtros) => {
    const params = new URLSearchParams();

    // 1. Categoria (Obligatoria)
    if (filtros.categoria) {
        params.append('categoria', filtros.categoria);
    }

    // 2. Marcas (Si hay más de una, la API debe manejarlas como un array)
    // Usaremos el formato ?marcas=A&marcas=B
    if (filtros.marcas && filtros.marcas.length > 0) {
        const marcasString = filtros.marcas.join(',');
        params.append('marcas', marcasString);
    }
    const subcategoriaValor = filtros.subcategoria ? filtros.subcategoria.trim() : null;
    if (subcategoriaValor) params.append('subcategoria', subcategoriaValor);
    // 3. Rango de Precio
    if (filtros.min) {
        params.append('precioMin', filtros.min);
    }
    if (filtros.max) {
        params.append('precioMax', filtros.max);
    }

    // 4. Búsqueda de texto (q)
    if (filtros.q) {
        params.append('texto', filtros.q);
    }

    // 5. Disponibilidad
    if (filtros.disponible === true) {
        params.append('disponible', 'true');
    }
    
    return params.toString();
};
// 🔹 Obtener productos por categoría
export async function buscarProductos(filtros, categoria) {
  try {
    const todosFiltros ={... filtros, categoria};
    const queryString = construirQueryString(todosFiltros);
    const url = `${API_URL}/productos/buscar?${queryString}`;
    const res = await fetch(url);
    if (!res.ok) console.log(`Error al obtener productos de ${categoria}`);
    const data = await res.json();
    console.log("➡️ Fetching URL:", url);
    console.log("✅ Productos por categoría:", data);
    return data;
  } catch (error) {
    console.error("❌ Error buscando productos por categoría:", error);
    return [];
  }
}


// 🔹 Obtener producto por ID
export async function obtenerProductoPorId(id) {
  try {
    const res = await fetch(`${API_URL}/productos/${id}`);

    if (!res.ok) {
      if (res.status === 404) return null;
      throw new Error(`Error al obtener producto: ${res.status}`);
    }

    const data = await res.json();
    return data;
  } catch (error) {
    console.error("❌ Error buscando producto por ID:", error);
    return null;
  }
}

// 🔹 Obtener marcas disponibles desde backend

export  async function obtenerFiltrosDisponibles(categoria){
  try
  {
    console.log("➡️ Obteniendo filtros disponibles para categoría: api", categoria);
    const res = await fetch(`${API_URL}/productos/buscar/filtros/${categoria}`);
    if (!res.ok) throw new Error("Error al obtener filtros disponibles");
    const data = await res.json();
    console.log("✅ Filtros disponibles obtenidos:", data);
    return data;
  }catch(error){
    console.error("❌ Error obteniendo filtros disponibles:", error);
    return {
      marcas: [],
      rangoPrecio: {
        min: "0",
        max: "0"
    }
    };
  } 
} 
export async function obtenerTodos(){
  try
  {
    console.log("Obteniendo todos los productos");
    const res = await fetch(`${API_URL}/productos/`);
    if (!res.ok) throw new Error("Error al obtener filtros disponibles");
    const data = await res.json();
    console.log("✅ Filtros disponibles obtenidos:", data);
    return data;
  }catch(error){
    console.error("❌ Error obteniendo filtros disponibles:", error);
    return [];
  } 
}

export async function borrarProducto(id) {
  try {
    const res = await fetch(`${API_URL}/productos/Borrar/${id}`, {
      method: "DELETE"
    });
    if (!res.ok) throw new Error("Error borrando producto");
    return await res.json();
  } catch (error) {
    console.error(error);
    return null;
  }
}
export async function actualizarProducto(id, producto) {
  try {
    const res = await fetch(`${API_URL}/productos/editar/${id}`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(producto),
    });
    if (!res.ok) throw new Error("Error al actualizar producto");
    return await res.json();
  } catch (error) {
    console.error(error);
    return null;
  }
}
export async function crearProducto(producto) {
  try {
    const res = await fetch(`${API_URL}/productos/crear`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(producto),
    });
    if (!res.ok) throw new Error("Error al crear producto");
    return await res.json();
  } catch (error) {
    console.error("❌ Error creando producto:", error);
    throw error;
  }
}

