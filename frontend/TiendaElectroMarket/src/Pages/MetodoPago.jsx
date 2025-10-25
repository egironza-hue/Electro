
import { useState, useEffect } from "react";
import Footer from "../components/layout/Footer";
import { useCart } from "../context/CartContext";
import Logo from "../components/layout/logo";
import mercado from "../assets/imagenes/ui/mercadoPago.png";
import logo from "../assets/imagenes/ui/logo.png";
import ResumenPedido from "../components/Pedido/ResumenPedido";

const MetodoPago = () => {
  const { cartItems, subtotal } = useCart(); // 🛒 Carrito global
  const [seleccion, setSeleccion] = useState(localStorage.getItem("metodoPago") || "");
  const [totales, setTotales] = useState({ subtotal: 0, envio: 0, total: 0 });

  // Campos tarjeta
  const [numero, setNumero] = useState("");
  const [exp, setExp] = useState("");
  const [titular, setTitular] = useState("");
  const [cvv, setCvv] = useState("");

  // Guardar método de pago
  useEffect(() => {
    if (seleccion) localStorage.setItem("metodoPago", seleccion);
  }, [seleccion]);

  // Calcular totales en base al carrito global
  useEffect(() => {
    const envio = subtotal > 0 ? 5000 : 0;
    setTotales({ subtotal, envio, total: subtotal + envio });
  }, [subtotal]);

  // 🔹 Función de pago con Mercado Pago
  const handlePagoMercadoPago = async () => {
    try {
      alert("🔵 Conectando con Mercado Pago...");

      // Si el carrito está vacío
      if (!cartItems || cartItems.length === 0) {
        alert("⚠️ Tu carrito está vacío. Agrega productos antes de pagar.");
        return;
      }

      const total = totales.total || 0;

      console.log("🛒 Enviando al backend:", cartItems, total);

      const res = await fetch("http://localhost:3000/mercadopago/create_preference", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ cartItems, total }),
      });

      if (!res.ok) {
        console.error("❌ Error HTTP:", res.status);
        alert("Error al comunicarse con el backend. Revisa la consola.");
        return;
      }

      const data = await res.json();
      console.log("✅ Respuesta Mercado Pago:", data);

      if (data.id) {
        alert("Redirigiendo a Mercado Pago...");
        window.location.href = `https://www.mercadopago.com.co/checkout/v1/redirect?pref_id=${data.id}`;
      } else {
        alert("⚠️ No se recibió el link de pago desde el backend.");
        console.warn("Respuesta incompleta:", data);
      }
    } catch (err) {
      console.error("❌ Error con Mercado Pago:", err);
      alert("Error al conectar con Mercado Pago. Verifica el backend.");
    }
  };

  const handleConfirm = () => {
    if (!seleccion) return alert("Seleccione un método de pago antes de continuar.");

    if (seleccion === "tarjeta") {
      if (!numero || !exp || !titular || !cvv)
        return alert("Complete los datos de la tarjeta.");
      alert("Pago con tarjeta simulado. Gracias.");
      return;
    }

    if (seleccion === "mercadopago") {
      handlePagoMercadoPago();
    }
  };

  return (
    <>
      <main className="max-w-6xl mx-auto px-4 py-12">
        <Logo src={logo} height={120} />
        <h1 className="text-2xl font-semibold mb-6">ELIGE UN MÉTODO DE PAGO</h1>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <section className="lg:col-span-2">
            <div className="flex gap-6 mb-8 flex-wrap">
              {/* TARJETA */}
              <div
                onClick={() => setSeleccion("tarjeta")}
                className={`flex-1 min-w-[220px] cursor-pointer p-6 border rounded-md text-center ${
                  seleccion === "tarjeta" ? "border-black" : "border-gray-200"
                }`}
              >
                <div className="h-20 flex items-center justify-center mb-4">💳</div>
                <div className="text-sm font-medium">TARJETA CRÉDITO/DÉBITO</div>
              </div>

              {/* MERCADO PAGO */}
              <div
                onClick={() => {
    setSeleccion("mercadopago");  // cambiar selección
    handlePagoMercadoPago();       // redirigir a Mercado Pago
  }}
                className={`flex-1 min-w-[220px] cursor-pointer p-6 rounded-md text-center border 
                  ${
                    seleccion === "mercadopago"
                      ? "border-white-600 bg-white-600 text-black"
                      : "border-gray-200 bg-white text-gray-900"
                  }
                  hover:bg-white-700 hover:text-white shadow-md hover:shadow-lg transition-all duration-200`}
              >
                <div className="h-20 flex items-center justify-center mb-4">
                  <Logo src={mercado} height={40} />
                </div>
                <div className="text-sm font-medium">MERCADOPAGO</div>
              </div>
            </div>

            {/* FORM TARJETA */}
            {seleccion === "tarjeta" && (
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                  <label className="text-xs text-gray-600">NÚMERO DE TARJETA</label>
                  <input
                    value={numero}
                    onChange={(e) => setNumero(e.target.value.replace(/[^0-9 ]/g, ""))}
                    placeholder="1234 5678 9012 3456"
                    className="w-full border-b py-2 mt-2"
                  />
                </div>
                <div>
                  <label className="text-xs text-gray-600">EXPIRACIÓN (MM/AA)</label>
                  <input
                    value={exp}
                    onChange={(e) => setExp(e.target.value)}
                    placeholder="MM/AA"
                    className="w-full border-b py-2 mt-2"
                  />
                </div>
                <div>
                  <label className="text-xs text-gray-600">TITULAR</label>
                  <input
                    value={titular}
                    onChange={(e) => setTitular(e.target.value)}
                    placeholder="Nombre como figura en la tarjeta"
                    className="w-full border-b py-2 mt-2"
                  />
                </div>
                <div>
                  <label className="text-xs text-gray-600">CVV</label>
                  <input
                    value={cvv}
                    onChange={(e) => setCvv(e.target.value.replace(/[^0-9]/g, ""))}
                    placeholder="123"
                    className="w-full border-b py-2 mt-2"
                  />
                </div>
              </div>
            )}

            {seleccion === "mercadopago" && (
              <div className="p-4 border rounded-md mt-4">
                <p>Serás redirigido a MercadoPago para completar el pago.</p>
              </div>
            )}

            <div className="mt-6">
              <button
                onClick={handleConfirm}
                className="bg-black text-white px-6 py-3 rounded-md"
              >
                Finalizar pago
              </button>
            </div>
          </section>

          {/* 🧾 Usa el componente de resumen normal (no requiere props) */}
          <ResumenPedido />
        </div>
      </main>

      <Footer />
    </>
  );
};

export default MetodoPago;

