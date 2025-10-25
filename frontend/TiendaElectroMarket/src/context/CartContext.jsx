//   import { createContext, useContext, useState, useEffect } from "react";
//   import CarritoApiService from '../services/carritoService'; // ⬅️ Usando el nuevo servicio

//   const CartContext = createContext(null);
//   export const useCart = () => useContext(CartContext);

//   export const CartProvider = ({ children }) => {
//       const [cartItems, setCartItems] = useState([]);
//       const [subtotal, setSubtotal] = useState(0);
//       const [totalItems, setTotalItems] = useState(0);
//       const [limiteAlcanzado, setlimiteAlcanzado] = useState(false);
//       const [loading, setLoading] = useState(false);
      
//       // --- FUNCIÓN CENTRAL PARA OBTENER EL CARRITO DE LA API ---
//       const fetchCart = async () => {
//           setLoading(true);
//           try {
//               const data = await CarritoApiService.obtenerCarrito(); 
              
//               setCartItems(data.items || []);
//               setSubtotal(data.total ? parseFloat(data.total) : 0);
//               setTotalItems(data.items.reduce((sum, item) => sum + item.cantidad, 0));
//           } catch (error) {
//               console.error("Error al obtener el carrito de la API:", error);
//               // Esto sucede si el carrito está vacío o hay un error de red
//               setCartItems([]);
//               setSubtotal(0);
//               setTotalItems(0);
//           } finally {
//               setLoading(false);
//           }
//       };

//       // 1. Efecto Inicial: Obtener el carrito de la API al cargar.
//       useEffect(() => {
//           fetchCart();
//       }, []); 

//       // --- FUNCIÓN DE AYUDA PARA MANEJAR RESPUESTAS DE API ---
//       const handleApiResponse = async (promise) => {
//           setLoading(true);
//           try {
//               const data = await promise;
              
//               // Actualizar el estado con los datos devueltos por la API
//               if (data.limiteAlcanzado)
//               {
//                     setlimiteAlcanzado(true);
//                     return { success: false, error: data.message || "Límite de stock alcanzado." };
//               }else{

//                   setlimiteAlcanzado(false);
//               }
//               setCartItems(data.items || []);
//               setSubtotal(data.total ? parseFloat(data.total) : 0);
//               setTotalItems(data.items.reduce((sum, item) => sum + item.cantidad, 0));
//               console.log("data.limiteAlcanzado",data.limiteAlcanzado);
              
//               return { success: true, message: data.message || "Operación exitosa." };
//           } catch (error) {
//               console.error("Error de API en el carrito:", error);
              
//               // Si el error contiene datos de respuesta (del backend) y es un 400 (ej: stock)
//               if (error.response && error.response.status === 400) {
//                   if (error.response.data.error.includes("Stock")) {
//                       setlimiteAlcanzado(true);
//                   }
//                   return { success: false, error: error.response.data.error };
//               }
              
//               return { success: false, error: error.message || "Error desconocido del carrito." };
//           } finally {
//               setLoading(false);
//           }
//       };

//       // --- FUNCIONES QUE LLAMAN A LA API ---

//       const addToCart = async (producto, cantidad = 1) => {
//           // Solo enviar ID y cantidad, la lógica de precio/stock es del backend
//           return handleApiResponse(
//               CarritoApiService.agregarItem(producto.id, cantidad)
//           );
//       };

//       const removeFromCart = async (productoId) => {
//           return handleApiResponse(
//               CarritoApiService.eliminarItem(productoId)
//           );
//       };

//       const updateQuantity = async (productoId, cantidad) => {
//           if (cantidad < 1) {
//               return removeFromCart(productoId);
//           }
          
//           return handleApiResponse(
//               CarritoApiService.actualizarCantidad(productoId, cantidad)
//           );
//       };

//       return (
//           <CartContext.Provider
//               value={{
//                   cartItems,
//                   addToCart,
//                   removeFromCart,
//                   updateQuantity,
//                   totalItems,
//                   subtotal,
//                   limiteAlcanzado,
//                   setlimiteAlcanzado,
//                   loading, 
//                   fetchCart,
//               }}
//           >
//               {children}
//           </CartContext.Provider>
//       );
//   };
import { createContext, useContext, useState, useEffect } from "react";
import CarritoApiService from "../services/carritoService";

const CartContext = createContext(null);
export const useCart = () => useContext(CartContext);

export const CartProvider = ({ children }) => {
  const [cartItems, setCartItems] = useState(() => {
    // 🔹 Cargar carrito desde localStorage al iniciar
    const stored = localStorage.getItem("cart");
    return stored ? JSON.parse(stored) : [];
  });

  const [subtotal, setSubtotal] = useState(0);
  const [totalItems, setTotalItems] = useState(0);
  const [limiteAlcanzado, setlimiteAlcanzado] = useState(false);
  const [loading, setLoading] = useState(false);

  // --- FUNCIÓN CENTRAL PARA OBTENER EL CARRITO DE LA API ---
  const fetchCart = async () => {
    setLoading(true);
    try {
      const data = await CarritoApiService.obtenerCarrito();

      const items = data.items || [];
      const total = data.total ? parseFloat(data.total) : 0;
      const count = items.reduce((sum, item) => sum + item.cantidad, 0);

      setCartItems(items);
      setSubtotal(total);
      setTotalItems(count);

      // 🔹 Guardar también en localStorage
      localStorage.setItem("cart", JSON.stringify(items));
      localStorage.setItem("subtotal", total);
    } catch (error) {
      console.error("Error al obtener el carrito de la API:", error);
      setCartItems([]);
      setSubtotal(0);
      setTotalItems(0);
    } finally {
      setLoading(false);
    }
  };

  // 1️⃣ Efecto inicial: obtener el carrito desde API y sincronizar localStorage
  useEffect(() => {
    fetchCart();
  }, []);

  // 2️⃣ Sincronizar localStorage cada vez que cambie el carrito
  useEffect(() => {
    localStorage.setItem("cart", JSON.stringify(cartItems));
    localStorage.setItem("subtotal", subtotal);
  }, [cartItems, subtotal]);

  // --- FUNCIÓN DE AYUDA PARA MANEJAR RESPUESTAS DE API ---
  const handleApiResponse = async (promise) => {
    setLoading(true);
    try {
      const data = await promise;

      if (data.limiteAlcanzado) {
        setlimiteAlcanzado(true);
        return { success: false, error: data.message || "Límite de stock alcanzado." };
      } else {
        setlimiteAlcanzado(false);
      }

      const items = data.items || [];
      const total = data.total ? parseFloat(data.total) : 0;
      const count = items.reduce((sum, item) => sum + item.cantidad, 0);

      setCartItems(items);
      setSubtotal(total);
      setTotalItems(count);

      // 🔹 Guardar también en localStorage
      localStorage.setItem("cart", JSON.stringify(items));
      localStorage.setItem("subtotal", total);

      return { success: true, message: data.message || "Operación exitosa." };
    } catch (error) {
      console.error("Error de API en el carrito:", error);

      if (error.response && error.response.status === 400) {
        if (error.response.data.error.includes("Stock")) {
          setlimiteAlcanzado(true);
        }
        return { success: false, error: error.response.data.error };
      }

      return { success: false, error: error.message || "Error desconocido del carrito." };
    } finally {
      setLoading(false);
    }
  };

  // --- FUNCIONES QUE LLAMAN A LA API ---
  const addToCart = async (producto, cantidad = 1) => {
    return handleApiResponse(CarritoApiService.agregarItem(producto.id, cantidad));
  };

  const removeFromCart = async (productoId) => {
    return handleApiResponse(CarritoApiService.eliminarItem(productoId));
  };

  const updateQuantity = async (productoId, cantidad) => {
    if (cantidad < 1) {
      return removeFromCart(productoId);
    }
    return handleApiResponse(CarritoApiService.actualizarCantidad(productoId, cantidad));
  };

  return (
    <CartContext.Provider
      value={{
        cartItems,
        addToCart,
        removeFromCart,
        updateQuantity,
        totalItems,
        subtotal,
        limiteAlcanzado,
        setlimiteAlcanzado,
        loading,
        fetchCart,
      }}
    >
      {children}
    </CartContext.Provider>
  );
};
