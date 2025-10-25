--
-- PostgreSQL database dump
--

\restrict g6ZBLmeJYvSS6efngbd6OPAUbqcARcSJCfQvkC5PnldPgWa38IXv90zen0DzRdk

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-10-25 07:10:17

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 17391)
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


--
-- TOC entry 279 (class 1255 OID 17437)
-- Name: actualizar_fecha_modificacion(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actualizar_fecha_modificacion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.fecha_actualizacion = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.actualizar_fecha_modificacion() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 17438)
-- Name: carrito_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carrito_items (
    id_item integer NOT NULL,
    carrito_id integer,
    producto_id integer,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    fecha_actualizacion timestamp without time zone DEFAULT now(),
    CONSTRAINT carrito_items_cantidad_check CHECK ((cantidad > 0))
);


ALTER TABLE public.carrito_items OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17446)
-- Name: carrito_items_id_item_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carrito_items_id_item_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carrito_items_id_item_seq OWNER TO postgres;

--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 222
-- Name: carrito_items_id_item_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carrito_items_id_item_seq OWNED BY public.carrito_items.id_item;


--
-- TOC entry 223 (class 1259 OID 17447)
-- Name: carritos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carritos (
    id_carrito integer NOT NULL,
    usuario_id integer,
    token_invitado character varying(255),
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(50) DEFAULT 'ACTIVO'::character varying NOT NULL,
    CONSTRAINT carritos_check CHECK ((((usuario_id IS NOT NULL) AND (token_invitado IS NULL)) OR ((usuario_id IS NULL) AND (token_invitado IS NOT NULL))))
);


ALTER TABLE public.carritos OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17456)
-- Name: carritos_id_carrito_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carritos_id_carrito_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carritos_id_carrito_seq OWNER TO postgres;

--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 224
-- Name: carritos_id_carrito_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carritos_id_carrito_seq OWNED BY public.carritos.id_carrito;


--
-- TOC entry 225 (class 1259 OID 17457)
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    id_categoria integer CONSTRAINT categorias_id_not_null NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17462)
-- Name: categorias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categorias_id_seq OWNER TO postgres;

--
-- TOC entry 5168 (class 0 OID 0)
-- Dependencies: 226
-- Name: categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorias_id_seq OWNED BY public.categorias.id_categoria;


--
-- TOC entry 227 (class 1259 OID 17463)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id_cliente integer,
    usuario_id integer,
    nombre_cliente character varying,
    correo_cliente character varying,
    direccion text,
    telefono character varying,
    rol character varying,
    fecha_creacion timestamp without time zone
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17468)
-- Name: marca_categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marca_categoria (
    id_marca integer NOT NULL,
    id_categoria integer NOT NULL
);


ALTER TABLE public.marca_categoria OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17473)
-- Name: marcas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marcas (
    id_marca integer CONSTRAINT marcas_id_not_null NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.marcas OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17478)
-- Name: marcas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.marcas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.marcas_id_seq OWNER TO postgres;

--
-- TOC entry 5169 (class 0 OID 0)
-- Dependencies: 230
-- Name: marcas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.marcas_id_seq OWNED BY public.marcas.id_marca;


--
-- TOC entry 231 (class 1259 OID 17479)
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    precio numeric(10,2) NOT NULL,
    stock integer DEFAULT 0,
    disponible boolean DEFAULT true,
    imagen_url character varying(500),
    destacado boolean DEFAULT false,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    especificaciones jsonb,
    detalle_extenso text,
    marca_id integer,
    subcategoria_id integer
);


ALTER TABLE public.productos OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17492)
-- Name: productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productos_id_seq OWNER TO postgres;

--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 232
-- Name: productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;


--
-- TOC entry 233 (class 1259 OID 17493)
-- Name: seguridad_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seguridad_usuario (
    id integer,
    usuario_id integer,
    intentos_fallidos integer,
    bloqueado boolean,
    fecha_desbloqueo timestamp without time zone,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE public.seguridad_usuario OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17496)
-- Name: subcategorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subcategorias (
    id_subcategoria integer CONSTRAINT subcategorias_id_not_null NOT NULL,
    nombre character varying(100) NOT NULL,
    categoria_id integer
);


ALTER TABLE public.subcategorias OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17501)
-- Name: subcategorias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subcategorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subcategorias_id_seq OWNER TO postgres;

--
-- TOC entry 5171 (class 0 OID 0)
-- Dependencies: 235
-- Name: subcategorias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subcategorias_id_seq OWNED BY public.subcategorias.id_subcategoria;


--
-- TOC entry 236 (class 1259 OID 17502)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    correo character varying,
    "contraseña" character varying,
    nombre character varying,
    tipo_usuario character varying,
    fecha_creacion timestamp without time zone,
    email_verificado boolean,
    codigo_verificacion character varying,
    codigo_expiracion timestamp without time zone,
    token_reset_password character varying,
    token_expiracion timestamp without time zone
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 17508)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.usuarios ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.usuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4945 (class 2604 OID 17509)
-- Name: carrito_items id_item; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrito_items ALTER COLUMN id_item SET DEFAULT nextval('public.carrito_items_id_item_seq'::regclass);


--
-- TOC entry 4947 (class 2604 OID 17510)
-- Name: carritos id_carrito; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carritos ALTER COLUMN id_carrito SET DEFAULT nextval('public.carritos_id_carrito_seq'::regclass);


--
-- TOC entry 4951 (class 2604 OID 17511)
-- Name: categorias id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias ALTER COLUMN id_categoria SET DEFAULT nextval('public.categorias_id_seq'::regclass);


--
-- TOC entry 4952 (class 2604 OID 17512)
-- Name: marcas id_marca; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marcas ALTER COLUMN id_marca SET DEFAULT nextval('public.marcas_id_seq'::regclass);


--
-- TOC entry 4953 (class 2604 OID 17513)
-- Name: productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);


--
-- TOC entry 4959 (class 2604 OID 17514)
-- Name: subcategorias id_subcategoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategorias ALTER COLUMN id_subcategoria SET DEFAULT nextval('public.subcategorias_id_seq'::regclass);


--
-- TOC entry 5143 (class 0 OID 17438)
-- Dependencies: 221
-- Data for Name: carrito_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carrito_items (id_item, carrito_id, producto_id, cantidad, precio_unitario, fecha_actualizacion) FROM stdin;
67	4	4	1	95000.00	2025-10-23 20:05:31.19467
80	5	16	2	75000.00	2025-10-23 20:44:11.229855
81	6	4	1	95000.00	2025-10-24 08:51:13.476914
83	7	8	3	155000.00	2025-10-24 09:20:35.957159
84	10	4	1	95000.00	2025-10-24 09:34:58.204454
85	11	5	1	140000.00	2025-10-24 13:37:51.929511
87	3	6	1	89000.00	2025-10-24 14:04:58.85268
39	1	6	4	89000.00	2025-10-23 16:38:10.283939
89	3	4	6	95000.00	2025-10-24 19:59:48.62718
93	3	30	1	480000.00	2025-10-24 19:59:48.62718
115	14	78	1	12000.00	2025-10-25 01:04:19.882602
118	14	4	4	95000.00	2025-10-25 06:52:45.346035
\.


--
-- TOC entry 5145 (class 0 OID 17447)
-- Dependencies: 223
-- Data for Name: carritos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carritos (id_carrito, usuario_id, token_invitado, fecha_creacion, fecha_actualizacion, estado) FROM stdin;
4	\N	a1c62a01-b7b2-4182-9018-aedd4f68723f	2025-10-23 19:55:59.798702-05	2025-10-23 20:05:34.555321-05	ACTIVO
5	\N	12d35958-e47d-4578-a71e-6070c6e96e3d	2025-10-23 20:43:28.593226-05	2025-10-23 20:44:11.230598-05	ACTIVO
6	\N	98c4b217-6ba3-43de-9682-67aa3859275b	2025-10-24 08:50:58.091042-05	2025-10-24 08:50:58.091042-05	ACTIVO
7	\N	8adde21f-7b25-4d62-b8aa-a2c86b21858b	2025-10-24 09:12:06.272454-05	2025-10-24 09:20:35.960201-05	ACTIVO
8	\N	dd705e5d-bf1f-470a-b861-c36f707156cd	2025-10-24 09:24:38.601146-05	2025-10-24 09:24:38.601146-05	ACTIVO
1	\N	861e17d2-4a81-4e26-a8fe-09d5fc8409d9	2025-10-22 22:33:35.330827-05	2025-10-23 16:38:10.284608-05	ACTIVO
9	\N	b332a5ab-6d8a-4232-bf7e-cffaada7c646	2025-10-24 09:26:36.551655-05	2025-10-24 09:26:36.551655-05	ACTIVO
10	\N	cbd20193-d11d-4b31-8b33-dd82989d8c7a	2025-10-24 09:30:43.54281-05	2025-10-24 09:30:43.54281-05	ACTIVO
11	\N	2669a24f-52d2-4850-b34e-d0f363f0b2de	2025-10-24 13:37:39.390904-05	2025-10-24 13:37:39.390904-05	ACTIVO
3	1	\N	2025-10-23 19:42:08.347754-05	2025-10-24 19:59:48.62718-05	ACTIVO
17	5	\N	2025-10-25 02:31:34.684766-05	2025-10-25 05:07:01.633192-05	ACTIVO
14	2	\N	2025-10-24 21:24:40.084805-05	2025-10-25 06:52:32.196608-05	ACTIVO
\.


--
-- TOC entry 5147 (class 0 OID 17457)
-- Dependencies: 225
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias (id_categoria, nombre) FROM stdin;
1	Sensores
2	Microcontroladores
3	Actuadores
\.


--
-- TOC entry 5149 (class 0 OID 17463)
-- Dependencies: 227
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (id_cliente, usuario_id, nombre_cliente, correo_cliente, direccion, telefono, rol, fecha_creacion) FROM stdin;
1	3	Ana López	cliente1@gmail.com	Calle 123 #45-67, Bogotá	3001234567	cliente	2025-10-12 13:54:54.382521
2	4	Juan Pérez	cliente2@gmail.com	Av. Principal #89-10, Medellín	3102345678	cliente	2025-10-12 13:54:54.382521
3	5	Laura Martínez	cliente3@hotmail.com	Carrera 56 #12-34, Cali	3203456789	cliente	2025-10-12 13:54:54.382521
4	6	Pedro Sánchez	cliente4@yahoo.com	Diagonal 78 #90-12, Barranquilla	3154567890	cliente	2025-10-12 13:54:54.382521
5	7	Sofia Ramírez	cliente5@gmail.com	Transversal 34 #56-78, Cartagena	3015678901	cliente	2025-10-12 13:54:54.382521
6	8	Roberto Jiménez	tecnico@arduino.com	Calle 90 #12-34, Bucaramanga	3176789012	cliente	2025-10-12 13:54:54.382521
7	9	Daniela Castro	estudiante@uni.edu	Av. Universitaria #45-67, Manizales	3197890123	cliente	2025-10-12 13:54:54.382521
8	10	Miguel Ángel Torres	proyectos@empresa.com	Carrera 100 #23-45, Pereira	3128901234	cliente	2025-10-12 13:54:54.382521
15	18	Manuel	gowpipe@gmail.com	carrera20b	3205255821	cliente	2025-10-21 21:58:14.061838
18	21	Luisa 	vmgonsalez@unimayor.edu.co	carrera20b	3205255821	cliente	2025-10-22 16:39:04.039856
\N	\N	valentina	vsulez@unimayor.edu.co	la aldea	356677	\N	\N
\N	\N	valentina	vsulez@unimayor.edu.co	la aldea	356677	\N	\N
\N	\N	valentina	vsulez@unimayor.edu.co	la aldea	356677	\N	\N
\N	1	valentina	vsulez@unimayor.edu.co	la aldea	356677	\N	\N
\N	2	brayan	baamayac1@academia.usbbog.edu.co	dsa	3232	\N	\N
\N	3	fas	brayanama87@gmail.com	dsa	33	\N	\N
\N	4	Brayan Alexis	apavellanedal@academia.usbbog.edu.co	sds	312	\N	\N
\.


--
-- TOC entry 5150 (class 0 OID 17468)
-- Dependencies: 228
-- Data for Name: marca_categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.marca_categoria (id_marca, id_categoria) FROM stdin;
24	3
17	3
9	3
12	3
1	3
7	3
19	3
10	3
18	2
22	2
21	2
25	2
11	2
13	2
23	2
14	2
15	2
6	1
2	1
3	1
8	1
5	1
26	1
20	1
16	1
4	1
\.


--
-- TOC entry 5151 (class 0 OID 17473)
-- Dependencies: 229
-- Data for Name: marcas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.marcas (id_marca, nombre) FROM stdin;
1	Nextion
2	Bosch
3	InvenSense
4	AMT
5	Maxim
6	Analog Devices
7	Pololu
8	Keyes
9	Elegoo
10	Waveshare
11	Lolin
12	Generic
13	Raspberry Pi
14	Texas Instruments
15	AI-Thinker
16	Sharp
17	DFRobot
18	Arduino
19	TowerPro
20	SenseAir
21	Freenove
22	Espressif
23	ST
24	Adafruit
25	Heltec
26	Plantower
\.


--
-- TOC entry 5153 (class 0 OID 17479)
-- Dependencies: 231
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos (id, nombre, descripcion, precio, stock, disponible, imagen_url, destacado, fecha_creacion, fecha_actualizacion, especificaciones, detalle_extenso, marca_id, subcategoria_id) FROM stdin;
78	Vibration Motor Coin	Motor vibratorio tipo coin para feedback háptico.	12000.00	80	t	https://mbientlab.com/wp-content/uploads/2016/06/coinvibration1.jpg	f	2025-10-19 15:59:24.226423	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Uso", "valor": "Feedback Háptico / Wearables"}, {"clave": "Ruido", "valor": "Bajo"}, {"clave": "Control", "valor": "Transistor simple"}], "principales": [{"clave": "Tipo", "valor": "Motor Vibratorio Excéntrico (ERM)"}, {"clave": "Factor de Forma", "valor": "Coin (Moneda)"}, {"clave": "Voltaje", "valor": "3V (Típico)"}]}	Un motor vibratorio de pequeño tamaño (tipo "moneda") sin partes externas que sobresalgan. Es el motor estándar para feedback háptico en wearables, teléfonos y gamepads. Su pequeño tamaño permite integrarlo fácilmente en carcasas estrechas, proporcionando vibraciones discretas y de bajo ruido.	12	1
77	Mini Linear Actuator 12V	Actuador lineal compacto para proyectos mecánicos.	98000.00	7	t	https://m.media-amazon.com/images/I/71AeN-1mxZL.jpg	f	2025-10-19 15:59:24.226423	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Recorrido", "valor": "Variable (Ej. 50mm)"}, {"clave": "Fuerza", "valor": "Baja a media"}, {"clave": "Control", "valor": "Driver H-Bridge"}], "principales": [{"clave": "Tipo", "valor": "Actuador Lineal DC"}, {"clave": "Voltaje Nominal", "valor": "12V"}, {"clave": "Función", "valor": "Movimiento Push-Pull"}]}	Actuador lineal en formato miniatura, ideal para empujar, tirar, levantar o posicionar objetos pequeños. Opera a 12V y proporciona un movimiento de línea recta en lugar de rotación. Es utilizado en automatización de maquetas, cerraduras automatizadas o en robótica para pequeños movimientos de articulaciones.	12	1
76	Motor Encoder DC	Motor DC con encoder para control de posición.	125000.00	6	t	https://m.media-amazon.com/images/I/41V8W84VDWL._SS400_.jpg	f	2025-10-19 15:59:24.226423	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Salida Encoder", "valor": "Cuadratura (A/B)"}, {"clave": "Precisión", "valor": "Alta"}, {"clave": "Aplicación", "valor": "Vehículos autónomos"}], "principales": [{"clave": "Tipo", "valor": "Motor DC con Feedback"}, {"clave": "Característica", "valor": "Encoder integrado"}, {"clave": "Uso", "valor": "Control de bucle cerrado"}]}	Un motor DC con caja reductora que incluye un encoder (generalmente magnético u óptico) en su eje. El encoder permite al microcontrolador leer la posición y velocidad exacta del motor. Esto es fundamental para sistemas de control de movimiento de bucle cerrado (PID), como vehículos autónomos y brazos robóticos de alta precisión.	7	1
75	Motor Geared 6V 300RPM	Motor con engranaje integrado para mayor torque.	52000.00	18	t	https://http2.mlstatic.com/D_NQ_NP_745285-MCO86044857153_062025-O.webp	f	2025-10-19 15:59:24.226423	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Torque", "valor": "Alto"}, {"clave": "Uso", "valor": "Robots de oruga / Peso"}, {"clave": "Ruido", "valor": "Medio"}], "principales": [{"clave": "Tipo", "valor": "Motor DC Engranado"}, {"clave": "Voltaje Nominal", "valor": "6V"}, {"clave": "Velocidad", "valor": "300 RPM"}]}	Versión robusta de un motor DC con engranajes para aumentar la capacidad de torque. Es un caballo de batalla en la robótica de estudiantes. La caja de engranajes está optimizada para equilibrar una velocidad utilizable con la fuerza necesaria para superar obstáculos y transportar el peso del robot.	12	1
73	Brushless Motor 2204	Motor brushless para drones y multicopters.	72000.00	9	t	https://http2.mlstatic.com/D_NQ_NP_639920-CBT79702351272_102024-O.webp	f	2025-10-19 15:59:24.226423	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Requisito", "valor": "ESC (Controlador de Velocidad)"}, {"clave": "Eficiencia", "valor": "Alta (Potencia/Peso)"}, {"clave": "KV", "valor": "Alto (RPM/Volt)"}], "principales": [{"clave": "Tipo", "valor": "Brushless (Sin Escobillas)"}, {"clave": "Modelo", "valor": "2204 (Típico)"}, {"clave": "Uso", "valor": "Drones y RC"}]}	Motor sin escobillas (Brushless) de tipo 2204, ampliamente utilizado en drones (multicopters) y vehículos RC. Ofrece una relación potencia-peso superior a los motores DC tradicionales y requiere un controlador de velocidad electrónico (ESC) externo para su funcionamiento. Ideal para sistemas de vuelo y alta eficiencia.	12	1
72	Motor Reductor 12V	Motor con caja reductora para torque.	86000.00	10	t	https://http2.mlstatic.com/D_NQ_NP_926358-CBT81068386696_122024-O.webp	f	2025-10-19 15:59:24.226423	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Engranajes", "valor": "Metálicos"}, {"clave": "Velocidad", "valor": "Baja (Variable)"}, {"clave": "Uso", "valor": "Elevación / Robots pesados"}], "principales": [{"clave": "Tipo", "valor": "Motor DC Reductor Industrial"}, {"clave": "Voltaje", "valor": "12V"}, {"clave": "Característica", "valor": "Máximo Torque"}]}	Motor DC robusto con una caja reductora de metal de alto rendimiento. Está diseñado para ofrecer el máximo torque a expensas de la velocidad. Es la elección perfecta para aplicaciones de elevación, tracción de robots pesados o actuadores de válvulas que requieren mucha fuerza de giro.	12	1
71	Stepper NEMA17	Motor paso a paso NEMA17 para impresoras 3D.	95000.00	8	t	https://www.didacticaselectronicas.com/web/image/product.template/7046/image_1024?unique=87a34c4	f	2025-10-19 15:59:24.226423	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Ángulo de Paso", "valor": "1.8 grados"}, {"clave": "Torque", "valor": "Alto (Variable)"}, {"clave": "Driver Compatible", "valor": "A4988, DRV8825"}], "principales": [{"clave": "Tipo", "valor": "Motor Paso a Paso de Potencia"}, {"clave": "Tamaño", "valor": "NEMA 17"}, {"clave": "Uso Principal", "valor": "Impresoras 3D / CNC"}]}	El motor NEMA17 es el estándar industrial para aplicaciones que requieren alto torque y precisión de posicionamiento, como impresoras 3D, máquinas CNC y grabadoras láser. Requiere un driver de motor stepper dedicado (como el A4988 o DRV8825) capaz de suministrar la corriente necesaria para su rendimiento óptimo.	12	1
70	Motor Paso a Paso 28BYJ-48	Stepper motor con driver ULN2003 incluido.	37000.00	25	t	https://www.prometec.net/wp-content/uploads/2015/06/FT68TVVHMMF4Z5P.LARGE_.jpg	f	2025-10-19 15:59:24.226423	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Ángulo de Paso", "valor": "5.625 grados"}, {"clave": "Uso", "valor": "Posicionamiento preciso"}, {"clave": "Aplicación", "valor": "Cámaras, Dispensadores"}], "principales": [{"clave": "Tipo", "valor": "Motor Paso a Paso (Stepper)"}, {"clave": "Voltaje Nominal", "valor": "5V"}, {"clave": "Driver", "valor": "ULN2003 (Incluido)"}]}	El 28BYJ-48 es un motor paso a paso (stepper) de bajo costo y tamaño compacto. Es perfecto para aplicaciones que requieren un control de posición preciso, como mover plataformas, aperturas o dosificadores. Viene con su driver ULN2003, simplificando la conexión y el control desde un microcontrolador.	9	1
69	Motor DC 12V 1000RPM	Motor de mayor velocidad para proyectos de tracción.	60000.00	12	t	https://naylampmechatronics.com/3297-superlarge_default/motor-dc-37d-12v-1000rpm.jpg	f	2025-10-19 15:59:24.226423	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Uso", "valor": "Ventiladores / Proyectos rápidos"}, {"clave": "Torque", "valor": "Bajo a medio"}, {"clave": "Driver Compatible", "valor": "L298N, DRV8833"}], "principales": [{"clave": "Tipo", "valor": "Motor DC de alta velocidad"}, {"clave": "Voltaje Nominal", "valor": "12V"}, {"clave": "Velocidad", "valor": "1000 RPM"}]}	Motor DC con caja reductora que opera a 12V y proporciona una alta velocidad de salida (1000 RPM). Es ideal para proyectos que requieren movimiento rápido, como ventiladores, bombas pequeñas o robots que se desplazan a alta velocidad. Requiere un driver de motor capaz de manejar 12V.	17	1
68	Motor DC 6V 300RPM	Motor DC con eje y engranaje, ideal para robots.	45000.00	40	t	https://http2.mlstatic.com/D_NQ_NP_643947-MCO31039026924_062019-O.webp	f	2025-10-19 15:59:24.226423	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Uso Principal", "valor": "Robots móviles de tracción"}, {"clave": "Torque", "valor": "Medio"}, {"clave": "Eje", "valor": "Doble (opcional)"}], "principales": [{"clave": "Tipo", "valor": "Motor DC con caja reductora"}, {"clave": "Voltaje Nominal", "valor": "6V"}, {"clave": "Velocidad", "valor": "300 RPM (Sin carga)"}]}	Este es un motor de corriente continua (DC) con caja reductora integrada, optimizado para aplicaciones de robótica móvil. La reducción de velocidad aumenta significativamente el torque, lo que permite a los robots moverse y transportar peso. Funciona bien con drivers de motor comunes y una alimentación de 6V.	12	1
67	Servo MG996R	Servo metálico de alto torque.	98000.00	15	t	https://electronilab.co/wp-content/uploads/2019/04/Servomotor-MG996R-11Kg-4.8-V-Tower-Pro-pinoneria-metalica.jpeg	f	2025-10-19 15:59:24.226423	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje", "valor": "4.8V - 6.6V"}, {"clave": "Uso", "valor": "Robótica pesada / RC"}, {"clave": "Control", "valor": "PWM"}], "principales": [{"clave": "Tipo", "valor": "Servo Alto Torque"}, {"clave": "Engranajes", "valor": "Metálicos"}, {"clave": "Torque", "valor": "10 kg/cm (Aprox)"}]}	El MG996R es un servomotor de alto torque con engranajes metálicos. Es la actualización robusta del SG90, diseñado para manejar cargas mucho más pesadas y resistir el desgaste. Es ideal para brazos robóticos más grandes, dirección de vehículos RC de mayor escala y cualquier aplicación que requiera fiabilidad y fuerza.	19	1
66	Servo SG90	Mini servo 9g para prototipos y robótica.	29000.00	60	t	https://dualtronica.com/2497-medium_default/microservo-sg90-tower-pro.jpg	t	2025-10-19 15:59:24.226423	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje", "valor": "4.8V - 6V"}, {"clave": "Uso", "valor": "Robótica ligera"}, {"clave": "Engranajes", "valor": "Plástico"}], "principales": [{"clave": "Tipo", "valor": "Mini Servo (9g)"}, {"clave": "Torque", "valor": "1.8 kg/cm (Aprox)"}, {"clave": "Rotación", "valor": "180 grados (Control PWM)"}]}	El Servo SG90 es el servomotor más pequeño y popular para proyectos de robótica y prototipado con Arduino. Es ligero y económico, ideal para mover pequeñas cargas, controlar la dirección de robots ligeros o para abrir y cerrar mecanismos simples. Ofrece rotación angular precisa controlada por señal PWM.	19	1
32	Raspberry Pi 400	Teclado con Raspberry Pi integrado.	380000.00	5	t	https://www.geekfactory.mx/wp-content/uploads/raspberry-pi-400.jpg.webp	f	2025-10-18 23:24:47.949847	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Puertos", "valor": "2 x Micro HDMI, 2 x USB 3.0"}, {"clave": "Teclado", "valor": "Layout español (u otro)"}, {"clave": "Uso", "valor": "Educación y Escritorio"}], "principales": [{"clave": "CPU", "valor": "BCM2711 (Quad-Core, Overclocked)"}, {"clave": "RAM", "valor": "4 GB LPDDR4"}, {"clave": "Diseño", "valor": "Integrado en teclado"}]}	El Raspberry Pi 400 es una computadora completa integrada en un teclado compacto. Simplemente conéctalo a un monitor y estás listo para usar. Es una solución elegante y todo-en-uno, perfecta para la educación, el trabajo ligero o como centro multimedia de bajo perfil, eliminando la necesidad de una torre de PC voluminosa.	13	2
31	Raspberry Pi Camera Module V2	Cámara oficial para Raspberry Pi.	95000.00	15	t	https://thepihut.com/cdn/shop/products/raspberry-pi-camera-module-v2-1-raspberry-pi-sc0023-30219474239683.jpg?crop=center&height=1200&v=1646380808&width=1200	f	2025-10-18 23:24:47.949847	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Video", "valor": "1080p30, 720p60"}, {"clave": "Compatibilidad", "valor": "Todos los modelos con puerto CSI"}, {"clave": "Aplicación", "valor": "Visión artificial"}], "principales": [{"clave": "Resolución", "valor": "8 Megapíxeles"}, {"clave": "Sensor", "valor": "Sony IMX219"}, {"clave": "Conexión", "valor": "Puerto CSI"}]}	El Módulo de Cámara Oficial V2 de Raspberry Pi es un sensor de alta calidad (8 megapíxeles) que se conecta al puerto CSI de la placa. Es fundamental para proyectos de visión artificial, seguridad o fotografía, ofreciendo una imagen mucho mejor que las cámaras USB genéricas y una integración perfecta con el sistema operativo de la Pi.	13	2
30	Raspberry Pi Compute Module 4	Módulo para integraciones industriales.	480000.00	3	t	https://www.sigmaelectronica.net/wp-content/uploads/2023/11/CM-4-HERO-ON-WHITE-scaled.jpg	f	2025-10-18 23:24:47.949847	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Almacenamiento", "valor": "eMMC opcional"}, {"clave": "Interfaz", "valor": "Doble conector de alta densidad"}, {"clave": "Conectividad", "valor": "WiFi y Bluetooth (opcional)"}], "principales": [{"clave": "Uso", "valor": "Industrial y OEM"}, {"clave": "RAM", "valor": "4GB"}, {"clave": "Factor de Forma", "valor": "SoM (System on Module)"}]}	El Compute Module 4 es una versión de la Raspberry Pi 4B diseñada para uso industrial. Es un módulo compacto sin puertos, destinado a ser insertado en una placa base (IO Board) que proporciona los puertos necesarios. Esto permite a los fabricantes crear productos finales personalizados con el poder de la Pi 4, optimizando el espacio.	13	2
29	Raspberry Pi Pico	Microcontrolador RP2040 económico.	85000.00	25	t	https://http2.mlstatic.com/D_NQ_NP_638337-MLA80661537006_112024-O.webp	f	2025-10-18 23:24:47.949847	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Flash", "valor": "2 MB"}, {"clave": "Pines GPIO", "valor": "26 (Multi-función)"}, {"clave": "Características", "valor": "PIO (Programmable I/O)"}], "principales": [{"clave": "Microcontrolador", "valor": "RP2040 (Dual Core Cortex M0+)"}, {"clave": "RAM", "valor": "264 KB"}, {"clave": "Voltaje de Operación", "valor": "3.3 V"}]}	El Raspberry Pi Pico es la incursión de Raspberry Pi en el mundo de los microcontroladores tradicionales. Utiliza el chip RP2040, diseñado por ellos mismos. Es una placa de bajo costo, alta eficiencia y fácil programación (MicroPython/C/C++), ideal para tareas que requieren control de bajo nivel y respuesta en tiempo real.	13	2
28	Raspberry Pi Zero 2 W	Placa ultra compacta con WiFi.	180000.00	12	t	https://http2.mlstatic.com/D_NQ_NP_826185-MCO72205301685_102023-O.webp	f	2025-10-18 23:24:47.949847	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Conexión", "valor": "Mini HDMI, Micro USB OTG"}, {"clave": "WiFi", "valor": "2.4 GHz"}, {"clave": "Bluetooth", "valor": "4.2"}], "principales": [{"clave": "CPU", "valor": "Quad-Core 64-bit ARM Cortex-A53"}, {"clave": "RAM", "valor": "512 MB"}, {"clave": "Tamaño", "valor": "Ultra compacto (65mm x 30mm)"}]}	La Pi Zero 2 W es una computadora increíblemente pequeña que integra un potente procesador Quad-Core (similar al del 3B+) y conectividad WiFi y Bluetooth. Es ideal para proyectos de hardware embebido, wearables, o cámaras discretas donde el espacio y el consumo de energía son críticos. Su tamaño la hace única en el mercado SBC.	13	2
27	Raspberry Pi 3B+	Modelo con WiFi y Bluetooth integrados.	320000.00	10	t	https://www.didacticaselectronicas.com/web/image/product.template/510/image_1024?unique=df01720	f	2025-10-18 23:24:47.949847	2025-10-21 20:44:28.652021	{"otros": [{"clave": "WiFi", "valor": "2.4 GHz y 5 GHz"}, {"clave": "Bluetooth", "valor": "4.2/BLE"}, {"clave": "Puertos USB", "valor": "4 x USB 2.0"}], "principales": [{"clave": "CPU", "valor": "Broadcom BCM2837B0"}, {"clave": "RAM", "valor": "1 GB LPDDR2"}, {"clave": "Red", "valor": "Gigabit Ethernet (vía USB)"}]}	El Raspberry Pi 3 Model B+ es una iteración mejorada del 3B. Ofrece un procesador más rápido y una conectividad de red Gigabit Ethernet (a través de USB), además de un WiFi de doble banda mucho más robusto. Sigue siendo una opción popular y confiable para proyectos de automatización del hogar, enseñanza y centros multimedia estándar.	13	2
26	Raspberry Pi 4B 8GB	Raspberry Pi 4 con 8GB RAM para cargas pesadas.	560000.00	6	t	https://http2.mlstatic.com/D_NQ_NP_714222-MLA50825604641_072022-O.webp	t	2025-10-18 23:24:47.949847	2025-10-21 20:44:28.652021	{"principales": [{"clave": "CPU", "valor": "Broadcom BCM2711 (Quad-Core Cortex-A72)"}, {"clave": "RAM", "valor": "8 GB LPDDR4"}, {"clave": "Uso", "valor": "Tareas pesadas y servidores"}]}	El modelo de 8GB de la Raspberry Pi 4 es la opción de máximo rendimiento, diseñada para usuarios avanzados, virtualización, grandes bases de datos o para compilar código intensivo. Esta capacidad de RAM permite ejecutar sistemas operativos de 64 bits y manejar cargas de trabajo que antes no eran posibles en una SBC, expandiendo sus posibilidades de uso profesional.	13	2
25	Raspberry Pi 4B 4GB	Single-board computer con 4GB RAM.	420000.00	8	t	https://http2.mlstatic.com/D_NQ_NP_620102-MCO40916014036_022020-O.webp	t	2025-10-18 23:24:47.949847	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Puertos Video", "valor": "2 x Micro HDMI (4K)"}, {"clave": "GPIO", "valor": "40 pines"}, {"clave": "Puertos USB", "valor": "2 x USB 3.0, 2 x USB 2.0"}], "principales": [{"clave": "CPU", "valor": "Broadcom BCM2711 (Quad-Core Cortex-A72)"}, {"clave": "RAM", "valor": "4 GB LPDDR4"}, {"clave": "Conectividad", "valor": "WiFi dual-band, Bluetooth 5.0"}]}	La Raspberry Pi 4 Model B con 4GB de RAM es una potente computadora de placa única (SBC) que ofrece un rendimiento de escritorio comparable a PCs de nivel de entrada. Es ideal para aplicaciones que requieren multitarea, como servidores web, centros multimedia 4K o estaciones de trabajo ligeras. Posee dos puertos micro HDMI y conectividad USB 3.0.	13	2
5	ESP32-S3 DevKit	ESP32-S3 con soporte vectorial y mejoras para AI.	140000.00	8	t	https://m.media-amazon.com/images/I/81js--wI-pL._AC_SX425_.jpg	f	2025-10-18 18:41:57.043251	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de funcionamiento", "valor": "3.3 V"}, {"clave": "Acelerador", "valor": "Vectorial para ML/AI"}, {"clave": "SRAM", "valor": "512 KB"}, {"clave": "Conectividad", "valor": "Wi-Fi 2.4 GHz, BLE 5"}], "principales": [{"clave": "Marca", "valor": "Espressif"}, {"clave": "Modelo", "valor": "S3 DevKit"}, {"clave": "Arquitectura", "valor": "Dual-core Xtensa LX7"}]}	El ESP32-S3 DevKit representa la nueva generación de microcontroladores de Espressif. Utiliza un procesador Dual-core Xtensa LX7 que incluye un acelerador vectorial crucial para la computación de borde (Edge AI) y Machine Learning. Esta placa ofrece más GPIOs y una conectividad mejorada con Bluetooth 5 (LE) además del Wi-Fi. Es ideal para aplicaciones futuras que demanden alta velocidad de procesamiento y algoritmos de IA ligeros.	22	3
4	ESP32-CAM	ESP32 con cámara OV2640 integrada.	95000.00	12	t	https://m.media-amazon.com/images/I/717ZetbHQUS._AC_SX425_PIbundle-2,TopRight,0,0_SH20_.jpg	f	2025-10-18 18:41:57.043251	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de entrada recomendado", "valor": "5V"}, {"clave": "Voltaje de funcionamiento", "valor": "3.3V"}, {"clave": "Frecuencia del reloj", "valor": "160 MHz"}, {"clave": "Flash", "valor": "4 MB"}], "principales": [{"clave": "Marca", "valor": "AI-Thinker"}, {"clave": "Modelo", "valor": "ESP32-CAM"}, {"clave": "Sensor de Cámara", "valor": "OV2640 (2MP)"}]}	La ESP32-CAM de AI-Thinker es un módulo compacto y de bajo costo que combina la potencia del ESP32 con una cámara OV2640 de 2 megapíxeles. Es el dispositivo predilecto para proyectos de visión artificial, sistemas de vigilancia IP, y aplicaciones de transmisión de video a través de Wi-Fi. Requiere una fuente de alimentación estable (5V) para operar correctamente, debido al consumo del módulo de cámara, y su pequeño factor de forma lo hace ideal para integración discreta.	15	3
3	ESP32 WROVER	ESP32 con PSRAM para aplicaciones que requieren más memoria.	135000.00	10	t	https://m.media-amazon.com/images/I/618WhTgycwL._AC_SY679_.jpg	f	2025-10-18 18:41:57.043251	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de funcionamiento", "valor": "3.3 V"}, {"clave": "Frecuencia del reloj", "valor": "240 MHz"}, {"clave": "Flash", "valor": "8 MB"}, {"clave": "Uso Principal", "valor": "Cámara y GUI"}], "principales": [{"clave": "Marca", "valor": "Espressif"}, {"clave": "Modelo", "valor": "WROVER"}, {"clave": "PSRAM", "valor": "4 MB (Adicional)"}]}	El ESP32 WROVER es la variante del módulo ESP32 que incluye una **Memoria de Acceso Aleatorio Estática (PSRAM)** adicional. Esta característica es crucial para aplicaciones que manejan grandes cantidades de datos, como procesamiento de imágenes, visualizaciones complejas o cuando se requieren múltiples búferes. Ofrece hasta 8MB de flash y 4MB de PSRAM, elevando significativamente las capacidades del ESP32 estándar en tareas de alta demanda de memoria.	22	3
11	ESP32 Audio Kit	ESP32 con codec de audio para proyectos multimedia.	175000.00	4	t	https://m.media-amazon.com/images/I/71X2hL9CMWL._AC_SY300_SX300_QL70_FMwebp_.jpg	f	2025-10-18 18:41:57.043251	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de entrada", "valor": "5V"}, {"clave": "Conexiones", "valor": "Micrófono, altavoz"}, {"clave": "Soporte", "valor": "Reconocimiento de voz"}, {"clave": "Interfaz", "valor": "I2S"}], "principales": [{"clave": "Marca", "valor": "Espressif"}, {"clave": "Modelo", "valor": "Audio Kit"}, {"clave": "Codec", "valor": "Integrado"}]}	Kit de desarrollo especializado en aplicaciones de audio. Esta placa está diseñada para trabajar con codecs I2S, micrófonos y salidas de altavoz, lo que la hace perfecta para sistemas de reconocimiento de voz, altavoces inteligentes o streaming de audio a través de Wi-Fi. Simplifica la implementación de funciones multimedia complejas en proyectos IoT.	22	3
10	ESP32 LoRa Module	ESP32 con módulo LoRa integrado (long range).	220000.00	5	t	https://m.media-amazon.com/images/I/71Th03dKSYL._AC_SX425_.jpg	f	2025-10-18 18:41:57.043251	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Frecuencia LoRa", "valor": "868/915 MHz"}, {"clave": "Voltaje de funcionamiento", "valor": "3.3 V"}, {"clave": "Pantalla", "valor": "OLED 0.96 pulgadas"}, {"clave": "Antena", "valor": "Externa incluida"}], "principales": [{"clave": "Marca", "valor": "Heltec"}, {"clave": "Modelo", "valor": "LoRa 32"}, {"clave": "Protocolo", "valor": "LoRaWAN"}]}	Módulo de comunicación de largo alcance. Este dispositivo integra el chip ESP32 con un transceptor LoRa (Long Range) como el SX1276/SX1278, haciéndolo ideal para crear redes de área amplia de baja potencia (LPWAN) y soluciones de IoT que necesiten transmitir datos a kilómetros de distancia. Incluye una pequeña pantalla OLED para depuración y monitoreo en campo.	25	3
9	ESP32-WROOM-32U	Versión con conector para antena externa.	120000.00	9	t	https://www.didacticaselectronicas.com/web/image/product.image/12374/image_1024/Imagen%20extra%20de%2026400.150000?unique=180688e	f	2025-10-18 18:41:57.043251	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de funcionamiento", "valor": "3.3 V"}, {"clave": "Frecuencia del reloj", "valor": "240 MHz"}, {"clave": "Flash", "valor": "8 MB"}, {"clave": "Interfaz", "valor": "SPI"}], "principales": [{"clave": "Marca", "valor": "Espressif"}, {"clave": "Modelo", "valor": "WROVER (8MB Flash)"}, {"clave": "PSRAM", "valor": "4 MB (Adicional)"}]}	Módulo ESP32 WROVER con 4MB PSRAM. Este módulo se elige específicamente para aplicaciones con alta demanda de memoria RAM, como visualización de GUIs complejas (interfaces gráficas de usuario), procesamiento de audio o video. La PSRAM (Pseudo-SRAM) adicional permite al desarrollador manejar datos más grandes sin comprometer el rendimiento del núcleo del microcontrolador.	22	3
8	Freenove ESP32 Kit	Kit de desarrollo ESP32 con sensores y cables.	155000.00	6	t	https://m.media-amazon.com/images/I/816DCXgYeHL._AC_SX425_.jpg	f	2025-10-18 18:41:57.043251	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de funcionamiento", "valor": "3.0V - 3.6V"}, {"clave": "Frecuencia del reloj", "valor": "160 MHz"}, {"clave": "Flash", "valor": "4 MB"}, {"clave": "Uso Principal", "valor": "Cajas metálicas o largo alcance"}], "principales": [{"clave": "Marca", "valor": "Espressif"}, {"clave": "Modelo", "valor": "WROOM-32U"}, {"clave": "Antena", "valor": "Conector IPEX para externa"}]}	El módulo ESP32 WROOM-32U es idéntico en funcionalidad al WROOM-32 estándar, pero se distingue por tener un **conector de antena externa (IPEX)** en lugar de la antena PCB integrada. Esta característica es esencial para proyectos que requieren una mayor fiabilidad de la señal, un rango extendido o cuando el módulo debe ser instalado dentro de una carcasa metálica que podría bloquear la señal de una antena interna.	21	3
7	NodeMCU-ESP32	Placa NodeMCU con ESP32, pinout compatible.	105000.00	14	t	https://m.media-amazon.com/images/I/714GfLAfnRL._AC_SX300_SY300_QL70_FMwebp_.jpg	f	2025-10-18 18:41:57.043251	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de entrada recomendado", "valor": "7V - 12V"}, {"clave": "Pines GPIO", "valor": "30"}, {"clave": "Soporte", "valor": "Arduino/MicroPython"}, {"clave": "Compatibilidad", "valor": "Breadboard-friendly"}], "principales": [{"clave": "Marca", "valor": "Lolin"}, {"clave": "Modelo", "valor": "NodeMCU V3"}, {"clave": "Interfaz USB", "valor": "CH340/CP2102"}]}	La placa NodeMCU V3 es una plataforma de desarrollo de código abierto diseñada para simplificar la creación de prototipos con el módulo ESP32. Su principal ventaja es el factor de forma amigable para protoboards y la inclusión de un chip de conversión USB a UART (como el CP2102 o CH340), lo que permite la programación y depuración directa desde la computadora sin hardware adicional. Es ampliamente compatible con el entorno Arduino y MicroPython.	11	3
6	ESP32-PICO	Módulo compacto ESP32-PICO para proyectos pequeños.	89000.00	15	t	https://m.media-amazon.com/images/I/61REUAH7c5L._AC_SY679_.jpg	f	2025-10-18 18:41:57.043251	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de funcionamiento", "valor": "3.3 V"}, {"clave": "Flash", "valor": "4 MB"}, {"clave": "Antena", "valor": "PCB integrada"}, {"clave": "Aplicación", "valor": "Diseños miniaturizados"}], "principales": [{"clave": "Marca", "valor": "Espressif"}, {"clave": "Modelo", "valor": "PICO-D4"}, {"clave": "Tamaño", "valor": "Módulo SiP compacto"}]}	El módulo ESP32-PICO-D4 es una solución compacta System-in-Package (SiP) que encapsula el chip ESP32, el cristal de reloj, el flash SPI y los componentes de filtrado pasivo en un solo paquete pequeño. Este diseño es ideal para la integración en productos finales donde el espacio es una preocupación crítica. Ofrece las mismas capacidades de conectividad Wi-Fi y Bluetooth del ESP32 estándar, pero en un factor de forma significativamente reducido.	22	3
2	ESP32 WROOM-32	Módulo ESP32 WROOM con antena integrada.	99000.00	18	t	https://m.media-amazon.com/images/I/71dfhP8OwcL._AC_SX425_PIbundle-2,TopRight,0,0_SH20_.jpg	t	2025-10-18 18:41:57.043251	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de funcionamiento", "valor": "3.0V - 3.6V"}, {"clave": "Frecuencia del reloj", "valor": "160 MHz"}, {"clave": "Flash", "valor": "4 MB"}, {"clave": "Conectividad", "valor": "Wi-Fi, BLE 4.2"}], "principales": [{"clave": "Marca", "valor": "Espressif"}, {"clave": "Modelo", "valor": "WROOM-32"}, {"clave": "Antena", "valor": "PCB integrada"}]}	El ESP32 WROOM-32 es el módulo estándar de ESP32. Se trata de una solución compacta y lista para usar que integra el chip principal ESP32, memoria flash, cristal oscilador y antena PCB en un solo paquete. Este módulo está diseñado para ser integrado directamente en productos finales o PCBs personalizadas, ofreciendo un alto rendimiento con un bajo consumo de energía. Es la base de la mayoría de las placas de desarrollo ESP32.	22	3
1	ESP32 DevKit V1	Placa de desarrollo ESP32 con WiFi y BLE, ideal para IoT.	115000.00	20	t	https://m.media-amazon.com/images/I/71YcLPnoa3L._AC_SX425_.jpg	t	2025-10-18 18:41:57.043251	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de funcionamiento", "valor": "3.3 V"}, {"clave": "Frecuencia del reloj", "valor": "240 MHz (Dual Core)"}, {"clave": "Flash", "valor": "4 MB"}, {"clave": "Pines Digitales", "valor": "30"}, {"clave": "Memoria SRAM", "valor": "520 KB"}], "principales": [{"clave": "Marca", "valor": "Espressif"}, {"clave": "Modelo", "valor": "DevKit V1"}, {"clave": "Chip", "valor": "ESP32-WROOM-32"}]}	El ESP32 DevKit V1 es la placa de desarrollo estándar y más popular basada en el chip ESP32-WROOM-32. Es la herramienta esencial para cualquier desarrollador de IoT que busque un microcontrolador potente con conectividad integrada Wi-Fi (802.11 b/g/n) y Bluetooth (BLE). Su diseño es amigable para prototipos, ideal para usarse en protoboards gracias a sus encabezados de pines laterales. Permite la programación a través de varios entornos, incluyendo el IDE de Arduino y ESP-IDF, facilitando el desarrollo de proyectos complejos de automatización, monitorización y redes de sensores.	22	3
84	Relay Solid State 5V	Relé de estado sólido para conmutación electrónica.	98000.00	12	t	https://grobotronics.com/images/detailed/115/7f524821-6718-477a-a611-ac53792aa017_grobo.jpg	f	2025-10-19 15:59:36.564248	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de Carga", "valor": "AC (Típico)"}, {"clave": "Corriente Máx", "valor": "Alto (Variable)"}, {"clave": "Uso", "valor": "Control de temperatura (PID)"}], "principales": [{"clave": "Tipo", "valor": "Relé de Estado Sólido (SSR)"}, {"clave": "Ventaja", "valor": "Silencioso y Larga vida útil"}, {"clave": "Voltaje de Control", "valor": "5V DC"}]}	El Relé de Estado Sólido (SSR) utiliza componentes electrónicos (tiristores o transistores) en lugar de partes mecánicas para conmutar la carga. Esto lo hace extremadamente rápido, silencioso y con una vida útil casi ilimitada. Es ideal para cargas que requieren conmutación frecuente, como control de temperatura con PID y calefactores.	12	4
87	Relay Module Optocoupler	Módulo relé con aislamiento optoacoplador.	38000.00	25	t	https://http2.mlstatic.com/D_NQ_NP_708150-CBT80608971023_112024-O.webp	f	2025-10-19 15:59:36.564248	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de Carga Máx", "valor": "250V AC"}, {"clave": "Corriente Máx", "valor": "10A"}, {"clave": "Ventaja", "valor": "Máxima protección de lógica"}], "principales": [{"clave": "Tipo", "valor": "Relé con Aislamiento"}, {"clave": "Aislamiento", "valor": "Optoacoplador completo"}, {"clave": "Voltaje de Control", "valor": "5V DC"}]}	Este módulo relé utiliza un optoacoplador para garantizar un aislamiento completo entre el circuito de control de bajo voltaje (microcontrolador) y el circuito de conmutación de alto voltaje. Este aislamiento proporciona una capa extra de seguridad y fiabilidad, protegiendo la lógica del ruido y los picos de potencia de la carga.	12	4
86	Driver TB6600	Driver para motores paso a paso de mayor potencia.	150000.00	6	t	https://suconel.com/_next/image?url=https%3A%2F%2Fcms.suconel.com%2Fuploads%2F16_1fa11223a8.png&w=1200&q=75	f	2025-10-19 15:59:36.564248	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de Carga", "valor": "9V a 42V DC"}, {"clave": "Corriente Máx", "valor": "4.0A (Pico)"}, {"clave": "Características", "valor": "Micropasos (hasta 1/32)"}], "principales": [{"clave": "Tipo", "valor": "Driver Motor Paso a Paso"}, {"clave": "Chip", "valor": "TB6600"}, {"clave": "Uso", "valor": "Motores NEMA de potencia"}]}	El driver TB6600 es una opción de alto rendimiento para controlar motores paso a paso grandes (NEMA 17, 23, etc.) con alta corriente. Soporta micropasos, lo que resulta en un movimiento más suave y preciso, y cuenta con protección contra sobrecorriente. Es esencial en máquinas CNC, impresoras 3D industriales y proyectos que requieren fuerza.	12	4
85	Driver Motor L298N	Driver para controlar motores DC y steppers.	42000.00	40	t	https://images-cdn.ubuy.co.in/63576241358358601c394a73-dc-motor-driver-l298n-module-h-bridge.jpg	f	2025-10-19 15:59:36.564248	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de Carga Máx", "valor": "46V"}, {"clave": "Corriente Máx", "valor": "2A (Pico)"}, {"clave": "Interfaz", "valor": "TTL Lógica"}], "principales": [{"clave": "Tipo", "valor": "Driver Doble Puente H"}, {"clave": "Chip", "valor": "L298N"}, {"clave": "Capacidad", "valor": "2 Motores DC o 1 Stepper"}]}	El módulo driver L298N (doble puente H) permite controlar la velocidad y dirección de dos motores DC, o un motor paso a paso de dos fases. Es un driver robusto y muy común en proyectos de robótica móvil, capaz de manejar corrientes y voltajes moderados (hasta 2A por canal y 46V máx).	12	4
83	Bomba Peristáltica 5V	Bomba para dosificación de líquidos.	70000.00	7	t	https://tienda.bricogeek.com/9934-thickbox_default/bomba-peristaltica-5v.jpg	f	2025-10-19 15:59:36.564248	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje Nominal", "valor": "5V DC"}, {"clave": "Uso", "valor": "Dosificación de precisión"}, {"clave": "Tubo", "valor": "Silicona flexible"}], "principales": [{"clave": "Tipo", "valor": "Bomba de dosificación"}, {"clave": "Principio", "valor": "Peristáltico"}, {"clave": "Ventaja", "valor": "Líquido no toca el motor"}]}	La bomba peristáltica funciona comprimiendo un tubo flexible con rodillos, empujando el líquido sin que este toque las partes mecánicas de la bomba. Esto garantiza la pureza del líquido (crucial en dispensadores de alimentos/químicos) y evita la contaminación. Es ideal para dosificación precisa y proyectos de química o hidroponía.	12	4
82	Solenoide 12V Push-Pull	Solenoide electromecánico para actuaciones de empuje/retorno.	82000.00	10	t	https://http2.mlstatic.com/D_Q_NP_2X_606477-MCO84773235168_052025-T.webp	f	2025-10-19 15:59:36.564248	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Carrera", "valor": "Variable (Ej. 10mm)"}, {"clave": "Fuerza", "valor": "Media a Alta"}, {"clave": "Uso", "valor": "Cerraduras/Dispensadores"}], "principales": [{"clave": "Tipo", "valor": "Actuador Lineal (Solenoide)"}, {"clave": "Voltaje Nominal", "valor": "12V DC"}, {"clave": "Función", "valor": "Empuje y Retorno"}]}	Un solenoide es un actuador lineal que utiliza un campo magnético para mover un émbolo (pistón). Este modelo "push-pull" (empuje y retorno) es ideal para cerraduras electrónicas, dispensadores o mecanismos que requieren un movimiento lineal rápido y fuerte. Opera con un voltaje de 12V DC y requiere un driver (ej. Transistor o Mosfet) para ser controlado.	12	4
17	Arduino Micro	Placa compacta con capacidades USB.	87000.00	9	t	https://store.arduino.cc/cdn/shop/files/A000053_01.iso_934x700.jpg?v=1727098237	f	2025-10-18 23:19:42.284205	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Pines Digitales", "valor": "20"}, {"clave": "Voltaje de Operación", "valor": "5V"}, {"clave": "Memoria Flash", "valor": "32 KB"}], "principales": [{"clave": "Microcontrolador", "valor": "ATmega32u4"}, {"clave": "Conexión USB", "valor": "Nativa (HID)"}, {"clave": "Tamaño", "valor": "Compacto"}]}	Similar al Nano pero con el ATmega32u4, el Arduino Micro es una placa compacta que también ofrece la funcionalidad de USB nativo, permitiéndole actuar como mouse o teclado. Es ideal para ser integrada en proyectos permanentes o carcasas pequeñas, combinando potencia y un factor de forma reducido.	18	8
81	Módulo Relé 4 Canales	Control de hasta cuatro dispositivos.	52000.00	30	t	https://www.dynamoelectronics.com/wp-content/uploads/2017/11/rele-4-canales.jpg	f	2025-10-19 15:59:36.564248	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de Carga Máx", "valor": "250V AC / 30V DC"}, {"clave": "Corriente Máx", "valor": "10A por canal"}, {"clave": "Uso", "valor": "Automatización avanzada"}], "principales": [{"clave": "Tipo", "valor": "Relé electromecánico"}, {"clave": "Canales", "valor": "4"}, {"clave": "Voltaje de Control", "valor": "5V DC"}]}	Módulo que ofrece cuatro relés independientes, proporcionando una solución compacta para controlar hasta cuatro cargas de alta potencia. Perfecto para proyectos de automatización avanzados, como sistemas de riego con múltiples bombas o paneles de control de luces con varias zonas. Requiere 4 pines de control digital del microcontrolador.	12	4
80	Módulo Relé 2 Canales	Relé doble para control de dos cargas.	35000.00	60	t	https://http2.mlstatic.com/D_NQ_NP_612703-MCO28975002735_122018-O.webp	f	2025-10-19 15:59:36.564248	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de Carga Máx", "valor": "250V AC / 30V DC"}, {"clave": "Corriente Máx", "valor": "10A por canal"}, {"clave": "Uso", "valor": "Domótica simple"}], "principales": [{"clave": "Tipo", "valor": "Relé electromecánico"}, {"clave": "Canales", "valor": "2"}, {"clave": "Voltaje de Control", "valor": "5V DC"}]}	Este módulo integra dos relés independientes, lo que permite controlar dos cargas separadas de forma simultánea o individual con un solo módulo. Es ideal para automatización del hogar, como controlar un ventilador y una luz, o dos etapas de un proceso industrial ligero, optimizando el espacio en el PCB.	12	4
79	Módulo Relé 1 Canal 5V	Relé para controlar cargas AC/DC desde microcontrolador.	23000.00	80	t	https://http2.mlstatic.com/D_NQ_NP_705512-MCO69722386588_052023-O.webp	t	2025-10-19 15:59:36.564248	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de Carga Máx", "valor": "250V AC / 30V DC"}, {"clave": "Corriente Máx", "valor": "10A"}, {"clave": "Aislamiento", "valor": "Optoacoplador"}], "principales": [{"clave": "Tipo", "valor": "Relé electromecánico"}, {"clave": "Canales", "valor": "1"}, {"clave": "Voltaje de Control", "valor": "5V DC"}]}	El módulo relé de 1 canal es una interfaz esencial que permite a un microcontrolador de bajo voltaje (5V) controlar dispositivos de alta potencia (AC o DC) de forma segura. El relé electromecánico proporciona aislamiento galvánico, protegiendo al microcontrolador de la línea de potencia. Es ideal para luces, electrodomésticos y bombas.	12	4
56	Sensor Step Detector	Sensor para detectar pasos y cadencia.	27000.00	10	t	https://files.seeedstudio.com/wiki/Grove-Step_Counter-BMA456/img/main.jpg	f	2025-10-19 14:46:56.74361	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje Lógico", "valor": "3.3V"}, {"clave": "Interfaz", "valor": "I2C"}, {"clave": "Aplicación", "valor": "Wearables y fitness"}], "principales": [{"clave": "Función", "valor": "Podómetro / Detección de pasos"}, {"clave": "Tecnología", "valor": "Acelerómetro de bajo consumo"}, {"clave": "Salida", "valor": "Digital (Conteo de pasos)"}]}	Este sensor es una unidad de acelerómetro de baja potencia con firmware optimizado para la detección de pasos (podómetro) y la medición de cadencia. Es una solución lista para usar en proyectos de seguimiento de actividad física y wearables, simplificando el procesamiento de datos de movimiento.	12	5
55	Sensor Magnetic Encoder	Encoder magnético para detección angular.	98000.00	6	t	https://m.media-amazon.com/images/I/61VGyCUj9tL._SL1000_.jpg	f	2025-10-19 14:46:56.74361	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Salida", "valor": "Cuadratura (A/B), Índice (Z)"}, {"clave": "Interfaz", "valor": "SPI o TTL"}, {"clave": "Uso", "valor": "Motores de precisión, CNC"}], "principales": [{"clave": "Función", "valor": "Medición angular/posición"}, {"clave": "Tecnología", "valor": "Magnética"}, {"clave": "Resolución", "valor": "Hasta 4096 cuentas por revolución"}]}	Un encoder magnético se utiliza para medir con precisión el ángulo, la posición y la velocidad de rotación de un eje. Es más resistente a la suciedad y el polvo que los encoders ópticos. El encoder genera pulsos que, al ser contados por el microcontrolador, proporcionan datos de posición con alta resolución.	4	5
54	Sensor Vibration Piezo	Elemento piezoeléctrico para detectar vibraciones.	18000.00	35	t	https://www.sparkfun.com/media/catalog/product/cache/a793f13fd3d678cea13d28206895ba0c/0/9/09199-03-L.jpg	f	2025-10-19 14:46:56.74361	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Uso", "valor": "Detección de golpes leves"}, {"clave": "Conexión", "valor": "Pinza o soldadura"}, {"clave": "Aplicación", "valor": "Feedback háptico"}], "principales": [{"clave": "Función", "valor": "Generador/Sensor de vibración"}, {"clave": "Tecnología", "valor": "Piezoeléctrica"}, {"clave": "Salida", "valor": "Analógica (Voltaje)"}]}	Este elemento piezoeléctrico genera un voltaje cuando se somete a una tensión mecánica, es decir, vibración o flexión. Es una forma económica de detectar vibraciones de alta frecuencia, golpes ligeros o medir la fuerza de impacto. Requiere un circuito de acondicionamiento de señal para una medición precisa con microcontroladores.	12	5
53	Sensor Reed Switch	Interruptor magnético para detección de puertas/ventanas.	15000.00	40	t	https://http2.mlstatic.com/D_NQ_NP_674455-MCO31035338645_062019-O.webp	f	2025-10-19 14:46:56.74361	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Activación", "valor": "Imán cercano"}, {"clave": "Salida", "valor": "Digital (Contacto)"}, {"clave": "Durabilidad", "valor": "Alta"}], "principales": [{"clave": "Función", "valor": "Detección de campo magnético"}, {"clave": "Tipo", "valor": "Interruptor (Normalmente Abierto)"}, {"clave": "Uso", "valor": "Seguridad (Puertas/Ventanas)"}]}	El Reed Switch (Interruptor de Láminas) es un interruptor eléctrico que opera por un campo magnético aplicado. Es ampliamente utilizado para la detección de apertura de puertas y ventanas en sistemas de seguridad o como sensor de posición en actuadores y mecanismos. Su funcionamiento es simple y fiable, sin piezas mecánicas complejas.	12	5
52	Sensor Gyro L3G4200D	Giroscopio 3 ejes para mediciones rotacionales.	72000.00	8	t	https://http2.mlstatic.com/D_NQ_NP_797710-MCO44166706539_112020-O.webp	f	2025-10-19 14:46:56.74361	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje Lógico", "valor": "3.3V"}, {"clave": "Uso", "valor": "Medición rotacional"}, {"clave": "Resolución", "valor": "16 bits"}], "principales": [{"clave": "Función", "valor": "Giroscopio 3 ejes"}, {"clave": "Rango Angular", "valor": "±250/±500/±2000 dps"}, {"clave": "Protocolo", "valor": "SPI / I2C"}]}	El L3G4200D es un giroscopio digital de tres ejes que mide la velocidad angular de rotación. Es ideal para complementar acelerómetros en sistemas IMU personalizados, proporcionando datos críticos para la orientación en proyectos de robótica y navegación inercial. Ofrece alta estabilidad y ancho de banda seleccionable.	23	5
51	Sensor ADXL345	Acelerómetro digital de 3 ejes de alta resolución.	68000.00	12	t	https://http2.mlstatic.com/D_Q_NP_957126-MLU74474158479_022024-O.webp	f	2025-10-19 14:46:56.74361	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Protocolo", "valor": "SPI / I2C"}, {"clave": "Voltaje Lógico", "valor": "3.3V"}, {"clave": "Aplicación", "valor": "Detección de Caída Libre"}], "principales": [{"clave": "Función", "valor": "Acelerómetro 3 ejes"}, {"clave": "Resolución", "valor": "13 bits"}, {"clave": "Rango", "valor": "±2g a ±16g"}]}	El ADXL345 es un acelerómetro de 3 ejes con alta resolución (13 bits) y amplio rango dinámico (hasta ±16g). Es una opción premium para aplicaciones que requieren mediciones precisas de aceleración, detección de caída libre, actividad o inclinación, comunicándose a través de SPI o I2C.	6	5
50	Sensor Tilt Switch	Interruptor de inclinación para detección de orientación.	21000.00	25	t	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8yJ5pLFqrSfbrbs46RirOpgwYHXxETLdk2A&s	f	2025-10-19 14:46:56.74361	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje", "valor": "5V"}, {"clave": "Uso", "valor": "Orientación simple"}, {"clave": "Diseño", "valor": "Pequeño factor de forma"}], "principales": [{"clave": "Función", "valor": "Detección de inclinación"}, {"clave": "Tipo", "valor": "Interruptor de bola"}, {"clave": "Salida", "valor": "Digital (ON/OFF)"}]}	El Tilt Switch es un interruptor simple que utiliza una pequeña bola de metal para cerrar un circuito cuando el sensor se inclina a un cierto ángulo. Se utiliza para detectar cambios de orientación o posición en proyectos sencillos, como juguetes interactivos o sistemas de seguridad de inclinación.	8	5
49	Sensor SW-420	Sensor de vibración simple para detección de golpes.	24000.00	30	t	https://http2.mlstatic.com/D_NQ_NP_918198-MLU76690505995_052024-O.webp	f	2025-10-19 14:46:56.74361	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje", "valor": "3.3V - 5V"}, {"clave": "Uso", "valor": "Alarmas de impacto"}, {"clave": "Tipo", "valor": "Mecánico"}], "principales": [{"clave": "Función", "valor": "Detección de vibración/golpe"}, {"clave": "Sensibilidad", "valor": "Ajustable"}, {"clave": "Salida", "valor": "Digital"}]}	El SW-420 es un sensor de vibración de alta sensibilidad utilizado para detectar golpes o movimientos bruscos. Su salida es digital, lo que facilita su uso en sistemas de alarma o en proyectos que simplemente necesitan saber si ha ocurrido un impacto significativo. Es un sensor mecánico económico y fácil de implementar.	12	5
48	Sensor MPU6050	Acelerómetro y giroscopio 6 ejes.	45000.00	20	t	https://www.arcaelectronica.com/cdn/shop/products/modulo-mpu6050-sensor-giroscopio-acelerometro-para-arduino_iZ573148504XvZgrandeXpZ4XfZ61349119-452750431-4XsZ61349119xIM_2048x.jpg?v=1604953078	f	2025-10-19 14:46:56.74361	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Protocolo", "valor": "I2C"}, {"clave": "DMP", "valor": "Procesador de Movimiento Digital"}, {"clave": "Voltaje Lógico", "valor": "3.3V - 5V"}], "principales": [{"clave": "Función", "valor": "IMU (6 DoF)"}, {"clave": "Giroscopio Rango", "valor": "±250 a ±2000 °/s"}, {"clave": "Acelerómetro Rango", "valor": "±2g a ±16g"}]}	El MPU6050 es una Unidad de Medición Inercial (IMU) de 6 grados de libertad (6DoF), combinando un acelerómetro de 3 ejes y un giroscopio de 3 ejes. Es fundamental para sistemas de estabilización, drones, robótica y detección de orientación espacial. Se comunica a través del protocolo I2C y es compatible con el famoso filtro de Kalman.	3	5
61	Ultrasonic JSN-SR04T	Versión waterproof del HC-SR04.	42000.00	8	t	https://m.media-amazon.com/images/I/61t8TEX2eXL._UF1000,1000_QL80_.jpg	f	2025-10-19 14:59:47.044824	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Protocolo", "valor": "Pulso (Trigger/Echo)"}, {"clave": "Voltaje", "valor": "5V"}, {"clave": "Aplicación", "valor": "Medición de nivel de líquido"}], "principales": [{"clave": "Función", "valor": "Medición de distancia"}, {"clave": "Característica", "valor": "Sonda a prueba de agua"}, {"clave": "Rango", "valor": "25cm a 450cm"}]}	El JSN-SR04T es una versión del sensor ultrasónico que incluye una sonda sellada, haciéndolo resistente al agua. Esto lo hace indispensable para medir el nivel de agua en tanques, cisternas o para aplicaciones en exteriores que estarán expuestas a la intemperie. Mantiene la misma interfaz de pulso (Trigger/Echo) del HC-SR04.	17	7
47	Sensor PIR HC-SR501	Detector de movimiento por infrarrojo pasivo.	27000.00	45	t	https://www.unipamplona.edu.co/unipamplona/portalIG/home_74/recursos/visual-basic-para-excel/17052017/mov1.jpg	t	2025-10-19 14:46:56.74361	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Salida", "valor": "Digital (HIGH/LOW)"}, {"clave": "Ángulo de Detección", "valor": "110 grados"}, {"clave": "Ajuste", "valor": "Sensibilidad y Tiempo"}], "principales": [{"clave": "Función", "valor": "Detección de movimiento PIR"}, {"clave": "Rango", "valor": "3 a 7 metros (Ajustable)"}, {"clave": "Voltaje", "valor": "4.5V a 20V"}]}	El HC-SR501 es el detector de movimiento infrarrojo pasivo (PIR) más común. Detecta cambios en la radiación infrarroja emitida por objetos calientes (como personas o animales), siendo ideal para sistemas de alarma, encendido automático de luces o contadores de personas, con ajustes de sensibilidad y tiempo integrados.	8	5
94	Nextion 3.2 Touch	Pantalla HMI táctil programable Nextion.	210000.00	6	t	https://www.nextion.in/wp-content/uploads/2021/04/C1-3.2_nextion_enhanced_hmi_display-1.jpg	t	2025-10-19 16:05:09.089941	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Táctil", "valor": "Resistiva"}, {"clave": "Programación", "valor": "Editor Nextion"}, {"clave": "Uso", "valor": "Paneles de control complejos"}], "principales": [{"clave": "Tipo", "valor": "Display HMI Inteligente"}, {"clave": "Tamaño", "valor": "3.2 pulgadas"}, {"clave": "Comunicación", "valor": "UART (Serial)"}]}	Las pantallas Nextion son displays HMI inteligentes que manejan toda la lógica de la interfaz gráfica internamente. Esto libera completamente el microcontrolador de la tarea de dibujar, permitiéndole centrarse en la lógica del proyecto. Se comunica por UART (Serial), simplificando la conexión a cualquier microcontrolador.	1	6
98	IPS TFT 3.5 touch	Pantalla IPS táctil 3.5" para proyectos avanzados.	180000.00	5	t	https://ifan-display.com/wp-content/uploads/2023/07/3.5-inch-IPS-LCD-Custom-Touch-Panel-320x480-P6.jpg	f	2025-10-19 16:05:09.089941	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Táctil", "valor": "Capacitiva o Resistiva"}, {"clave": "Resolución", "valor": "480x320 píxeles"}, {"clave": "Uso", "valor": "Interfaces de alta calidad"}], "principales": [{"clave": "Tecnología", "valor": "IPS TFT a color"}, {"clave": "Tamaño", "valor": "3.5 pulgadas"}, {"clave": "Ángulo de Visión", "valor": "Amplio (IPS)"}]}	Pantalla TFT grande (3.5 pulgadas) con tecnología IPS (In-Plane Switching), que garantiza una excelente calidad de color y amplios ángulos de visión, algo crucial para interfaces de usuario. Incluye una capa táctil (a menudo capacitiva) y se conecta típicamente por una interfaz de alta velocidad como SPI o paralelo.	12	6
92	TFT 1.8 SPI	Pantalla TFT a color 1.8" SPI para Arduino.	58000.00	12	t	https://www.canadarobotix.com/cdn/shop/files/3056_1_1024x1024@2x.jpg?v=1692983178	f	2025-10-19 16:05:09.089941	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Resolución", "valor": "160x128 píxeles (Típico)"}, {"clave": "Voltaje Lógico", "valor": "3.3V"}, {"clave": "Uso", "valor": "Visualización gráfica"}], "principales": [{"clave": "Tecnología", "valor": "TFT a color"}, {"clave": "Tamaño", "valor": "1.8 pulgadas"}, {"clave": "Interfaz", "valor": "SPI"}]}	Pantalla TFT (Thin-Film Transistor) a color de 1.8 pulgadas. Ofrece una visualización colorida y es ideal para mostrar gráficos, imágenes y elementos de interfaz de usuario más atractivos. Utiliza la interfaz SPI, que es rápida y requiere pocos pines de control, siendo compatible con la mayoría de los microcontroladores.	12	6
90	LCD 16x2 I2C	Pantalla alfanumérica con adaptador I2C.	25000.00	50	t	https://http2.mlstatic.com/D_NQ_NP_2X_674701-MCO79110255389_092024-F.webp	f	2025-10-19 16:05:09.089941	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Retroiluminación", "valor": "LED (Controlable)"}, {"clave": "Voltaje", "valor": "5V"}, {"clave": "Ventaja", "valor": "Ahorro de pines GPIO"}], "principales": [{"clave": "Tipo", "valor": "LCD Alfanumérico"}, {"clave": "Formato", "valor": "16 caracteres x 2 líneas"}, {"clave": "Interfaz", "valor": "I2C (con PCF8574)"}]}	El clásico display LCD alfanumérico de 16 caracteres por 2 líneas, esencial para mostrar texto. Este módulo incluye un adaptador I2C (basado en PCF8574), lo que reduce la conexión de 16 pines a solo 4 pines (VCC, GND, SDA, SCL), simplificando enormemente el cableado en proyectos con recursos limitados.	12	6
95	E-Ink 2.13 inch	Pantalla e-ink de baja potencia para info estática.	98000.00	8	t	https://http2.mlstatic.com/D_NQ_NP_652612-CBT54840799381_042023-O.webp	f	2025-10-19 16:05:09.089941	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Interfaz", "valor": "SPI"}, {"clave": "Uso", "valor": "Etiquetas / Señalización estática"}, {"clave": "Color", "valor": "Blanco y Negro (típico)"}], "principales": [{"clave": "Tecnología", "valor": "Tinta Electrónica (E-Ink)"}, {"clave": "Tamaño", "valor": "2.13 pulgadas"}, {"clave": "Ventaja", "valor": "Consumo de energía ultra bajo"}]}	Las pantallas de tinta electrónica (E-Ink) consumen energía solo cuando se actualiza el contenido; el display se mantiene visible de forma estática sin consumir. Son ideales para etiquetas de precio electrónicas, señalización digital estática o para displays de bajo consumo en dispositivos alimentados por batería. Ofrecen un contraste similar al papel.	10	6
91	LCD 20x4 I2C	Pantalla 20x4 con interfaz I2C para proyectos.	55000.00	18	t	https://www.didacticaselectronicas.com/web/image/product.product/5417/image_1024/%5BLCD-2004-I2C-A%5D%20Display%20LCD%2020x4%20interfaz%20I2C%20Azul?unique=7b798d1	f	2025-10-19 16:05:09.089941	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Retroiluminación", "valor": "LED"}, {"clave": "Voltaje", "valor": "5V"}, {"clave": "Uso", "valor": "Visualización de datos grandes"}], "principales": [{"clave": "Tipo", "valor": "LCD Alfanumérico"}, {"clave": "Formato", "valor": "20 caracteres x 4 líneas"}, {"clave": "Interfaz", "valor": "I2C"}]}	Una pantalla alfanumérica de mayor capacidad, mostrando 20 caracteres por 4 líneas de texto. Al igual que la 16x2, esta versión incluye el adaptador I2C, lo que la hace perfecta para mostrar grandes cantidades de datos o menús de estado en proyectos de automatización, medición o instrumentación de forma clara.	12	6
97	Graphical LCD 128x64	LCD gráfico para menús sencillos.	42000.00	14	t	https://cdn1-shop.mikroe.com/img/product/glcd-128x64/glcd-128x64-large_default-1.jpg?v=100	f	2025-10-19 16:05:09.089941	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Retroiluminación", "valor": "LED"}, {"clave": "Interfaz", "valor": "SPI o Paralelo"}, {"clave": "Uso", "valor": "Menús y gráficos simples"}], "principales": [{"clave": "Tipo", "valor": "LCD Gráfico"}, {"clave": "Resolución", "valor": "128x64 píxeles"}, {"clave": "Driver", "valor": "ST7920 (típico)"}]}	Pantalla LCD gráfica con una resolución de 128x64 píxeles. A diferencia de las LCD alfanuméricas, permite dibujar gráficos simples, iconos y diferentes fuentes de texto. Utiliza el driver ST7920 (u similar) y es ideal para menús de estado o interfaces gráficas de usuario en proyectos que requieren visualización de datos complejos.	12	6
89	OLED 1.3 inch	Pantalla OLED I2C 128x64 de mayor tamaño.	49000.00	22	t	https://electronilab.co/wp-content/uploads/2020/11/Display-OLED-1.3-128%C3%9764-I2C-Bajo-Consumo-Blanco-1.jpg	f	2025-10-19 16:05:09.089941	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Interfaz", "valor": "I2C"}, {"clave": "Color", "valor": "Monocromo (Blanco/Azul)"}, {"clave": "Uso", "valor": "Mejor legibilidad"}], "principales": [{"clave": "Tecnología", "valor": "OLED (Autoiluminada)"}, {"clave": "Resolución", "valor": "128x64 píxeles"}, {"clave": "Tamaño", "valor": "1.3 pulgadas"}]}	Una versión de mayor tamaño de la popular pantalla OLED monocroma, con 1.3 pulgadas de diagonal y resolución 128x64. El aumento de tamaño mejora la legibilidad, manteniéndose compacta y utilizando la interfaz I2C, lo que minimiza el número de pines requeridos para la conexión con el microcontrolador.	24	6
88	OLED 0.96 inch I2C	Pantalla OLED monocroma 128x64 I2C.	39000.00	30	t	https://www.smart-prototyping.com/image/cache/data/9_Modules/101864%200.96%20IIC/1-750x750.jpg	t	2025-10-19 16:05:09.089941	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Color", "valor": "Monocromo (Blanco/Azul)"}, {"clave": "Tamaño", "valor": "0.96 pulgadas"}, {"clave": "Ventaja", "valor": "Bajo consumo, Alto contraste"}], "principales": [{"clave": "Tecnología", "valor": "OLED (Autoiluminada)"}, {"clave": "Resolución", "valor": "128x64 píxeles"}, {"clave": "Interfaz", "valor": "I2C"}]}	La pantalla OLED de 0.96 pulgadas es una de las opciones de visualización más populares. Utiliza una matriz de puntos orgánicos autoiluminados, ofreciendo un contraste perfecto (negro verdadero) y un consumo de energía muy bajo. Su pequeño tamaño e interfaz I2C la hacen ideal para wearables, dispositivos portátiles y proyectos con microcontroladores.	24	6
93	TFT 2.4 Touch	Pantalla táctil 2.4" SPI a color.	76000.00	9	t	https://http2.mlstatic.com/D_NQ_NP_832109-MCO54340942752_032023-O.webp	t	2025-10-19 16:05:09.089941	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Interfaz", "valor": "SPI (generalmente)"}, {"clave": "Resolución", "valor": "320x240 píxeles"}, {"clave": "Uso", "valor": "HMI (Interfaz de Usuario)"}], "principales": [{"clave": "Tecnología", "valor": "TFT a color con Touch"}, {"clave": "Tamaño", "valor": "2.4 pulgadas"}, {"clave": "Táctil", "valor": "Resistiva"}]}	Pantalla TFT a color de 2.4 pulgadas que incorpora una capa táctil resistiva. Esto la convierte en un componente clave para crear Interfaces Hombre-Máquina (HMI) sencillas, permitiendo la interacción directa del usuario. Es ideal para proyectos de control de clima o pequeños paneles de control.	12	6
65	ToF VL6180X	Sensor ToF para mediciones de muy corto alcance.	47000.00	9	t	https://http2.mlstatic.com/D_NQ_NP_638537-MCO44167315107_112020-O.webp	f	2025-10-19 14:59:47.044824	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Protocolo", "valor": "I2C"}, {"clave": "Precisión", "valor": "Alta (mm)"}, {"clave": "Voltaje Lógico", "valor": "3.3V"}], "principales": [{"clave": "Función", "valor": "Proximidad y luz"}, {"clave": "Tecnología", "valor": "Time-of-Flight (ToF)"}, {"clave": "Rango Máx", "valor": "100 mm (Proximidad)"}]}	El VL6180X es otro sensor láser Time-of-Flight (ToF) de STMicroelectronics, pero optimizado para distancias muy cortas (hasta unos 100mm). Además de distancia, puede medir la luz ambiente. Es excelente para detección de gestos, corrección de color y aplicaciones que requieren una respuesta de proximidad extremadamente rápida y precisa.	23	7
64	Ultrasonic Mini Module	Módulo ultrasónico mini para prototipos.	28000.00	25	t	https://electropeak.com/media/catalog/product/cache/a99a51fafac039a73087ecfaa8ccceba/s/e/sen-07-023-1.jpg	f	2025-10-19 14:59:47.044824	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Protocolo", "valor": "Pulso (Trigger/Echo)"}, {"clave": "Voltaje", "valor": "5V"}, {"clave": "Consumo", "valor": "Bajo consumo"}], "principales": [{"clave": "Función", "valor": "Medición de distancia"}, {"clave": "Tamaño", "valor": "Miniatura"}, {"clave": "Rango", "valor": "Menor a 3 metros"}]}	Módulo de distancia ultrasónico compacto y de bajo consumo, ideal para integrarse discretamente en pequeños robots o dispositivos portátiles. Aunque su alcance es generalmente menor que el HC-SR04, su tamaño miniatura lo convierte en la mejor opción para prototipos donde el factor de forma es crucial.	12	7
63	Capacitive Proximity	Sensor capacitivo para detección sin contacto.	54000.00	6	t	https://circuit.rocks/cdn/shop/products/capacitive-proximity-sensor-ljc18a3-h-z-by-1831.jpg?v=1689739797	f	2025-10-19 14:59:47.044824	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Salida", "valor": "Digital (PNP/NPN)"}, {"clave": "Uso Industrial", "valor": "Detección de nivel/objeto"}, {"clave": "Rango", "valor": "Hasta 20mm (variable)"}], "principales": [{"clave": "Función", "valor": "Detección sin contacto (general)"}, {"clave": "Principio", "valor": "Capacitivo"}, {"clave": "Detección", "valor": "Metales y No-Metales"}]}	El sensor de proximidad capacitivo detecta objetos que tienen una constante dieléctrica diferente a la del aire, incluyendo metales, líquidos, plásticos y otros materiales no metálicos. Se utiliza a menudo en la industria para contar piezas o detectar la presencia de material a través de una pared de contenedor.	12	7
62	Infrared Reflective Sensor	Sensor reflectivo para líneas y proximidad.	20000.00	35	t	https://www.waveshare.com/media/catalog/product/i/n/infrared-reflective-sensor_l_1_5.jpg	f	2025-10-19 14:59:47.044824	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Uso Principal", "valor": "Robot seguidor de línea"}, {"clave": "Voltaje", "valor": "3.3V - 5V"}, {"clave": "Rango", "valor": "Muy corto (milímetros)"}], "principales": [{"clave": "Función", "valor": "Detección de contraste/línea"}, {"clave": "Tecnología", "valor": "Infrarrojo"}, {"clave": "Salida", "valor": "Digital y Analógica"}]}	Este pequeño módulo, a menudo llamado sensor TCRT5000, utiliza luz infrarroja para detectar la reflectividad de una superficie. Es el sensor de elección para los robots seguidores de línea (detecta el contraste entre la línea oscura y la superficie clara) y también sirve como un simple sensor de proximidad a muy corta distancia.	12	7
60	Sharp GP2Y0A21YK0F	Sensor analógico de distancia optico.	48000.00	10	t	https://ferretronica.com/cdn/shop/products/GP2Y0A21YK0F_Sensor_de_distancia_Sharp_10_cm_80_cm_GP2Y0A21_ferretronica_x700.jpg?v=1577020850	f	2025-10-19 14:59:47.044824	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Marca", "valor": "Sharp"}, {"clave": "Voltaje", "valor": "5V"}, {"clave": "Ventaja", "valor": "Lectura estable"}], "principales": [{"clave": "Función", "valor": "Medición de distancia (Óptico)"}, {"clave": "Rango", "valor": "10cm a 80cm"}, {"clave": "Salida", "valor": "Analógica (Voltaje)"}]}	El Sharp GP2Y0A21YK0F es un sensor de distancia óptico que proporciona una salida de voltaje analógica inversamente proporcional a la distancia del objeto. Es más preciso que el ultrasonido en distancias específicas y es muy popular en robótica para la detección de obstáculos en un rango medio (10 cm a 80 cm).	16	7
59	IR Proximity Module	Sensor infrarrojo de proximidad para detección corta.	35000.00	30	t	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnl5x2IBnGZ9V53dSGbRBMsR79ethtyHpejA&s	f	2025-10-19 14:59:47.044824	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Rango Típico", "valor": "1cm a 5cm"}, {"clave": "Voltaje", "valor": "5V"}, {"clave": "Aplicación", "valor": "Seguidor de línea"}], "principales": [{"clave": "Función", "valor": "Detección de proximidad"}, {"clave": "Tecnología", "valor": "Infrarrojo Reflectivo"}, {"clave": "Salida", "valor": "Digital"}]}	Este módulo utiliza un LED infrarrojo y un fototransistor para detectar la presencia de un objeto a corta distancia (unos pocos centímetros). Es comúnmente usado como sensor de barrera o para detección de línea en robots seguidores. Su funcionamiento es simple y su salida es un estado digital (detectado/no detectado).	12	7
58	VL53L0X ToF	Sensor láser ToF de rango corto con alta precisión.	65000.00	12	t	https://ja-bots.com/wp-content/uploads/2021/06/Tof-VL53LOX.jpg	t	2025-10-19 14:59:47.044824	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Protocolo", "valor": "I2C"}, {"clave": "Precisión", "valor": "Milimétrica"}, {"clave": "Voltaje Lógico", "valor": "3.3V"}], "principales": [{"clave": "Función", "valor": "Medición de distancia Láser"}, {"clave": "Tecnología", "valor": "Time-of-Flight (ToF)"}, {"clave": "Rango", "valor": "Hasta 2 metros"}]}	El VL53L0X es un sensor de distancia láser que utiliza la tecnología Time-of-Flight (ToF). A diferencia del ultrasonido, el láser ofrece una precisión mucho mayor en distancias cortas y no se ve afectado por la acústica del entorno. Es ideal para aplicaciones de enfoque de cámara, detección de gestos y medición de alta velocidad.	23	7
57	HC-SR04 Ultrasonico	Sensor ultrasónico para medir distancia.	30000.00	50	t	https://http2.mlstatic.com/D_NQ_NP_672133-MCO51471975920_092022-O.webp	t	2025-10-19 14:59:47.044824	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Salida", "valor": "Tiempo de vuelo (Pulso)"}, {"clave": "Voltaje", "valor": "5V"}, {"clave": "Uso", "valor": "Robótica / Nivel"}], "principales": [{"clave": "Función", "valor": "Medición de distancia"}, {"clave": "Principio", "valor": "Ultrasonido (Eco)"}, {"clave": "Rango", "valor": "2cm a 400cm"}]}	El HC-SR04 es el sensor de distancia ultrasónico más popular. Utiliza el principio de eco-localización para calcular la distancia a un objeto. Es muy fácil de usar con Arduino y otros microcontroladores, siendo fundamental para proyectos de robótica (evasión de obstáculos) y medición de niveles simples. Es robusto y económico.	9	7
24	Arduino Sensor Kit	Kit de sensores compatibles con Arduino.	48000.00	16	t	https://tauxi.com.co/wp-content/uploads/2021/07/unnamed-min.jpg.webp	f	2025-10-18 23:19:42.284205	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Sensores Comunes", "valor": "PIR, DHT11, Ultrasónico"}, {"clave": "Objetivo", "valor": "Proyectos de E/S"}, {"clave": "Conexión", "valor": "Digital y Analógica"}], "principales": [{"clave": "Contenido", "valor": "Módulos de sensores"}, {"clave": "Uso", "valor": "Experimentación y Prototipo"}, {"clave": "Compatibilidad", "valor": "Arduino y similares"}]}	Este kit es una colección de los sensores más comunes y útiles en el ecosistema Arduino, incluyendo módulos de temperatura, humedad, movimiento, luz y más. Es el complemento ideal para cualquier placa de desarrollo, proporcionando una base sólida para experimentar con diferentes tipos de entradas y crear proyectos funcionales y variados.	18	8
22	Arduino MKR WiFi 1010	MKR con conectividad WiFi y crypto.	220000.00	6	t	https://www.didacticaselectronicas.com/web/image/product.template/11459/image_1024?unique=188e833	f	2025-10-18 23:19:42.284205	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de Operación", "valor": "3.3 V"}, {"clave": "Batería", "valor": "Soporte Li-Po"}, {"clave": "Uso Principal", "valor": "IoT Seguro"}], "principales": [{"clave": "Microcontrolador", "valor": "SAM D21"}, {"clave": "Conectividad", "valor": "WiFi, Bluetooth"}, {"clave": "Seguridad", "valor": "Chip Crypto ECC608"}]}	Parte de la familia MKR, el WiFi 1010 combina el potente SAM D21 con el módulo U-BLOX NINA-W10 (que incluye WiFi y Bluetooth) y un chip criptográfico ECC608. Esta combinación lo convierte en una opción segura y robusta para proyectos de IoT conectados, donde la seguridad de los datos y la fiabilidad de la conexión son prioritarias.	18	8
21	Arduino MKR Zero	Placa MKR para proyectos de audio y SD.	145000.00	5	t	https://www.didacticaselectronicas.com/web/image/product.template/17418/image_1024?unique=8be750c	f	2025-10-18 23:19:42.284205	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de Operación", "valor": "3.3 V"}, {"clave": "Conector", "valor": "I2S"}, {"clave": "Velocidad de Reloj", "valor": "48 MHz"}], "principales": [{"clave": "Microcontrolador", "valor": "SAM D21 (32 bit)"}, {"clave": "Función", "valor": "Audio y Datalogging"}, {"clave": "Almacenamiento", "valor": "Slot SD"}]}	El MKR Zero es una placa compacta ideal para aplicaciones que involucran audio o almacenamiento masivo de datos. Utiliza un chip SAM D21 (Cortex-M0+) y cuenta con un lector de tarjetas SD a bordo y un conector I2S. Es perfecto para proyectos de grabación de datos (datalogging) y procesamiento de señales de audio con bajo consumo.	18	8
19	Arduino Portenta H7	Placa industrial con doble core y Mbed.	620000.00	2	t	https://http2.mlstatic.com/D_Q_NP_971918-MLU79097230504_092024-O.webp	t	2025-10-18 23:19:42.284205	2025-10-21 20:44:28.652021	{"otros": [{"clave": "RAM", "valor": "1 MB"}, {"clave": "Velocidad M7", "valor": "480 MHz"}, {"clave": "Soporte OS", "valor": "Mbed OS"}], "principales": [{"clave": "Microcontrolador", "valor": "STM32H747 (Dual Core)"}, {"clave": "Conectividad", "valor": "WiFi/BLE/Ethernet"}, {"clave": "Uso", "valor": "Industrial/Edge AI"}]}	La Portenta H7 es una placa de desarrollo de grado industrial y de alto rendimiento. Utiliza un procesador de doble núcleo (Cortex-M7 y Cortex-M4), está diseñada para aplicaciones de Machine Learning en el borde y operaciones industriales críticas. Es compatible con el ecosistema Mbed OS y puede ejecutar código Python.	18	8
18	Arduino Uno SMD	Versión con componentes montados en SMD.	92000.00	14	t	https://store.arduino.cc/cdn/shop/files/A000073_00.front_1200x900.jpg?v=1727098256	f	2025-10-18 23:19:42.284205	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de Operación", "valor": "5V"}, {"clave": "Entradas Analógicas", "valor": "6"}, {"clave": "Velocidad de Reloj", "valor": "16 MHz"}], "principales": [{"clave": "Microcontrolador", "valor": "ATmega328P (SMD)"}, {"clave": "Diseño", "valor": "Montaje en superficie"}, {"clave": "Pines Digitales", "valor": "14"}]}	El Arduino Uno SMD es una variante del Uno R3 donde el microcontrolador (ATmega328P) viene montado en superficie (SMD) en lugar de un zócalo. Esto hace la placa más robusta y ligeramente más económica, aunque el chip no es reemplazable. Mantiene toda la funcionalidad y compatibilidad del Uno estándar, ideal para entornos más exigentes.	18	8
20	Arduino Ethernet Shie	Shield para conectar Arduino por Ethernet.	118000.00	7	t	https://docs.arduino.cc/static/61f89cdbee1f4b4d00168ea63d9fbd6a/6aca1/a000072_featured.jpg	f	2025-10-19 04:19:42.284	2025-10-25 06:38:16.668483	{"otros": [{"clave": "Compatibilidad", "valor": "Arduino Uno/Mega"}, {"clave": "Almacenamiento", "valor": "Slot MicroSD"}, {"clave": "Velocidad", "valor": "10/100 Mbps"}], "principales": [{"clave": "Función", "valor": "Conectividad de Red"}, {"clave": "Chip", "valor": "W5100"}, {"clave": "Conexión", "valor": "RJ45 Ethernet"}]}	El Arduino Ethernet Shield permite conectar cualquier placa Arduino compatible (como el Uno o Mega) a una red cableada a través de un conector RJ45. Es esencial para proyectos de IoT o automatización que requieren una conexión a internet estable y fiable por cable, además de incluir un slot para tarjeta SD para almacenamiento de datos.	18	8
16	Arduino Pro Mini 5V	Placa pequeña para proyectos embebidos.	75000.00	18	t	https://electronilab.co/wp-content/uploads/2015/02/Arduino-Pro-Mini-328-5V16-MHz-new-2.jpg	f	2025-10-18 23:19:42.284205	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de Operación", "valor": "5V"}, {"clave": "Pines Digitales", "valor": "14"}, {"clave": "Memoria Flash", "valor": "32 KB"}], "principales": [{"clave": "Microcontrolador", "valor": "ATmega328P"}, {"clave": "Conector", "valor": "Requiere FTDI externo"}, {"clave": "Diseño", "valor": "Embebido y compacto"}]}	El Arduino Pro Mini es la opción más pequeña y ligera para proyectos donde el tamaño y el peso son críticos, como drones pequeños o dispositivos vestibles. No incluye conector USB, por lo que requiere un conversor USB a serial externo (FTDI) para su programación. Es la solución para integraciones permanentes de bajo perfil.	18	8
15	Arduino Leonardo	Arduino con USB nativo para emular periféricos.	99000.00	12	t	https://store.arduino.cc/cdn/shop/files/A000057_03.front_934x700.jpg?v=1727098244	f	2025-10-18 23:19:42.284205	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de Operación", "valor": "5V"}, {"clave": "Memoria Flash", "valor": "32 KB"}, {"clave": "Velocidad de Reloj", "valor": "16 MHz"}], "principales": [{"clave": "Microcontrolador", "valor": "ATmega32u4"}, {"clave": "Conexión USB", "valor": "Nativa (HID)"}, {"clave": "Pines Digitales", "valor": "20"}]}	El Arduino Leonardo utiliza un microcontrolador ATmega32u4 que posee comunicación USB incorporada. Esto le permite emular un mouse o un teclado, haciéndolo perfecto para proyectos de interfaz humana (HID) o dispositivos de juego personalizados sin necesidad de un chip conversor USB externo, simplificando el desarrollo de interfaces.	18	8
14	Arduino Mega 2560	Placa Arduino Mega con 54 pines digitales.	135000.00	10	t	https://www.didacticaselectronicas.com/web/image/product.template/1138/image_1024?unique=530b177	f	2025-10-18 23:19:42.284205	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Entradas Analógicas", "valor": "16"}, {"clave": "UARTs", "valor": "4"}, {"clave": "Velocidad de Reloj", "valor": "16 MHz"}], "principales": [{"clave": "Microcontrolador", "valor": "ATmega2560"}, {"clave": "Pines Digitales", "valor": "54"}, {"clave": "Memoria Flash", "valor": "256 KB"}]}	El Arduino Mega 2560 es la placa ideal para proyectos ambiciosos que requieren una gran cantidad de entradas/salidas. Con 54 pines digitales, 16 entradas analógicas y 4 UARTs (puertos seriales), el Mega está diseñado para impresoras 3D, robótica compleja y proyectos que interactúan con muchos sensores y actuadores simultáneamente, gracias a su potente microcontrolador ATmega2560.	18	8
13	Arduino Nano V3	Arduino Nano con CH340 USB, ideal para prototipos.	69000.00	25	t	https://electronilab.co/wp-content/uploads/2015/02/Arduino-Nano-V3-ATmega328-5V-Cable-USB-Compatible-1.webp	f	2025-10-18 23:19:42.284205	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Pines Digitales", "valor": "14 (6 PWM)"}, {"clave": "Voltaje de Entrada", "valor": "7-12V (Recomendado)"}, {"clave": "SRAM", "valor": "2 KB"}], "principales": [{"clave": "Microcontrolador", "valor": "ATmega328P"}, {"clave": "Conector", "valor": "Mini-USB (CH340)"}, {"clave": "Tamaño", "valor": "Compacto, para protoboard"}]}	El Arduino Nano es una versión pequeña, completa y amigable para protoboard de la popular plataforma Arduino. Es la opción preferida para proyectos compactos o integrados. Esta versión incluye el chip CH340 para la comunicación USB, ofreciendo un gran rendimiento a un costo muy accesible y facilitando la creación de prototipos miniaturizados.	18	8
12	Arduino Uno R3 Original	Placa Arduino UNO R3 original con ATmega328P.	89000.00	30	t	https://www.dynamoelectronics.com/wp-content/uploads/2016/11/arduino-uno-R3-compressor.png	t	2025-10-18 23:19:42.284205	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Pines Digitales", "valor": "14 (6 PWM)"}, {"clave": "Entradas Analógicas", "valor": "6"}, {"clave": "Velocidad de Reloj", "valor": "16 MHz"}], "principales": [{"clave": "Microcontrolador", "valor": "ATmega328P"}, {"clave": "Voltaje de Operación", "valor": "5V"}, {"clave": "Memoria Flash", "valor": "32 KB"}]}	La placa Arduino Uno R3 es el punto de partida para la electrónica y la programación. Utiliza el microcontrolador ATmega328P, es la versión original y más estable, ideal para estudiantes, artistas y aficionados. Cuenta con 14 pines digitales, 6 entradas analógicas y es compatible con el vasto ecosistema de shields y bibliotecas de Arduino, proporcionando una base sólida para cualquier proyecto electrónico.	18	8
46	Sensor UV	Sensor de radiación ultravioleta (UV).	47000.00	7	t	https://www.didacticaselectronicas.com/web/image/product.template/7839/image_1024?unique=02e8a4f	f	2025-10-19 14:46:44.477628	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Rango", "valor": "UV-A y UV-B"}, {"clave": "Voltaje", "valor": "3.3V - 5V"}, {"clave": "Aplicación", "valor": "Alertas solares"}], "principales": [{"clave": "Función", "valor": "Radiación Ultravioleta (UV)"}, {"clave": "Salida", "valor": "Analógica"}, {"clave": "Uso", "valor": "Monitoreo solar"}]}	Este sensor está diseñado para detectar y medir la intensidad de la radiación ultravioleta (UV) del sol. Es útil para proyectos de estaciones meteorológicas, sistemas de alerta solar o dispositivos wearables que monitorean la exposición solar. La salida es generalmente analógica y proporcional al índice UV, permitiendo cálculos de riesgo solar.	24	9
45	Sensor Humedad Capacitivo	Sensor de humedad del suelo (capacitivo).	39000.00	16	t	https://http2.mlstatic.com/D_NQ_NP_784376-MCO77603077951_072024-O.webp	f	2025-10-19 14:46:44.477628	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje", "valor": "3.3V - 5V"}, {"clave": "Ventaja", "valor": "Larga vida útil"}, {"clave": "Uso", "valor": "Sistemas de riego"}], "principales": [{"clave": "Función", "valor": "Humedad del suelo"}, {"clave": "Tecnología", "valor": "Capacitiva (Anticorrosión)"}, {"clave": "Salida", "valor": "Analógica"}]}	A diferencia de los sensores resistivos de humedad del suelo, este sensor utiliza tecnología capacitiva, midiendo la humedad del suelo sin contacto directo con el metal. Esto lo hace mucho más resistente a la corrosión y garantiza una vida útil prolongada, ideal para sistemas de riego inteligentes y jardinería automatizada y monitoreo a largo plazo.	17	9
43	Sensor PM2.5	Sensor de partículas para calidad del aire.	85000.00	9	t	https://files.seeedstudio.com/wiki/Grove-Laser_PM2.5_Sensor-HM3301/img/main.jpg	f	2025-10-19 14:46:44.477628	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Salida", "valor": "UART"}, {"clave": "Voltaje", "valor": "5V"}, {"clave": "Aplicación", "valor": "Contaminación atmosférica"}], "principales": [{"clave": "Función", "valor": "Partículas finas en aire"}, {"clave": "Medición", "valor": "PM2.5 / PM10"}, {"clave": "Tecnología", "valor": "Dispersión de luz láser"}]}	El sensor PM2.5 (Particulate Matter 2.5) mide la concentración de partículas muy finas en el aire, que son consideradas las más dañinas para la salud. Utiliza tecnología láser para contar y estimar la masa de las partículas, siendo esencial para crear sistemas de monitoreo de contaminación atmosférica urbana y doméstica.	26	9
42	Sensor CO2 NDIR	Sensor de CO2 NDIR para mediciones precisas.	320000.00	4	t	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY7spMZLRAHWWKRTQrRrid2N-5P4K3ujinug&s	f	2025-10-19 14:46:44.477628	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Rango", "valor": "0 a 5000 PPM"}, {"clave": "Salida", "valor": "UART/I2C"}, {"clave": "Uso", "valor": "Alta precisión"}], "principales": [{"clave": "Función", "valor": "Dióxido de Carbono (CO2)"}, {"clave": "Tecnología", "valor": "NDIR (Infrarrojo)"}, {"clave": "Medición", "valor": "PPM (partes por millón)"}]}	Este es un sensor de Dióxido de Carbono (CO2) que utiliza la tecnología de Infrarrojo No Dispersivo (NDIR). Esta tecnología es el estándar de oro para mediciones precisas y estables de CO2 en PPM (partes por millón), siendo crucial para el monitoreo de ventilación, calidad del aire en oficinas y entornos médicos o de cultivo.	20	9
41	Sensor LM35	Sensor analógico de temperatura.	25000.00	28	t	https://http2.mlstatic.com/D_NQ_NP_855956-MCO43078773051_082020-O.webp	f	2025-10-19 14:46:44.477628	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de Operación", "valor": "4V a 30V"}, {"clave": "Precisión", "valor": "±0.5°C"}, {"clave": "Tipo", "valor": "Circuito integrado de precisión"}], "principales": [{"clave": "Función", "valor": "Temperatura analógica"}, {"clave": "Salida", "valor": "10 mV/°C"}, {"clave": "Rango", "valor": "0°C a +100°C"}]}	El LM35 es un sensor de temperatura analógico cuya salida de voltaje es linealmente proporcional a la temperatura en grados Celsius. No requiere circuitería adicional y es muy fácil de usar con microcontroladores que tienen entradas analógicas. Es una opción robusta y económica para medir temperaturas en un rango moderado.	14	9
40	Sensor AirQuality VOC	Sensor VOC para compuestos orgánicos volátiles.	52000.00	10	t	https://cdn11.bigcommerce.com/s-e7ighpotvb/images/stencil/1280x1280/products/131/782/ES-12127-1__93502.1703331692.jpg?c=1	f	2025-10-19 14:46:44.477628	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje Lógico", "valor": "3.3V / 5V"}, {"clave": "Tecnología", "valor": "MOS"}, {"clave": "Aplicación", "valor": "Automatización del hogar"}], "principales": [{"clave": "Función", "valor": "VOC (Compuestos Orgánicos Volátiles)"}, {"clave": "Uso", "valor": "Calidad del aire interior"}, {"clave": "Salida", "valor": "Digital (I2C o similar)"}]}	Este sensor detecta Compuestos Orgánicos Volátiles (VOC) que se liberan de pinturas, limpiadores, muebles y otros elementos comunes en interiores. La medición de VOC es un excelente indicador de la calidad del aire interior y la ventilación. Ideal para sistemas domóticos inteligentes que ajustan la ventilación automáticamente.	12	9
39	Sensor MQ-2	Sensor de gases inflamables y humo.	38000.00	20	t	https://http2.mlstatic.com/D_NQ_NP_859694-MCO77110175358_062024-O.webp	f	2025-10-19 14:46:44.477628	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de Calefacción", "valor": "5V"}, {"clave": "Salida", "valor": "Analógica y Digital"}, {"clave": "Uso", "valor": "Alarmas de seguridad"}], "principales": [{"clave": "Función", "valor": "Detección de gases inflamables"}, {"clave": "Detección", "valor": "GLP, Propano, Humo"}, {"clave": "Tipo", "valor": "Semiconductor"}]}	El MQ-2 es un sensor de gas de la serie MQ optimizado para detectar gases inflamables como el GLP, propano, metano (gas natural), hidrógeno, y humo. Se utiliza ampliamente en sistemas de alarma de fugas de gas y detectores de incendios debido a su alta sensibilidad y bajo tiempo de respuesta, crucial para la seguridad.	17	9
38	Sensor MQ-135	Sensor para calidad de aire y CO2 aproximado.	41000.00	18	t	https://www.sigmaelectronica.net/wp-content/uploads/2013/08/MQ-135.png	f	2025-10-19 14:46:44.477628	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje de Calefacción", "valor": "5V"}, {"clave": "Salida", "valor": "Analógica"}, {"clave": "Uso", "valor": "Monitoreo interior"}], "principales": [{"clave": "Función", "valor": "Calidad del aire"}, {"clave": "Detección", "valor": "CO2, NH3, Nox, Alcohol"}, {"clave": "Tipo", "valor": "Semiconductor de óxido de estaño"}]}	El MQ-135 es un sensor de gas semiconductor que se utiliza para detectar una amplia gama de gases nocivos, incluyendo amoníaco, sulfuro, benceno y, de forma aproximada, CO2. Es fundamental para sistemas de monitoreo de calidad del aire interior, alertando sobre la presencia de contaminantes y requiriendo un periodo de calentamiento inicial.	17	9
37	Sensor BME280	Sensor de presión, temperatura y humedad (alta precisión).	78000.00	12	t	https://www.didacticaselectronicas.com/web/image/product.template/14317/image_1024?unique=058f53a	f	2025-10-19 14:46:44.477628	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje Lógico", "valor": "3.3V"}, {"clave": "Rango de Humedad", "valor": "0% - 100%"}, {"clave": "Aplicación", "valor": "Estaciones meteorológicas"}], "principales": [{"clave": "Función", "valor": "P, T y Humedad"}, {"clave": "Protocolo", "valor": "I2C / SPI"}, {"clave": "Precisión", "valor": "Máxima de la serie"}]}	El BME280 es el sensor ambiental más avanzado de Bosch, combinando presión barométrica, temperatura y humedad en un solo chip. Es la opción de alta precisión para aplicaciones climáticas profesionales, sistemas de control de aire acondicionado y monitoreo ambiental avanzado. Es compatible con interfaces I2C y SPI y destaca por su estabilidad a largo plazo.	2	9
36	Sensor BMP280	Sensor de presión barométrica y temperatura.	42000.00	22	t	https://www.didacticaselectronicas.com/web/image/product.image/23558/image_1024/Imagen%20extra%20de%2015399.790000?unique=e95fb18	f	2025-10-19 14:46:44.477628	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Voltaje Lógico", "valor": "3.3V"}, {"clave": "Rango de Presión", "valor": "300 a 1100 hPa"}, {"clave": "Consumo", "valor": "Bajo consumo"}], "principales": [{"clave": "Función", "valor": "Presión y Temperatura"}, {"clave": "Protocolo", "valor": "I2C / SPI"}, {"clave": "Uso", "valor": "Altímetro de precisión"}]}	El BMP280 de Bosch es un sensor ambiental altamente integrado que mide la presión barométrica y la temperatura. Está optimizado para dispositivos de bajo consumo, como rastreadores de actividad y navegadores de interior, ya que su medición de presión permite calcular la altitud con gran precisión. Utiliza interfaces I2C y SPI para comunicación rápida.	2	9
44	Sensor O3	Sensor de ozono para aplicaciones ambientales.	76000.00	6	t	https://m.media-amazon.com/images/I/61swiWPvt3L.jpg	f	2025-10-19 14:46:44.477628	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Salida", "valor": "Analógica"}, {"clave": "Voltaje", "valor": "5V"}, {"clave": "Rango de Detección", "valor": "PPM (variable)"}], "principales": [{"clave": "Función", "valor": "Gas Ozono (O3)"}, {"clave": "Tecnología", "valor": "Electroquímica"}, {"clave": "Uso", "valor": "Monitoreo ambiental"}]}	Este sensor mide la concentración del gas Ozono (O3), un contaminante secundario importante en la atmósfera. Se utiliza en el monitoreo de la calidad del aire exterior o en procesos industriales donde el ozono es un subproducto. Generalmente utiliza una celda electroquímica para una detección precisa en el rango de partes por billón (PPB).	12	9
35	Sensor DHT11	Sensor básico de temperatura y humedad.	18000.00	50	t	https://http2.mlstatic.com/D_NQ_NP_718750-MCO52651213158_112022-O.webp	f	2025-10-19 14:46:44.477628	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Protocolo", "valor": "Digital (1-Wire propietario)"}, {"clave": "Uso", "valor": "Básico/Prototipado"}, {"clave": "Voltaje", "valor": "3V - 5V"}], "principales": [{"clave": "Función", "valor": "Temperatura y Humedad"}, {"clave": "Precisión Humedad", "valor": "±5% HR"}, {"clave": "Rango Temp", "valor": "0°C a 50°C"}]}	El DHT11 es un sensor básico y económico para medir la temperatura y la humedad. Aunque su precisión es menor que la del DHT22, su simplicidad y bajo costo lo hacen muy popular para proyectos de iniciación y pruebas donde no se requiere una alta fidelidad en los datos. Utiliza una interfaz digital simple de 1-Wire.	8	9
34	Sensor DHT22	Sensor de temperatura y humedad de alta precisión.	45000.00	30	t	https://dualtronica.com/3830-thickbox_default/sensor-de-temperatura-y-humedad-dht22-am2302.jpg	f	2025-10-19 14:46:44.477628	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Protocolo", "valor": "Digital (1-Wire propietario)"}, {"clave": "Tiempo de Respuesta", "valor": "2 segundos"}, {"clave": "Voltaje", "valor": "3.3V - 5V"}], "principales": [{"clave": "Función", "valor": "Temperatura y Humedad"}, {"clave": "Precisión Humedad", "valor": "±2% HR"}, {"clave": "Rango Temp", "valor": "-40°C a +80°C"}]}	El DHT22, también conocido como AM2302, es un sensor digital que mide la temperatura y la humedad relativa del aire. Ofrece una mayor precisión y un rango de medición más amplio que el DHT11, siendo la opción preferida para estaciones meteorológicas domésticas o sistemas de monitoreo de invernaderos que requieren datos fiables.	17	9
33	Sensor DS18B20	Sensor digital de temperatura, resistente al agua.	36000.00	40	t	https://electronilab.co/wp-content/uploads/2015/04/ds18b20-waterproof.jpg	t	2025-10-19 14:46:44.477628	2025-10-21 20:44:28.652021	{"otros": [{"clave": "Precisión", "valor": "±0.5°C"}, {"clave": "Resistencia", "valor": "A prueba de agua"}, {"clave": "Voltaje", "valor": "3.0V - 5.5V"}], "principales": [{"clave": "Función", "valor": "Temperatura digital"}, {"clave": "Protocolo", "valor": "1-Wire"}, {"clave": "Rango", "valor": "-55°C a +125°C"}]}	El DS18B20 es un termómetro digital que utiliza el protocolo 1-Wire, permitiendo conectar múltiples sensores a un solo pin del microcontrolador. Su principal ventaja es que viene encapsulado en una sonda resistente al agua, haciéndolo ideal para medir la temperatura de líquidos, suelos o exteriores con alta precisión y durabilidad.	5	9
74	Motor DC 3V Mini	Motor pequeño para prototipos y juguetes.	1.00	50	t	https://electronilab.co/wp-content/uploads/2019/02/Micro-Motor-DC-3V-6V-130-16500-RPM-Electronilab-2.jpg	f	2025-10-19 15:59:24.226423	2025-10-25 01:03:24.948548	{"otros": [{"clave": "Uso", "valor": "Juguetes / Proyectos de hobby"}, {"clave": "Torque", "valor": "Bajo"}, {"clave": "Control", "valor": "Transistor o Driver simple"}], "principales": [{"clave": "Tipo", "valor": "Motor DC miniatura"}, {"clave": "Voltaje Nominal", "valor": "3V"}, {"clave": "Tamaño", "valor": "Pequeño"}]}	Motor de corriente continua de tamaño muy pequeño, diseñado para operar con bajo voltaje (típicamente 3V o menos). Es perfecto para pequeños proyectos de hobby, juguetes o mecanismos donde se requiere un actuador discreto y ligero. Su torque es limitado pero su consumo es muy bajo.	12	1
99	arduino	arduino	1000.00	7	t	https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcQMaHEaFLZz4amQxMkuzUK7KvefxHNVD_yeTz-5EPFQpFuolhOEzAFQvzT3oCYqDjHax0tO0SyeQQLpBm7_XGZ2l_68tWp8lpTDKsRKOJGa5ErtDicOhIPXYiyCntL1D2e8St20J-w&usqp=CAc	t	0025-04-25 00:00:00	2025-10-25 06:54:58.536066	{"age": 29, "name": "Molecule Man", "powers": ["Radiation resistance", "Turning tiny", "Radiation blast"], "secretIdentity": "Dan Jukes"}	saf	2	2
\.


--
-- TOC entry 5155 (class 0 OID 17493)
-- Dependencies: 233
-- Data for Name: seguridad_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seguridad_usuario (id, usuario_id, intentos_fallidos, bloqueado, fecha_desbloqueo, fecha_actualizacion) FROM stdin;
12	21	0	f	\N	2025-10-22 16:39:04.03577
8	18	0	f	\N	2025-10-21 21:58:14.059042
\N	10	1	f	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	\N	\N	\N	\N	\N
\N	1	0	f	\N	\N
11	3	2	f	\N	2025-10-22 16:05:57.646408
\N	3	2	f	\N	\N
\N	4	0	f	\N	\N
\N	5	0	f	\N	\N
\N	2	0	f	\N	\N
\.


--
-- TOC entry 5156 (class 0 OID 17496)
-- Dependencies: 234
-- Data for Name: subcategorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subcategorias (id_subcategoria, nombre, categoria_id) FROM stdin;
1	Motores	3
2	Raspberry pi	2
3	Esp32	2
4	Electromecánicos	3
5	Movimiento	1
6	Pantallas	3
7	Proximidad	1
8	Arduino	2
9	Ambientales	1
\.


--
-- TOC entry 5158 (class 0 OID 17502)
-- Dependencies: 236
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, correo, "contraseña", nombre, tipo_usuario, fecha_creacion, email_verificado, codigo_verificacion, codigo_expiracion, token_reset_password, token_expiracion) FROM stdin;
1	vsulez@unimayor.edu.co	$2b$10$vj/RHl7iP9.OW5rFdGcY9uynnlKhhoHUXXgM4IK2h/1Gr315fLvZO	valentina	cliente	\N	t	\N	\N	\N	\N
5	brayanama987@gmail.com	$2b$10$RERMT5zvW0bg.WxXa49fqOw3N3NG0DgIVeNXr4xDigP1HDOtI9ekO	brayan	admin	\N	t	\N	\N	\N	\N
2	baamayac1@academia.usbbog.edu.co	$2b$10$RERMT5zvW0bg.WxXa49fqOw3N3NG0DgIVeNXr4xDigP1HDOtI9ekO	brayan	cliente	\N	t	\N	\N	\N	\N
3	brayanama87@gmail.com	Angie11@	fas	cliente	\N	f	984287	2025-10-24 23:49:39.07	\N	\N
4	apavellanedal@academia.usbbog.edu.co	$2b$10$I9xG/v/pDxjDn5bVQINhUOyt1Qu9WbnfuZULuBXODfqVwmZOHJa56	Brayan Alexis	cliente	\N	f	562901	2025-10-24 23:58:32.006	\N	\N
\.


--
-- TOC entry 5172 (class 0 OID 0)
-- Dependencies: 222
-- Name: carrito_items_id_item_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carrito_items_id_item_seq', 118, true);


--
-- TOC entry 5173 (class 0 OID 0)
-- Dependencies: 224
-- Name: carritos_id_carrito_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carritos_id_carrito_seq', 25, true);


--
-- TOC entry 5174 (class 0 OID 0)
-- Dependencies: 226
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_id_seq', 3, true);


--
-- TOC entry 5175 (class 0 OID 0)
-- Dependencies: 230
-- Name: marcas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.marcas_id_seq', 26, true);


--
-- TOC entry 5176 (class 0 OID 0)
-- Dependencies: 232
-- Name: productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_id_seq', 99, true);


--
-- TOC entry 5177 (class 0 OID 0)
-- Dependencies: 235
-- Name: subcategorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subcategorias_id_seq', 9, true);


--
-- TOC entry 5178 (class 0 OID 0)
-- Dependencies: 237
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 5, true);


--
-- TOC entry 4963 (class 2606 OID 17516)
-- Name: carrito_items carrito_items_carrito_id_producto_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrito_items
    ADD CONSTRAINT carrito_items_carrito_id_producto_id_key UNIQUE (carrito_id, producto_id);


--
-- TOC entry 4965 (class 2606 OID 17518)
-- Name: carrito_items carrito_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrito_items
    ADD CONSTRAINT carrito_items_pkey PRIMARY KEY (id_item);


--
-- TOC entry 4967 (class 2606 OID 17520)
-- Name: carritos carritos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carritos
    ADD CONSTRAINT carritos_pkey PRIMARY KEY (id_carrito);


--
-- TOC entry 4969 (class 2606 OID 17522)
-- Name: carritos carritos_token_invitado_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carritos
    ADD CONSTRAINT carritos_token_invitado_key UNIQUE (token_invitado);


--
-- TOC entry 4973 (class 2606 OID 17524)
-- Name: categorias categorias_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_nombre_key UNIQUE (nombre);


--
-- TOC entry 4975 (class 2606 OID 17526)
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id_categoria);


--
-- TOC entry 4977 (class 2606 OID 17528)
-- Name: marca_categoria marca_categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca_categoria
    ADD CONSTRAINT marca_categoria_pkey PRIMARY KEY (id_marca, id_categoria);


--
-- TOC entry 4979 (class 2606 OID 17530)
-- Name: marcas marcas_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marcas
    ADD CONSTRAINT marcas_nombre_key UNIQUE (nombre);


--
-- TOC entry 4981 (class 2606 OID 17532)
-- Name: marcas marcas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marcas
    ADD CONSTRAINT marcas_pkey PRIMARY KEY (id_marca);


--
-- TOC entry 4983 (class 2606 OID 17534)
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);


--
-- TOC entry 4985 (class 2606 OID 17536)
-- Name: subcategorias subcategorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategorias
    ADD CONSTRAINT subcategorias_pkey PRIMARY KEY (id_subcategoria);


--
-- TOC entry 4987 (class 2606 OID 17538)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4970 (class 1259 OID 17539)
-- Name: unique_active_guest_cart; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_active_guest_cart ON public.carritos USING btree (token_invitado, estado) WHERE (((estado)::text = 'ACTIVO'::text) AND (token_invitado IS NOT NULL));


--
-- TOC entry 4971 (class 1259 OID 17540)
-- Name: unique_active_user_cart; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_active_user_cart ON public.carritos USING btree (usuario_id, estado) WHERE (((estado)::text = 'ACTIVO'::text) AND (usuario_id IS NOT NULL));


--
-- TOC entry 4995 (class 2620 OID 17541)
-- Name: productos trigger_actualizar_fecha; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_actualizar_fecha BEFORE UPDATE ON public.productos FOR EACH ROW EXECUTE FUNCTION public.actualizar_fecha_modificacion();


--
-- TOC entry 4988 (class 2606 OID 17542)
-- Name: carrito_items carrito_items_carrito_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrito_items
    ADD CONSTRAINT carrito_items_carrito_id_fkey FOREIGN KEY (carrito_id) REFERENCES public.carritos(id_carrito) ON DELETE CASCADE;


--
-- TOC entry 4989 (class 2606 OID 17547)
-- Name: carrito_items carrito_items_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrito_items
    ADD CONSTRAINT carrito_items_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- TOC entry 4992 (class 2606 OID 17552)
-- Name: productos fk_marca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT fk_marca FOREIGN KEY (marca_id) REFERENCES public.marcas(id_marca) ON DELETE SET NULL;


--
-- TOC entry 4993 (class 2606 OID 17557)
-- Name: productos fk_subcategoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT fk_subcategoria FOREIGN KEY (subcategoria_id) REFERENCES public.subcategorias(id_subcategoria) ON DELETE SET NULL;


--
-- TOC entry 4990 (class 2606 OID 17562)
-- Name: marca_categoria marca_categoria_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca_categoria
    ADD CONSTRAINT marca_categoria_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categorias(id_categoria) ON DELETE CASCADE;


--
-- TOC entry 4991 (class 2606 OID 17567)
-- Name: marca_categoria marca_categoria_id_marca_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca_categoria
    ADD CONSTRAINT marca_categoria_id_marca_fkey FOREIGN KEY (id_marca) REFERENCES public.marcas(id_marca) ON DELETE CASCADE;


--
-- TOC entry 4994 (class 2606 OID 17572)
-- Name: subcategorias subcategorias_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategorias
    ADD CONSTRAINT subcategorias_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.categorias(id_categoria);


-- Completed on 2025-10-25 07:10:17

--
-- PostgreSQL database dump complete
--

\unrestrict g6ZBLmeJYvSS6efngbd6OPAUbqcARcSJCfQvkC5PnldPgWa38IXv90zen0DzRdk

