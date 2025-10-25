import { useCart } from "../../context/CartContext";
import CartProducto from "../Productos/CartProducto";

const ResumenPedido = () => {
  const { cartItems, totalItems, subtotal, totales } = useCart();

  return (
    <aside className="lg:col-span-1 border p-4 rounded-md">
      <h3 className="font-semibold mb-4">RESUMEN DEL PEDIDO</h3>

      {cartItems.length === 0 ? (
        <p className="text-gray-500 text-center py-6">Tu carrito está vacío 🕊️</p>
      ) : (
        <>
          {/* Lista de productos */}
          <div className="flex flex-col gap-4 max-h-80 overflow-y-auto pr-2 scrollbar-thin scrollbar-thumb-gray-300 scrollbar-track-transparent">
            {cartItems.map((item, index) => (
              <CartProducto key={index} item={item} />
            ))}
          </div>

          {/* Totales */}
          <div className="mt-6 border-t border-gray-300 pt-4">
            <div className="flex items-center justify-between mb-2 text-sm">
              <p>Subtotal</p>
              <p>${totales?.subtotal?.toLocaleString("es-CO") ?? subtotal.toLocaleString("es-CO")}</p>
            </div>
            <div className="flex items-center justify-between mb-2 text-sm">
              <p>Envío</p>
              <p>${totales?.envio?.toLocaleString("es-CO") ?? 0}</p>
            </div>
            <div className="flex items-center justify-between font-semibold text-lg mt-2">
              <p>Total ({totalItems} items)</p>
              <p>${totales?.total?.toLocaleString("es-CO") ?? subtotal.toLocaleString("es-CO")}</p>
            </div>
          </div>
        </>
      )}
    </aside>
  );
};

export default ResumenPedido;
