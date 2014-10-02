
CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
SET search_path = public, pg_catalog;
SET client_encoding=LATIN1;
CREATE FUNCTION fn_log_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
      INSERT INTO tbl_audit ("nombre_tabla", "operacion", "valor_anterior", "valor_nuevo", "fecha_cambio", "usuario")
             VALUES (TG_TABLE_NAME, 'D', OLD, NULL, now(), USER);
      RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
      INSERT INTO tbl_audit ("nombre_tabla", "operacion", "valor_anterior", "valor_nuevo", "fecha_cambio", "usuario")
             VALUES (TG_TABLE_NAME, 'U', OLD, NEW, now(), USER);
      RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
      INSERT INTO tbl_audit ("nombre_tabla", "operacion", "valor_anterior", "valor_nuevo", "fecha_cambio", "usuario")
             VALUES (TG_TABLE_NAME, 'I', NULL, NEW, now(), USER);
      RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$;
LANGUAGE 'plpgsql' VOLATILE COST 100;
ALTER FUNCTION public.fn_log_audit() OWNER TO postgres;
--
-- Estrutura de la tabla 'c_cobrarexternas'
--

DROP TABLE c_cobrarexternas CASCADE;
CREATE TABLE c_cobrarexternas (
id_c_cobrarexternas int4 NOT NULL,
id_cliente int4,
id_empresa int4,
id_usuario int4,
comprobante text,
fecha_actual text,
hora_actual text,
num_factura text,
tipo_documento text,
total text,
saldo text,
estado text
);

--
-- Creating data for 'c_cobrarexternas'
--



--
-- Creating index for 'c_cobrarexternas'
--

ALTER TABLE ONLY  c_cobrarexternas  ADD CONSTRAINT  c_cobrarexternas_pkey  PRIMARY KEY  (id_c_cobrarexternas);

--
-- Estrutura de la tabla 'c_pagarexternas'
--

DROP TABLE c_pagarexternas CASCADE;
CREATE TABLE c_pagarexternas (
id_c_pagarexternas int4 NOT NULL,
id_proveedor int4,
id_empresa int4,
id_usuario int4,
comprobante text,
fecha_actual text,
hora_actual text,
num_factura text,
tipo_documento text,
total text,
saldo text,
estado text
);

--
-- Creating data for 'c_pagarexternas'
--



--
-- Creating index for 'c_pagarexternas'
--

ALTER TABLE ONLY  c_pagarexternas  ADD CONSTRAINT  c_pagarexternas_pkey  PRIMARY KEY  (id_c_pagarexternas);

--
-- Estrutura de la tabla 'categoria'
--

DROP TABLE categoria CASCADE;
CREATE TABLE categoria (
id_categoria int4 NOT NULL,
nombre_categoria text,
estado text
);

--
-- Creating data for 'categoria'
--

INSERT INTO categoria VALUES ('1','COMPUTADORAS','Activo');


--
-- Creating index for 'categoria'
--

ALTER TABLE ONLY  categoria  ADD CONSTRAINT  categoria_pkey  PRIMARY KEY  (id_categoria);

--
-- Estrutura de la tabla 'clientes'
--

DROP TABLE clientes CASCADE;
CREATE TABLE clientes (
id_cliente int4 NOT NULL,
tipo_documento text,
identificacion text,
nombres_cli text,
tipo_cliente text,
direccion_cli text,
telefono text,
celular text,
pais text,
ciudad text,
correo text,
credito_cupo text,
notas text,
estado text
);

--
-- Creating data for 'clientes'
--

INSERT INTO clientes VALUES ('1','Cedula','1003384169','GRACE VELASCO','natural','IBARRA',NULL,'0981613016','ECUADOR','IBARRA',NULL,'1000',NULL,'Activo');
INSERT INTO clientes VALUES ('2','Cedula','1002050001','SANTIAGO YEPEZ','natural','AV EUGENIO ESPEJO 966 Y BONILLA','062585463','0987805075','ECUADOR','IBARRA',NULL,'10000',NULL,'Activo');
INSERT INTO clientes VALUES ('3','Ruc','1091712799001','FUNDACION TIERRA PARA TODOS','juridico','PEDRO MONCAYO 11-53','062605398',NULL,'ECUADOR','IBARRA',NULL,'5000',NULL,'Activo');


--
-- Creating index for 'clientes'
--

ALTER TABLE ONLY  clientes  ADD CONSTRAINT  clientes_pkey  PRIMARY KEY  (id_cliente);

--
-- Estrutura de la tabla 'color
--

DROP TABLE color CASCADE;
CREATE TABLE color (
id_color int4 NOT NULL,
nombre_color text,
estado text
);

--
-- Creating data for 'color'
--

INSERT INTO color VALUES ('1','AZUL','Activo');
INSERT INTO color VALUES ('2','NEGRO','Activo');
INSERT INTO color VALUES ('3','MORADO','Activo');


--
-- Creating index for 'color'
--

ALTER TABLE ONLY  color  ADD CONSTRAINT  color_pkey  PRIMARY KEY  (id_color);

--
-- Estrutura de la tabla  'detalle_devolucion_compra'
--

DROP TABLE detalle_devolucion_compra CASCADE;
CREATE TABLE detalle_devolucion_compra (
id_detalle_devcompra int4 NOT NULL,
id_devolucion_compra int4,
cod_productos int4,
cantidad text,
precio_compra text,
descuento_producto text,
total_compra text,
estado text
);

--
-- Creating data for 'detalle_devolucion_compra'
--



--
-- Creating index for 'detalle_devolucion_compra'
--

ALTER TABLE ONLY  detalle_devolucion_compra  ADD CONSTRAINT  detalle_devolucion_compra_pkey  PRIMARY KEY  (id_detalle_devcompra);

--
-- Estrutura de la tabla 'detalle_devolucion_venta'
--

DROP TABLE detalle_devolucion_venta CASCADE;
CREATE TABLE detalle_devolucion_venta (
id_detalle_deventa int4 NOT NULL,
id_devolucion_venta int4,
cod_productos int4,
cantidad text,
precio_venta text,
descuento_producto text,
total_venta text,
estado text
);

--
-- Creating data for 'detalle_devolucion_venta'
--



--
-- Creating index for 'detalle_devolucion_venta'
--

ALTER TABLE ONLY  detalle_devolucion_venta  ADD CONSTRAINT  detalle_devolucion_venta_pkey  PRIMARY KEY  (id_detalle_deventa);

--
-- Estrutura de la tabla 'detalle_egreso'
--

DROP TABLE detalle_egreso CASCADE;
CREATE TABLE detalle_egreso (
id_detalle_egreso int4 NOT NULL,
id_egresos int4,
cod_productos int4,
cantidad text,
precio_costo text,
descuento text,
total text,
estado text
);

--
-- Creating data for 'detalle_egreso'
--



--
-- Creating index for 'detalle_egreso'
--

ALTER TABLE ONLY  detalle_egreso  ADD CONSTRAINT  detalle_egreso_pkey  PRIMARY KEY  (id_detalle_egreso);

--
-- Estrutura de la tabla 'detalle_factura_compra'
--

DROP TABLE detalle_factura_compra CASCADE;
CREATE TABLE detalle_factura_compra (
id_detalle_compra int4 NOT NULL,
id_factura_compra int4,
cod_productos int4,
cantidad text,
precio_compra text,
descuento_producto text,
total_compra text,
estado text
);

--
-- Creating data for 'detalle_factura_compra'
--



--
-- Creating index for 'detalle_factura_compra'
--

ALTER TABLE ONLY  detalle_factura_compra  ADD CONSTRAINT  detalle_factura_compra_pkey  PRIMARY KEY  (id_detalle_compra);

--
-- Estrutura de la tabla 'detalle_factura_venta'
--

DROP TABLE detalle_factura_venta CASCADE;
CREATE TABLE detalle_factura_venta (
id_detalle_venta int4 NOT NULL,
id_factura_venta int4,
cod_productos int4,
cantidad text,
precio_venta text,
descuento_producto text,
total_venta text,
estado text,
pendientes text
);

--
-- Creating data for 'detalle_factura_venta'
--



--
-- Creating index for 'detalle_factura_venta'
--

ALTER TABLE ONLY  detalle_factura_venta  ADD CONSTRAINT  detalle_factura_venta_pkey  PRIMARY KEY  (id_detalle_venta);

--
-- Estrutura de la tabla 'detalle_ingreso'
--

DROP TABLE detalle_ingreso CASCADE;
CREATE TABLE detalle_ingreso (
id_detalle_ingreso int4 NOT NULL,
id_ingresos int4,
cod_productos int4,
cantidad text,
precio_costo text,
descuento text,
total text,
estado text
);

--
-- Creating data for 'detalle_ingreso'
--

INSERT INTO detalle_ingreso VALUES ('1','1','15','10','8.00','0','80.00','Activo');


--
-- Creating index for 'detalle_ingreso'
--

ALTER TABLE ONLY  detalle_ingreso  ADD CONSTRAINT  detalle_ingreso_pkey  PRIMARY KEY  (id_detalle_ingreso);

--
-- Estrutura de la tabla 'detalle_inventario'
--

DROP TABLE detalle_inventario CASCADE;
CREATE TABLE detalle_inventario (
id_detalle_inventario int4 NOT NULL,
id_inventario int4,
cod_productos int4,
p_costo text,
p_venta text,
disponibles text,
existencia text,
diferencia text,
estado text
);

--
-- Creating data for 'detalle_inventario'
--

INSERT INTO detalle_inventario VALUES ('1','1','15','8.00','10.00','10','10','10','Activo');


--
-- Creating index for 'detalle_inventario'
--

ALTER TABLE ONLY  detalle_inventario  ADD CONSTRAINT  detalle_inventario_pkey  PRIMARY KEY  (id_detalle_inventario);

--
-- Estrutura de la tabla ' detalle_pagos_venta'
--

DROP TABLE  detalle_pagos_venta CASCADE;
CREATE TABLE  detalle_pagos_venta (
id_detalle_pagos_venta int4 NOT NULL,
id_pagos_venta int4,
fecha_pago text,
cuota text,
saldo text,
estado text
);

--
-- Creating data for ' detalle_pagos_venta'
--


--
-- Estrutura de la tabla 'detalle_proforma'
--

DROP TABLE detalle_proforma CASCADE;
CREATE TABLE detalle_proforma (
id_detalle_proforma int4 NOT NULL,
id_proforma int4,
cod_productos int4,
cantidad text,
precio_venta text,
descuento_venta text,
total_venta text,
estado text
);

--
-- Creating data for 'detalle_proforma'
--

INSERT INTO detalle_proforma VALUES ('1','1','19','5','1.50','0','7.50','Activo');


--
-- Creating index for 'detalle_proforma'
--

ALTER TABLE ONLY  detalle_proforma  ADD CONSTRAINT  detalle_proforma_pkey  PRIMARY KEY  (id_detalle_proforma);

--
-- Estrutura de la tabla 'detalles_ordenes'
--

DROP TABLE detalles_ordenes CASCADE;
CREATE TABLE detalles_ordenes (
id_detalles_ordenes int4 NOT NULL,
id_ordenes int4,
cod_productos int4,
cantidad text,
precio_costo text,
total_costo text,
estado text
);

--
-- Creating data for 'detalles_ordenes'
--

INSERT INTO detalles_ordenes VALUES ('1','1','19','3','2.00','6.00','Activo');
INSERT INTO detalles_ordenes VALUES ('2','2','15','2','8.00','16.00','Activo');


--
-- Creating index for 'detalles_ordenes'
--

ALTER TABLE ONLY  detalles_ordenes  ADD CONSTRAINT  detalles_ordenes_pkey  PRIMARY KEY  (id_detalles_ordenes);

--
-- Estrutura de la tabla 'detalles_pagos_internos'
--

DROP TABLE detalles_pagos_internos CASCADE;
CREATE TABLE detalles_pagos_internos (
id_detalles_pagos_interna int4 NOT NULL,
id_cuentas_cobrar int4,
fecha_pago_actual text,
total_pagos text,
saldo text,
estado text
);

--
-- Creating data for 'detalles_pagos_internos'
--



--
-- Creating index for 'detalles_pagos_internos'
--

ALTER TABLE ONLY  detalles_pagos_internos  ADD CONSTRAINT  id_detalles_pagos_internos_pkey  PRIMARY KEY  (id_detalles_pagos_interna);

--
-- Estrutura de la tabla 'detalles_trabajo'
--

DROP TABLE detalles_trabajo CASCADE;
CREATE TABLE detalles_trabajo (
id_detalle int4 NOT NULL,
nombre_detalle text,
valor_detalle text,
id_trabajotecnico int4,
codigo text,
cantidad text,
tipo text
);

--
-- Creating data for 'detalles_trabajo'
--

INSERT INTO detalles_trabajo VALUES ('1','FORMATEO COMPUTADOR','20','1','1','1','Servicio');
INSERT INTO detalles_trabajo VALUES ('2','SISTEMA SICADI 2 USUARIOS','200','1','2','2','Producto');
INSERT INTO detalles_trabajo VALUES ('3','TARJETA PCI WIRELESS N 150','29','1','6','2','Producto');


--
-- Creating index for 'detalles_trabajo'
--

ALTER TABLE ONLY  detalles_trabajo  ADD CONSTRAINT  detalles_trabajo_pkey  PRIMARY KEY  (id_detalle);

--
-- Estrutura de la tabla 'devolucion_compra'
--

DROP TABLE devolucion_compra CASCADE;
CREATE TABLE devolucion_compra (
id_devolucion_compra int4 NOT NULL,
id_empresa int4,
id_proveedor int4,
id_usuario int4,
comprobante text,
fecha_actual text,
hora_actual text,
tipo_comprobante text,
num_serie text,
num_autorizacion text,
tarifa0 text,
tarifa12 text,
iva_compra text,
descuento_compra text,
total_compra text,
observaciones text,
estado text
);

--
-- Creating data for 'devolucion_compra'
--



--
-- Creating index for 'devolucion_compra'
--

ALTER TABLE ONLY  devolucion_compra  ADD CONSTRAINT  devolucion_compra_pkey  PRIMARY KEY  (id_devolucion_compra);

--
-- Estrutura de la tabla 'devolucion_venta'
--

DROP TABLE devolucion_venta CASCADE;
CREATE TABLE devolucion_venta (
id_devolucion_venta int4 NOT NULL,
id_empresa int4,
id_cliente int4,
id_usuario int4,
comprobante text,
fecha_actual text,
hora_actual text,
tipo_comprobante text,
num_serie text,
tarifa0 text,
tarifa12 text,
iva_venta text,
descuento_venta text,
total_venta text,
observaciones text,
estado text
);

--
-- Creating data for 'devolucion_venta'
--



--
-- Creating index for 'devolucion_venta'
--

ALTER TABLE ONLY  devolucion_venta  ADD CONSTRAINT  devolucion_venta_pkey  PRIMARY KEY  (id_devolucion_venta);

--
-- Estrutura de la tabla 'egresos'
--

DROP TABLE egresos CASCADE;
CREATE TABLE egresos (
id_egresos  int4 NOT NULL,
id_empresa int4,
id_usuario int4,
comprobante text,
fecha_actual text,
hora_actual text,
origen text,
destino text,
tarifa0 text,
tarifa12 text,
iva_egreso text,
descuento_egreso text,
total_egreso text,
observaciones text,
estado text
);

--
-- Creating data for 'egresos'
--



--
-- Creating index for 'egresos'
--

ALTER TABLE ONLY  egresos  ADD CONSTRAINT  egresos_pkey  PRIMARY KEY  (id_egresos);

--
-- Estrutura de la tabla 'empresa'
--

DROP TABLE empresa CASCADE;
CREATE TABLE empresa (
id_empresa int4 NOT NULL,
nombre_empresa text,
ruc_empresa text,
direccion_empresa text,
telefono_empresa text,
celular_empresa text,
fax_empresa text,
email_empresa text,
pagina_web text,
estado text
);

--
-- Creating data for 'empresa'
--

INSERT INTO empresa VALUES ('1','P&S System','100345678956001','Ibarra',NULL,NULL,NULL,'system@hotmail.com','www.syste.com','Activo');


--
-- Creating index for 'empresa'
--

ALTER TABLE ONLY  empresa  ADD CONSTRAINT  empresa_pkey  PRIMARY KEY  (id_empresa);

--
-- Estrutura de la tabla 'factura_compra'
--

DROP TABLE factura_compra CASCADE;
CREATE TABLE factura_compra (
id_factura_compra int4 NOT NULL,
id_empresa int4,
id_proveedor int4,
id_usuario int4,
comprobante text,
fecha_actual text,
hora_actual text,
fecha_registro text,
fecha_emision text,
fecha_caducidad text,
tipo_comprobante text,
num_serie text,
num_autorizacion text,
fecha_cancelacion text,
forma_pago text,
tarifa0 text,
tarifa12 text,
iva_compra text,
descuento_compra text,
total_compra text,
estado text
);

--
-- Creating data for 'factura_compra'
--



--
-- Creating index for 'factura_compra'
--

ALTER TABLE ONLY  factura_compra  ADD CONSTRAINT  factura_compra_pkey  PRIMARY KEY  (id_factura_compra);

--
-- Estrutura de la tabla 'factura_venta'
--

DROP TABLE factura_venta CASCADE;
CREATE TABLE factura_venta (
id_factura_venta int4 NOT NULL,
id_empresa int4,
id_cliente int4,
id_usuario int4,
comprobante text,
num_factura text,
fecha_actual text,
hora_actual text,
fecha_cancelacion text,
tipo_precio text,
forma_pago text,
num_autorizacion text,
fecha_autorizacion text,
fecha_caducidad text,
tarifa0 text,
tarifa12 text,
iva_venta text,
descuento_venta text,
total_venta text,
estado text,
fecha_anulacion text
);

--
-- Creating data for 'factura_venta'
--



--
-- Creating index for 'factura_venta'
--

ALTER TABLE ONLY  factura_venta  ADD CONSTRAINT  factura_venta_pkey  PRIMARY KEY  (id_factura_venta);

--
-- Estrutura de la tabla 'gastos'
--

DROP TABLE gastos CASCADE;
CREATE TABLE gastos (
id_gastos int4 NOT NULL,
id_usuario int4,
id_factura_venta int4,
comprobante text,
fecha_actual text,
hora_actual text,
descripcion text,
valor text,
saldo text,
acumulado text,
estado text
);

--
-- Creating data for 'gastos'
--



--
-- Creating index for 'gastos'
--

ALTER TABLE ONLY  gastos  ADD CONSTRAINT  gastos_pkey  PRIMARY KEY  (id_gastos);

--
-- Estrutura de la tabla 'gastos_internos'
--

DROP TABLE gastos_internos CASCADE;
CREATE TABLE gastos_internos (
id_gastos int4 NOT NULL,
id_usuario int4,
id_proveedor int4,
comprobante text,
fecha_actual text,
hora_actual text,
num_factura text,
descripcion text,
total text,
estado text
);

--
-- Creating data for 'gastos_internos'
--



--
-- Creating index for 'gastos_internos'
--

ALTER TABLE ONLY  gastos_internos  ADD CONSTRAINT  gastos_internos_pkey  PRIMARY KEY  (id_gastos);

--
-- Estrutura de la tabla 'ingresos'
--

DROP TABLE ingresos CASCADE;
CREATE TABLE ingresos (
id_ingresos int4 NOT NULL,
id_empresa int4,
id_usuario int4,
comprobante text,
fecha_actual text,
hora_actual text,
origen text,
destino text,
tarifa0 text,
tarifa12 text,
iva_ingreso text,
descuento_ingreso text,
total_ingreso text,
observaciones text,
estado text
);

--
-- Creating data for 'ingresos'
--

INSERT INTO ingresos VALUES ('1','1','2','1','2014-09-18','11:56:26 AM',NULL,NULL,'0.00','80.00','9.60','0.00','89.60',NULL,'Activo');


--
-- Creating index for 'ingresos'
--

ALTER TABLE ONLY  ingresos  ADD CONSTRAINT  ingresos_pkey  PRIMARY KEY  (id_ingresos);

--
-- Estrutura de la tabla 'inventario'
--

DROP TABLE inventario CASCADE;
CREATE TABLE inventario (
id_inventario int4 NOT NULL,
id_usuario int4,
id_empresa int4,
comprobante text,
fecha_actual text,
hora_actual text,
estado text
);

--
-- Creating data for 'inventario'
--

INSERT INTO inventario VALUES ('1','2','1','1','2014-09-18','11:54:45 AM','Activo');


--
-- Creating index for 'inventario'
--

ALTER TABLE ONLY  inventario  ADD CONSTRAINT  inventario_pkey  PRIMARY KEY  (id_inventario);

--
-- Estrutura de la tabla 'kardex'
--

DROP TABLE kardex CASCADE;
CREATE TABLE kardex (
id_kardex int4 NOT NULL,
fecha_kardex text,
detalle text,
cantidad_c text,
valor_unitario_c text,
total_c text,
cantidad_v text,
valor_unitario_v text,
total_v  text,
cod_productos  int4,
transaccion  text,
estado text
);

--
-- Creating data for 'kardex'
--



--
-- Creating index for 'kardex'
--

ALTER TABLE ONLY  kardex  ADD CONSTRAINT  kardex_pkey  PRIMARY KEY  (id_kardex);

--
-- Estrutura de la tabla 'kardex_valorizado'
--

DROP TABLE kardex_valorizado CASCADE;
CREATE TABLE kardex_valorizado (
id_kardex int4 NOT NULL,
cod_productos int4,
fecha_transaccion text,
concepto text,
entrada text,
salida text,
existencia text,
costo_unitario text,
costo_promedio text,
debe text,
haber text,
saldo text,
estado text
);

--
-- Creating data for 'kardex_valorizado'
--

INSERT INTO kardex_valorizado VALUES ('5','1','2014-05-09','Inventario inicial',NULL,NULL,'0','100.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('6','2','2014-05-09','Inventario inicial',NULL,NULL,'0','100.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('7','3','2014-05-09','Inventario inicial',NULL,NULL,'0','100.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('8','4','2014-05-09','Inventario inicial',NULL,NULL,'0','0.70','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('9','5','2014-05-09','Inventario inicial',NULL,NULL,'0','0.60','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('10','6','2014-05-09','Inventario inicial',NULL,NULL,'0','14.50','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('11','7','2014-05-09','Inventario inicial',NULL,NULL,'0','0.40','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('12','8','2014-05-09','Inventario inicial',NULL,NULL,'0','12.50','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('13','9','2014-05-09','Inventario inicial',NULL,NULL,'0','5.92','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('14','10','2014-05-09','Inventario inicial',NULL,NULL,'0','5.50','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('15','11','2014-05-09','Inventario inicial',NULL,NULL,'0','5.50','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('16','12','2014-05-09','Inventario inicial',NULL,NULL,'0','65.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('17','13','2014-05-09','Inventario inicial',NULL,NULL,'0','56.61','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('18','14','2014-05-09','Inventario inicial',NULL,NULL,'0','41.99','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('20','14','2014-05-09','Inventario inicial',NULL,NULL,'0','5.42','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('21','15','2014-05-09','Inventario inicial',NULL,NULL,'0','8.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('22','16','2014-05-09','Inventario inicial',NULL,NULL,'0','10.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('23','17','2014-05-09','Inventario inicial',NULL,NULL,'0','8.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('24','18','2014-05-09','Inventario inicial',NULL,NULL,'0','6.56','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('25','19','2014-05-09','Inventario inicial',NULL,NULL,'0','2.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('26','20','2014-05-09','Inventario inicial',NULL,NULL,'0','16.98','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('27','21','2014-05-09','Inventario inicial',NULL,NULL,'0','6.21','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('28','22','2014-05-09','Inventario inicial',NULL,NULL,'0','6.56','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('29','23','2014-05-09','Inventario inicial',NULL,NULL,'0','5.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('30','24','2014-05-12','Inventario inicial',NULL,NULL,'0','5.23','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('31','25','2014-05-12','Inventario inicial',NULL,NULL,'0','5.23','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('32','26','2014-05-12','Inventario inicial',NULL,NULL,'0','5.45','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('33','27','2014-05-12','Inventario inicial',NULL,NULL,'0','5.23','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('34','28','2014-05-12','Inventario inicial',NULL,NULL,'0','21.50','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('35','29','2014-05-12','Inventario inicial',NULL,NULL,'0','16.83','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('36','30','2014-05-12','Inventario inicial',NULL,NULL,'0','14.77','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('37','31','2014-05-12','Inventario inicial',NULL,NULL,'0','9.97','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('38','32','2014-05-12','Inventario inicial',NULL,NULL,'0','18.25','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('39','33','2014-05-12','Inventario inicial',NULL,NULL,'0','29.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('40','34','2014-05-12','Inventario inicial',NULL,NULL,'0','7.98','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('41','35','2014-05-12','Inventario inicial',NULL,NULL,'0','6.96','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('42','36','2014-05-12','Inventario inicial',NULL,NULL,'0','6.65','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('43','37','2014-05-12','Inventario inicial',NULL,NULL,'0','6.95','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('44','38','2014-05-12','Inventario inicial',NULL,NULL,'0','8.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('45','39','2014-05-12','Inventario inicial',NULL,NULL,'0','10.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('46','40','2014-05-12','Inventario inicial',NULL,NULL,'0','8.20','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('47','41','2014-05-12','Inventario inicial',NULL,NULL,'0','7.55','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('48','42','2014-05-12','Inventario inicial',NULL,NULL,'0','8.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('49','43','2014-05-12','Inventario inicial',NULL,NULL,'0','9.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('50','44','2014-05-12','Inventario inicial',NULL,NULL,'0','8.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('51','45','2014-05-12','Inventario inicial',NULL,NULL,'0','3.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('52','46','2014-05-12','Inventario inicial',NULL,NULL,'0','28.44','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('53','47','2014-05-12','Inventario inicial',NULL,NULL,'0','10.50','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('54','48','2014-05-12','Inventario inicial',NULL,NULL,'0','36.53','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('55','49','2014-05-12','Inventario inicial',NULL,NULL,'0','18.55','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('56','50','2014-05-13','Inventario inicial',NULL,NULL,'0','5.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('57','51','2014-05-13','Inventario inicial',NULL,NULL,'0','5.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('58','52','2014-05-13','Inventario inicial',NULL,NULL,'0','68.83','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('59','53','2014-05-13','Inventario inicial',NULL,NULL,'0','12.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('60','54','2014-05-13','Inventario inicial',NULL,NULL,'0','20.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('61','55','2014-05-13','Inventario inicial',NULL,NULL,'0','10.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('62','56','2014-05-13','Inventario inicial',NULL,NULL,'0','100.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('63','57','2014-05-13','Inventario inicial',NULL,NULL,'0','70.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('64','58','2014-05-13','Inventario inicial',NULL,NULL,'0','30.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('65','59','2014-05-13','Inventario inicial',NULL,NULL,'0','4.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('66','60','2014-05-13','Inventario inicial',NULL,NULL,'0','54.40','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('67','61','2014-05-14','Inventario inicial',NULL,NULL,'0','0.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('68','62','2014-05-14','Inventario inicial',NULL,NULL,'0','0.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('69','63','2014-05-14','Inventario inicial',NULL,NULL,'0','0.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('70','64','2014-05-14','Inventario inicial',NULL,NULL,'0','0.00','0.00',NULL,NULL,'0.00','Activo');
INSERT INTO kardex_valorizado VALUES ('19','14','2014-05-09','Inventario inicial',NULL,NULL,'0','123.00','0.00',NULL,NULL,'0.00','Activo');


--
-- Creating index for 'kardex_valorizado'
--

ALTER TABLE ONLY  kardex_valorizado  ADD CONSTRAINT  kardex_valorizado_pkey  PRIMARY KEY  (id_kardex);

--
-- Estrutura de la tabla 'marcas'
--

DROP TABLE marcas CASCADE;
CREATE TABLE marcas (
id_marca int4 NOT NULL,
nombre_marca text,
estado text
);

--
-- Creating data for 'marcas'
--

INSERT INTO marcas VALUES ('1','TOSHIBA','Activo');
INSERT INTO marcas VALUES ('2','Hp','Activo');
INSERT INTO marcas VALUES ('3','KINGSTON','Activo');
INSERT INTO marcas VALUES ('5','SAMSUNG','Activo');
INSERT INTO marcas VALUES ('4','GENIUS','Activo');
INSERT INTO marcas VALUES ('6','LG','Activo');
INSERT INTO marcas VALUES ('8','EPSON','Activo');
INSERT INTO marcas VALUES ('7','DELL','Activo');
INSERT INTO marcas VALUES ('9','ALTEK','Activo');
INSERT INTO marcas VALUES ('11','CNET','Activo');
INSERT INTO marcas VALUES ('10','D-LINK','Activo');
INSERT INTO marcas VALUES ('12','ASUS','Activo');
INSERT INTO marcas VALUES ('13','HONEYWELL','Activo');
INSERT INTO marcas VALUES ('15','SPEEDMIND','Activo');
INSERT INTO marcas VALUES ('14','GIGABYTE','Activo');
INSERT INTO marcas VALUES ('16','TRIPP.LITE','Activo');
INSERT INTO marcas VALUES ('18','SEAGATE','Activo');
INSERT INTO marcas VALUES ('17','ESENSES','Activo');
INSERT INTO marcas VALUES ('19','BIOSTAR','Activo');
INSERT INTO marcas VALUES ('20','RLIP-XTREME','Activo');
INSERT INTO marcas VALUES ('44','COMPAQ','Activo');
INSERT INTO marcas VALUES ('43','CANON','Activo');
INSERT INTO marcas VALUES ('42','ACER','Activo');
INSERT INTO marcas VALUES ('41','SOUND BLASTER','Activo');
INSERT INTO marcas VALUES ('40','KEY MEDIA','Activo');
INSERT INTO marcas VALUES ('39','SENTEY','Activo');
INSERT INTO marcas VALUES ('38','XTECH','Activo');
INSERT INTO marcas VALUES ('37','DELUX','Activo');
INSERT INTO marcas VALUES ('36','CLON','Activo');
INSERT INTO marcas VALUES ('35','GENERICO','Activo');
INSERT INTO marcas VALUES ('34','TRENDNET','Activo');
INSERT INTO marcas VALUES ('33','NUTRIVIDA','Activo');
INSERT INTO marcas VALUES ('32','BELKIN','Activo');
INSERT INTO marcas VALUES ('31','OMEGA','Activo');
INSERT INTO marcas VALUES ('30','NIUTEK','Activo');
INSERT INTO marcas VALUES ('29','NVIDIA','Activo');
INSERT INTO marcas VALUES ('28','THX','Activo');
INSERT INTO marcas VALUES ('27','NEXXT','Activo');
INSERT INTO marcas VALUES ('21','D-LINK','Activo');
INSERT INTO marcas VALUES ('22','VALK','Activo');
INSERT INTO marcas VALUES ('23','COMQTECH','Activo');
INSERT INTO marcas VALUES ('24','AKUT','Activo');
INSERT INTO marcas VALUES ('25','TITAN','Activo');
INSERT INTO marcas VALUES ('26','SICADI','Activo');
INSERT INTO marcas VALUES ('45','INTEL','Activo');
INSERT INTO marcas VALUES ('46','j¤','Activo');


--
-- Creating index for 'marcas'
--

ALTER TABLE ONLY  marcas  ADD CONSTRAINT  marcas_pkey  PRIMARY KEY  (id_marca);

--
-- Estrutura de la tabla 'ordenes_produccion'
--

DROP TABLE ordenes_produccion CASCADE;
CREATE TABLE ordenes_produccion (
id_ordenes int4 NOT NULL,
id_usuario int4,
comprobante text,
fecha_actual text,
hora_actual text,
cod_productos int4,
cantidad text,
sub_total text,
 estado text
);

--
-- Creating data for 'ordenes_produccion'
--

INSERT INTO ordenes_produccion VALUES ('1','2','1','2014-09-18','12:02:51 AM','19','5','6.00','Activo');
INSERT INTO ordenes_produccion VALUES ('2','2','2','2014-09-18','12:16:57 AM','6','1','16.00','Activo');


--
-- Creating index for 'ordenes_produccion'
--

ALTER TABLE ONLY  ordenes_produccion  ADD CONSTRAINT  ordenes_produccion_pkey  PRIMARY KEY  (id_ordenes);

--
-- Estrutura de la tabla 'pagos_cobrar'
--

DROP TABLE pagos_cobrar CASCADE;
CREATE TABLE pagos_cobrar (
id_cuentas_cobrar int4 NOT NULL,
id_cliente int4,
id_usuario int4,
comprobante text,
fecha_actual text,
hora_actual text,
forma_pago text,
tipo_pago text,
num_factura text,
tipo_factura text,
fecha_factura text,
total_factura text,
valor_pagado text,
saldo_factura text,
observaciones text,
 estado text
);

--
-- Creating data for 'pagos_cobrar'
--



--
-- Creating index for 'pagos_cobrar'
--

ALTER TABLE ONLY  pagos_cobrar  ADD CONSTRAINT  pagos_cobrar_externa_pkey  PRIMARY KEY  (id_cuentas_cobrar);

--
-- Estrutura de la tabla 'pagos_compra'
--

DROP TABLE pagos_compra CASCADE;
CREATE TABLE pagos_compra (
id_pagos_compra int4 NOT NULL,
id_proveedor int4,
id_factura_compra int4,
id_usuario int4,
fecha_credito text,
adelanto text,
meses text,
tipo_documento text,
monto_credito text,
saldo text,
 estado text
);

--
-- Creating data for 'pagos_compra'
--



--
-- Creating index for 'pagos_compra'
--

ALTER TABLE ONLY  pagos_compra  ADD CONSTRAINT  pagos_compra_pkey  PRIMARY KEY  (id_pagos_compra);

--
-- Estrutura de la tabla 'pagos_pagar'
--

DROP TABLE pagos_pagar CASCADE;
CREATE TABLE pagos_pagar (
id_cuentas_pagar int4 NOT NULL,
id_proveedor int4,
id_usuario int4,
comprobante text,
fecha_actual text,
hora_actual text,
forma_pago text,
tipo_pago text,
num_factura text,
tipo_factura text,
fecha_factura text,
total_factura text,
valor_pagado text,
saldo_factura text,
observaciones text,
 estado text
);

--
-- Creating data for 'pagos_pagar'
--



--
-- Creating index for 'pagos_pagar'
--

ALTER TABLE ONLY  pagos_pagar  ADD CONSTRAINT  pagos_pagar_pkey  PRIMARY KEY  (id_cuentas_pagar);

--
-- Estrutura de la tabla 'pagos_venta'
--

DROP TABLE pagos_venta CASCADE;
CREATE TABLE pagos_venta (
id_pagos_venta int4 NOT NULL,
id_cliente int4,
id_factura_venta int4,
id_usuario int4,
fecha_credito text,
adelanto text,
meses text,
tipo_documento text,
monto_credito text,
saldo text,
 estado text
);

--
-- Creating data for 'pagos_venta'
--



--
-- Creating index for 'pagos_venta'
--

ALTER TABLE ONLY  pagos_venta  ADD CONSTRAINT  pagos_venta_pkey  PRIMARY KEY  (id_pagos_venta);

--
-- Estrutura de la tabla 'parametros'
--

DROP TABLE parametros CASCADE;
CREATE TABLE parametros (
id_parametro int4 NOT NULL,
nombre_empresa text,
ruc_empresa text,
telefono_empresa text,
direccion_empresa text,
 propietario text
);

--
-- Creating data for 'parametros'
--



--
-- Creating index for 'parametros'
--

ALTER TABLE ONLY  parametros  ADD CONSTRAINT  parametros_pkey  PRIMARY KEY  (id_parametro);

--
-- Estrutura de la tabla 'productos'
--

DROP TABLE productos CASCADE;
CREATE TABLE productos (
cod_productos int4 NOT NULL,
codigo text,
cod_barras text,
articulo text,
iva text,
series text,
precio_compra text,
utilidad_minorista text,
utilidad_mayorista text,
iva_minorista text,
iva_mayorista text,
categoria text,
marca text,
stock text,
stock_minimo text,
stock_maximo text,
fecha_creacion text,
caracteristicas text,
observaciones text,
descuento text,
estado text,
inventariable text,
existencia text,
 diferencia text
);

--
-- Creating data for 'productos'
--

INSERT INTO productos VALUES ('19','AUDIOSPLITTER','798302061552','SEPARADOR DE AURICULARES RLIP XTREME','Si','Si','1.20','25','10','1.50','1.32','ACCESORIOS','RLIP-STREME','5','1','1','2014-05-09',NULL,NULL,NULL,'Activo','Si','4','4');
INSERT INTO productos VALUES ('6','TWIRPCIN150','790069332760','TARJETA PCI WIRELESS N 150','Si','Si','14.50','25','10','18.13','15.95','ACCESORIOS','DLINK','0','1','1','2014-05-09',NULL,NULL,'0','Activo','Si','0','0');
INSERT INTO productos VALUES ('15','TPCID-LINK','PW011A6069905','TARJETA PCI ADAPTERD-LINK','Si','Si','8.00','25','10','10.00','8.80','ACCESORIOS','null','18','1','1','2014-05-09',NULL,NULL,NULL,'Activo','Si','10','10');
INSERT INTO productos VALUES ('2','SIS002','SIS002','SISTEMA SICADI 2 USUARIOS','Si','No','100.00','500','0','600.00','100.00','SISTEMA','SICADI','-4','1','1','2014-05-09',NULL,NULL,'0','Activo','Si','0','0');
INSERT INTO productos VALUES ('18','FLAKINGJACK','740617193671','FLASH MEMORY KINGSTON 8GB BLACK JACK','Si','Si','6.56','25','10','8.20','7.22','ACCESORIOS','KINGTONG','-3','1','1','2014-05-09',NULL,NULL,NULL,'Activo','Si','0','0');
INSERT INTO productos VALUES ('3','SIS003','SIS003','SISTEMA SICADI 3 USUARIOS','Si','No','100.00','500','0','600.00','100.00','SISTEMA','SICADI','-3','1','1','2014-05-09',NULL,NULL,'0','Activo','Si','0','0');
INSERT INTO productos VALUES ('13','MOTHERBOARDH61M-EASUS','DCM0CS017370','MOTHERBOARD H61M-E','Si','Si','56.61','25','10','70.76','62.27','ACCESORIOS','ASUS','-2','1','1','2014-05-09',NULL,NULL,'0','Activo','Si','0','0');
INSERT INTO productos VALUES ('14','NIMINOTEBOOK','X4A86077201897','MOUSE MINI NOTEBOOK','Si','Si','5.42','25','10','6.78','5.96','ACCESORIOS','GENIUS','0','1','1','2014-05-09',NULL,NULL,'3','Activo','Si','0','0');
INSERT INTO productos VALUES ('17','MNPSP-i165','WM130EF01370','MINI PARLANTE GENIUS','Si','Si','8.00','25','10','10.00','8.80','ACCESORIOS','GENIUS','1','1','1','2014-05-09',NULL,NULL,NULL,'Activo','Si','3','2');
INSERT INTO productos VALUES ('8','TWIRPCIN150TR','C213113P00305','TARJETA WIRELESS PCI N 150','Si','Si','12.50','25','10','15.63','13.75','ACCESORIOS','TRENDNET','-17','1','1','2014-05-09',NULL,NULL,'0','Activo','Si','3','3');
INSERT INTO productos VALUES ('4','GRA001','GRA001','GRANOLA 400GR','No','No','0.70','115','100','1.51','1.40','ALIMENTOS','NUTRIVIDA','300','1','1','2014-05-09',NULL,NULL,'0','Activo','Si','350','0');
INSERT INTO productos VALUES ('12','G41M','SN132950135196','MOTHERBOARD G41M GIGABYTE','Si','Si','65.00','25','10','81.25','71.50','ACCESORIOS','GIGABYTE','0','1','1','2014-05-09',NULL,NULL,'0','Activo','Si','1','1');
INSERT INTO productos VALUES ('7','AVE001','AVE001','AVENA 400GR','Si','No','2.00','150','100','5.00','4.00','ALIMENTOS','NUTRIVIDA','7','1','1','2014-05-09',NULL,NULL,'0','Activo','Si','12','0');
INSERT INTO productos VALUES ('9','TGENIUS','YB41C1U16693','TECLADO STANTARD C110 GENIUS','Si','Si','5.92','25','10','7.40','6.51','ACCESORIOS','GENIUS','-12','1','1','2014-05-09',NULL,NULL,'0','Activo','Si','0','0');
INSERT INTO productos VALUES ('5','GALL001|','GALL001','GALLETA AVENA 400GR','Si','Si','0.60','100','67','1.20','1.00','ALIMENTOS','NUTRIVIDA','-47','1','1','2014-05-09',NULL,NULL,'0','Activo','Si','0','0');
INSERT INTO productos VALUES ('1','SIS001','SIS001','SISTEMA SICADI 1 USSUARIIO','Si','No','112.50','500','0','675','112.5','SISTEMA','SICADI','4','1','1','2014-05-09',NULL,NULL,'2','Activo','Si','0','0');
INSERT INTO productos VALUES ('11','ESSENTIALKEYBOARD','KKS61613062700822','TECLADO RLIP XTREME','Si','Si','5.50','25','10','6.88','6.05','ACCESORIOS','null','2','1','1','2014-05-09',NULL,NULL,'0','Activo','Si','2','0');
INSERT INTO productos VALUES ('10','TKEYBOARD','3856130601122','TECLADO KEYBOARD ALTEK','Si','Si','5.50','25','10','6.88','6.05','ACCESORIOS','ALTEK','0','1','1','2014-05-09',NULL,NULL,'0','Activo','Si','2','0');


--
-- Creating index for 'productos'
--

ALTER TABLE ONLY  productos  ADD CONSTRAINT  productos_pkey  PRIMARY KEY  (cod_productos);

--
-- Estrutura de la tabla 'proforma'
--

DROP TABLE proforma CASCADE;
CREATE TABLE proforma (
id_proforma int4 NOT NULL,
id_cliente int4,
id_usuario int4,
id_empresa int4,
comprobante text,
fecha_actual text,
hora_actual text,
tipo_precio text,
tarifa0 text,
tarifa12 text,
iva_proforma text,
descuento_proforma text,
total_proforma text,
observaciones text,
 estado text
);

--
-- Creating data for 'proforma'
--

INSERT INTO proforma VALUES ('1','3','2','1','1','2014-09-18','12:03:39 AM','MINORISTA','0.00','7.50','0.90','0.00','8.40',NULL,'Activo');


--
-- Creating index for 'proforma'
--

ALTER TABLE ONLY  proforma  ADD CONSTRAINT  proforma_pkey  PRIMARY KEY  (id_proforma);

--
-- Estrutura de la tabla 'proveedores'
--

DROP TABLE proveedores CASCADE;
CREATE TABLE proveedores (
id_proveedor int4 NOT NULL,
tipo_documento text,
identificacion_pro text,
empresa_pro text,
representante_legal text,
visitador text,
direccion_pro text,
telefono text,
celular text,
fax text,
pais text,
ciudad text,
forma_pago text,
correo text,
principal text,
observaciones text,
 estado text
);

--
-- Creating data for 'proveedores'
--

INSERT INTO proveedores VALUES ('4','Ruc','1790164241001','FEP CAMARI QUITO','JORGE ANIBAL ARBOLEDA',NULL,'LA FLORESTA MALLORCA','062520408',NULL,NULL,'ECUADOR','QUITO','Contado','NO','No',NULL,'Activo');
INSERT INTO proveedores VALUES ('5','Ruc','1001227808001','VALLE DEL LAGO','ING.JAVIER ROSERO LOPEZ',NULL,'OTAVALO','062635018',NULL,NULL,'ECUADOR','OTAVALO','Contado','NO@HOTMAIL.COM','No',NULL,'Activo');
INSERT INTO proveedores VALUES ('7','Ruc','1000765006001','QUITO QUILCA BLANCA MARIA MAGDALENA','BLANCA QUILCA',NULL,'CALLE ANTONIO ANTE 1-12 Y EUGENIO ESPEJO','062939446',NULL,NULL,'ECUADOR','URCUQUI','Contado','NO@HOTMAIL.COM','No',NULL,'Activo');
INSERT INTO proveedores VALUES ('8','Ruc','1001417631001','MEJIA ARTIEDA MARIA MAGDALENA','MEJIA ARTIEDA MARIA MAGDALENA',NULL,'AV. EUGENIO ESPEJO 8-78 Y JUAN FRANCISCO BONILLA','062643739',NULL,NULL,'ECUADOR','IBARRA','Contado','NO@HOTMAIL.COM','No',NULL,'Activo');
INSERT INTO proveedores VALUES ('3','Ruc','1001991031001','ABASERIA MARROQUIN','MARROQUIN ESPINOSA JOSE RAFAEL',NULL,'OBISPO  MOSQUERA  100Y JUAN ATABALIPA','062955862',NULL,NULL,'ECUADOR','IBARRA','Contado','NO@HOTMAIL.COM','No',NULL,'Activo');
INSERT INTO proveedores VALUES ('6','Ruc','1002050001001','MAS GRAM','BONILLA POZO GIOVANNA ELISABETH',NULL,' HONDURAS Y URUGUAY ESQUINA','062645047',NULL,NULL,'ECUADOR','IBARRA','Contado','NO@HOTMAIL.COM','No',NULL,'Activo');
INSERT INTO proveedores VALUES ('2','Ruc','1091741977001','PIZZERIA EL HORNERO IBARRA','PIZZERIA EL HORNERO IBARRA',NULL,'ELEODORO AYALA Y JOSE TOBAR','062606555',NULL,NULL,'ECUADOR','IBARRA','Contado','ADMIN@HOTMAIL.COM','No',NULL,'Activo');
INSERT INTO proveedores VALUES ('1','Ruc','1002460655001','NORCELL','CHAVEZ CAISEDO DIEGO ISRAEL',NULL,'OBISPO PAQUEL MOPNGE Y AV. MARIANO ACOSTA','062611877',NULL,NULL,'Ecuador','Ibarra','Contado','NO@HOTMAIL.COM','No','Ninguna','Activo');


--
-- Creating index for 'proveedores'
--

ALTER TABLE ONLY  proveedores  ADD CONSTRAINT  proveedores_pkey  PRIMARY KEY  (id_proveedor);

--
-- Estrutura de la tabla 'registro_equipo'
--

DROP TABLE registro_equipo CASCADE;
CREATE TABLE registro_equipo (
id_registro int4 NOT NULL,
id_color int4,
id_marca int4,
id_cliente int4,
nro_serie text,
observaciones text,
detalles text,
estado text,
id_usuario int4,
fecha_ingreso text,
id_categoria int4,
modelo text,
fecha_salida text,
descuento text,
 tecnico text
);

--
-- Creating data for 'registro_equipo'
--

INSERT INTO registro_equipo VALUES ('1','2','1','2','ASD',NULL,NULL,'2','2','2014-09-22','1','ASDASD','2014-09-22','0','Willy Narv ez');


--
-- Creating index for 'registro_equipo'
--

ALTER TABLE ONLY  registro_equipo  ADD CONSTRAINT  registro_equipo_pkey  PRIMARY KEY  (id_registro);

--
-- Estrutura de la tabla 'seguridad'
--

DROP TABLE seguridad CASCADE;
CREATE TABLE seguridad (
id_seguridad int4 NOT NULL,
clave text,
 estado text
);

--
-- Creating data for 'seguridad'
--

INSERT INTO seguridad VALUES ('1','123','Activo');


--
-- Creating index for 'seguridad'
--

ALTER TABLE ONLY  seguridad  ADD CONSTRAINT  seguridad_pkey  PRIMARY KEY  (id_seguridad);

--
-- Estrutura de la tabla 'serie_venta'
--

DROP TABLE serie_venta CASCADE;
CREATE TABLE serie_venta (
id_serie_venta int4 NOT NULL,
cod_productos int4,
id_factura_venta int4,
serie text,
observacion text,
 estado text
);

--
-- Creating data for 'serie_venta'
--



--
-- Creating index for 'serie_venta'
--

ALTER TABLE ONLY  serie_venta  ADD CONSTRAINT  serie_venta_pkey  PRIMARY KEY  (id_serie_venta);

--
-- Estrutura de la tabla 'series_compra'
--

DROP TABLE series_compra CASCADE;
CREATE TABLE series_compra (
id_serie int4 NOT NULL,
cod_productos int4,
id_factura_compra int4,
serie text,
observacion text,
 estado text
);

--
-- Creating data for 'series_compra'
--



--
-- Creating index for 'series_compra'
--

ALTER TABLE ONLY  series_compra  ADD CONSTRAINT  series_pkey  PRIMARY KEY  (id_serie);

--
-- Estrutura de la tabla '"tipoProducto"'
--

DROP TABLE "tipoProducto" CASCADE;
CREATE TABLE "tipoProducto" (
"id_tipoProducto" int4 NOT NULL,
"nombreTipo" text,
 estado text
);

--
-- Creating data for '"tipoProducto"'
--


--
-- Estrutura de la tabla 'trabajo'
--

DROP TABLE trabajo CASCADE;
CREATE TABLE trabajo (
id_trabajo int4 NOT NULL,
nombre_trabajo text,
precio_trabajo text,
 estado text
);

--
-- Creating data for 'trabajo'
--

INSERT INTO trabajo VALUES ('1','FORMATEO COMPUTADOR','20','Activo');
INSERT INTO trabajo VALUES ('2','MANTENIMIENTO FISICO','25','Activo');
INSERT INTO trabajo VALUES ('3','MANTENIMIENTO IMPRESORA','25','Activo');
INSERT INTO trabajo VALUES ('4','REVISION EQUIPO','10','Activo');
INSERT INTO trabajo VALUES ('5','VISITA TECNICA','30','Activo');
INSERT INTO trabajo VALUES ('6','SOPORTE EN SITIO','30','Activo');
INSERT INTO trabajo VALUES ('7','INSTALACION PUNTO DE RED','25','Activo');
INSERT INTO trabajo VALUES ('8','RECARGA TONER','20','Activo');
INSERT INTO trabajo VALUES ('9','REVISION RED DE DATOS','20','Activo');
INSERT INTO trabajo VALUES ('10','CONFIGURACION EQUIPO','20','Activo');
INSERT INTO trabajo VALUES ('11','INSTALACION SOFTWARE','20','Activo');
INSERT INTO trabajo VALUES ('12','INSTALACION ROUTER','30','Activo');
INSERT INTO trabajo VALUES ('13','CONFIGURACION ROUTER','20','Activo');
INSERT INTO trabajo VALUES ('14','MANTENIMIENTO EQUIPO INFORMATICO','20','Activo');
INSERT INTO trabajo VALUES ('15','ORGANIZACION RED DE DATOS','25','Activo');
INSERT INTO trabajo VALUES ('16','INSTALACION SISTEMA CONTABLE','25','Activo');
INSERT INTO trabajo VALUES ('17','INSTALACION SISTEMA SICADI','25','Activo');
INSERT INTO trabajo VALUES ('18','REINSTALACION SISTEMA SICADI','25','Activo');
INSERT INTO trabajo VALUES ('19','SOPORTE TECNICO SICADI','25','Activo');
INSERT INTO trabajo VALUES ('20','CONFIGURACION SISTEMA SICADI','25','Activo');
INSERT INTO trabajo VALUES ('21','RESPALDO DE INFORMACION','10','Activo');
INSERT INTO trabajo VALUES ('22','ACTIVACION SISTEMA','15','Activo');
INSERT INTO trabajo VALUES ('23','SERVICIOS 0%','0.0001','Activo');
INSERT INTO trabajo VALUES ('24','SERVICIOS 12%
','0.0001','Activo');


--
-- Creating index for 'trabajo'
--

ALTER TABLE ONLY  trabajo  ADD CONSTRAINT  trabajo_pkey  PRIMARY KEY  (id_trabajo);

--
-- Estrutura de la tabla 'trabajo_tecnico'
--

DROP TABLE trabajo_tecnico CASCADE;
CREATE TABLE trabajo_tecnico (
id_trabajotecnico int4 NOT NULL,
id_tecnico int4,
id_registro int4,
total_reparaciones text,
 detalles text
);

--
-- Creating data for 'trabajo_tecnico'
--

INSERT INTO trabajo_tecnico VALUES ('1','2','1','249',NULL);


--
-- Creating index for 'trabajo_tecnico'
--

ALTER TABLE ONLY  trabajo_tecnico  ADD CONSTRAINT  "trabajoTecnico_pkey"  PRIMARY KEY  (id_trabajotecnico);

--
-- Estrutura de la tabla 'usuario'
--

DROP TABLE usuario CASCADE;
CREATE TABLE usuario (
id_usuario int4 NOT NULL,
nombre_usuario text,
apellido_usuario text,
ci_usuario text,
telefono_usuario text,
celular_usuario text,
cargo_usuario text,
clave text,
email_usuario text,
direccion_usuario text,
 usuario text
);

--
-- Creating data for 'usuario'
--

INSERT INTO usuario VALUES ('1','Oscar','Troya','1004358584','062922670','0989912241','1','123123','oskr_trov@gmail.com','Otavalo','Oscar');
INSERT INTO usuario VALUES ('2','Willy','Narv ez','1002910345','062922992','0967404989','1','123123','w_narvaez6@hotmail.com','Otavalo','Willy');
INSERT INTO usuario VALUES ('4','JASON','MALES','1004192082',NULL,'0969739104','1','JMALES',NULL,NULL,'JASON');
INSERT INTO usuario VALUES ('5','RONY','MALES','1004134183',NULL,'0997029890','1','RMALES',NULL,NULL,'RONY');
INSERT INTO usuario VALUES ('3','SANTIAGO','YEPEZ','1002050001','0999999999','0987805075','1','santy.2014',NULL,'IBARRA','SANTY');


--
-- Creating index for 'usuario'
--

ALTER TABLE ONLY  usuario  ADD CONSTRAINT  usuario_pkey  PRIMARY KEY  (id_usuario);

--
-- Estrutura de la tabla 'tbl_audit'
--

DROP TABLE tbl_audit CASCADE;
CREATE SEQUENCE tbl_audit_pk_audit_seq
    START WITH 743
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE tbl_audit (
pk_audit int4 NOT NULL DEFAULT nextval('tbl_audit_pk_audit_seq'::regclass) ,
nombre_tabla text NOT NULL,
operacion character(1) NOT NULL,
valor_anterior text,
valor_nuevo text,
fecha_cambio timestamp NOT NULL,
usuario text NOT NULL
);

--
-- Creating data for 'tbl_audit'
--

INSERT INTO tbl_audit VALUES ('3','clientes                                     ','D','(77,Cedula,1002999678,IVON,natural,IBARRA,"","","","","",0,"",Activo)',NULL,'2014-09-18 10:06:19.643','postgres                                     ');
INSERT INTO tbl_audit VALUES ('4','clientes                                     ','D','(76,Ruc,1004358584001,ALFONZO,natural,OTAVALO,0989912312,"","","","",0,"",Activo)',NULL,'2014-09-18 10:14:34.672','postgres                                     ');
INSERT INTO tbl_audit VALUES ('5','clientes                                     ','D','(75,Cedula,1004358584,"OSCAR TROYA",natural,"MIGUEL EGAS",098765345,"","","","",0,"",Activo)',NULL,'2014-09-18 10:14:34.711','postgres                                     ');
INSERT INTO tbl_audit VALUES ('6','clientes                                     ','D','(74,Cedula,1003700869,"DAVID ROMERO",natural,COTACACHI,0991346177,"",ECUADOR,IBARRA,NO@HOTMAIL.COM,5000,"",Activo)',NULL,'2014-09-18 10:14:34.711','postgres                                     ');
INSERT INTO tbl_audit VALUES ('7','clientes                                     ','D','(73,Cedula,1001513355,"JUAN CARLOS JIMENES",natural,"AV.EUJENIO ESPEJO 9-66 Y JUAN FRANCISCO BONILLA",062953347,"",ECUADOR,IBARRA,NO@HOTMAIL.COM,5000,"",Activo)',NULL,'2014-09-18 10:14:34.712','postgres                                     ');
INSERT INTO tbl_audit VALUES ('8','clientes                                     ','D','(72,Ruc,1002050001001,"DAVID ROMERO",natural,COTACACHI,0991346177,"",ECUADOR,IBARRA,NO@HOTMAIL.COM,5000,"",Activo)',NULL,'2014-09-18 10:14:34.713','postgres                                     ');
INSERT INTO tbl_audit VALUES ('9','clientes                                     ','D','(71,Ruc,1001583002001,"CARLOS VELALCAZAR",natural,"JAIME RIVADENEIRA 2-51",062611151,"",ECUADOR,IBARRA,NO@HOTMAIL.COM,5000,"",Activo)',NULL,'2014-09-18 10:14:34.714','postgres                                     ');
INSERT INTO tbl_audit VALUES ('10','clientes                                     ','D','(70,Cedula,1001542560,"ELIZABETH MENESES",natural,"FRANCISCO DE GOYA 1-33",2950968,0983452194,ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:34.715','postgres                                     ');
INSERT INTO tbl_audit VALUES ('11','clientes                                     ','D','(69,Cedula,1002117453,"KARKA ROSALES",natural,"LOS CEIBOS",2954877,0986520801,ECUADOR,IBARRA,"",500,"",Activo)',NULL,'2014-09-18 10:14:34.715','postgres                                     ');
INSERT INTO tbl_audit VALUES ('12','clientes                                     ','D','(53,Ruc,1091717677001,"CENTRO DE DESARROLLO INFANTIL BERNANDINO ECHEVERRIA",natural,"SUCRE 19-91 Y 10 DE AGOSTO",062915203,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:34.716','postgres                                     ');
INSERT INTO tbl_audit VALUES ('13','clientes                                     ','D','(47,Ruc,1090107484001,"SEGUROS VASQUEZ VASQUEZ ",natural,"BARTOLOME GARVA 1-94 Y OVISPO MOSQUERA",062956044,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:34.746','postgres                                     ');
INSERT INTO tbl_audit VALUES ('14','clientes                                     ','D','(45,Cedula,1001937240,"VERONICA VILLARREAL",natural,"CHICA NARVAEZ 6-52",06207939,"",ECUADOR,IBARRA,"",200,"",Activo)',NULL,'2014-09-18 10:14:34.747','postgres                                     ');
INSERT INTO tbl_audit VALUES ('15','clientes                                     ','D','(17,Ruc,1722840624001,"FRANCO GABRIELA",natural,"SANTO DOMINGO DE LOS TSACHILAS","",0993276686,ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:34.748','postgres                                     ');
INSERT INTO tbl_audit VALUES ('16','clientes                                     ','D','(16,Ruc,1091704575001,"UNIDAD EDUCATIVA SAN LUIS",natural,"31 DE OCTUBRE ISAAC BARRERA Y MONCAYO",062920054,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:34.749','postgres                                     ');
INSERT INTO tbl_audit VALUES ('17','clientes                                     ','D','(15,Ruc,1091707582001,"ESCUELA CATOLICA ULPIANO PERES QUI¥ONES",natural,"ISAAC J. BARRERA ELADIO BENITEZ",062922520,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:34.75','postgres                                     ');
INSERT INTO tbl_audit VALUES ('18','clientes                                     ','D','(14,Ruc,1001566379001,"RODRIGUEZ LIMA MARUJA",natural," PANAMERICANA LUIS OLMEDO JATIVA",062907678,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:34.751','postgres                                     ');
INSERT INTO tbl_audit VALUES ('19','clientes                                     ','D','(13,Ruc,1790349578001,ANETA,natural,"OLMEDO Y COLON",062644066,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:34.751','postgres                                     ');
INSERT INTO tbl_audit VALUES ('20','clientes                                     ','D','(12,Ruc,1091701991001,"DISTRIBUIDORA CARLOS ARIAS DISTARIAS CLA.LTDA",natural,"13 DE ABRIL E IBARRA",062546532,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:34.752','postgres                                     ');
INSERT INTO tbl_audit VALUES ('21','clientes                                     ','D','(11,Pasaporte,100151335001,"JUAN CARLOS JIMENES",natural,IBARRA,062953347,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:34.753','postgres                                     ');
INSERT INTO tbl_audit VALUES ('22','clientes                                     ','D','(10,Ruc,1090067601001,"COLEGIO DIOCESANO BILINGUE",natural,"JUAN JOSE FLORES 5_51 Y SUCRE",062952846,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:34.753','postgres                                     ');
INSERT INTO tbl_audit VALUES ('23','clientes                                     ','D','(9,Ruc,1091719076001,"GLOBAL MED",natural,"LODORA AYALA  110 Y JORGE DAVILA MEZA",062601000,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:34.754','postgres                                     ');
INSERT INTO tbl_audit VALUES ('24','clientes                                     ','D','(8,Ruc,1001902533001,"GINA ANGELITA POZO ANDRADE",natural,"SANCHEZ Y CIFUENTES 10_76 Y VELASCO",062953093,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:34.755','postgres                                     ');
INSERT INTO tbl_audit VALUES ('25','clientes                                     ','D','(7,Ruc,1091704494001,"UNIDAD EDUCATIVA MILITAR SAN DIEGO",natural,"AV. EL RETORNO",062650801,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:34.755','postgres                                     ');
INSERT INTO tbl_audit VALUES ('26','clientes                                     ','D','(29,Ruc,1002815106001,"CARLOS ALMEIDA",natural,"LA VICTORIA",062608232,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:39.13','postgres                                     ');
INSERT INTO tbl_audit VALUES ('27','clientes                                     ','D','(28,Ruc,1091742329000,"UNIDAD EDUCATIVA LAS LOMAS",natural,"SAN FRANCISCO CALLE PEDRO MONCAYO",062916668,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:39.146','postgres                                     ');
INSERT INTO tbl_audit VALUES ('28','clientes                                     ','D','(27,Ruc,1003082789001,"PAUL ANDRES PORTILLA MORALES",natural,"LUCIO TARQUINO PAEZ 2-51 ABELARDO MARAN","",0991742441,ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:39.205','postgres                                     ');
INSERT INTO tbl_audit VALUES ('29','clientes                                     ','D','(26,Ruc,1001328515001,"MARTHA PEREZ",natural,"VELASCO 4-41 ROCAFUERTE",062642282,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:39.206','postgres                                     ');
INSERT INTO tbl_audit VALUES ('30','clientes                                     ','D','(25,Ruc,1060003600001,"HOSPITAL SAN VICENTE DE PAUL",natural,"LUIS VARGAS TORRES Y PASQUEL MONGE",062957272,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:39.208','postgres                                     ');
INSERT INTO tbl_audit VALUES ('31','clientes                                     ','D','(24,Ruc,1091737678001,LBONSERVICE,natural,"BARTOLOME GARVA",062612100,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:39.21','postgres                                     ');
INSERT INTO tbl_audit VALUES ('32','clientes                                     ','D','(23,Ruc,1002598793001,"PATRICIA GOMEZ",natural,IBARA,"","",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:39.235','postgres                                     ');
INSERT INTO tbl_audit VALUES ('565','trabajo_tecnico                              ','I',NULL,'(15,2,2,20,"")','2014-09-22 17:49:05.592','postgres                                     ');
INSERT INTO tbl_audit VALUES ('33','clientes                                     ','D','(22,Ruc,0102360567001,"CARLOS PADILLA",natural,"BOLIVAR 12-50 OBISPO MOSQUERA",062954755,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:39.237','postgres                                     ');
INSERT INTO tbl_audit VALUES ('34','clientes                                     ','D','(21,Ruc,0991443630001,REFERTOP,natural,"FLORES 11-75 RAFAEL ROSALES",062643896,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:39.264','postgres                                     ');
INSERT INTO tbl_audit VALUES ('35','clientes                                     ','D','(20,Ruc,1002487112001,"MARVA LLERENA CALDERON",natural,"FLORES 7-65 Y OLMEDO",062951136,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:39.266','postgres                                     ');
INSERT INTO tbl_audit VALUES ('36','clientes                                     ','D','(19,Ruc,0802366235001,"MONTALVAN FERNANDO",natural,"SAN LORENZO",062781006,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:39.267','postgres                                     ');
INSERT INTO tbl_audit VALUES ('37','clientes                                     ','D','(18,Ruc,0201060423001,"NELSON LEOPOLDO CAMPO ANDRADE",natural,"COLON 8-49 Y SANCHEZ Y CIFUENTES",062612273,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:39.269','postgres                                     ');
INSERT INTO tbl_audit VALUES ('38','clientes                                     ','D','(44,Ruc,1711707859001,"CARMEN ORTIZ FLORES",natural,"COLON 8-53 Y SANCHEZ Y CIFUENTES",062612273,"",ECUADOR,IBARRA,"",200,"",Activo)',NULL,'2014-09-18 10:14:43.661','postgres                                     ');
INSERT INTO tbl_audit VALUES ('39','clientes                                     ','D','(43,Ruc,1002539633001,"MARCO BONILLA",natural,"HONDURAZ Y URUGUAY",062645047,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:43.662','postgres                                     ');
INSERT INTO tbl_audit VALUES ('40','clientes                                     ','D','(42,Ruc,1091700449400,"UNIDAD EDUCATIVA ACADEMIA MILITAR SAN DIEGO",natural,"AV.EL REETORNO Y NAZACOTA PUENTO ",062650801,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:43.664','postgres                                     ');
INSERT INTO tbl_audit VALUES ('41','clientes                                     ','D','(41,Ruc,1091742329001,"UNIDAD EDUCATIVA LAS LOMAS",natural,COTACACHI,062916668,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:43.665','postgres                                     ');
INSERT INTO tbl_audit VALUES ('42','clientes                                     ','D','(40,Ruc,1090701991001,"IDSTRIBUIDORA CARLOS ARIAS DISTARIAS CIA.LTDA",natural,"13 DE ABRIL E IBARRA",062546532,"",ECUADOR,IBARRA,"",200,"",Activo)',NULL,'2014-09-18 10:14:43.666','postgres                                     ');
INSERT INTO tbl_audit VALUES ('43','clientes                                     ','D','(39,Ruc,1002688842001,"BONILLA POZO GIOVANNA ELIZABETH",natural,"HONDURAS Y URUGUAY ",062645047,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:43.668','postgres                                     ');
INSERT INTO tbl_audit VALUES ('44','clientes                                     ','D','(38,Ruc,1001389079001,"XIMENA POSSO",natural,"AV.MARIANOP  ACOSTA 10-32","","",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:43.669','postgres                                     ');
INSERT INTO tbl_audit VALUES ('45','clientes                                     ','D','(37,Ruc,1002529228001,"JHONNY MU¥OZ",natural,"AV. MARIANO ACOSTA 21-47",062631505,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:43.671','postgres                                     ');
INSERT INTO tbl_audit VALUES ('46','clientes                                     ','D','(36,Ruc,1707408421001,"CONSUELO TUQUERRES",natural,COTACACHI,062915763,"",ECUADOR,COTACACHI,"",5000,"",Activo)',NULL,'2014-09-18 10:14:43.672','postgres                                     ');
INSERT INTO tbl_audit VALUES ('47','clientes                                     ','D','(35,Ruc,1001515335001,"JUAN CARLOS JIMENES",natural,"FLORES 767 Y OLMEDO",062953347,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:43.673','postgres                                     ');
INSERT INTO tbl_audit VALUES ('48','clientes                                     ','D','(34,Ruc,1002286357001,"ING. MIRNA LUNA",natural,"AV. ATAHUALPA 16-98 Y JUAN FRANCISCO BONILLA",062600767,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:43.675','postgres                                     ');
INSERT INTO tbl_audit VALUES ('49','clientes                                     ','D','(33,Ruc,1060014130001,"DIRECCION DISTRITAL 1ODO3 COTACACHI SALUD",natural,"PEDRO MONCAYO Y SEGUNDO LUIS MORENO",06291550,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:43.677','postgres                                     ');
INSERT INTO tbl_audit VALUES ('50','clientes                                     ','D','(32,Ruc,1090106305001,"DIOCESIS DE IBARRA",natural,"GARVA MORENO 5-68 Y BOLIVAR",062955773,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:43.678','postgres                                     ');
INSERT INTO tbl_audit VALUES ('51','clientes                                     ','D','(31,Ruc,1060017820001,"PATRONATO DE URCUQUI",natural,"GUZMAN Y GONZALEZ SUAREZ",062939888,"",ECUADOR,URCUQUI,"",5000,"",Activo)',NULL,'2014-09-18 10:14:43.679','postgres                                     ');
INSERT INTO tbl_audit VALUES ('52','clientes                                     ','D','(30,Ruc,0400068573001,"OSWALDO LUNA",natural,"AV. MARIANO ACOSTA",062630989,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:43.68','postgres                                     ');
INSERT INTO tbl_audit VALUES ('53','clientes                                     ','D','(6,Ruc,1002538633001,"MARCO BONILLA",natural,"HONDURAS Y URUGUAY",062645047,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-18 10:14:43.682','postgres                                     ');
INSERT INTO tbl_audit VALUES ('54','clientes                                     ','D','(61,Ruc,1002503314001,"LUIS CADENA",natural,"AV.MARIANO ACOSTA",062631964,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:47.842','postgres                                     ');
INSERT INTO tbl_audit VALUES ('55','clientes                                     ','D','(60,Ruc,1002231734001,"LUIS CARRANCO",natural,"PEREZ GUERRERO 6-19 Y BOLIVA",62609214,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:47.844','postgres                                     ');
INSERT INTO tbl_audit VALUES ('56','clientes                                     ','D','(59,Ruc,1001605102001,"EDWIN ROBLES",natural,"SANCHEZ Y CIFUENTES 12-63",062611612,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:47.846','postgres                                     ');
INSERT INTO tbl_audit VALUES ('57','clientes                                     ','D','(58,Ruc,1001683141001,"MERCEDEZ YOLANDA SIMBA¥A",natural,"ARGENTINA 550 Y URUGUAY",062610218,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:47.847','postgres                                     ');
INSERT INTO tbl_audit VALUES ('58','clientes                                     ','D','(57,Ruc,1091700995001,"GREMIO DE MAESTRO MECANICOS",natural,"ARCENICOMTORRES Y JAIME ROLDOS",062950956,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:47.851','postgres                                     ');
INSERT INTO tbl_audit VALUES ('59','clientes                                     ','D','(56,Ruc,1702582592001,"VERGARA ALBUJA MIRIAM",natural,"ROCA ENTRE QUITO Y QUIROGA",062927597,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:47.852','postgres                                     ');
INSERT INTO tbl_audit VALUES ('60','clientes                                     ','D','(55,Ruc,1091711571001,"ESCUELA PARTICULAR  MIXTA PEDDRO DE AROBE",natural,SALINAS,"","",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:47.853','postgres                                     ');
INSERT INTO tbl_audit VALUES ('61','clientes                                     ','D','(54,Ruc,1002137097001,"EDUARDO YEPEZ",natural,"OANAMA 7-153 Y BOLIVIA",062644064,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:47.855','postgres                                     ');
INSERT INTO tbl_audit VALUES ('62','clientes                                     ','D','(52,Ruc,1003292065001,"DIEGO SANDOVAL",natural,COTACACHI,062916200,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:47.856','postgres                                     ');
INSERT INTO tbl_audit VALUES ('675','trabajo_tecnico                              ','D','(2,2,1,20,"")',NULL,'2014-09-22 17:56:06.133','postgres                                     ');
INSERT INTO tbl_audit VALUES ('63','clientes                                     ','D','(51,Ruc,1002064192001,"MANUEL  ESTUARDO JATIVA ",natural,"BOLIVAR 10-78 Y 101 DE AGOSTO",062915682,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:47.858','postgres                                     ');
INSERT INTO tbl_audit VALUES ('64','clientes                                     ','D','(50,Cedula,1000948602,SR.JUAN,natural,"SANTA ROSA DEL TEJAR",062652693,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:47.86','postgres                                     ');
INSERT INTO tbl_audit VALUES ('65','clientes                                     ','D','(49,Ruc,1090105880001,FODEMI,natural,"AV.JAIME RIVADENEIRA 6.88 Y MARIANO ACOSTA",062641893,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:47.861','postgres                                     ');
INSERT INTO tbl_audit VALUES ('66','clientes                                     ','D','(48,Ruc,1091738283001,"CORPORACION TECNOLOGICA MORAN MU¥OS S.A",natural,"VICTOR GOMEZ JURADO 344 Y AV. LATACUNGA",062603894,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:47.903','postgres                                     ');
INSERT INTO tbl_audit VALUES ('67','clientes                                     ','D','(46,Ruc,1001361870001,"AMPARITO LOZANO",natural,"ROCAFUERTE 2-16",062643301,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:47.904','postgres                                     ');
INSERT INTO tbl_audit VALUES ('68','clientes                                     ','D','(68,Cedula,1001765583,"OSCAR PLACENCIA",natural,"AV. Mariano Acosta 13-14","",0999043909,Ecuador,Ibarra,no,2000,"",Activo)',NULL,'2014-09-18 10:14:55.961','postgres                                     ');
INSERT INTO tbl_audit VALUES ('69','clientes                                     ','D','(67,Ruc,1091719181001,"ESPINO VERDE CIA.LTDA",natural,"RODRIGO DE MO¥O 3-122 Y AV.  FRAY VACAS GALINDO",062510422,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:55.963','postgres                                     ');
INSERT INTO tbl_audit VALUES ('70','clientes                                     ','D','(66,Ruc,1091706373001,"DISPENSARIO MONSE¥OR BERNARDINO ECHEVERRIA",natural,"SANCHEZ Y CIFUENTES 15-26 Y RAFAEL  LARREA",0621957724,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:55.964','postgres                                     ');
INSERT INTO tbl_audit VALUES ('71','clientes                                     ','D','(65,Ruc,1790127613001,"CORPORACION ADVENTISTA DEL SEPTIMO DIA",natural,"Km 14 VIA A QUEVEDO","","",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:55.966','postgres                                     ');
INSERT INTO tbl_audit VALUES ('72','clientes                                     ','D','(64,Ruc,1091722018001,TECNINORTE,natural,"AV. ELOY ALFARO",062642657,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:55.97','postgres                                     ');
INSERT INTO tbl_audit VALUES ('73','clientes                                     ','D','(63,Cedula,1001258761,"GILBERTO TERAN",natural,COTACACHI,"","",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:55.972','postgres                                     ');
INSERT INTO tbl_audit VALUES ('74','clientes                                     ','D','(62,Ruc,1091709704001,GLT,natural,"AV.FRAY VACAS GALINDO 4-11",062607088,"",ECUADOR,IBARRA,"",2000,"",Activo)',NULL,'2014-09-18 10:14:55.974','postgres                                     ');
INSERT INTO tbl_audit VALUES ('75','c_cobrarexternas                             ','D','(1,1,1,2,1,2014-08-19,"3:50:57 PM",1223123,Factura,122.00,88.00,Activo)',NULL,'2014-09-18 10:21:47.063','postgres                                     ');
INSERT INTO tbl_audit VALUES ('76','categoria                                    ','D','(8,ALIMENTOS,)',NULL,'2014-09-18 10:22:00.945','postgres                                     ');
INSERT INTO tbl_audit VALUES ('77','categoria                                    ','D','(7,SISTEMA,)',NULL,'2014-09-18 10:22:01.003','postgres                                     ');
INSERT INTO tbl_audit VALUES ('78','categoria                                    ','D','(6,MONITORES,)',NULL,'2014-09-18 10:22:01.004','postgres                                     ');
INSERT INTO tbl_audit VALUES ('79','categoria                                    ','D','(5,IMPRESORAS,)',NULL,'2014-09-18 10:22:01.006','postgres                                     ');
INSERT INTO tbl_audit VALUES ('80','categoria                                    ','D','(4,CPU,)',NULL,'2014-09-18 10:22:01.007','postgres                                     ');
INSERT INTO tbl_audit VALUES ('81','categoria                                    ','D','(3,PORTATILES,)',NULL,'2014-09-18 10:22:01.009','postgres                                     ');
INSERT INTO tbl_audit VALUES ('82','categoria                                    ','D','(2,EQUIPOS,)',NULL,'2014-09-18 10:22:01.01','postgres                                     ');
INSERT INTO tbl_audit VALUES ('83','categoria                                    ','D','(1,ACCESORIOS,)',NULL,'2014-09-18 10:22:01.012','postgres                                     ');
INSERT INTO tbl_audit VALUES ('84','color                                        ','D','(11,PLOMO)',NULL,'2014-09-18 10:22:17.176','postgres                                     ');
INSERT INTO tbl_audit VALUES ('85','color                                        ','D','(10,NARANJA)',NULL,'2014-09-18 10:22:17.192','postgres                                     ');
INSERT INTO tbl_audit VALUES ('86','color                                        ','D','(9,VERDE)',NULL,'2014-09-18 10:22:17.195','postgres                                     ');
INSERT INTO tbl_audit VALUES ('87','color                                        ','D','(8,MORADO)',NULL,'2014-09-18 10:22:17.199','postgres                                     ');
INSERT INTO tbl_audit VALUES ('88','color                                        ','D','(7,BLANCO)',NULL,'2014-09-18 10:22:17.2','postgres                                     ');
INSERT INTO tbl_audit VALUES ('89','color                                        ','D','(6,CELESTE)',NULL,'2014-09-18 10:22:17.202','postgres                                     ');
INSERT INTO tbl_audit VALUES ('90','color                                        ','D','(5,ROJO)',NULL,'2014-09-18 10:22:17.21','postgres                                     ');
INSERT INTO tbl_audit VALUES ('91','color                                        ','D','(4,CAFE)',NULL,'2014-09-18 10:22:17.212','postgres                                     ');
INSERT INTO tbl_audit VALUES ('92','color                                        ','D','(3,NEGRO)',NULL,'2014-09-18 10:22:17.213','postgres                                     ');
INSERT INTO tbl_audit VALUES ('93','color                                        ','D','(2,AMARILLO)',NULL,'2014-09-18 10:22:17.214','postgres                                     ');
INSERT INTO tbl_audit VALUES ('94','color                                        ','D','(1,AZUL)',NULL,'2014-09-18 10:22:17.215','postgres                                     ');
INSERT INTO tbl_audit VALUES ('95','detalle_devolucion_compra                    ','D','(1,1,6,1,14.50,0,14.50,Activo)',NULL,'2014-09-18 10:22:25.96','postgres                                     ');
INSERT INTO tbl_audit VALUES ('96','detalle_factura_compra                       ','D','(2,1,8,2,15.50,0,31,Activo)',NULL,'2014-09-18 10:22:41.015','postgres                                     ');
INSERT INTO tbl_audit VALUES ('97','detalle_factura_compra                       ','D','(1,1,6,1,14.50,0,14.50,Activo)',NULL,'2014-09-18 10:22:41.071','postgres                                     ');
INSERT INTO tbl_audit VALUES ('98','detalle_factura_venta                        ','D','(2,2,16,12,12.50,0,150.00,Activo,0)',NULL,'2014-09-18 10:22:59.214','postgres                                     ');
INSERT INTO tbl_audit VALUES ('99','detalle_factura_venta                        ','D','(1,1,21,1,7.76,0,7.76,Activo,0)',NULL,'2014-09-18 10:22:59.278','postgres                                     ');
INSERT INTO tbl_audit VALUES ('100','detalle_pagos_venta                          ','D','(3,1,2014-11-19,56.00,56.00,Activo)',NULL,'2014-09-18 10:23:17.887','postgres                                     ');
INSERT INTO tbl_audit VALUES ('101','detalle_pagos_venta                          ','D','(2,1,2014-10-19,56.00,56.00,Activo)',NULL,'2014-09-18 10:23:17.916','postgres                                     ');
INSERT INTO tbl_audit VALUES ('102','detalle_pagos_venta                          ','D','(1,1,2014-09-19,56.00,24.00,Activo)',NULL,'2014-09-18 10:23:17.918','postgres                                     ');
INSERT INTO tbl_audit VALUES ('103','detalles_pagos_internos                      ','D','(2,3,2014-09-19,20,24,Activo)',NULL,'2014-09-18 10:23:33.312','postgres                                     ');
INSERT INTO tbl_audit VALUES ('104','detalles_pagos_internos                      ','D','(1,1,2014-09-19,12,44,Activo)',NULL,'2014-09-18 10:23:33.406','postgres                                     ');
INSERT INTO tbl_audit VALUES ('105','devolucion_compra                            ','D','(1,1,150,2,1,2014-08-18,"3:12:45 PM",Factura,123-123-123123123,123123123,0.00,14.50,1.74,0.00,16.24,"",Activo)',NULL,'2014-09-18 10:23:44.606','postgres                                     ');
INSERT INTO tbl_audit VALUES ('106','empresa                                      ','U','(1,WQE,QWE,QWE,QEQ,,,,,)','(1,"P&S System",100345678956001,Ibarra,,,,system@hotmail.com,www.syste.com,Activo)','2014-09-18 10:24:53.608','postgres                                     ');
INSERT INTO tbl_audit VALUES ('107','factura_compra                               ','D','(1,1,150,2,1,2014-08-18,"3:12:25 PM",2014-08-18,2014-08-18,2014-08-18,Factura,123-123-123123123,123123123,2014-08-18,Contado,0.00,14.50,1.74,0.00,16.24,Activo)',NULL,'2014-09-18 10:25:02.989','postgres                                     ');
INSERT INTO tbl_audit VALUES ('108','factura_venta                                ','D','(2,1,1,2,2,001-001-213123124,2014-08-19,"3:44:47 PM",2014-08-19,MINORISTA,Credito,123123,2014-08-19,2014-08-19,0.00,150.00,18.00,0.00,168.00,Activo,"")',NULL,'2014-09-18 10:25:13.473','postgres                                     ');
INSERT INTO tbl_audit VALUES ('109','factura_venta                                ','D','(1,1,1,2,1,001-001-213123123,2014-08-12,"12:25:53 AM",2014-08-12,MINORISTA,Contado,1213123123,2014-08-12,2014-08-12,0.00,7.76,0.93,0.00,8.69,Activo,"")',NULL,'2014-09-18 10:25:13.532','postgres                                     ');
INSERT INTO tbl_audit VALUES ('110','gastos_internos                              ','D','(1,2,4,1,2014-08-21,"5:05:25 PM",123123,12312,12.00,Activo)',NULL,'2014-09-18 10:27:41.941','postgres                                     ');
INSERT INTO tbl_audit VALUES ('111','marcas                                       ','U','(1,TOSHIBA,)','(1,TOSHIBA,Activo)','2014-09-18 10:28:14.406','postgres                                     ');
INSERT INTO tbl_audit VALUES ('112','marcas                                       ','U','(2,Hp,)','(2,Hp,Activo)','2014-09-18 10:28:18.286','postgres                                     ');
INSERT INTO tbl_audit VALUES ('113','marcas                                       ','U','(3,KINGSTON,)','(3,KINGSTON,Activo)','2014-09-18 10:28:21.446','postgres                                     ');
INSERT INTO tbl_audit VALUES ('114','marcas                                       ','U','(5,SAMSUNG,)','(5,SAMSUNG,Activo)','2014-09-18 10:28:24.792','postgres                                     ');
INSERT INTO tbl_audit VALUES ('115','marcas                                       ','U','(4,GENIUS,)','(4,GENIUS,Activo)','2014-09-18 10:28:28.535','postgres                                     ');
INSERT INTO tbl_audit VALUES ('116','marcas                                       ','U','(6,LG,)','(6,LG,Activo)','2014-09-18 10:28:31.935','postgres                                     ');
INSERT INTO tbl_audit VALUES ('117','marcas                                       ','U','(8,EPSON,)','(8,EPSON,Activo)','2014-09-18 10:28:34.927','postgres                                     ');
INSERT INTO tbl_audit VALUES ('118','marcas                                       ','U','(7,DELL,)','(7,DELL,Activo)','2014-09-18 10:28:37.91','postgres                                     ');
INSERT INTO tbl_audit VALUES ('119','marcas                                       ','U','(9,ALTEK,)','(9,ALTEK,Activo)','2014-09-18 10:28:41.406','postgres                                     ');
INSERT INTO tbl_audit VALUES ('120','marcas                                       ','U','(11,CNET,)','(11,CNET,Activo)','2014-09-18 10:28:45.174','postgres                                     ');
INSERT INTO tbl_audit VALUES ('121','marcas                                       ','U','(10,D-LINK,)','(10,D-LINK,Activo)','2014-09-18 10:28:48.703','postgres                                     ');
INSERT INTO tbl_audit VALUES ('122','marcas                                       ','U','(12,ASUS,)','(12,ASUS,Activo)','2014-09-18 10:28:52.277','postgres                                     ');
INSERT INTO tbl_audit VALUES ('123','marcas                                       ','U','(13,HONEYWELL,)','(13,HONEYWELL,Activo)','2014-09-18 10:28:55.735','postgres                                     ');
INSERT INTO tbl_audit VALUES ('124','marcas                                       ','U','(15,SPEEDMIND,)','(15,SPEEDMIND,Activo)','2014-09-18 10:28:58.936','postgres                                     ');
INSERT INTO tbl_audit VALUES ('125','marcas                                       ','U','(14,GIGABYTE,)','(14,GIGABYTE,Activo)','2014-09-18 10:29:02.424','postgres                                     ');
INSERT INTO tbl_audit VALUES ('126','marcas                                       ','U','(16,TRIPP.LITE,)','(16,TRIPP.LITE,Activo)','2014-09-18 10:29:05.736','postgres                                     ');
INSERT INTO tbl_audit VALUES ('127','marcas                                       ','U','(18,SEAGATE,)','(18,SEAGATE,Activo)','2014-09-18 10:29:09.039','postgres                                     ');
INSERT INTO tbl_audit VALUES ('128','marcas                                       ','U','(17,ESENSES,)','(17,ESENSES,Activo)','2014-09-18 10:29:12.071','postgres                                     ');
INSERT INTO tbl_audit VALUES ('129','marcas                                       ','U','(19,BIOSTAR,)','(19,BIOSTAR,Activo)','2014-09-18 10:29:15.942','postgres                                     ');
INSERT INTO tbl_audit VALUES ('130','marcas                                       ','U','(20,RLIP-XTREME,)','(20,RLIP-XTREME,Activo)','2014-09-18 10:29:21.918','postgres                                     ');
INSERT INTO tbl_audit VALUES ('131','marcas                                       ','U','(45,INTEL,)','(45,INTEL,Activo)','2014-09-18 10:29:25.645','postgres                                     ');
INSERT INTO tbl_audit VALUES ('132','marcas                                       ','U','(44,COMPAQ,)','(44,COMPAQ,Activo)','2014-09-18 10:29:32.463','postgres                                     ');
INSERT INTO tbl_audit VALUES ('133','marcas                                       ','U','(43,CANON,)','(43,CANON,Activo)','2014-09-18 10:30:44.103','postgres                                     ');
INSERT INTO tbl_audit VALUES ('134','marcas                                       ','U','(42,ACER,)','(42,ACER,Activo)','2014-09-18 10:30:46.846','postgres                                     ');
INSERT INTO tbl_audit VALUES ('135','marcas                                       ','U','(41,"SOUND BLASTER",)','(41,"SOUND BLASTER",Activo)','2014-09-18 10:30:50.499','postgres                                     ');
INSERT INTO tbl_audit VALUES ('136','marcas                                       ','U','(40,"KEY MEDIA",)','(40,"KEY MEDIA",Activo)','2014-09-18 10:30:53.838','postgres                                     ');
INSERT INTO tbl_audit VALUES ('137','marcas                                       ','U','(39,SENTEY,)','(39,SENTEY,Activo)','2014-09-18 10:30:57.435','postgres                                     ');
INSERT INTO tbl_audit VALUES ('138','marcas                                       ','U','(38,XTECH,)','(38,XTECH,Activo)','2014-09-18 10:31:00.288','postgres                                     ');
INSERT INTO tbl_audit VALUES ('139','marcas                                       ','U','(37,DELUX,)','(37,DELUX,Activo)','2014-09-18 10:31:03.315','postgres                                     ');
INSERT INTO tbl_audit VALUES ('140','marcas                                       ','U','(36,CLON,)','(36,CLON,Activo)','2014-09-18 10:31:06.606','postgres                                     ');
INSERT INTO tbl_audit VALUES ('141','marcas                                       ','U','(35,GENERICO,)','(35,GENERICO,Activo)','2014-09-18 10:31:10.374','postgres                                     ');
INSERT INTO tbl_audit VALUES ('142','marcas                                       ','U','(34,TRENDNET,)','(34,TRENDNET,Activo)','2014-09-18 10:31:13.435','postgres                                     ');
INSERT INTO tbl_audit VALUES ('143','marcas                                       ','U','(33,NUTRIVIDA,)','(33,NUTRIVIDA,Activo)','2014-09-18 10:31:16.479','postgres                                     ');
INSERT INTO tbl_audit VALUES ('144','marcas                                       ','U','(32,BELKIN,)','(32,BELKIN,Activo)','2014-09-18 10:31:19.104','postgres                                     ');
INSERT INTO tbl_audit VALUES ('145','marcas                                       ','U','(31,OMEGA,)','(31,OMEGA,Activo)','2014-09-18 10:31:22.008','postgres                                     ');
INSERT INTO tbl_audit VALUES ('146','marcas                                       ','U','(30,NIUTEK,)','(30,NIUTEK,Activo)','2014-09-18 10:31:24.967','postgres                                     ');
INSERT INTO tbl_audit VALUES ('147','marcas                                       ','U','(29,NVIDIA,)','(29,NVIDIA,Activo)','2014-09-18 10:31:28.606','postgres                                     ');
INSERT INTO tbl_audit VALUES ('148','marcas                                       ','U','(28,THX,)','(28,THX,Activo)','2014-09-18 10:31:31.315','postgres                                     ');
INSERT INTO tbl_audit VALUES ('149','marcas                                       ','U','(27,NEXXT,)','(27,NEXXT,Activo)','2014-09-18 10:31:33.957','postgres                                     ');
INSERT INTO tbl_audit VALUES ('150','marcas                                       ','U','(21,D-LINK,)','(21,D-LINK,Activo)','2014-09-18 10:31:38.082','postgres                                     ');
INSERT INTO tbl_audit VALUES ('151','marcas                                       ','U','(22,VALK,)','(22,VALK,Activo)','2014-09-18 10:31:40.919','postgres                                     ');
INSERT INTO tbl_audit VALUES ('152','marcas                                       ','U','(23,COMQTECH,)','(23,COMQTECH,Activo)','2014-09-18 10:31:43.658','postgres                                     ');
INSERT INTO tbl_audit VALUES ('153','marcas                                       ','U','(24,AKUT,)','(24,AKUT,Activo)','2014-09-18 10:31:46.129','postgres                                     ');
INSERT INTO tbl_audit VALUES ('154','marcas                                       ','U','(25,TITAN,)','(25,TITAN,Activo)','2014-09-18 10:31:49.414','postgres                                     ');
INSERT INTO tbl_audit VALUES ('155','marcas                                       ','U','(26,SICADI,)','(26,SICADI,Activo)','2014-09-18 10:31:53.974','postgres                                     ');
INSERT INTO tbl_audit VALUES ('156','pagos_cobrar                                 ','D','(4,1,2,4,2014-08-19,"4:21:50 PM",EFECTIVO,EXTERNA,1223123,Factura,2014-08-19,122.00,22.00,88.00,"",Activo)',NULL,'2014-09-18 10:33:04.532','postgres                                     ');
INSERT INTO tbl_audit VALUES ('157','pagos_cobrar                                 ','D','(3,1,2,3,2014-08-19,"4:08:55 PM",EFECTIVO,INTERNA,001-001-213123124,Factura,2014-08-19,168.00,20.00,136.00,"",Activo)',NULL,'2014-09-18 10:33:04.606','postgres                                     ');
INSERT INTO tbl_audit VALUES ('158','pagos_cobrar                                 ','D','(2,1,2,2,2014-08-19,"3:51:28 PM",EFECTIVO,EXTERNA,1223123,Factura,2014-08-19,122.00,12.00,110.00,"",Activo)',NULL,'2014-09-18 10:33:04.608','postgres                                     ');
INSERT INTO tbl_audit VALUES ('159','pagos_cobrar                                 ','D','(1,1,2,1,2014-08-19,"3:50:10 PM",EFECTIVO,INTERNA,001-001-213123124,Factura,2014-08-19,168.00,12.00,156.00,"",Activo)',NULL,'2014-09-18 10:33:04.609','postgres                                     ');
INSERT INTO tbl_audit VALUES ('160','pagos_venta                                  ','D','(1,1,2,2,2014-08-19,0,3,Factura,168.00,136.00,Activo)',NULL,'2014-09-18 10:33:20.487','postgres                                     ');
INSERT INTO tbl_audit VALUES ('161','productos                                    ','D','(146,CORTAPIC,"CORTA PICOS","CORTA PICOS FORZA",Si,Si,4.50,25,10,5.63,4.95,ACCESORIOS,"",0,1,1,2014-05-29,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:39.973','postgres                                     ');
INSERT INTO tbl_audit VALUES ('162','productos                                    ','D','(145,CABPODER,"CABLE PODER","CABLE DE PODER",Si,Si,2.00,25,10,2.50,2.20,ACCESORIOS,"",0,1,1,2014-05-29,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.026','postgres                                     ');
INSERT INTO tbl_audit VALUES ('163','productos                                    ','D','(144,CABUSB,"CALBLE USB","CABLE USB",Si,Si,2.00,10,5,2.20,2.10,ACCESORIOS,"",0,1,1,2014-05-29,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.028','postgres                                     ');
INSERT INTO tbl_audit VALUES ('164','productos                                    ','D','(143,TSPEEDMIND,TECLADO,"TECLADO COMBO ESCRITORIO SPEEDMIND",Si,Si,12.00,25,10,15.00,13.20,ACCESORIOS,SPEEDMIND,0,1,1,2014-05-29,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.029','postgres                                     ');
INSERT INTO tbl_audit VALUES ('165','productos                                    ','D','(142,TSPEEDMIND,TECLADO,"TECLADO COMBO ESCRITORIO SPEEDMIND",Si,Si,12.00,25,10,15.00,13.20,ACCESORIOS,SPEEDMIND,0,1,1,2014-05-29,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.031','postgres                                     ');
INSERT INTO tbl_audit VALUES ('166','productos                                    ','D','(141,TKITGEN,TECLADO,"TECLADO KB-C100 KIT GENIUS",Si,Si,7.85,25,10,9.81,8.63,ACCESORIOS,GENIUS,0,1,1,2014-05-29,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.032','postgres                                     ');
INSERT INTO tbl_audit VALUES ('167','productos                                    ','D','(140,PROCEINTEL,PROCESADOR,"PROCESADOR CORE I3 3.40GHZ INTEL",Si,Si,132.61,25,10,165.76,145.87,ACCESORIOS,INTEL,0,1,1,2014-05-29,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.034','postgres                                     ');
INSERT INTO tbl_audit VALUES ('168','productos                                    ','D','(139,MBH61M-CASUS,MOTHERBOARD,"MOTHERBOARD H61M-C ASUS",Si,Si,63.27,25,10,79.09,69.60,ACCESORIOS,ASUS,0,1,1,2014-05-29,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.035','postgres                                     ');
INSERT INTO tbl_audit VALUES ('169','productos                                    ','D','(138,FLASH32GB,"FLASH MEMORY","FLASH MEMORY KINGSTONG 32GB",Si,Si,17.00,25,10,21.25,18.70,ACCESORIOS,KINGSTON,0,1,1,2014-05-29,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.037','postgres                                     ');
INSERT INTO tbl_audit VALUES ('170','productos                                    ','D','(137,FLASH4GB,"FLASH MEMORY","FLASH MEMORY KINGSTONG 4GB",Si,Si,6.56,25,10,8.20,7.22,ACCESORIOS,KINGSTON,0,1,1,2014-05-29,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.038','postgres                                     ');
INSERT INTO tbl_audit VALUES ('171','productos                                    ','D','(136,CABRED,CABLE,"CABLE DE RED",Si,Si,1.50,25,10,1.88,1.65,ACCESORIOS,"",0,1,1,2014-05-29,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.04','postgres                                     ');
INSERT INTO tbl_audit VALUES ('172','productos                                    ','D','(135,CABSATA,"CABLE SATA","CABLE SATA",Si,Si,1.00,25,10,1.25,1.10,ACCESORIOS,"",15,1,1,2014-05-28,"","",0,Activo,Si,15,15)',NULL,'2014-09-18 10:33:40.041','postgres                                     ');
INSERT INTO tbl_audit VALUES ('173','productos                                    ','D','(134,KITLIM,KITLIM,"KITS DE LIMPIEZA ",Si,Si,8.00,25,10,10.00,8.80,ACCESORIOS,"",4,1,1,2014-05-28,"","",0,Activo,Si,4,4)',NULL,'2014-09-18 10:33:40.043','postgres                                     ');
INSERT INTO tbl_audit VALUES ('174','productos                                    ','D','(133,MBINTEL,MBINTEL,"MOTHERBOARD INTEL",Si,Si,98.34,25,10,122.93,108.17,ACCESORIOS,BIOSTAR,1,1,1,2014-05-28,"","",0,Activo,Si,1,1)',NULL,'2014-09-18 10:33:40.044','postgres                                     ');
INSERT INTO tbl_audit VALUES ('175','productos                                    ','D','(132,FUENPODER,4713621965653,"FUENTE DE PODER SPEEDMIND 550W",Si,Si,13.16,25,10,16.45,14.48,ACCESORIOS,SPEEDMIND,0,1,1,2014-05-28,"","",0,Activo,Si,7,7)',NULL,'2014-09-18 10:33:40.045','postgres                                     ');
INSERT INTO tbl_audit VALUES ('176','productos                                    ','D','(131,MONSAMS19,MONITOR,"MONITOR SAMSUNG 19""",Si,Si,116.00,25,10,145.00,127.60,ACCESORIOS,"",-4,1,1,2014-05-23,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.047','postgres                                     ');
INSERT INTO tbl_audit VALUES ('177','productos                                    ','D','(130,TONHO80A,TONER,"TONER HP 80A",Si,Si,120.00,25,10,150.00,132.00,ACCESORIOS,"",-1,1,1,2014-05-23,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.048','postgres                                     ');
INSERT INTO tbl_audit VALUES ('178','productos                                    ','D','(129,TONHP49A,TONER,"TONER HP 49A",Si,Si,95.00,25,10,118.75,104.50,ACCESORIOS,"",-1,1,1,2014-05-23,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.05','postgres                                     ');
INSERT INTO tbl_audit VALUES ('179','productos                                    ','D','(128,REVIMPRE,REVIMPRE,"REVISION IMPRESORA",Si,Si,20.00,25,10,25.00,22.00,ACCESORIOS,"",-2,1,1,2014-05-23,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.051','postgres                                     ');
INSERT INTO tbl_audit VALUES ('180','productos                                    ','D','(127,MEM268,MEM268,"MEMORIA 268 DDR2",Si,Si,35.00,25,10,43.75,38.50,ACCESORIOS,"",-3,1,1,2014-05-23,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.053','postgres                                     ');
INSERT INTO tbl_audit VALUES ('181','productos                                    ','D','(126,MEMDDR3,MENDDR3,"MEMORIA DDR3 2GB",Si,Si,30.00,25,10,37.50,33.00,ACCESORIOS,"",-1,1,1,2014-05-23,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:40.054','postgres                                     ');
INSERT INTO tbl_audit VALUES ('182','productos                                    ','D','(125,REVRED,REVRED,"REVISION RED DE COMPUTADORAS",Si,Si,30.00,25,10,37.50,33.00,ACCESORIOS,"",-1,1,1,2014-05-23,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:43.998','postgres                                     ');
INSERT INTO tbl_audit VALUES ('183','productos                                    ','D','(124,REVCOMPU,RECOMPU,"REVISION COMPUTADOR",Si,Si,10.00,25,10,12.50,11.00,ACCESORIOS,"",-2,1,1,2014-05-23,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:43.999','postgres                                     ');
INSERT INTO tbl_audit VALUES ('184','productos                                    ','D','(123,ACRED,ACRED,"ACCESORIOS DE RED",Si,Si,50.00,25,10,62.50,55.00,ACCESORIOS,"",-4,1,1,2014-05-23,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:44','postgres                                     ');
INSERT INTO tbl_audit VALUES ('185','productos                                    ','D','(122,OREDCOMPU,ORGANIZACION,"ORGANIZACION RED DE COMPUTADORAS",Si,Si,75.00,25,10,93.75,82.50,ACCESORIOS,"",-1,1,1,2014-05-23,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:44.001','postgres                                     ');
INSERT INTO tbl_audit VALUES ('186','productos                                    ','D','(120,AUGENIMINI,AUDIFONO,"AUDIFONO GENIUS MINI",Si,Si,12.50,25,10,15.63,13.75,ACCESORIOS,GENIUS,4,1,1,2014-05-23,"","",0,Activo,Si,4,2)',NULL,'2014-09-18 10:33:44.001','postgres                                     ');
INSERT INTO tbl_audit VALUES ('187','productos                                    ','D','(118,IEPSONL555,IMPRESORA,"IMPRESORA EPSON L555",Si,Si,330.00,25,10,412.50,363.00,IMPRESORAS,EPSON,-1,1,1,2014-05-23,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:44.002','postgres                                     ');
INSERT INTO tbl_audit VALUES ('188','productos                                    ','D','(117,TRED,TRED,"TARJETA DE RED WIRELESS",Si,Si,17.00,25,10,21.25,18.70,ACCESORIOS,"",5,1,1,2014-05-23,"","",0,Activo,Si,5,3)',NULL,'2014-09-18 10:33:44.003','postgres                                     ');
INSERT INTO tbl_audit VALUES ('189','productos                                    ','D','(115,INSTCOMPU,INSTAL,"INSTALACION COMPUTADOR",Si,Si,10.00,25,10,12.50,11.00,ACCESORIOS,"",-2,1,1,2014-05-22,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:44.004','postgres                                     ');
INSERT INTO tbl_audit VALUES ('190','productos                                    ','D','(113,LCB,LCB,"LECTOR DE CODIGO DE BARRAS",Si,Si,150.00,25,10,187.50,165.00,ACCESORIOS,"",1,1,1,2014-05-22,"","",0,Activo,Si,1,0)',NULL,'2014-09-18 10:33:44.004','postgres                                     ');
INSERT INTO tbl_audit VALUES ('191','productos                                    ','D','(112,REVISISTEM,REVISION,"REVISION SISTEMA",Si,Si,150.00,25,01,187.50,151.50,ACCESORIOS,"",-2,1,1,2014-05-22,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:44.005','postgres                                     ');
INSERT INTO tbl_audit VALUES ('192','productos                                    ','D','(111,PANTAPORT,PANTALLA,"PANTALLA PORTATIL",Si,Si,170.00,25,10,212.50,187.00,ACCESORIOS,"",-2,1,1,2014-05-22,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:44.006','postgres                                     ');
INSERT INTO tbl_audit VALUES ('193','productos                                    ','D','(110,CATX,CATX,"CASE ATX PCI",Si,Si,45.00,25,10,56.25,49.50,ACCESORIOS,"",-1,1,1,2014-05-22,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:44.006','postgres                                     ');
INSERT INTO tbl_audit VALUES ('194','productos                                    ','D','(108,KITRECAR,KITS,"KITS DE RECARGA",Si,Si,5.00,25,10,6.25,5.50,ACCESORIOS,"",-12,1,1,2014-05-22,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:44.007','postgres                                     ');
INSERT INTO tbl_audit VALUES ('195','productos                                    ','D','(107,IMCANMULT,IMPRE,"IMPRESORA CANON MULTIFUNCION MG 2410",Si,Si,60.00,25,10,75.00,66.00,IMPRESORAS,CANON,-1,1,1,2014-05-22,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:44.008','postgres                                     ');
INSERT INTO tbl_audit VALUES ('196','productos                                    ','D','(121,MBBIOSTAR,MBBIOSTAR,"MB BIOSTAR",Si,Si,50.00,25,10,62.50,55.00,ACCESORIOS,BIOSTAR,-2,1,1,2014-05-23,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:48.146','postgres                                     ');
INSERT INTO tbl_audit VALUES ('197','productos                                    ','D','(119,UPSFOR,UPS,"UPS FORZA 750W",Si,Si,60.00,25,10,75.00,66.00,ACCESORIOS,"",-1,1,1,2014-05-23,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:48.148','postgres                                     ');
INSERT INTO tbl_audit VALUES ('198','productos                                    ','D','(116,CONECTRJ45,CONECTOR,"CONECTOR RJ 45",Si,Si,0.50,25,10,0.63,0.55,ACCESORIOS,"",-34,1,1,2014-05-23,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:48.149','postgres                                     ');
INSERT INTO tbl_audit VALUES ('199','productos                                    ','D','(114,RESINFOR,RESINFOR,"RESPALDO DE INFORMACION",Si,Si,10.00,25,10,12.50,11.00,ACCESORIOS,"",-1,1,1,2014-05-22,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:48.151','postgres                                     ');
INSERT INTO tbl_audit VALUES ('200','productos                                    ','D','(109,PRD,PRD,"PUNTO DE RED DE DATOS",Si,Si,25.00,25,10,31.25,27.50,ACCESORIOS,"",-25,1,1,2014-05-22,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:48.152','postgres                                     ');
INSERT INTO tbl_audit VALUES ('201','productos                                    ','D','(106,REINSTSIS,REISTAL,"REINSTALACION SISTEMA",Si,Si,30.00,25,10,37.50,33.00,ACCESORIOS,"",-1,1,1,2014-05-22,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:48.153','postgres                                     ');
INSERT INTO tbl_audit VALUES ('202','productos                                    ','D','(105,SISPURI,SISTEMA,"SISTEMA PURIFICACION AGUA",Si,Si,200.00,25,10,250.00,220.00,ACCESORIOS,"",-1,1,1,2014-05-22,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:48.155','postgres                                     ');
INSERT INTO tbl_audit VALUES ('203','productos                                    ','D','(104,TUSBG,TECLADO,"TECLADO USB GENIUS",Si,Si,7.00,25,10,8.75,7.70,ACCESORIOS,"",5,1,1,2014-05-22,"","",0,Activo,Si,6,-1)',NULL,'2014-09-18 10:33:48.156','postgres                                     ');
INSERT INTO tbl_audit VALUES ('204','productos                                    ','D','(103,TVPCIEX16B,TARJETA,"TARJETA DE VIDEO PCI EXPRESS 16B",Si,Si,42.00,25,10,52.50,46.20,ACCESORIOS,"",1,1,1,2014-05-22,"","",0,Activo,Si,1,-4)',NULL,'2014-09-18 10:33:48.158','postgres                                     ');
INSERT INTO tbl_audit VALUES ('205','productos                                    ','D','(102,CABLUSB,CABLE,"CABLE USB",Si,Si,3.00,25,10,3.75,3.30,ACCESORIOS,"",-1,1,1,2014-05-22,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:48.159','postgres                                     ');
INSERT INTO tbl_audit VALUES ('206','productos                                    ','D','(101,IEPLX300M,IMPRESORA,"IMPRESORA EPSON LX300 MATRICIAL",Si,Si,215.00,25,20,268.75,258.00,IMPRESORAS,EPSON,-2,1,1,2014-05-22,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:48.16','postgres                                     ');
INSERT INTO tbl_audit VALUES ('207','productos                                    ','D','(100,FORMATEADACOMPU,FORMATEADA,"FORMATEADA COMPUTADOR",Si,Si,50.00,25,10,62.50,55.00,ACCESORIOS,"",-16,1,1,2014-05-22,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:48.164','postgres                                     ');
INSERT INTO tbl_audit VALUES ('208','productos                                    ','D','(99,IMEPMATRFX890,IMPRESORA,"IMPRESORA EPSON MATRICIAL FX890 PARALELA /USB",Si,Si,428.57,25,10,535.71,471.43,IMPRESORAS,EPSON,-1,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:48.214','postgres                                     ');
INSERT INTO tbl_audit VALUES ('209','productos                                    ','D','(98,MANCOMPU,MANCOMPU,"MANTENIMIENTO COMPUTADORA",Si,Si,20.00,25,10,25.00,22.00,ACCESORIOS,"",-8,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:48.216','postgres                                     ');
INSERT INTO tbl_audit VALUES ('210','productos                                    ','D','(97,INSTAYCONFIG,INSTAL,"INSTALACION Y CONFIGURACION ROUTER",Si,Si,30.00,25,10,37.50,33.00,ACCESORIOS,"",-1,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:48.217','postgres                                     ');
INSERT INTO tbl_audit VALUES ('509','detalles_trabajo                             ','I',NULL,'(19," ??  ","",6,Producto:,"","")','2014-09-19 15:45:00.18','postgres                                     ');
INSERT INTO tbl_audit VALUES ('211','productos                                    ','D','(96,CABVIDVGA,CABLE,"CABLE DE VIDEO VGA",Si,Si,30.00,25,10,37.50,33.00,ACCESORIOS,"",-1,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:52.433','postgres                                     ');
INSERT INTO tbl_audit VALUES ('212','productos                                    ','D','(95,EXTLUZ,EXTLUZ,"EXTENSION LUZ",Si,Si,10.00,25,10,12.50,11.00,ACCESORIOS,"",-1,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:52.435','postgres                                     ');
INSERT INTO tbl_audit VALUES ('213','productos                                    ','D','(94,TREPSONL200,TINTA,"TINTA DE RECARGA EPSON L200",Si,Si,10.00,25,10,12.50,11.00,ACCESORIOS,EPSON,14,1,1,2014-05-21,"","",0,Activo,Si,14,2)',NULL,'2014-09-18 10:33:52.438','postgres                                     ');
INSERT INTO tbl_audit VALUES ('214','productos                                    ','D','(93,IMEPSONM205,IMPRESORA,"IMPRESORA EPSON M205",Si,Si,295.00,25,10,368.75,324.50,IMPRESORAS,EPSON,-2,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:52.442','postgres                                     ');
INSERT INTO tbl_audit VALUES ('215','productos                                    ','D','(92,CONFTARJRED,CONFIGURACION,"CONFIGURACION TARJETA DE RED",Si,Si,15.00,25,10,18.75,16.50,ACCESORIOS,"",-1,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:52.444','postgres                                     ');
INSERT INTO tbl_audit VALUES ('216','productos                                    ','D','(91,VARIOS,VARIOS,VARIOS,Si,Si,40.00,25,10,50.00,44.00,ACCESORIOS,"",-20,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:52.445','postgres                                     ');
INSERT INTO tbl_audit VALUES ('217','productos                                    ','D','(90,FUENPODESENT,FUENTE,"FUENTE DE PODER SENTEY",Si,Si,38.37,25,10,47.96,42.21,ACCESORIOS,"",1,1,1,2014-05-21,"","",0,Activo,Si,1,-2)',NULL,'2014-09-18 10:33:52.446','postgres                                     ');
INSERT INTO tbl_audit VALUES ('218','productos                                    ','D','(89,SOPORTECNI,SOPORTE,"SOPORTE TECNICO",Si,Si,10.00,25,10,12.50,11.00,ACCESORIOS,"",-2,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:52.447','postgres                                     ');
INSERT INTO tbl_audit VALUES ('219','productos                                    ','D','(88,TARSONCREA,TARJETA,"TARJETA DE SONIDO CREATIVE X-FL 5.1 PRO USB",Si,Si,80.00,25,10,100.00,88.00,ACCESORIOS,"",1,1,1,2014-05-21,"","",0,Activo,Si,1,-2)',NULL,'2014-09-18 10:33:52.448','postgres                                     ');
INSERT INTO tbl_audit VALUES ('220','productos                                    ','D','(87,TONSAMSUN,TONER,"TONER SAMSUNG SCX4521",Si,Si,78.00,25,10,97.50,85.80,ACCESORIOS,SAMSUNG,-3,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:52.45','postgres                                     ');
INSERT INTO tbl_audit VALUES ('221','productos                                    ','D','(86,PROYECTOREPSONX12,PROYECT,"PROYECTOR EPSON X12-517",Si,Si,602.68,25,10,753.35,662.95,ACCESORIOS,EPSON,-2,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:52.452','postgres                                     ');
INSERT INTO tbl_audit VALUES ('222','productos                                    ','D','(85,"MONLGLED20""",MONITOR,"MONITOR LG LED 20""",Si,Si,140.00,25,10,175.00,154.00,ACCESORIOS,"",-6,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:52.454','postgres                                     ');
INSERT INTO tbl_audit VALUES ('223','productos                                    ','D','(84,MONLGLED18.5,MONITOR,"MONITOR LG LED 18,5""",Si,Si,125.00,25,10,156.25,137.50,ACCESORIOS,LG,-2,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:52.455','postgres                                     ');
INSERT INTO tbl_audit VALUES ('224','productos                                    ','D','(83,DISCDURTOSHI500GB,"DISCO ","DISCO DURO TOSHIBA 500GB",Si,Si,75.00,25,10,93.75,82.50,ACCESORIOS,"",-4,1,1,2014-05-21,"","",0,Activo,Si,1,-1)',NULL,'2014-09-18 10:33:52.456','postgres                                     ');
INSERT INTO tbl_audit VALUES ('225','productos                                    ','D','(82,ACTUSISTEM,ACTUSISTEM,"ACTUALIZACION DE SISTEMA",Si,Si,250.00,25,10,312.50,275.00,ACCESORIOS,"",-2,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:52.458','postgres                                     ');
INSERT INTO tbl_audit VALUES ('226','productos                                    ','D','(81,MUESSLI400GR,MUESSLI,"MUESSLI 400GR",Si,Si,2.50,25,10,3.13,2.75,ACCESORIOS,"",-25,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:52.459','postgres                                     ');
INSERT INTO tbl_audit VALUES ('227','productos                                    ','D','(80,CASESENCOOL,CASES,"CASES SENTEY COOL ",Si,Si,120.00,25,10,150.00,132.00,ACCESORIOS,"",-3,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:52.46','postgres                                     ');
INSERT INTO tbl_audit VALUES ('228','productos                                    ','D','(79,MANTIMPRE,MANTEN,"MANTENIMIENTO IMPRESORA ",Si,Si,60.00,25,10,75.00,66.00,ACCESORIOS,"",-8,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:52.461','postgres                                     ');
INSERT INTO tbl_audit VALUES ('229','productos                                    ','D','(78,ROUTWIRELVPN,ROUTER,"ROUTER WIRELESS VPN RV110W",Si,Si,125.00,25,10,156.25,137.50,ACCESORIOS,"",-3,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.639','postgres                                     ');
INSERT INTO tbl_audit VALUES ('230','productos                                    ','D','(77,VENTIESCRIT,VENTILADOR,"VENTILADOR DE ESCRITORIO TIPO COOLER ",Si,Si,15.00,25,10,18.75,16.50,ACCESORIOS,"",-1,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.64','postgres                                     ');
INSERT INTO tbl_audit VALUES ('231','productos                                    ','D','(76,ADAPENERG,ADAPT,"ADAPTADOR DE ENERGIA ACER 12V",Si,Si,45.00,25,10,56.25,49.50,ACCESORIOS,"",-1,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.641','postgres                                     ');
INSERT INTO tbl_audit VALUES ('232','productos                                    ','D','(75,NOT32ANT,ANT,"ANTIVIRUS NOD 32 SERVIDOR",Si,Si,50.00,25,10,62.50,55.00,ACCESORIOS,"",-1,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.642','postgres                                     ');
INSERT INTO tbl_audit VALUES ('233','productos                                    ','D','(74,MECOMPU,MESA,"MESA DE COMPUTADOR",Si,Si,30.00,25,10,37.50,33.00,ACCESORIOS,"",-1,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.643','postgres                                     ');
INSERT INTO tbl_audit VALUES ('234','productos                                    ','D','(73,MAINGIGABY,MAINB,"MAINBOARD GIGABYTE",Si,Si,85.00,25,10,106.25,93.50,ACCESORIOS,"",-2,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.643','postgres                                     ');
INSERT INTO tbl_audit VALUES ('235','productos                                    ','D','(72,CABLEUTP,CABLE,"CABLE UTP CATS  ",Si,No,2.00,25,2.50,2.50,2.05,ACCESORIOS,"",2,1,1,2014-05-21,"","",0,Activo,Si,2,-236)',NULL,'2014-09-18 10:33:57.644','postgres                                     ');
INSERT INTO tbl_audit VALUES ('236','productos                                    ','D','(71,PIECOMPU,PCOMP,"PIEZAS COMPUTADOR",Si,No,297.00,25,10,371.25,326.70,ACCESORIOS,"",-2,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.645','postgres                                     ');
INSERT INTO tbl_audit VALUES ('237','productos                                    ','D','(70,COMPUDESCRI,COMPU,"COMPUTADOR DE ESCRITORIO",Si,Si,5,25,10,675.00,594.00,EQUIPOS,"",-26,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.645','postgres                                     ');
INSERT INTO tbl_audit VALUES ('238','productos                                    ','D','(69,MAN001,SOP001,"SOPORTE EN SITIO",Si,No,10.00,100,5,20.00,10.50,"","",-28,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.646','postgres                                     ');
INSERT INTO tbl_audit VALUES ('239','productos                                    ','D','(68,DISDURIDEINTERN250GB,2454845454,"DISCO DURO IDE INTERNO 250 GB",Si,Si,65.00,25,10,81.25,71.50,ACCESORIOS,"",-1,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.647','postgres                                     ');
INSERT INTO tbl_audit VALUES ('510','detalles_trabajo                             ','I',NULL,'(20,"",20,6,"","",Servicio)','2014-09-19 15:45:00.181','postgres                                     ');
INSERT INTO tbl_audit VALUES ('240','productos                                    ','D','(67,DISDUROEXTER1TB,2548511548,"DISCO DURO EXTERNO 1TB",Si,Si,107.00,25,10,133.75,117.70,ACCESORIOS,"",-3,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.647','postgres                                     ');
INSERT INTO tbl_audit VALUES ('241','productos                                    ','D','(66,IMPEPSL210,1232323454,"IMPRESORA EPSON L210 MULTIFUNCION",Si,Si,205.00,10,5,225.50,215.25,"","",-13,1,1,2014-05-21,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.648','postgres                                     ');
INSERT INTO tbl_audit VALUES ('242','productos                                    ','D','(65,NOD32ANT,ANTNOD32,"ANTIVIRUS NOD 32 V7",Si,No,12.50,50,20,18.75,15.00,"","",-121,1,1,2014-05-19,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.648','postgres                                     ');
INSERT INTO tbl_audit VALUES ('243','productos                                    ','D','(64,S0,S0,"SERVICIOS 0%",No,No,5.00,00001,00001,5.05,5.05,"","",9,1,1,2014-05-14,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.649','postgres                                     ');
INSERT INTO tbl_audit VALUES ('244','productos                                    ','D','(63,S12,S12,"SERVICIOS 12%",Si,No,0.00,00001,00001,0.00,0.00,"","",0,1,1,2014-05-14,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.65','postgres                                     ');
INSERT INTO tbl_audit VALUES ('245','productos                                    ','D','(62,P12,PRODD12,"PRODUCTOS 12%",Si,No,132.81,00001,00001,134.1381,134.1381,"","",142,1,1,2014-05-14,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.65','postgres                                     ');
INSERT INTO tbl_audit VALUES ('246','productos                                    ','D','(61,P0,P0,"PRODUCTOS 0%",No,No,5.98,00001,00001,6.0398,6.0398,"","",45,1,1,2014-05-14,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:33:57.651','postgres                                     ');
INSERT INTO tbl_audit VALUES ('247','productos                                    ','D','(60,HONSCA3200,10298C7191,"HONEYWELL 3200 ",Si,Si,54.40,25,10,68.00,59.84,ACCESORIOS,HONEYWELL,0,1,1,2014-05-13,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:34:02.402','postgres                                     ');
INSERT INTO tbl_audit VALUES ('248','productos                                    ','D','(59,CINCAR8750EPSON,010343600096,"CINTA EPSON 8750 LX-300",Si,Si,4.00,25,10,5.00,4.40,ACCESORIOS,EPSON,6,1,1,2014-05-13,"","",0,Activo,Si,6,5)',NULL,'2014-09-18 10:34:02.403','postgres                                     ');
INSERT INTO tbl_audit VALUES ('249','productos                                    ','D','(58,SOUNBLASCREATIVE,YJSB0570321474078W,"SOUND BLASTER CREATIVE",Si,Si,30.00,25,10,37.50,33.00,ACCESORIOS,"SOUND BLASTER",0,1,1,2014-05-13,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:34:02.405','postgres                                     ');
INSERT INTO tbl_audit VALUES ('250','productos                                    ','D','(57,DISKDRIVETOSHIBA,73NICRUWTS97,"DISK DRIVE TOSHIBA  ",Si,Si,70.00,25,10,87.50,77.00,ACCESORIOS,TOSHIBA,0,1,1,2014-05-13,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:34:02.406','postgres                                     ');
INSERT INTO tbl_audit VALUES ('251','productos                                    ','D','(56,BARRSEA3000GB,Z1F2EKPG,"BARRACUDA SEAGATE 3000GB ",Si,Si,100.00,25,10,125.00,110.00,ACCESORIOS,SEAGATE,0,1,1,2014-05-13,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:34:02.41','postgres                                     ');
INSERT INTO tbl_audit VALUES ('252','productos                                    ','D','(55,SM55COLNOSPEED,201203010351,"NOTEBOOK COOLDER SM55 SPEEDMIND",Si,Si,10.00,25,10,12.50,11.00,ACCESORIOS,SPEEDMIND,0,1,1,2014-05-13,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:34:02.412','postgres                                     ');
INSERT INTO tbl_audit VALUES ('253','productos                                    ','D','(54,UNINOTE12V,822594030504,"UNIVERSAL NOTEBOOK CAR CHANGE KEY MEDIA 12V",Si,Si,20.00,25,10,25.00,22.00,ACCESORIOS,"KEY MEDIA",1,1,1,2014-05-13,"","",0,Activo,Si,1,1)',NULL,'2014-09-18 10:34:02.414','postgres                                     ');
INSERT INTO tbl_audit VALUES ('254','productos                                    ','D','(53,TARION150NEXXT,798302033917,"TARJETA ION 150 NEXXT ",Si,Si,12.00,25,10,15,13.2,ACCESORIOS,NEXXT,-61,1,1,2014-05-13,"","",0,Activo,Si,1,1)',NULL,'2014-09-18 10:34:02.415','postgres                                     ');
INSERT INTO tbl_audit VALUES ('255','productos                                    ','D','(52,SOUCARBLASX-FI5.1PRO,YDSB1095248002539N,"SOUND CAR CREATIVE X-FI SURROUND 5.1 PRO",Si,Si,68.83,25,10,86.04,75.71,ACCESORIOS,THX,1,1,1,2014-05-13,"","",0,Activo,Si,1,1)',NULL,'2014-09-18 10:34:02.416','postgres                                     ');
INSERT INTO tbl_audit VALUES ('256','productos                                    ','D','(50,USBHUBRLIPXTREME,798302070240,"CONCENTRADOR UNIVERSAL DE 4 PUERTOS USB RLIP XTREME",Si,Si,5.00,25,10,6.25,5.50,ACCESORIOS,RLIP-XTREME,0,1,1,2014-05-13,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:34:02.418','postgres                                     ');
INSERT INTO tbl_audit VALUES ('257','productos                                    ','D','(49,NOTETRIPP-LITEUSB,037332127051,"NOTEBOOK TRIPP-LITE",Si,Si,18.55,25,10,23.19,20.41,ACCESORIOS,TRIPP.LITE,0,1,1,2014-05-12,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:34:02.419','postgres                                     ');
INSERT INTO tbl_audit VALUES ('258','productos                                    ','D','(48,POSENTBRP460W,16012014,"FUENTE DE PODER BRP 460W",Si,Si,36.53,25,10,45.66,40.18,ACCESORIOS,SENTEY,-11,1,1,2014-05-12,"","",0,Activo,Si,0,0)',NULL,'2014-09-18 10:34:02.421','postgres                                     ');
INSERT INTO tbl_audit VALUES ('259','productos                                    ','D','(47,NETRLIPXTREME,798316073251,"NETBOOKSLEEVE RLIP XTREME 10.1",Si,Si,10.50,25,10,13.13,11.55,ACCESORIOS,RLIP-XTREME,1,1,1,2014-05-12,"","",0,Activo,Si,1,1)',NULL,'2014-09-18 10:34:02.423','postgres                                     ');
INSERT INTO tbl_audit VALUES ('260','productos                                    ','D','(46,SWITCHD-LINK,DL2I1D7000525,"EASILE SWITCH WITH D-LINK",Si,Si,5.23,25,10,6.54,5.75,ACCESORIOS,D-LINK,2,1,1,2014-05-12,"","","",Activo,Si,2,-1)',NULL,'2014-09-18 10:34:02.424','postgres                                     ');
INSERT INTO tbl_audit VALUES ('261','productos                                    ','D','(45,MOUBROWXTECHPS/2,063003682,"MOUSE BROWSER PS/2 XTECH",Si,Si,2.37,25,10,2.96,2.61,ACCESORIOS,XTECH,12,1,1,2014-05-12,"","","",Activo,Si,1,1)',NULL,'2014-09-18 10:34:02.425','postgres                                     ');
INSERT INTO tbl_audit VALUES ('262','productos                                    ','D','(44,PARPCIHOSTCARIEEE,753182850030,"TARJETA PCI HOST CARD COMQTECH",Si,Si,8.00,25,10,10.00,8.80,ACCESORIOS,COMQTECH,0,1,1,2014-05-12,"","","",Activo,Si,0,0)',NULL,'2014-09-18 10:34:02.427','postgres                                     ');
INSERT INTO tbl_audit VALUES ('263','productos                                    ','D','(51,HUBVALKUSB,7862115670072,"ADAPTADOR 4 PUERTOS USB VALK  ",Si,Si,5.00,25,10,6.25,5.50,ACCESORIOS,VALK,4,1,1,2014-05-13,"","",0,Activo,Si,4,3)',NULL,'2014-09-18 10:34:05.962','postgres                                     ');
INSERT INTO tbl_audit VALUES ('264','productos                                    ','D','(43,MULTHEADSESENMH5700,7707278171779,"AUDIFONO CON MICROFONO MH 5700 ESENSES",Si,Si,9.00,25,10,11.25,9.90,ACCESORIOS,ESENSES,-12,1,1,2014-05-12,"","","",Activo,Si,1,1)',NULL,'2014-09-18 10:34:12.045','postgres                                     ');
INSERT INTO tbl_audit VALUES ('265','productos                                    ','D','(42,MULTHEADESENMH306,7707278170826,"AUDIFONO CON MICROFONO HM306 ESENSES",Si,Si,8.00,25,10,10.00,8.80,ACCESORIOS,ESENSES,-3,1,1,2014-05-12,"","","",Activo,Si,1,1)',NULL,'2014-09-18 10:34:12.046','postgres                                     ');
INSERT INTO tbl_audit VALUES ('266','productos                                    ','D','(41,STERHEADRLIPKHS-470,798308071272,"HEADSET RLIP XTREME KHS-470",Si,Si,7.55,25,10,9.44,8.30,ACCESORIOS,RLIP-XTREME,-30,1,1,2014-05-12,"","","",Activo,Si,0,0)',NULL,'2014-09-18 10:34:12.047','postgres                                     ');
INSERT INTO tbl_audit VALUES ('267','productos                                    ','D','(40,STERHEADKSH-320,798302100572,"HEADSET RLIP XTREME KSH-320",Si,Si,8.20,25,10,10.25,9.02,ACCESORIOS,RLIP-XTREME,-5,1,1,2014-05-12,"","","",Activo,Si,0,0)',NULL,'2014-09-18 10:34:12.048','postgres                                     ');
INSERT INTO tbl_audit VALUES ('268','productos                                    ','D','(39,MOBIG2KING,740617163155,"MOBILELITE G2 KINGSTON ",Si,Si,2.37,25,10,2.96,2.61,ACCESORIOS,KINGSTON,12,1,1,2014-05-12,"","","",Activo,Si,0,0)',NULL,'2014-09-18 10:34:12.049','postgres                                     ');
INSERT INTO tbl_audit VALUES ('269','productos                                    ','D','(38,LCDCLEASYST,722868441558,"LCD CLEANING SYSTEM BELKIN",Si,Si,8.00,25,10,10.00,8.80,ACCESORIOS,BELKIN,0,1,1,2014-05-12,"","","",Activo,Si,0,0)',NULL,'2014-09-18 10:34:12.05','postgres                                     ');
INSERT INTO tbl_audit VALUES ('270','productos                                    ','D','(37,BOTEPSONMAGENTA,010343885318,"INK BOTTLE EPSON T664320 MAGENTA",Si,Si,6.95,25,10,8.69,7.65,ACCESORIOS,EPSON,0,1,1,2014-05-12,"","","",Activo,Si,0,0)',NULL,'2014-09-18 10:34:12.051','postgres                                     ');
INSERT INTO tbl_audit VALUES ('271','productos                                    ','D','(36,BOTEPSONYELLOW,010343885325,"INK BOTTLE EPSON T664420 YELLOW",Si,Si,6.65,25,10,8.31,7.32,ACCESORIOS,EPSON,-24,1,1,2014-05-12,"","","",Activo,Si,0,0)',NULL,'2014-09-18 10:34:12.052','postgres                                     ');
INSERT INTO tbl_audit VALUES ('272','productos                                    ','D','(35,BOTEPSONCIANT6642,010343885301,"INK BOTTLE EPSON T664220 CYAN",Si,Si,6.96,25,10,8.7,7.656,ACCESORIOS,EPSON,2,1,1,2014-05-12,"","","",Activo,Si,0,0)',NULL,'2014-09-18 10:34:12.053','postgres                                     ');
INSERT INTO tbl_audit VALUES ('273','productos                                    ','D','(34,PARDELUXUSB2.0,6938820430667,"PARLANTES DELUX USB 2.0",Si,Si,7.98,25,10,9.98,8.78,ACCESORIOS,DELUX,0,1,1,2014-05-12,"","","",Activo,Si,11,0)',NULL,'2014-09-18 10:34:12.054','postgres                                     ');
INSERT INTO tbl_audit VALUES ('274','productos                                    ','D','(33,MULTPARLAKUT,1810103200024,"PARLANTES THONEY VANDER AKUT",Si,Si,29.00,25,10,36.25,31.90,ACCESORIOS,AKUT,1,1,1,2014-05-12,"","","",Activo,Si,1,1)',NULL,'2014-09-18 10:34:12.055','postgres                                     ');
INSERT INTO tbl_audit VALUES ('275','productos                                    ','D','(32,CAD-LINKDCS-910,P1VC3B2000019,"CAMERA D-LINK DCS-910",Si,Si,18.25,25,10,22.81,20.08,ACCESORIOS,D-LINK,-6,1,1,2014-05-12,"","","",Activo,Si,1,1)',NULL,'2014-09-18 10:34:12.056','postgres                                     ');
INSERT INTO tbl_audit VALUES ('276','productos                                    ','D','(31,CARHPN§122BLAK,884962983546,"CARTUCHO HP N§122 BLACK",Si,Si,9.97,25,10,12.46,10.97,ACCESORIOS,Hp,-6,1,1,2014-05-12,"","","",Activo,Si,1,1)',NULL,'2014-09-18 10:34:12.057','postgres                                     ');
INSERT INTO tbl_audit VALUES ('277','productos                                    ','D','(30,CARHPN§60BLAK,883585983179,"CARTUCHO HP N§60 BLAK",Si,Si,14.77,25,10,18.46,16.25,ACCESORIOS,Hp,-21,1,1,2014-05-12,"","","",Activo,Si,2,1)',NULL,'2014-09-18 10:34:12.058','postgres                                     ');
INSERT INTO tbl_audit VALUES ('278','productos                                    ','D','(29,CARHPN¦60TRI,883585983193,"CARTUCHO HP N¦60 TRICOLOR",Si,Si,16.83,25,10,21.04,18.51,ACCESORIOS,Hp,-17,1,1,2014-05-12,"","","",Activo,Si,0,0)',NULL,'2014-09-18 10:34:12.06','postgres                                     ');
INSERT INTO tbl_audit VALUES ('279','productos                                    ','D','(28,CARHPTRIN22,829160902227,"CARTUCHO HP N¦22 TRICOLOR",Si,Si,21.50,25,10,26.88,23.65,ACCESORIOS,Hp,-1,1,1,2014-05-12,"","","",Activo,Si,0,0)',NULL,'2014-09-18 10:34:12.064','postgres                                     ');
INSERT INTO tbl_audit VALUES ('280','productos                                    ','D','(27,MOU3DOMEUSB,4710728127120,"MOUSE 3D OMEGA USB",Si,Si,5.23,25,10,6.54,5.75,ACCESORIOS,OMEGA,1,1,1,2014-05-12,"","","",Activo,Si,1,1)',NULL,'2014-09-18 10:34:12.065','postgres                                     ');
INSERT INTO tbl_audit VALUES ('281','productos                                    ','D','(26,MOUGENUSB,X4A86077201919,"MOUSE GENIUS MICRO TRAVELER USB ",Si,Si,5.45,25,10,6.81,6.00,ACCESORIOS,GENIUS,1,1,1,2014-05-12,"","","",Activo,Si,1,-8)',NULL,'2014-09-18 10:34:12.066','postgres                                     ');
INSERT INTO tbl_audit VALUES ('282','productos                                    ','D','(25,OMALTEKUSB,"S-N¤ NO 3858130300978","MOUSE ALTEK 3D USB",Si,Si,5.23,25,10,6.54,5.75,ACCESORIOS,ALTEK,0,1,1,2014-05-12,"","","",Activo,Si,0,0)',NULL,'2014-09-18 10:34:12.067','postgres                                     ');
INSERT INTO tbl_audit VALUES ('283','productos                                    ','D','(24,OMRLIPXTREMEUSB,798303071048,"MOUSE RLIP XTREME USB",Si,Si,5.23,25,10,6.54,5.75,ACCESORIOS,RLIP-XTREME,0,1,1,2014-05-12,"","","",Activo,Si,1,1)',NULL,'2014-09-18 10:34:12.068','postgres                                     ');
INSERT INTO tbl_audit VALUES ('284','productos                                    ','D','(23,AUSTEREORLIPXTREME,798302061644,"AUDIFONOS RLIP XTREME",Si,Si,5.00,25,10,6.25,5.50,ACCESORIOS,RLIP-XTREME,-6,1,1,2014-05-09,"","","",Activo,Si,0,0)',NULL,'2014-09-18 10:34:18.466','postgres                                     ');
INSERT INTO tbl_audit VALUES ('285','productos                                    ','D','(22,FLAKINGSE68GB,740617205282,"FLASH MEMORY KINGSTON 2GB",Si,Si,6.56,25,8.20,10,7.22,ACCESORIOS,KINGSTON,-2,1,1,2014-05-09,"","","",Activo,Si,0,0)',NULL,'2014-09-18 10:34:18.468','postgres                                     ');
INSERT INTO tbl_audit VALUES ('286','productos                                    ','D','(21,FLAKING8GB,740617214284,"FLASH MEMORY KINGSTON 8GB",Si,Si,6.21,25,10,7.76,6.83,ACCESORIOS,KINGSTON,4,1,1,2014-05-09,"","","",Activo,Si,5,5)',NULL,'2014-09-18 10:34:18.469','postgres                                     ');
INSERT INTO tbl_audit VALUES ('287','proveedores                                  ','D','(150,Cedula,1004358584,ITCO,"","","ESQUINA MOVIMIENTO",062922670,"","",ECUADOR,OTAVALO,Contado,itco@hotmail.com,Si,NO,Activo)',NULL,'2014-09-18 10:34:34.242','postgres                                     ');
INSERT INTO tbl_audit VALUES ('288','proveedores                                  ','D','(149,Ruc,1000354140001,"EDITORIAL ALMEIDA","ALMEIDA EGAS JAIME RENE","","AV.JAIME RIVADENEIRA 3-24 Y JUAN DE DIOS NAVAS",062951674,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.25','postgres                                     ');
INSERT INTO tbl_audit VALUES ('289','proveedores                                  ','D','(148,Ruc,1001698800001,PROGRAFIC,"CHUCAY ABAD PATRICIO VINICIO","","OLMEDOM 4-22 Y BORRERO",062954749,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.251','postgres                                     ');
INSERT INTO tbl_audit VALUES ('290','proveedores                                  ','D','(147,Ruc,1717231060001,"RESTAURANTE VEGETARIANO","SHI MAO TE","","OVIEDO 5.45 Y SUCRE",062608808,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.253','postgres                                     ');
INSERT INTO tbl_audit VALUES ('291','proveedores                                  ','D','(146,Ruc,0500511027001,"EPPETRO ECUADOR","PACHECO PACHECO HUGO VICENTE","","LA MERCED AV. ALBERTO ZAMBRANO Y AMAZONAS",032530005,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.256','postgres                                     ');
INSERT INTO tbl_audit VALUES ('292','proveedores                                  ','D','(145,Ruc,1002708848001,"REMATES EL PAISA","MAIQUEZ SOSA HIPATIA GABRIELA","","COLON 8-54 Y SANCHEZ Y CIFUENTES",062611160,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.258','postgres                                     ');
INSERT INTO tbl_audit VALUES ('293','proveedores                                  ','D','(144,Ruc,1001538253001,"LUBRICANTES DON NABOR E HIJOS","WILLIAN VINICIO JARRIN OBANDO ","","FLORES 12-117 Y ABELARDO MONCAYO",062954245,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.259','postgres                                     ');
INSERT INTO tbl_audit VALUES ('294','proveedores                                  ','D','(143,Ruc,1001285897001,"ABASTOS ""BACHITA""","AGUIRRE TORRES CARLOS MANUEL","","ABISPO MOSQUERA 10.31 Y ANTONIO COEDERO",062643527,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.26','postgres                                     ');
INSERT INTO tbl_audit VALUES ('295','proveedores                                  ','D','(142,Ruc,1060034240001,EPAA,EPAA,"","CENTRAL BOLIVAR Y  GONZALES SUARES",062909857,"","",ECUADOR,"ANTONIO ANTE",Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.261','postgres                                     ');
INSERT INTO tbl_audit VALUES ('296','proveedores                                  ','D','(141,Ruc,1791307704001,"FUNDACION VISTA PARA TODOS","FUNDACION VISTA PARA TODOS","","GASPAR DE VILLARROEL Y MARIANO JIMBO",062438053,"","",ECUADOR,QUITO,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.263','postgres                                     ');
INSERT INTO tbl_audit VALUES ('297','proveedores                                  ','D','(140,Ruc,1792124379001,"ESTACION DE SERVICIO ""PEAJE -NORTE""","ESTACION DE SERVICIO ""PEAJE -NORTE""","","KM-14 OYACOTO",062839014,"","",ECUADOR,QUITO,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.264','postgres                                     ');
INSERT INTO tbl_audit VALUES ('298','proveedores                                  ','D','(139,Ruc,1090008273001,"ESTACION DE SEVICIOS 28 DE SEPTIEMBRE","ESTACION DE SEVICIOS 28 DE SEPTIEMBRE","","AV.CRISTOBAL DE TROYA 2.151 Y JESUS YEROVI",062950380,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.265','postgres                                     ');
INSERT INTO tbl_audit VALUES ('299','proveedores                                  ','D','(138,Ruc,1721278156001,"GUAN XIN YUAN","HUANG CHING TANG","","ISAAC ALBENIZ E2-99 Y MOZART",062812587,"","",ECUADOR,QUITO,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.266','postgres                                     ');
INSERT INTO tbl_audit VALUES ('300','proveedores                                  ','D','(137,Ruc,0992125934001,ECUADORTELECOM,ECUADORTELECOM,"","KENNEDIT NORTE QUINTA ETAPA AV. FRANCISCO DE ORELLANA",045004040,"","",ECUADOR,GUAYAQUIL,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.268','postgres                                     ');
INSERT INTO tbl_audit VALUES ('301','proveedores                                  ','D','(136,Ruc,1791984722001,"FARMACIAS ECONOMICAS","FARMACIAS ECONOMICAS","","RAFAEL RAMOS E2-210 Y AV. ATAHUALPA",062993100,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.269','postgres                                     ');
INSERT INTO tbl_audit VALUES ('302','proveedores                                  ','D','(135,Ruc,1091738283001,"MEGASYSTEM GLOBAL TECNOLOGI","MEGASYSTEM GLOBAL TECNOLOGI","","VICTOR GOMES JURADO 344 Y DOCTOR LUIS  FERNANDO",06232007,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.27','postgres                                     ');
INSERT INTO tbl_audit VALUES ('303','proveedores                                  ','D','(134,Ruc,1791362004001,"AUTO PLAZA","AUTO PLAZA","","VIA CAYAMBE",066255555,"","",ECUADOR,CAYAMBE,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.308','postgres                                     ');
INSERT INTO tbl_audit VALUES ('304','proveedores                                  ','D','(133,Ruc,1001785862001,"TORRES PASQUEL MARIA ISABEL","TORRES PASQUEL MARIA ISABEL","","AV.RAFAEL SANCHEZ 6-94 Y BONILLA",06210016,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:34.31','postgres                                     ');
INSERT INTO tbl_audit VALUES ('305','proveedores                                  ','D','(132,Ruc,1791938127001,BIRCONI,BIRCONI,"","REINA VICTORIA 1539 Y AV.COLON",2907462,"","",ECUADOR,QUITO,Credito,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:38.065','postgres                                     ');
INSERT INTO tbl_audit VALUES ('306','proveedores                                  ','D','(131,Ruc,0490038663001,"COOP.TRANSPORTES ESPEJO","COOP.TRANSPORTES ESPEJO","","AV.TEODORO GOMEZ Y EUGENIO ESPEJO",062959917,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:38.067','postgres                                     ');
INSERT INTO tbl_audit VALUES ('307','proveedores                                  ','D','(130,Ruc,1791307860001,ALITECNO,ALITECNO,"","AV.GALO PLAZA LASSO N4651 YDE LAS REMATAS",2407316,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:38.07','postgres                                     ');
INSERT INTO tbl_audit VALUES ('308','proveedores                                  ','D','(128,Ruc,1001273596001,MADEC,"CHASIQUIZA FUERTES LUIS ALFONSO","","ALEJANDRO PASQUEL 1-124 Y DARIO EGAS",062640220,"","",ECUADOR,IBARRA,Contado,N,No,"",Activo)',NULL,'2014-09-18 10:34:38.074','postgres                                     ');
INSERT INTO tbl_audit VALUES ('309','proveedores                                  ','D','(127,Ruc,1792457130001,"PETRO ECUADOR","PETRO ECUADOR","","Km  1 ENTRE ATUNTAQUI Y SAN ROQUE",062926888,"","",ECUADOR,"SAN ROQUE",Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:38.076','postgres                                     ');
INSERT INTO tbl_audit VALUES ('310','proveedores                                  ','D','(126,Ruc,1000407609001,"EL REPUESTO","ENDARA MONCAYO JORGE ANIVAL","","GARCIA MORENO 7-34 Y OLMEDO",062640400,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:38.077','postgres                                     ');
INSERT INTO tbl_audit VALUES ('311','proveedores                                  ','D','(125,Ruc,1002688842001,"MAS GRAM","BONILLA POZO GIOVANNA ELIZABTH","","HONDURAZ Y URUGUAY ESQ.",062645047,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:38.085','postgres                                     ');
INSERT INTO tbl_audit VALUES ('312','proveedores                                  ','D','(123,Ruc,0992220929001,"MEDEL S.A","MEDEL S.A","","PANAMERICANA NORTE PEAGE DE AYACOTO",0623317352,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:38.087','postgres                                     ');
INSERT INTO tbl_audit VALUES ('313','proveedores                                  ','D','(122,Ruc,1002510772001,"ELECTRONICA 3","RODRIGUEZ SANCHEZ HUGO ANDRES","","ELIAS  ALMEIDA 2-26 Y RIVADENEIRA",062641713,"","",ECUADOR,IBARRA,Contado,N,No,"",Activo)',NULL,'2014-09-18 10:34:38.088','postgres                                     ');
INSERT INTO tbl_audit VALUES ('314','proveedores                                  ','D','(121,Ruc,1002282489001,"PLASTICOS EL DORADO","CARDENAS NAVIA ALFONSO","","ANTONIO CORDERO 3-18 Y RAFAEL LARREA",062958105,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:38.09','postgres                                     ');
INSERT INTO tbl_audit VALUES ('315','proveedores                                  ','D','(120,Ruc,1001464856001,"AUDIO CAR","EDGAR FABIAN PUENTE ROSERO","","AV.JAIME RIVADENEIRA 6-08 Y PEDRO MONCAYO",062642414,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:38.092','postgres                                     ');
INSERT INTO tbl_audit VALUES ('316','proveedores                                  ','D','(119,Ruc,0401168513001,MEGASYSTEM,"MORAN CORAL RILMER LENNIG","","VICTOR GOMEZ JURADO 344 Y DOC. LUIS FERNANDO AGUILERA",062603193,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:38.093','postgres                                     ');
INSERT INTO tbl_audit VALUES ('317','proveedores                                  ','D','(118,Ruc,1790041220001,KIWI,KIWI,"","AV.EUGENIO ESPEJO9-66 Y BONIL",062631018,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:38.095','postgres                                     ');
INSERT INTO tbl_audit VALUES ('318','proveedores                                  ','D','(117,Ruc,1001052438001,"PROVEEDORA SANTA MONICA","OLGA BETTY DEL CARMEN VASCONEZ FLORES","","BARTOLOME GARCIA Y LUIS TORO MORENO",62600674,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:38.097','postgres                                     ');
INSERT INTO tbl_audit VALUES ('319','proveedores                                  ','D','(116,Ruc,0400734109001,COMPUTOTAL,"PEPE EDMUNDO VACA SANCHEZ","","BOLIVAR 12-155 ENTRE RAFAEL LARREA  Y OBISPO MOSQUERA",062603198,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:38.1','postgres                                     ');
INSERT INTO tbl_audit VALUES ('511','detalles_trabajo                             ','I',NULL,'(21,"FORMATEO COMPUTADOR","",6,1,1,"")','2014-09-19 15:45:00.185','postgres                                     ');
INSERT INTO tbl_audit VALUES ('320','proveedores                                  ','D','(129,Ruc,1790127613001,"SERVICIO EDUCACIONAL HOGAR Y SALUD ","SERVICIO EDUCACIONAL HOGAR Y SALUD ","","MARIA PAREDES N72-49",062471146,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:41.929','postgres                                     ');
INSERT INTO tbl_audit VALUES ('321','proveedores                                  ','D','(124,Ruc,0591712551001,"PRODICEREAL S.A","PRODICEREAL S.A","","PARROQUIA SAN FRANCISCO",062603193,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:41.933','postgres                                     ');
INSERT INTO tbl_audit VALUES ('322','proveedores                                  ','D','(115,Ruc,0400685822001,MOVICOM,"CERON VILLAMAGUA SANDRA PATRICIA","","JUAN JOSE FLORES 11-111 Y AV. JAIME RIVADENEIRA",062603193,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:41.938','postgres                                     ');
INSERT INTO tbl_audit VALUES ('323','proveedores                                  ','D','(114,Ruc,1001950920001,PCTOOLS,"VASQUEZ SUARES JUAN MIGUEL","","CALLE JUAN JOSE FLORES",062606804,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:41.939','postgres                                     ');
INSERT INTO tbl_audit VALUES ('324','proveedores                                  ','D','(113,Ruc,1791413237001,"MARATHON SPROTS","MARATHON SPORTS","","AV.PLAZA LASSO ",062483914,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:41.941','postgres                                     ');
INSERT INTO tbl_audit VALUES ('325','proveedores                                  ','D','(112,Ruc,0400725388001,"LA FERIA DEL CELULAR","CEDE¥O CHAVARRIA RAUL ANTONIO","","SANCHEZ Y CIFUENTES 7-84 Y AV.PERZ GUERRERO",062950140,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:41.942','postgres                                     ');
INSERT INTO tbl_audit VALUES ('326','proveedores                                  ','D','(111,Ruc,1713130415001,"AUTO SPLASH EXPRESS ","ALVARES SALAS ROSSANA PAOLA","","AV. LOS GALEANOS Y MAUELA CA¥IZARES",0625001033,"","",ECUADOR,IBARRA,Contado,N,No,"",Activo)',NULL,'2014-09-18 10:34:41.943','postgres                                     ');
INSERT INTO tbl_audit VALUES ('327','proveedores                                  ','D','(109,Ruc,1002050001001,"ZEN WEI","SHI MAO TE","","SECTOR LOS SAUCES OLMEDO 4-84 Y JUAN EMILIO GRIGALVA",062955759,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:41.944','postgres                                     ');
INSERT INTO tbl_audit VALUES ('328','proveedores                                  ','D','(108,Ruc,1002050001001,"MADEC ","CHASIQUIZA FUERTES LUIS ALFONSO","","ALEGANDRO PASQUEL 1-124 Y DARIO EGAS",062640220,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:41.946','postgres                                     ');
INSERT INTO tbl_audit VALUES ('329','proveedores                                  ','D','(107,Ruc,1001993433001,"MEGA P.S","CHAMORRO MONTALVO MARTHA JANETH","","RAFAEL ROSALES 1-52 Y  FLORES",062644904,"","",ECUADOR,IBARRA,Contado,N,No,"",Activo)',NULL,'2014-09-18 10:34:41.947','postgres                                     ');
INSERT INTO tbl_audit VALUES ('330','proveedores                                  ','D','(106,Ruc,0992371188001,MOVISTAR,MOVISTAR,"","AV. 9 DE OCTUBRE 100 Y MALECON S. BOLIVIA ",0987805075,0987805075,"",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:41.948','postgres                                     ');
INSERT INTO tbl_audit VALUES ('331','proveedores                                  ','D','(105,Ruc,1711132233001,TERPEL,"CORAL BENAVIDES BLANCA LEONOR","","PANA MERICANA NORTE Km 8 1/2 NATABUELA",062958708,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:41.95','postgres                                     ');
INSERT INTO tbl_audit VALUES ('332','proveedores                                  ','D','(104,Ruc,1002348199001,"BENITAZ FLORES NARCISA DE JESUS","BENITAZ FLORES NARCISA DE JESUS","","FLORES 777 Y OLMEDO",062605061,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:41.951','postgres                                     ');
INSERT INTO tbl_audit VALUES ('333','proveedores                                  ','D','(103,Ruc,1002538633001,"DISTRIBUIDORA BONILLA","BONILLA POZO MARCO DAVID","","HONDURAS Y URUGUAY",062645047,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:41.953','postgres                                     ');
INSERT INTO tbl_audit VALUES ('334','proveedores                                  ','D','(102,Ruc,1002286357001,CERELECTRIC,"ING.ALICIA GENOVEVA CERON GARCIA","","AV.ATAHUALPA 16-98 Y FRANCISCO BONILLA",0622600767,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:41.954','postgres                                     ');
INSERT INTO tbl_audit VALUES ('335','proveedores                                  ','D','(110,Ruc,1723933311001,"CASA ORIENTE","HE YAOXI","","JOSE MIGUEL LEORO Y AV. ATAHUALPA",062602335,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:45.265','postgres                                     ');
INSERT INTO tbl_audit VALUES ('336','proveedores                                  ','D','(101,Ruc,1002265146001,"PLASTICOS LA MINGUITA","LOPEZ AGUILAR MARA GIOVANNA","","SANCHEZ Y CIFUENTES 14-44 Y OBISPO MOSQUERA",062609716,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:45.267','postgres                                     ');
INSERT INTO tbl_audit VALUES ('337','proveedores                                  ','D','(99,Ruc,1004382006001,"QUITO RAMOS ANRDEA JENIFFER ANDREA","QUITO RAMOS ANRDEA JENIFFER ANDREA","","CALLE ANTONIO ANTE Y EUGENI ESPEJO",062605061,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:45.269','postgres                                     ');
INSERT INTO tbl_audit VALUES ('338','proveedores                                  ','D','(97,Ruc,1001142916001,"EDGAR RAFAEL ARIAS CARRASCO","EDGAR RAFAEL ARIAS CARRASCO","","SANCHEZ Y CIFUENTES 16-20 Y LUIS TORO MORENO",062952979,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:45.274','postgres                                     ');
INSERT INTO tbl_audit VALUES ('339','proveedores                                  ','D','(96,Ruc,0400990446001,SPORTBIKE,"REVELO TAMAYO CARLOS MANUEL","","AV. ELOY ALFARRO 2-116 Y JUAN DE DIOS NAVAS",062958725,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:45.275','postgres                                     ');
INSERT INTO tbl_audit VALUES ('340','proveedores                                  ','D','(95,Ruc,1002246369001,"FERRI SOL","YOLANDA MARISOL BEDON TIRADO","","AV.ATAHUALPA 24-18 Y RIO CENEPA",062650520,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:45.277','postgres                                     ');
INSERT INTO tbl_audit VALUES ('341','proveedores                                  ','D','(94,Ruc,1002050001001,ALITECNO,ALITECNO,"","AV. GHALO PLAZA LASSO N4651 Y DE LAS RETAMAS",062603193,"","",ECUADOR,IBARRA,Contado,N,No,"",Activo)',NULL,'2014-09-18 10:34:45.278','postgres                                     ');
INSERT INTO tbl_audit VALUES ('342','proveedores                                  ','D','(93,Ruc,1002050001001,"MEGA REFUGIO","MEGA REFUGIO","","AV. LA PRENSA N46-75 Y ZAMORA",062275698,"","",ECUADOR,QUITO,Contado,N,No,"",Activo)',NULL,'2014-09-18 10:34:45.28','postgres                                     ');
INSERT INTO tbl_audit VALUES ('343','proveedores                                  ','D','(92,Ruc,1001861929001,"DOCU CENTRO","LUNA ACOSTA TATIANA YASMIN","","OVIEDO 9-26 Y SANCHEZ Y CIFUENTES",062951674,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:45.282','postgres                                     ');
INSERT INTO tbl_audit VALUES ('344','proveedores                                  ','D','(91,Ruc,1002050001001,"IMPRENTA MACVISION","PABLO EDUARDO GONGORA RUIZ","","BOLIVAR 1-61 Y MEJIA",0622600180,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:45.284','postgres                                     ');
INSERT INTO tbl_audit VALUES ('644','detalles_trabajo                             ','D','(11," ??  ","",4,Producto:,"","")',NULL,'2014-09-22 17:55:49.753','postgres                                     ');
INSERT INTO tbl_audit VALUES ('345','proveedores                                  ','D','(90,Ruc,1091720805001,"IMPORTADORA  JIMEMOR .CIA.LTDA","IMPORTADORA  JIMEMOR .CIA.LTDA","","ALPACHACA,MACHALA 5-20 Y TENA ",062602801,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:45.286','postgres                                     ');
INSERT INTO tbl_audit VALUES ('346','proveedores                                  ','D','(89,Ruc,1792220629001,I.D.SOLUTIONS,I.D.SOLUTIONS,"","GASPAR DE VILLARREAL E14-33 Y ELOY ALFARO",062603193,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:45.287','postgres                                     ');
INSERT INTO tbl_audit VALUES ('347','proveedores                                  ','D','(100,Ruc,1003424643001,"MAYRA ALEXANDRA ARCINIEGA OSEJOS","MAYRA ALEXANDRA ARCINIEGA OSEJOS","","RIO AMAZONAS 1319 Y BOLIBAR",062906345,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:49.434','postgres                                     ');
INSERT INTO tbl_audit VALUES ('348','proveedores                                  ','D','(98,Ruc,1001287125001,PLASTICOM,"EDGAR GERMAN POZO TORRES","","AV. ORIENTAL N3.191 Y REMIGIO CRESPO TORAL",062573212,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:49.436','postgres                                     ');
INSERT INTO tbl_audit VALUES ('349','proveedores                                  ','D','(88,Ruc,1002050001001,"TECNI EXPRESS","CARLOS EDUARDO VELELCAZAR FLORES","","AV.JAIME RIVADENEIRA",062603193,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:49.487','postgres                                     ');
INSERT INTO tbl_audit VALUES ('350','proveedores                                  ','D','(87,Ruc,1001771201001,"GUILLERMO ROBERTO FLORES CIFUENTES ","GUILLERMO ROBERTO FLORES CIFUENTES ","","AV. EUGENIO ESPEJO Y AV.TEODORO GOMEZ ",062954981,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:49.489','postgres                                     ');
INSERT INTO tbl_audit VALUES ('351','proveedores                                  ','D','(86,Ruc,1002248944001,"DISTRIBUIDORA DE FLORES  LOS ANTURIOS","CARLOSAMA QUIROZ AMILCAR NEPTALI","","AV.PEREZ GUERRERO 5-27 Y SUCRE",062609651,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:49.491','postgres                                     ');
INSERT INTO tbl_audit VALUES ('352','proveedores                                  ','D','(85,Ruc,1000211936001,"COMERCIAL MONTALVO","MONTALVO DONOSO ARMANDO","","CALLE GEBERAL ENRIQUEZ 12-24 Y SUCRE",062290537,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:49.492','postgres                                     ');
INSERT INTO tbl_audit VALUES ('353','proveedores                                  ','D','(84,Ruc,1002606679001,FRESPAN,"DIAN PATRICIA ORTIZ CONDO","","AV.CRISTOBAL DE TROYA",062600647,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:49.494','postgres                                     ');
INSERT INTO tbl_audit VALUES ('354','proveedores                                  ','D','(83,Ruc,1203192552001,"PZZA D STALIN","RENGIFO SANCLEMENTE ESTALIN ORLANDO","","AV.QUITO Y PAPALLACTA",062762943,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:49.496','postgres                                     ');
INSERT INTO tbl_audit VALUES ('355','proveedores                                  ','D','(82,Ruc,0400734109001,"COMPU TOTAL","PEPE EDMUNDO VACA SANCHEZ","","ENTRE RAFAEL LARREA Y OBISPO MOSQUERA",062605086,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:49.498','postgres                                     ');
INSERT INTO tbl_audit VALUES ('356','proveedores                                  ','D','(81,Ruc,1002050001001,"AUDIO CAR","EDGAR FABIAN PUENTE ROSERO","","YACUCALLE AV.TEODORO GOMEZ",062642414,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:49.499','postgres                                     ');
INSERT INTO tbl_audit VALUES ('357','proveedores                                  ','D','(80,Ruc,1002245882001,"LA CASA DEL EXTINTOR","MARIA ESMERALDA RODRIGUEZ ROMO","","LUIS FERNANDO VILLAMAR 2-19 Y OLMEDO",062951140,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:49.501','postgres                                     ');
INSERT INTO tbl_audit VALUES ('358','proveedores                                  ','D','(79,Ruc,1708637408001,"MINI DESPENSA Y ALGO MAS","REDROBAN BILLAFUERTE MARIA EULALIA","","ANASAYASAS AV.GALO PLAZA LAGO",062814050,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:49.502','postgres                                     ');
INSERT INTO tbl_audit VALUES ('359','proveedores                                  ','D','(78,Ruc,1091716670001,"TAPICES Y COLORES","TAPICES Y COLORES","","CALLE CALIXTO MIRANDA",062610488,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:49.504','postgres                                     ');
INSERT INTO tbl_audit VALUES ('360','proveedores                                  ','D','(77,Ruc,1000849370001,"MUNDO ELECTRONICO","PLASCENCI MENESES LUIS ALFREDO","","VELASCO#8-73 Y SANCHEZ Y CIFUENTES",06209896,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:49.505','postgres                                     ');
INSERT INTO tbl_audit VALUES ('361','proveedores                                  ','D','(76,Ruc,0400855292001,"INNOVACION ELECTRICA","HERNANDEZ  DELGADO MARIA MARTHA","","OBISPO MOSQUERA 666",06209979,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:49.507','postgres                                     ');
INSERT INTO tbl_audit VALUES ('362','proveedores                                  ','D','(75,Ruc,1002615696001,"EL RINCON TIPICO","CADENA ANDINO MARTHA ELENA","","MALDONADO 9-69Y PEDRO MONCAYO ",062603193,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:53.393','postgres                                     ');
INSERT INTO tbl_audit VALUES ('363','proveedores                                  ','D','(74,Ruc,1791328864001,"LA HORMIGUITA DE ORO","LA HORMIGUITA DE ORO","","JUAN FRANCISCO CEVALLOS 1-46 Y OBISPO MOSQUERA",062951821,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:53.432','postgres                                     ');
INSERT INTO tbl_audit VALUES ('364','proveedores                                  ','D','(73,Ruc,0400409785001,"COMERCIAL CADENA CASANOVA","COMERCIAL CADENA CASANOVA","","SANCHEZ Y CIFUENTES 1469",062640043,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:53.434','postgres                                     ');
INSERT INTO tbl_audit VALUES ('365','proveedores                                  ','D','(72,Ruc,1791768124001,MEGAREFUGIO,MEGAREFUGIO,"","AV.LA PRENSA N46-75 Y ZAMORA",062275698,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:53.436','postgres                                     ');
INSERT INTO tbl_audit VALUES ('366','proveedores                                  ','D','(71,Ruc,1001698636001,IMPOCOM,"CARLOS JAVIER MAFLA RIVADENEIRA","","JORGE JUAN N31-236 Y AV. MARIANA DE JESUS",0623212211,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:53.437','postgres                                     ');
INSERT INTO tbl_audit VALUES ('367','proveedores                                  ','D','(69,Ruc,1002286357001,JERUSALEM,"ING.MIRNA MARIANNELA LUNA ACOSTA","","AV.ATAHUALPA 16-98 Y JUAN FRANCISCO BONILLA",062958708,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:53.439','postgres                                     ');
INSERT INTO tbl_audit VALUES ('368','proveedores                                  ','D','(68,Ruc,1001779048001,"CENTRO EDUCATIVO MUNDO IFANTIL ATUNTAQUI","LUIS HUMBERTO LIMA CXACHIGUANGO","","AV .SAN VICENTE Y ROCAFUERTE",062585463,"","",ECUADOR,IBARRA,Contado,n,No,"",Activo)',NULL,'2014-09-18 10:34:53.44','postgres                                     ');
INSERT INTO tbl_audit VALUES ('369','proveedores                                  ','D','(66,Ruc,1001814316001,PARCHESITOS,"CHECA GUDI¥O PATRICIA MARICELA","","AV.TEODORO GOEZ DE LA TORRE 6-48 Y BOLIVAR",06206376,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:53.441','postgres                                     ');
INSERT INTO tbl_audit VALUES ('370','proveedores                                  ','D','(65,Ruc,1091737236001,"LIBRERIA AY PAPELERIA POPULAR","LIBRERIA AY PAPELERIA POPULAR","","SAN FRANCISCI AV.MARIANO ACOSTA",062606287,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:53.443','postgres                                     ');
INSERT INTO tbl_audit VALUES ('371','proveedores                                  ','D','(64,Ruc,1002497566001,MADEC,"CHASIQUIZA FUERTES LUIS ALFONSO","","ALJANDRO PASQUEL 1-124 Y DARI EGAS",062640220,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:53.445','postgres                                     ');
INSERT INTO tbl_audit VALUES ('372','proveedores                                  ','D','(63,Ruc,0401599667001,"LUCIA PAULINA RODRIGURZ","LUCIA PAULINA RODRIGURZ","","BOLIVAR Y OLMEDO",062909815,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:53.446','postgres                                     ');
INSERT INTO tbl_audit VALUES ('373','proveedores                                  ','D','(62,Ruc,1003001110001,"PREMIUM EXPORT VFLOWERS","VERGARA GUERRA IVETH JHOANA","","AURELIO GOMEZ JURADO Y MARCO NICOLALDE",062991555,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:53.448','postgres                                     ');
INSERT INTO tbl_audit VALUES ('374','proveedores                                  ','D','(61,Ruc,1002181160001,HARDTECHNOLOGY,HARDTECHNOLOGY,"","SANCHEZ Y CIFUENTES 969 ENTRE PEDRO MONCAYO",062608193,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:53.449','postgres                                     ');
INSERT INTO tbl_audit VALUES ('375','proveedores                                  ','D','(70,Ruc,1002050001001,"LIVUN SERVISE","LIVUN SERVISE","","SANCHEZ Y CIFUENTES 15-26 Y RAFAEL LARREA",062803193,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:57.665','postgres                                     ');
INSERT INTO tbl_audit VALUES ('376','proveedores                                  ','D','(67,Ruc,1709211237001,"HERNANDES BIACULLI HERNAN RENATO","HERNANDES BIACULLI HERNAN RENATO","","EL INCA E5-33 Y MIGUEL DE AREVALO",062603193,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:57.667','postgres                                     ');
INSERT INTO tbl_audit VALUES ('377','proveedores                                  ','D','(59,Ruc,1002050001001,"CANDO HUERTAS ROSA LEONOR","CANDO HUERTAS ROSA LEONOR","","SANCHEZ Y CUFUENTES 1469",062603193,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:57.668','postgres                                     ');
INSERT INTO tbl_audit VALUES ('378','proveedores                                  ','D','(56,Ruc,1001950920001,"VASQUEZ SUAREZ JUAN MIGUEL","VASQUEZ SUAREZ JUAN MIGUEL","","CALLE JOSE FLORES",062606804,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:57.67','postgres                                     ');
INSERT INTO tbl_audit VALUES ('379','proveedores                                  ','D','(55,Ruc,1003696315001,"FERNANDEZ REA KARLA GABRILELA","FERNANDEZ REA KARLA GABRILELA","","VICENTE ROCAFUERTE 7-85 Y PEDRO MONCAYO",062607144,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:57.671','postgres                                     ');
INSERT INTO tbl_audit VALUES ('380','proveedores                                  ','D','(53,Ruc,1791891546001,"GALLON BAENA ALVAREZ GABAL","GALLON BAENA ALVAREZ GABAL","","NATALIA JARRIN 52-73 Y DIEZ DE AGOSTO",062239837,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:57.672','postgres                                     ');
INSERT INTO tbl_audit VALUES ('381','proveedores                                  ','D','(52,Ruc,1002050000001,"EDGAR FABIAN PUENTE ROSERO","EDGAR FABIAN PUENTE ROSERO","","AV.JAIME RIVADENEIRA 6-08",62642414,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:57.673','postgres                                     ');
INSERT INTO tbl_audit VALUES ('382','proveedores                                  ','D','(51,Ruc,1001585130001,"JARRIN OBANDO SEGUNDO NABOR","JARRIN OBANDO SEGUNDO NABOR","","FERROVIARIA CALLA FLORES 12-117",062954245,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:57.675','postgres                                     ');
INSERT INTO tbl_audit VALUES ('383','proveedores                                  ','D','(50,Ruc,1002050001001,"REGALOS SCC","REGALOS SCC","","LODORA AYALA Y JOSE TOBAR",062606555,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:57.676','postgres                                     ');
INSERT INTO tbl_audit VALUES ('384','proveedores                                  ','D','(49,Ruc,1001547585001,"TORRES VILLARRUEL LUIS ROLAN","TORRES VILLARRUEL LUIS ROLAN","","YACUCALLE ANTONIO CORDERO 5-11 Y LUIS TORO MORENO",062643028,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:57.677','postgres                                     ');
INSERT INTO tbl_audit VALUES ('385','proveedores                                  ','D','(48,Ruc,1002287660001,"CHUQUIN CUEVA HUGO ANDRES","CHUQUIN CUEVA HUGO ANDRES ","","ANTONIO CORDERO 6-85 Y JOSE MIGUEL LEORO",062951588,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:57.678','postgres                                     ');
INSERT INTO tbl_audit VALUES ('386','proveedores                                  ','D','(47,Ruc,1001036514001,"MARIA TERESA ACOSTA ZAPATA","MARIA TERESA ACOSTA ZAPATA","","YACUCALLE AV. EUGENIO ESPEJO",062955759,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:34:57.68','postgres                                     ');
INSERT INTO tbl_audit VALUES ('387','proveedores                                  ','D','(60,Ruc,1002334173001,"OBANDO JARRIN LOURDES CECILIA","OBANDO JARRIN LOURDES CECILIA","","AV.TEODORO GOMEZ DE LA TORRE 8-43 Y BARTOLOME GARCIA",062641104,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:01.097','postgres                                     ');
INSERT INTO tbl_audit VALUES ('388','proveedores                                  ','D','(57,Ruc,1001449956001,"PROVESUM Y CIA","PROVESUM Y CIA","","CHICA NARVAEZ 7-24 Y OVIEDO",062644904,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:01.099','postgres                                     ');
INSERT INTO tbl_audit VALUES ('389','proveedores                                  ','D','(54,Ruc,1001583002001,"SUSPENCION FRENOS-MOTOR","CARLOS EDUARDO VELALCAZAR FLORES","","AV.JAIME RIVADENEIRA",062611151,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:01.101','postgres                                     ');
INSERT INTO tbl_audit VALUES ('390','proveedores                                  ','D','(46,Ruc,0400855292001,"HERNANDEZ DELGADO MARIA MARTHA","HERNANDEZ DELGADO MARIA MARTHA","","OBISPO MOSQUERA 666",0622603193,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:01.102','postgres                                     ');
INSERT INTO tbl_audit VALUES ('391','proveedores                                  ','D','(45,Ruc,1091717898001,NORPHONE,NORPHONE,"","AV.MARIANO ACOSTA NO.2147 Y VICTOR GOMEZ JURADO",062631313,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:01.106','postgres                                     ');
INSERT INTO tbl_audit VALUES ('392','proveedores                                  ','D','(44,Ruc,1001866381001,"IMPRENTA MACVICION","PABLO DUARDO GONGORA RUIZ","","BOLIVAR 1-61 Y MEJIA",0622600180,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:01.108','postgres                                     ');
INSERT INTO tbl_audit VALUES ('393','proveedores                                  ','D','(42,Ruc,1002286357001,"LUNA ACOSTA MIRNA MARIANNELA","LUNA ACOSTA MIRNA MARIANNELA","","V. ATAHUALPA 16-98 Y JUAN FRANCISCO",062600767,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:01.109','postgres                                     ');
INSERT INTO tbl_audit VALUES ('394','proveedores                                  ','D','(41,Ruc,1002430138001,"ARMAS FLORES XIMENA ELISABETH","ARMAS FLORES XIMENA ELISABETH","","URB. YACUCALLE",062953331,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:01.111','postgres                                     ');
INSERT INTO tbl_audit VALUES ('395','proveedores                                  ','D','(40,Ruc,1091745701001,"PROQUILIM SANTA MONICA","PROQUILIM SANTA MONICA","","BARTOLOME GARCIA 3-19 Y LUIS TORO MORENO",062600614,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:01.113','postgres                                     ');
INSERT INTO tbl_audit VALUES ('396','proveedores                                  ','D','(39,Ruc,1002050001001,"ALITECNO S.A","ALITECNO S.A","","AV.GALO PLAZA LASSO N4651 Y DE LAS RETAMAS",062603193,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:01.114','postgres                                     ');
INSERT INTO tbl_audit VALUES ('397','proveedores                                  ','D','(58,Ruc,1713128864001,"VEGA JIMENES LUIS EDUARDO","VEGA JIMENES LUIS EDUARDO","","JUAN FRANCISCO CEVALLOS 1-46 Y OBISPO MOSQUERA",062951821,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:05.121','postgres                                     ');
INSERT INTO tbl_audit VALUES ('398','proveedores                                  ','D','(43,Ruc,1091742434001,SYSTEMURBINA,SYSTEMURBINA,"","YACUCALLE-RIO BLANCO",062000127,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:05.123','postgres                                     ');
INSERT INTO tbl_audit VALUES ('399','proveedores                                  ','D','(38,Ruc,1002050001001,"ENLACE DIGITAL","ENLACE DIGITAL","","EL INCA FRANCISCO DE IZAZAGA N45-07 Y PIO VALDIVIEZO",062603193,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:05.127','postgres                                     ');
INSERT INTO tbl_audit VALUES ('400','proveedores                                  ','D','(37,Ruc,1791826418001,"LA LIRA","LA LIRA","","I¥AQUITO AV. 10 DE AGOSTO Y AV. NACIONES UNIDADS",0622606092,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:05.13','postgres                                     ');
INSERT INTO tbl_audit VALUES ('401','proveedores                                  ','D','(36,Ruc,1715030142001,"BRASERO GARZON VERONICA YESSENIA","BRASERO GARZON VERONICA YESSENIA","","AV.TEODORO GOMEZ 8.34 Y BARTOLOME GARCIA",062950842,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:09.433','postgres                                     ');
INSERT INTO tbl_audit VALUES ('402','proveedores                                  ','D','(35,Ruc,1709424988001,"CARRERA ALVAREZ LILIA VERONICA","CARRERA ALVAREZ LILIA VERONICA","","AV.TEODORO GOMES  Y AV. EUJENIO ESPEJO",062643527,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:09.434','postgres                                     ');
INSERT INTO tbl_audit VALUES ('403','proveedores                                  ','D','(34,Ruc,1001645132001,"OBANDO ARTURO ANA LUSIA","OBANDO ARTURO ANA LUSIA","","AV. FRAY VACAS GALINDO 487 Y CHORLAVI",062642885,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:09.436','postgres                                     ');
INSERT INTO tbl_audit VALUES ('404','proveedores                                  ','D','(33,Ruc,1002472908001,"ENRIQUEZ ANDRADE JENNY PATRICIA","ENRIQUEZ ANDRADE JENNY PATRICIA","","OBISPO MOSQUERA Y SANCHEZ Y CUFUENTES",062955862,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:09.437','postgres                                     ');
INSERT INTO tbl_audit VALUES ('405','proveedores                                  ','D','(32,Ruc,1002050001001,PRODICERAL,PRODICERAL,"","EL NIAGARA  AV. UNIDAD NACIONAL 176 Y TOMAS VERLANGA",062603193,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:09.441','postgres                                     ');
INSERT INTO tbl_audit VALUES ('406','proveedores                                  ','D','(30,Ruc,1792060346001,"MEGA SANTA MARIA S.A","MEGA SANTA MARIA S.A",""," AV MARIANO ACOSTA Y FRAY VACAS GALINDO",062942920,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:09.443','postgres                                     ');
INSERT INTO tbl_audit VALUES ('407','proveedores                                  ','D','(29,Ruc,1790985504001,ETAFASHION,ETAFASHION,"","PANAMERICANA NORTE KM 2 1/2 LA RIMI¥AHUI",062483090,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:09.445','postgres                                     ');
INSERT INTO tbl_audit VALUES ('408','proveedores                                  ','D','(27,Ruc,0990004277001,"ECUADORTELECOM S.A","ECUADORTELECOM S.A","","EUGENIO ESPEJON 966 Y CALLE JUAN FRANCISCO BONILLA",06295048,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:09.447','postgres                                     ');
INSERT INTO tbl_audit VALUES ('409','proveedores                                  ','D','(25,Ruc,1001417631001,"MEJIA ARTIEDA MARIA MAGDALENA","MEJIA ARTIEDA MARIA MAGDALENA","","AV. EUJENIO ESPEJO 8-78 Y JUAN FRANCISCO BONILLA",062643739,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:09.452','postgres                                     ');
INSERT INTO tbl_audit VALUES ('410','proveedores                                  ','D','(24,Ruc,1791807529001,PAYLES,PAYLES,"","MARIANO ACOSTA 2147 Y VICTOR GOMES JURADO",062544144,"","",ECUADOR,QUITO,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:09.454','postgres                                     ');
INSERT INTO tbl_audit VALUES ('411','proveedores                                  ','D','(23,Ruc,1002050001001,"BONILLA POZO GIOVANNA ELIZABETH","BONILLA POZO GIOVANNA ELIZABETH","","HONDURS Y URUGUAY ESQ.",062603198,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:09.46','postgres                                     ');
INSERT INTO tbl_audit VALUES ('412','proveedores                                  ','D','(22,Ruc,1001226388001,"CASTILLO TERAN GRIMANESA DEL SOCORRO","CASTILLO TERAN GRIMANESA DEL SOCORRO","","AV.FARY VACAS GALINDO 2-30 Y MARIANOP ACOSTA",062604546,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:09.461','postgres                                     ');
INSERT INTO tbl_audit VALUES ('413','proveedores                                  ','D','(21,Ruc,1002472908001,"ENRIQUEZ ANDRADE JENNY PATRICIA","ENRIQUEZ ANDRADE JENNY PATRICIA","","OBISPO MOSQUERA Y SANCHEZ Y CIFUENTES",062955862,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:09.463','postgres                                     ');
INSERT INTO tbl_audit VALUES ('414','proveedores                                  ','D','(31,Ruc,1002050001001,"FERNADO GALO CARDENAS VINUEZA","FERNADO GALO CARDENAS VINUEZA","","TEODORO GOMES DE LA TORRE 1047 Y JUANA ATABALIPA",062606840,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:16.329','postgres                                     ');
INSERT INTO tbl_audit VALUES ('415','proveedores                                  ','D','(28,Ruc,1002596219001,"REINOSO VINUEZA DORIS JULIETA","REINOSO VINUEZA DORIS JULIETA",""," EL CRODON, SAN MIGUEL EGAS ENTRE QUIROGA Y QUITO",062924901,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:16.331','postgres                                     ');
INSERT INTO tbl_audit VALUES ('416','proveedores                                  ','D','(26,Ruc,1001017274001,"JARAMILLOVASSUQEZ MARIO JORGE OSWALDO","JARAMILLOVASSUQEZ MARIO JORGE OSWALDO","","BARTOLOME GARCIA 4-15 Y AV. LEORO FRANCO",062951168,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:16.333','postgres                                     ');
INSERT INTO tbl_audit VALUES ('417','proveedores                                  ','D','(20,Ruc,1002050001001,"PRODICERAL S.A","PRODICERAL S.A","","EL NIAGARA-AV.UNIDAD  NACIONAL 176",062805920,"","",ECUADOR,LATACUNGA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:38.201','postgres                                     ');
INSERT INTO tbl_audit VALUES ('418','proveedores                                  ','D','(19,Ruc,1706447016001,"SERVICIO EDUCACIONAL HOGAR Y SALUD -NORTE","RODRIGO DE VILLALOBOS","","MARIANO PAREDES N72-49",062471147,"","",ECUADOR,QUITO,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:38.213','postgres                                     ');
INSERT INTO tbl_audit VALUES ('670','trabajo_tecnico                              ','D','(7,2,1,20,"")',NULL,'2014-09-22 17:56:06.072','postgres                                     ');
INSERT INTO tbl_audit VALUES ('419','proveedores                                  ','D','(18,Ruc,1002050001001,"FERNANDO GALO CARDENAS VINUEZA","FERNANDO GALO CARDENAS VINUEZA","","TOEDORO GOMES DE LA TORRE 1047 Y JUANA ATABALIPA",06210025,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:38.215','postgres                                     ');
INSERT INTO tbl_audit VALUES ('420','proveedores                                  ','D','(17,Ruc,1091734903001,"ALMACENES PINTA CASA","ALMACENES PINTA CASA","","YACUCALLE TEODORO GOMES DE LA TORRE",062240101,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:38.216','postgres                                     ');
INSERT INTO tbl_audit VALUES ('421','proveedores                                  ','D','(16,Ruc,1790016919001,"CORPORACION LA FAVORITA","CORPORACION LA FAVORITA C.A","","av.mariano acosta 2147 y victor gomez jurado",062950820,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:38.22','postgres                                     ');
INSERT INTO tbl_audit VALUES ('422','proveedores                                  ','D','(15,Ruc,1792060346001,"MEGA SANTA MARIA S.A","MEGA SANTA MARIA S.A","","AV.EUGENIO ESPEJO 9-66",062942920,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:38.222','postgres                                     ');
INSERT INTO tbl_audit VALUES ('423','proveedores                                  ','D','(14,Ruc,1700097437001,"COERCIAL ETATEX C.A","COERCIAL ETATEX C.A","","AV.10 DE AGOSTON60 Y SANTA LUSIA",062483090,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:38.223','postgres                                     ');
INSERT INTO tbl_audit VALUES ('424','proveedores                                  ','D','(13,Ruc,1002596219001,ARLENE,"REINOSO VINUEZA DORIS JULIETA","","EL CARDON, MIGUEL FLORES ENTRE QUIROGA",062924901,"","",ECUADOR,OTAVALO,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:38.224','postgres                                     ');
INSERT INTO tbl_audit VALUES ('425','proveedores                                  ','D','(12,Ruc,1090053449001,"TRANSPORTES ANDINA S.A",SONIA,"","LUIS CABEZAS BORJA 3-51",062950833,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:38.225','postgres                                     ');
INSERT INTO tbl_audit VALUES ('426','proveedores                                  ','D','(11,Ruc,1000373280001,"EPPETRO ECUADOR","MOREJON YEPEZ JORGE HONORIO","","AV. CRISTOBAL DE TROYA Y TOBAR SURIA",062957862,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-18 10:35:38.227','postgres                                     ');
INSERT INTO tbl_audit VALUES ('427','trabajo                                      ','U','(1,"FORMATEO COMPUTADOR",20,)','(1,"FORMATEO COMPUTADOR",20,Activo)','2014-09-18 10:36:15.386','postgres                                     ');
INSERT INTO tbl_audit VALUES ('428','trabajo                                      ','U','(2,"MANTENIMIENTO FISICO",25,)','(2,"MANTENIMIENTO FISICO",25,Activo)','2014-09-18 10:36:18.283','postgres                                     ');
INSERT INTO tbl_audit VALUES ('429','trabajo                                      ','U','(3,"MANTENIMIENTO IMPRESORA",25,)','(3,"MANTENIMIENTO IMPRESORA",25,Activo)','2014-09-18 10:36:21.499','postgres                                     ');
INSERT INTO tbl_audit VALUES ('430','trabajo                                      ','U','(4,"REVISION EQUIPO",10,)','(4,"REVISION EQUIPO",10,Activo)','2014-09-18 10:36:24.336','postgres                                     ');
INSERT INTO tbl_audit VALUES ('431','trabajo                                      ','U','(5,"VISITA TECNICA",30,)','(5,"VISITA TECNICA",30,Activo)','2014-09-18 10:36:26.972','postgres                                     ');
INSERT INTO tbl_audit VALUES ('432','trabajo                                      ','U','(6,"SOPORTE EN SITIO",30,)','(6,"SOPORTE EN SITIO",30,Activo)','2014-09-18 10:36:29.503','postgres                                     ');
INSERT INTO tbl_audit VALUES ('433','trabajo                                      ','U','(7,"INSTALACION PUNTO DE RED",25,)','(7,"INSTALACION PUNTO DE RED",25,Activo)','2014-09-18 10:36:32.194','postgres                                     ');
INSERT INTO tbl_audit VALUES ('434','trabajo                                      ','U','(8,"RECARGA TONER",20,)','(8,"RECARGA TONER",20,Activo)','2014-09-18 10:36:35.155','postgres                                     ');
INSERT INTO tbl_audit VALUES ('435','trabajo                                      ','U','(9,"REVISION RED DE DATOS",20,)','(9,"REVISION RED DE DATOS",20,Activo)','2014-09-18 10:36:39.566','postgres                                     ');
INSERT INTO tbl_audit VALUES ('436','trabajo                                      ','U','(10,"CONFIGURACION EQUIPO",20,)','(10,"CONFIGURACION EQUIPO",20,Activo)','2014-09-18 10:36:42.414','postgres                                     ');
INSERT INTO tbl_audit VALUES ('437','trabajo                                      ','U','(11,"INSTALACION SOFTWARE",20,)','(11,"INSTALACION SOFTWARE",20,Activo)','2014-09-18 10:36:45.05','postgres                                     ');
INSERT INTO tbl_audit VALUES ('438','trabajo                                      ','U','(12,"INSTALACION ROUTER",30,)','(12,"INSTALACION ROUTER",30,Activo)','2014-09-18 10:36:47.632','postgres                                     ');
INSERT INTO tbl_audit VALUES ('439','trabajo                                      ','U','(13,"CONFIGURACION ROUTER",20,)','(13,"CONFIGURACION ROUTER",20,Activo)','2014-09-18 10:36:50.144','postgres                                     ');
INSERT INTO tbl_audit VALUES ('440','trabajo                                      ','U','(14,"MANTENIMIENTO EQUIPO INFORMATICO",20,)','(14,"MANTENIMIENTO EQUIPO INFORMATICO",20,Activo)','2014-09-18 10:36:52.655','postgres                                     ');
INSERT INTO tbl_audit VALUES ('441','trabajo                                      ','U','(15,"ORGANIZACION RED DE DATOS",25,)','(15,"ORGANIZACION RED DE DATOS",25,Activo)','2014-09-18 10:36:55.09','postgres                                     ');
INSERT INTO tbl_audit VALUES ('442','trabajo                                      ','U','(16,"INSTALACION SISTEMA CONTABLE",25,)','(16,"INSTALACION SISTEMA CONTABLE",25,Activo)','2014-09-18 10:36:57.539','postgres                                     ');
INSERT INTO tbl_audit VALUES ('443','trabajo                                      ','U','(17,"INSTALACION SISTEMA SICADI",25,)','(17,"INSTALACION SISTEMA SICADI",25,Activo)','2014-09-18 10:37:00.191','postgres                                     ');
INSERT INTO tbl_audit VALUES ('444','trabajo                                      ','U','(18,"REINSTALACION SISTEMA SICADI",25,)','(18,"REINSTALACION SISTEMA SICADI",25,Activo)','2014-09-18 10:37:02.761','postgres                                     ');
INSERT INTO tbl_audit VALUES ('445','trabajo                                      ','U','(19,"SOPORTE TECNICO SICADI",25,)','(19,"SOPORTE TECNICO SICADI",25,Activo)','2014-09-18 10:37:05.182','postgres                                     ');
INSERT INTO tbl_audit VALUES ('446','trabajo                                      ','U','(20,"CONFIGURACION SISTEMA SICADI",25,)','(20,"CONFIGURACION SISTEMA SICADI",25,Activo)','2014-09-18 10:37:07.534','postgres                                     ');
INSERT INTO tbl_audit VALUES ('447','trabajo                                      ','U','(21,"RESPALDO DE INFORMACION",10,)','(21,"RESPALDO DE INFORMACION",10,Activo)','2014-09-18 10:37:10.168','postgres                                     ');
INSERT INTO tbl_audit VALUES ('448','trabajo                                      ','U','(22,"ACTIVACION SISTEMA",15,)','(22,"ACTIVACION SISTEMA",15,Activo)','2014-09-18 10:37:13.9','postgres                                     ');
INSERT INTO tbl_audit VALUES ('449','trabajo                                      ','U','(23,"SERVICIOS 0%",0.0001,)','(23,"SERVICIOS 0%",0.0001,Activo)','2014-09-18 10:37:16.311','postgres                                     ');
INSERT INTO tbl_audit VALUES ('450','trabajo                                      ','U','(24,"SERVICIOS 12%
",0.0001,)','(24,"SERVICIOS 12%
",0.0001,Activo)','2014-09-18 10:37:19.823','postgres                                     ');
INSERT INTO tbl_audit VALUES ('451','inventario                                   ','I',NULL,'(1,2,1,1,2014-09-18,"11:54:45 AM",Activo)','2014-09-18 11:54:46.299','postgres                                     ');
INSERT INTO tbl_audit VALUES ('452','detalle_inventario                           ','I',NULL,'(1,1,15,8.00,10.00,10,10,10,Activo)','2014-09-18 11:54:46.357','postgres                                     ');
INSERT INTO tbl_audit VALUES ('671','trabajo_tecnico                              ','D','(6,2,1,20,"")',NULL,'2014-09-22 17:56:06.074','postgres                                     ');
INSERT INTO tbl_audit VALUES ('453','productos                                    ','U','(15,TPCID-LINK,PW011A6069905,"TARJETA PCI ADAPTERD-LINK",Si,Si,8.00,25,10,10.00,8.80,ACCESORIOS,null,0,1,1,2014-05-09,"","","",Activo,Si,0,0)','(15,TPCID-LINK,PW011A6069905,"TARJETA PCI ADAPTERD-LINK",Si,Si,8.00,25,10,10.00,8.80,ACCESORIOS,null,10,1,1,2014-05-09,"","","",Activo,Si,10,10)','2014-09-18 11:54:46.361','postgres                                     ');
INSERT INTO tbl_audit VALUES ('454','ingresos                                     ','I',NULL,'(1,1,2,1,2014-09-18,"11:56:26 AM","","",0.00,80.00,9.60,0.00,89.60,"",Activo)','2014-09-18 11:56:26.799','postgres                                     ');
INSERT INTO tbl_audit VALUES ('455','detalle_ingreso                              ','I',NULL,'(1,1,15,10,8.00,0,80.00,Activo)','2014-09-18 11:56:26.821','postgres                                     ');
INSERT INTO tbl_audit VALUES ('456','productos                                    ','U','(15,TPCID-LINK,PW011A6069905,"TARJETA PCI ADAPTERD-LINK",Si,Si,8.00,25,10,10.00,8.80,ACCESORIOS,null,10,1,1,2014-05-09,"","","",Activo,Si,10,10)','(15,TPCID-LINK,PW011A6069905,"TARJETA PCI ADAPTERD-LINK",Si,Si,8.00,25,10,10.00,8.80,ACCESORIOS,null,20,1,1,2014-05-09,"","","",Activo,Si,10,10)','2014-09-18 11:56:26.826','postgres                                     ');
INSERT INTO tbl_audit VALUES ('457','ordenes_produccion                           ','I',NULL,'(1,2,1,2014-09-18,"12:02:51 AM",19,5,6.00,Activo)','2014-09-18 12:02:52.709','postgres                                     ');
INSERT INTO tbl_audit VALUES ('458','productos                                    ','U','(19,AUDIOSPLITTER,798302061552,"SEPARADOR DE AURICULARES RLIP XTREME",Si,Si,2.00,25,10,2.50,2.20,ACCESORIOS,RLIP-STREME,3,1,1,2014-05-09,"","","",Activo,Si,4,4)','(19,AUDIOSPLITTER,798302061552,"SEPARADOR DE AURICULARES RLIP XTREME",Si,Si,1.20,25,10,1.50,1.32,ACCESORIOS,RLIP-STREME,8,1,1,2014-05-09,"","","",Activo,Si,4,4)','2014-09-18 12:02:52.732','postgres                                     ');
INSERT INTO tbl_audit VALUES ('459','detalles_ordenes                             ','I',NULL,'(1,1,19,3,2.00,6.00,Activo)','2014-09-18 12:02:52.736','postgres                                     ');
INSERT INTO tbl_audit VALUES ('460','productos                                    ','U','(19,AUDIOSPLITTER,798302061552,"SEPARADOR DE AURICULARES RLIP XTREME",Si,Si,1.20,25,10,1.50,1.32,ACCESORIOS,RLIP-STREME,8,1,1,2014-05-09,"","","",Activo,Si,4,4)','(19,AUDIOSPLITTER,798302061552,"SEPARADOR DE AURICULARES RLIP XTREME",Si,Si,1.20,25,10,1.50,1.32,ACCESORIOS,RLIP-STREME,5,1,1,2014-05-09,"","","",Activo,Si,4,4)','2014-09-18 12:02:52.738','postgres                                     ');
INSERT INTO tbl_audit VALUES ('461','proforma                                     ','I',NULL,'(1,3,2,1,1,2014-09-18,"12:03:39 AM",MINORISTA,0.00,7.50,0.90,0.00,8.40,"",Activo)','2014-09-18 12:03:40.039','postgres                                     ');
INSERT INTO tbl_audit VALUES ('462','detalle_proforma                             ','I',NULL,'(1,1,19,5,1.50,0,7.50,Activo)','2014-09-18 12:03:40.094','postgres                                     ');
INSERT INTO tbl_audit VALUES ('463','ordenes_produccion                           ','I',NULL,'(2,2,2,2014-09-18,"12:16:57 AM",6,1,16.00,Activo)','2014-09-18 12:16:57.482','postgres                                     ');
INSERT INTO tbl_audit VALUES ('464','productos                                    ','U','(6,TWIRPCIN150,790069332760,"TARJETA PCI WIRELESS N 150",Si,Si,14.50,25,10,18.13,15.95,ACCESORIOS,DLINK,-1,1,1,2014-05-09,"","",0,Activo,Si,0,0)','(6,TWIRPCIN150,790069332760,"TARJETA PCI WIRELESS N 150",Si,Si,14.50,25,10,18.13,15.95,ACCESORIOS,DLINK,0,1,1,2014-05-09,"","",0,Activo,Si,0,0)','2014-09-18 12:16:57.524','postgres                                     ');
INSERT INTO tbl_audit VALUES ('465','detalles_ordenes                             ','I',NULL,'(2,2,15,2,8.00,16.00,Activo)','2014-09-18 12:16:57.529','postgres                                     ');
INSERT INTO tbl_audit VALUES ('466','productos                                    ','U','(15,TPCID-LINK,PW011A6069905,"TARJETA PCI ADAPTERD-LINK",Si,Si,8.00,25,10,10.00,8.80,ACCESORIOS,null,20,1,1,2014-05-09,"","","",Activo,Si,10,10)','(15,TPCID-LINK,PW011A6069905,"TARJETA PCI ADAPTERD-LINK",Si,Si,8.00,25,10,10.00,8.80,ACCESORIOS,null,18,1,1,2014-05-09,"","","",Activo,Si,10,10)','2014-09-18 12:16:57.531','postgres                                     ');
INSERT INTO tbl_audit VALUES ('467','categoria                                    ','I',NULL,'(1,COMPUTADORAS,Activo)','2014-09-19 12:37:33.394','postgres                                     ');
INSERT INTO tbl_audit VALUES ('468','marcas                                       ','D','(45,INTEL,Activo)',NULL,'2014-09-19 12:38:43.298','postgres                                     ');
INSERT INTO tbl_audit VALUES ('469','marcas                                       ','I',NULL,'(45,INTEL,Activo)','2014-09-19 12:38:59.097','postgres                                     ');
INSERT INTO tbl_audit VALUES ('470','color                                        ','I',NULL,'(1,AZUL,Activo)','2014-09-19 12:39:33.366','postgres                                     ');
INSERT INTO tbl_audit VALUES ('471','color                                        ','I',NULL,'(2,NEGRO,Activo)','2014-09-19 12:39:39.991','postgres                                     ');
INSERT INTO tbl_audit VALUES ('472','color                                        ','I',NULL,'(3,MORADO,Activo)','2014-09-19 12:39:46.511','postgres                                     ');
INSERT INTO tbl_audit VALUES ('473','proveedores                                  ','D','(10,Ruc,1091729683001,"ALMACENES FERROELECTRICO","ALMACENES FERROELECTRICO","","ANTONIO JOSE DE SUCRE 13-34 Y ROSALIA ROSALES",062953375,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,No,"",Activo)',NULL,'2014-09-19 14:32:02.546','postgres                                     ');
INSERT INTO tbl_audit VALUES ('474','productos                                    ','D','(20,DVDLGGH24NSBO,401H7WG029833,"DVD WRITE LG GH24NSBO ",Si,Si,16.98,25,10,21.225,18.678,ACCESORIOS,LG,25,1,1,2014-05-09,"","","",Activo,Si,2,2)',NULL,'2014-09-19 14:48:58.99','postgres                                     ');
INSERT INTO tbl_audit VALUES ('475','clientes                                     ','D','(5,Ruc,1091704524001,"ESCUELA  JUAN DIEGO",natural,"AV. LOS SAUCES 4_77",0622585787,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-19 15:15:25.828','postgres                                     ');
INSERT INTO tbl_audit VALUES ('476','proveedores                                  ','D','(9,Ruc,1001017274001,"DISTRIBUIDORA JV","JARAMILLO VASQUES MARIO JORGE","","BARTOLOME GARCIA 4-15 Y AV. TEODORO GOMES  ESQUINA",062950265,"","",ECUADOR,IBARRA,Contado,NO@HOTMAIL.COM,Si,"",Activo)',NULL,'2014-09-19 15:24:55.779','postgres                                     ');
INSERT INTO tbl_audit VALUES ('477','clientes                                     ','D','(4,Ruc,1708052814001,"JORGE HOMERO YUNDA MACHADO",natural,"SANCHEZ Y CIFUENTES 1070 Y JUAN VELASCO",06200051,"",ECUADOR,IBARRA,"",5000,"",Activo)',NULL,'2014-09-19 15:28:01.708','postgres                                     ');
INSERT INTO tbl_audit VALUES ('478','productos                                    ','D','(16,LIGTWEINGHTSTEREO,798302100572,"AUDIFONO HEADSET",Si,Si,10.00,25,10,12.50,11.00,ACCESORIOS,RLIP-STREME,-12,1,1,2014-05-09,"","","",Activo,Si,0,0)',NULL,'2014-09-19 15:34:03.179','postgres                                     ');
INSERT INTO tbl_audit VALUES ('479','categoria                                    ','I',NULL,'(2,kj,Activo)','2014-09-19 15:37:28.782','postgres                                     ');
INSERT INTO tbl_audit VALUES ('480','marcas                                       ','I',NULL,'(46,j¤,Activo)','2014-09-19 15:37:31.646','postgres                                     ');
INSERT INTO tbl_audit VALUES ('481','registro_equipo                              ','I',NULL,'(1,1,1,2,434435,DFG,DFGG,0,2,2014-09-19,1,43535,2014-09-19,0,"")','2014-09-19 15:43:31.359','postgres                                     ');
INSERT INTO tbl_audit VALUES ('482','registro_equipo                              ','U','(1,1,1,2,434435,DFG,DFGG,0,2,2014-09-19,1,43535,2014-09-19,0,"")','(1,1,1,2,434435,DFG,DFGG,3,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','2014-09-19 15:44:34.592','postgres                                     ');
INSERT INTO tbl_audit VALUES ('483','trabajo_tecnico                              ','I',NULL,'(2,2,1,20,"")','2014-09-19 15:44:52.121','postgres                                     ');
INSERT INTO tbl_audit VALUES ('672','trabajo_tecnico                              ','D','(5,2,1,20,"")',NULL,'2014-09-22 17:56:06.076','postgres                                     ');
INSERT INTO tbl_audit VALUES ('484','detalles_trabajo                             ','I',NULL,'(2,Agregar,"",2,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-19 15:44:52.143','postgres                                     ');
INSERT INTO tbl_audit VALUES ('485','detalles_trabajo                             ','I',NULL,'(3," ??  ","",2,Producto:,"","")','2014-09-19 15:44:52.146','postgres                                     ');
INSERT INTO tbl_audit VALUES ('486','detalles_trabajo                             ','I',NULL,'(4,"",20,2,"","",Servicio)','2014-09-19 15:44:52.147','postgres                                     ');
INSERT INTO tbl_audit VALUES ('487','detalles_trabajo                             ','I',NULL,'(5,"FORMATEO COMPUTADOR","",2,1,1,"")','2014-09-19 15:44:52.15','postgres                                     ');
INSERT INTO tbl_audit VALUES ('488','registro_equipo                              ','U','(1,1,1,2,434435,DFG,DFGG,3,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','2014-09-19 15:44:52.151','postgres                                     ');
INSERT INTO tbl_audit VALUES ('489','trabajo_tecnico                              ','I',NULL,'(3,2,1,20,"")','2014-09-19 15:44:59.307','postgres                                     ');
INSERT INTO tbl_audit VALUES ('490','detalles_trabajo                             ','I',NULL,'(6,Agregar,"",3,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-19 15:44:59.354','postgres                                     ');
INSERT INTO tbl_audit VALUES ('491','detalles_trabajo                             ','I',NULL,'(7," ??  ","",3,Producto:,"","")','2014-09-19 15:44:59.355','postgres                                     ');
INSERT INTO tbl_audit VALUES ('492','detalles_trabajo                             ','I',NULL,'(8,"",20,3,"","",Servicio)','2014-09-19 15:44:59.356','postgres                                     ');
INSERT INTO tbl_audit VALUES ('493','detalles_trabajo                             ','I',NULL,'(9,"FORMATEO COMPUTADOR","",3,1,1,"")','2014-09-19 15:44:59.359','postgres                                     ');
INSERT INTO tbl_audit VALUES ('494','registro_equipo                              ','U','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','2014-09-19 15:44:59.36','postgres                                     ');
INSERT INTO tbl_audit VALUES ('495','trabajo_tecnico                              ','I',NULL,'(4,2,1,20,"")','2014-09-19 15:44:59.851','postgres                                     ');
INSERT INTO tbl_audit VALUES ('496','detalles_trabajo                             ','I',NULL,'(10,Agregar,"",4,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-19 15:44:59.857','postgres                                     ');
INSERT INTO tbl_audit VALUES ('497','detalles_trabajo                             ','I',NULL,'(11," ??  ","",4,Producto:,"","")','2014-09-19 15:44:59.859','postgres                                     ');
INSERT INTO tbl_audit VALUES ('498','detalles_trabajo                             ','I',NULL,'(12,"",20,4,"","",Servicio)','2014-09-19 15:44:59.859','postgres                                     ');
INSERT INTO tbl_audit VALUES ('499','detalles_trabajo                             ','I',NULL,'(13,"FORMATEO COMPUTADOR","",4,1,1,"")','2014-09-19 15:44:59.878','postgres                                     ');
INSERT INTO tbl_audit VALUES ('500','registro_equipo                              ','U','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','2014-09-19 15:44:59.879','postgres                                     ');
INSERT INTO tbl_audit VALUES ('501','trabajo_tecnico                              ','I',NULL,'(5,2,1,20,"")','2014-09-19 15:45:00.041','postgres                                     ');
INSERT INTO tbl_audit VALUES ('502','detalles_trabajo                             ','I',NULL,'(14,Agregar,"",5,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-19 15:45:00.049','postgres                                     ');
INSERT INTO tbl_audit VALUES ('503','detalles_trabajo                             ','I',NULL,'(15," ??  ","",5,Producto:,"","")','2014-09-19 15:45:00.05','postgres                                     ');
INSERT INTO tbl_audit VALUES ('504','detalles_trabajo                             ','I',NULL,'(16,"",20,5,"","",Servicio)','2014-09-19 15:45:00.051','postgres                                     ');
INSERT INTO tbl_audit VALUES ('505','detalles_trabajo                             ','I',NULL,'(17,"FORMATEO COMPUTADOR","",5,1,1,"")','2014-09-19 15:45:00.054','postgres                                     ');
INSERT INTO tbl_audit VALUES ('506','registro_equipo                              ','U','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','2014-09-19 15:45:00.055','postgres                                     ');
INSERT INTO tbl_audit VALUES ('507','trabajo_tecnico                              ','I',NULL,'(6,2,1,20,"")','2014-09-19 15:45:00.157','postgres                                     ');
INSERT INTO tbl_audit VALUES ('508','detalles_trabajo                             ','I',NULL,'(18,Agregar,"",6,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-19 15:45:00.164','postgres                                     ');
INSERT INTO tbl_audit VALUES ('512','registro_equipo                              ','U','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','2014-09-19 15:45:00.185','postgres                                     ');
INSERT INTO tbl_audit VALUES ('513','trabajo_tecnico                              ','I',NULL,'(7,2,1,20,"")','2014-09-19 15:45:00.338','postgres                                     ');
INSERT INTO tbl_audit VALUES ('514','detalles_trabajo                             ','I',NULL,'(22,Agregar,"",7,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-19 15:45:00.346','postgres                                     ');
INSERT INTO tbl_audit VALUES ('515','detalles_trabajo                             ','I',NULL,'(23," ??  ","",7,Producto:,"","")','2014-09-19 15:45:00.348','postgres                                     ');
INSERT INTO tbl_audit VALUES ('516','detalles_trabajo                             ','I',NULL,'(24,"",20,7,"","",Servicio)','2014-09-19 15:45:00.349','postgres                                     ');
INSERT INTO tbl_audit VALUES ('517','detalles_trabajo                             ','I',NULL,'(25,"FORMATEO COMPUTADOR","",7,1,1,"")','2014-09-19 15:45:00.352','postgres                                     ');
INSERT INTO tbl_audit VALUES ('518','registro_equipo                              ','U','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','2014-09-19 15:45:00.353','postgres                                     ');
INSERT INTO tbl_audit VALUES ('519','trabajo_tecnico                              ','I',NULL,'(8,2,1,20,"")','2014-09-19 15:45:00.452','postgres                                     ');
INSERT INTO tbl_audit VALUES ('520','detalles_trabajo                             ','I',NULL,'(26,Agregar,"",8,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-19 15:45:00.458','postgres                                     ');
INSERT INTO tbl_audit VALUES ('521','detalles_trabajo                             ','I',NULL,'(27," ??  ","",8,Producto:,"","")','2014-09-19 15:45:00.46','postgres                                     ');
INSERT INTO tbl_audit VALUES ('522','detalles_trabajo                             ','I',NULL,'(28,"",20,8,"","",Servicio)','2014-09-19 15:45:00.46','postgres                                     ');
INSERT INTO tbl_audit VALUES ('523','detalles_trabajo                             ','I',NULL,'(29,"FORMATEO COMPUTADOR","",8,1,1,"")','2014-09-19 15:45:00.464','postgres                                     ');
INSERT INTO tbl_audit VALUES ('524','registro_equipo                              ','U','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','2014-09-19 15:45:00.464','postgres                                     ');
INSERT INTO tbl_audit VALUES ('525','trabajo_tecnico                              ','I',NULL,'(9,2,1,20,"")','2014-09-19 15:45:00.623','postgres                                     ');
INSERT INTO tbl_audit VALUES ('526','detalles_trabajo                             ','I',NULL,'(30,Agregar,"",9,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-19 15:45:00.633','postgres                                     ');
INSERT INTO tbl_audit VALUES ('527','detalles_trabajo                             ','I',NULL,'(31," ??  ","",9,Producto:,"","")','2014-09-19 15:45:00.634','postgres                                     ');
INSERT INTO tbl_audit VALUES ('528','detalles_trabajo                             ','I',NULL,'(32,"",20,9,"","",Servicio)','2014-09-19 15:45:00.635','postgres                                     ');
INSERT INTO tbl_audit VALUES ('529','detalles_trabajo                             ','I',NULL,'(33,"FORMATEO COMPUTADOR","",9,1,1,"")','2014-09-19 15:45:00.639','postgres                                     ');
INSERT INTO tbl_audit VALUES ('530','registro_equipo                              ','U','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','2014-09-19 15:45:00.639','postgres                                     ');
INSERT INTO tbl_audit VALUES ('531','trabajo_tecnico                              ','I',NULL,'(10,2,1,20,"")','2014-09-19 15:45:00.743','postgres                                     ');
INSERT INTO tbl_audit VALUES ('532','detalles_trabajo                             ','I',NULL,'(34,Agregar,"",10,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-19 15:45:00.75','postgres                                     ');
INSERT INTO tbl_audit VALUES ('533','detalles_trabajo                             ','I',NULL,'(35," ??  ","",10,Producto:,"","")','2014-09-19 15:45:00.751','postgres                                     ');
INSERT INTO tbl_audit VALUES ('534','detalles_trabajo                             ','I',NULL,'(36,"",20,10,"","",Servicio)','2014-09-19 15:45:00.752','postgres                                     ');
INSERT INTO tbl_audit VALUES ('535','detalles_trabajo                             ','I',NULL,'(37,"FORMATEO COMPUTADOR","",10,1,1,"")','2014-09-19 15:45:00.754','postgres                                     ');
INSERT INTO tbl_audit VALUES ('536','registro_equipo                              ','U','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','2014-09-19 15:45:00.755','postgres                                     ');
INSERT INTO tbl_audit VALUES ('537','trabajo_tecnico                              ','I',NULL,'(11,2,1,20,"")','2014-09-19 15:45:00.921','postgres                                     ');
INSERT INTO tbl_audit VALUES ('673','trabajo_tecnico                              ','D','(4,2,1,20,"")',NULL,'2014-09-22 17:56:06.129','postgres                                     ');
INSERT INTO tbl_audit VALUES ('674','trabajo_tecnico                              ','D','(3,2,1,20,"")',NULL,'2014-09-22 17:56:06.131','postgres                                     ');
INSERT INTO tbl_audit VALUES ('538','detalles_trabajo                             ','I',NULL,'(38,Agregar,"",11,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-19 15:45:00.929','postgres                                     ');
INSERT INTO tbl_audit VALUES ('539','detalles_trabajo                             ','I',NULL,'(39," ??  ","",11,Producto:,"","")','2014-09-19 15:45:00.952','postgres                                     ');
INSERT INTO tbl_audit VALUES ('540','detalles_trabajo                             ','I',NULL,'(40,"",20,11,"","",Servicio)','2014-09-19 15:45:00.953','postgres                                     ');
INSERT INTO tbl_audit VALUES ('541','detalles_trabajo                             ','I',NULL,'(41,"FORMATEO COMPUTADOR","",11,1,1,"")','2014-09-19 15:45:00.995','postgres                                     ');
INSERT INTO tbl_audit VALUES ('542','registro_equipo                              ','U','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','2014-09-19 15:45:00.996','postgres                                     ');
INSERT INTO tbl_audit VALUES ('543','trabajo_tecnico                              ','I',NULL,'(12,2,1,20,"")','2014-09-19 15:45:01.055','postgres                                     ');
INSERT INTO tbl_audit VALUES ('544','detalles_trabajo                             ','I',NULL,'(42,Agregar,"",12,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-19 15:45:01.062','postgres                                     ');
INSERT INTO tbl_audit VALUES ('545','detalles_trabajo                             ','I',NULL,'(43," ??  ","",12,Producto:,"","")','2014-09-19 15:45:01.063','postgres                                     ');
INSERT INTO tbl_audit VALUES ('546','detalles_trabajo                             ','I',NULL,'(44,"",20,12,"","",Servicio)','2014-09-19 15:45:01.064','postgres                                     ');
INSERT INTO tbl_audit VALUES ('547','detalles_trabajo                             ','I',NULL,'(45,"FORMATEO COMPUTADOR","",12,1,1,"")','2014-09-19 15:45:01.067','postgres                                     ');
INSERT INTO tbl_audit VALUES ('548','registro_equipo                              ','U','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','2014-09-19 15:45:01.068','postgres                                     ');
INSERT INTO tbl_audit VALUES ('549','trabajo_tecnico                              ','I',NULL,'(13,2,1,20,"")','2014-09-19 15:45:01.207','postgres                                     ');
INSERT INTO tbl_audit VALUES ('550','detalles_trabajo                             ','I',NULL,'(46,Agregar,"",13,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-19 15:45:01.215','postgres                                     ');
INSERT INTO tbl_audit VALUES ('551','detalles_trabajo                             ','I',NULL,'(47," ??  ","",13,Producto:,"","")','2014-09-19 15:45:01.217','postgres                                     ');
INSERT INTO tbl_audit VALUES ('552','detalles_trabajo                             ','I',NULL,'(48,"",20,13,"","",Servicio)','2014-09-19 15:45:01.218','postgres                                     ');
INSERT INTO tbl_audit VALUES ('553','detalles_trabajo                             ','I',NULL,'(49,"FORMATEO COMPUTADOR","",13,1,1,"")','2014-09-19 15:45:01.221','postgres                                     ');
INSERT INTO tbl_audit VALUES ('554','registro_equipo                              ','U','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','2014-09-19 15:45:01.222','postgres                                     ');
INSERT INTO tbl_audit VALUES ('555','trabajo_tecnico                              ','I',NULL,'(14,2,1,20,"")','2014-09-19 15:45:01.354','postgres                                     ');
INSERT INTO tbl_audit VALUES ('556','detalles_trabajo                             ','I',NULL,'(50,Agregar,"",14,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-19 15:45:01.361','postgres                                     ');
INSERT INTO tbl_audit VALUES ('557','detalles_trabajo                             ','I',NULL,'(51," ??  ","",14,Producto:,"","")','2014-09-19 15:45:01.362','postgres                                     ');
INSERT INTO tbl_audit VALUES ('558','detalles_trabajo                             ','I',NULL,'(52,"",20,14,"","",Servicio)','2014-09-19 15:45:01.363','postgres                                     ');
INSERT INTO tbl_audit VALUES ('559','detalles_trabajo                             ','I',NULL,'(53,"FORMATEO COMPUTADOR","",14,1,1,"")','2014-09-19 15:45:01.365','postgres                                     ');
INSERT INTO tbl_audit VALUES ('560','registro_equipo                              ','U','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")','2014-09-19 15:45:01.366','postgres                                     ');
INSERT INTO tbl_audit VALUES ('561','categoria                                    ','D','(2,kj,Activo)',NULL,'2014-09-19 16:34:07.261','postgres                                     ');
INSERT INTO tbl_audit VALUES ('562','registro_equipo                              ','I',NULL,'(2,2,1,2,QWEQWE,"","",0,2,2014-09-22,1,QWE,2014-09-22,0,"")','2014-09-22 16:26:46.185','postgres                                     ');
INSERT INTO tbl_audit VALUES ('563','registro_equipo                              ','U','(2,2,1,2,QWEQWE,"","",0,2,2014-09-22,1,QWE,2014-09-22,0,"")','(2,2,1,2,QWEQWE,"","",0,2,2014-09-22,1,QWE123123123,2014-09-22,0,"")','2014-09-22 17:46:18.688','postgres                                     ');
INSERT INTO tbl_audit VALUES ('564','registro_equipo                              ','U','(2,2,1,2,QWEQWE,"","",0,2,2014-09-22,1,QWE123123123,2014-09-22,0,"")','(2,2,1,2,QWEQWE,"","",3,2,2014-09-22,1,QWE123123123,2014-09-22,0,"Willy Narv ez")','2014-09-22 17:48:50.948','postgres                                     ');
INSERT INTO tbl_audit VALUES ('566','detalles_trabajo                             ','I',NULL,'(54,Agregar,"",15,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-22 17:49:05.606','postgres                                     ');
INSERT INTO tbl_audit VALUES ('567','detalles_trabajo                             ','I',NULL,'(55," ??  ","",15,Producto:,"","")','2014-09-22 17:49:05.647','postgres                                     ');
INSERT INTO tbl_audit VALUES ('568','detalles_trabajo                             ','I',NULL,'(56,"",20,15,"","",Servicio)','2014-09-22 17:49:05.649','postgres                                     ');
INSERT INTO tbl_audit VALUES ('569','detalles_trabajo                             ','I',NULL,'(57,"FORMATEO COMPUTADOR","",15,1,1,"")','2014-09-22 17:49:05.664','postgres                                     ');
INSERT INTO tbl_audit VALUES ('570','registro_equipo                              ','U','(2,2,1,2,QWEQWE,"","",3,2,2014-09-22,1,QWE123123123,2014-09-22,0,"Willy Narv ez")','(2,2,1,2,QWEQWE,"","",1,2,2014-09-22,1,QWE123123123,2014-09-22,0,"Willy Narv ez")','2014-09-22 17:49:05.666','postgres                                     ');
INSERT INTO tbl_audit VALUES ('571','trabajo_tecnico                              ','I',NULL,'(16,2,2,20,"")','2014-09-22 17:49:15.464','postgres                                     ');
INSERT INTO tbl_audit VALUES ('572','detalles_trabajo                             ','I',NULL,'(58,Agregar,"",16,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-22 17:49:15.472','postgres                                     ');
INSERT INTO tbl_audit VALUES ('573','detalles_trabajo                             ','I',NULL,'(59," ??  ","",16,Producto:,"","")','2014-09-22 17:49:15.474','postgres                                     ');
INSERT INTO tbl_audit VALUES ('574','detalles_trabajo                             ','I',NULL,'(60,"",20,16,"","",Servicio)','2014-09-22 17:49:15.475','postgres                                     ');
INSERT INTO tbl_audit VALUES ('575','detalles_trabajo                             ','I',NULL,'(61,"FORMATEO COMPUTADOR","",16,1,1,"")','2014-09-22 17:49:15.482','postgres                                     ');
INSERT INTO tbl_audit VALUES ('576','registro_equipo                              ','U','(2,2,1,2,QWEQWE,"","",1,2,2014-09-22,1,QWE123123123,2014-09-22,0,"Willy Narv ez")','(2,2,1,2,QWEQWE,"","",1,2,2014-09-22,1,QWE123123123,2014-09-22,0,"Willy Narv ez")','2014-09-22 17:49:15.483','postgres                                     ');
INSERT INTO tbl_audit VALUES ('577','trabajo_tecnico                              ','I',NULL,'(17,2,2,20,"")','2014-09-22 17:50:50.641','postgres                                     ');
INSERT INTO tbl_audit VALUES ('578','detalles_trabajo                             ','I',NULL,'(62,Agregar,"",17,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-22 17:50:50.647','postgres                                     ');
INSERT INTO tbl_audit VALUES ('579','detalles_trabajo                             ','I',NULL,'(63," ??  ","",17,Producto:,"","")','2014-09-22 17:50:50.649','postgres                                     ');
INSERT INTO tbl_audit VALUES ('580','detalles_trabajo                             ','I',NULL,'(64,"",20,17,"","",Servicio)','2014-09-22 17:50:50.65','postgres                                     ');
INSERT INTO tbl_audit VALUES ('581','detalles_trabajo                             ','I',NULL,'(65,"FORMATEO COMPUTADOR","",17,1,1,"")','2014-09-22 17:50:50.657','postgres                                     ');
INSERT INTO tbl_audit VALUES ('582','registro_equipo                              ','U','(2,2,1,2,QWEQWE,"","",1,2,2014-09-22,1,QWE123123123,2014-09-22,0,"Willy Narv ez")','(2,2,1,2,QWEQWE,"","",1,2,2014-09-22,1,QWE123123123,2014-09-22,0,"Willy Narv ez")','2014-09-22 17:50:50.658','postgres                                     ');
INSERT INTO tbl_audit VALUES ('583','trabajo_tecnico                              ','I',NULL,'(18,2,2,49,"")','2014-09-22 17:51:13.994','postgres                                     ');
INSERT INTO tbl_audit VALUES ('584','detalles_trabajo                             ','I',NULL,'(66,Agregar,"",18,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-22 17:51:14','postgres                                     ');
INSERT INTO tbl_audit VALUES ('585','detalles_trabajo                             ','I',NULL,'(67," ??  ","",18,Producto:,"TARJETA PCI WIRELESS N 150","")','2014-09-22 17:51:14.003','postgres                                     ');
INSERT INTO tbl_audit VALUES ('586','detalles_trabajo                             ','I',NULL,'(68,"",20,18,"","",Servicio)','2014-09-22 17:51:14.004','postgres                                     ');
INSERT INTO tbl_audit VALUES ('587','detalles_trabajo                             ','I',NULL,'(69,"FORMATEO COMPUTADOR",29,18,1,1,Producto)','2014-09-22 17:51:14.005','postgres                                     ');
INSERT INTO tbl_audit VALUES ('588','detalles_trabajo                             ','I',NULL,'(70,"TARJETA PCI WIRELESS N 150","",18,6,2,"")','2014-09-22 17:51:14.029','postgres                                     ');
INSERT INTO tbl_audit VALUES ('589','registro_equipo                              ','U','(2,2,1,2,QWEQWE,"","",1,2,2014-09-22,1,QWE123123123,2014-09-22,0,"Willy Narv ez")','(2,2,1,2,QWEQWE,"","",1,2,2014-09-22,1,QWE123123123,2014-09-22,0,"Willy Narv ez")','2014-09-22 17:51:14.031','postgres                                     ');
INSERT INTO tbl_audit VALUES ('590','detalles_trabajo                             ','D','(70,"TARJETA PCI WIRELESS N 150","",18,6,2,"")',NULL,'2014-09-22 17:55:43.174','postgres                                     ');
INSERT INTO tbl_audit VALUES ('591','detalles_trabajo                             ','D','(69,"FORMATEO COMPUTADOR",29,18,1,1,Producto)',NULL,'2014-09-22 17:55:43.208','postgres                                     ');
INSERT INTO tbl_audit VALUES ('592','detalles_trabajo                             ','D','(68,"",20,18,"","",Servicio)',NULL,'2014-09-22 17:55:43.21','postgres                                     ');
INSERT INTO tbl_audit VALUES ('593','detalles_trabajo                             ','D','(67," ??  ","",18,Producto:,"TARJETA PCI WIRELESS N 150","")',NULL,'2014-09-22 17:55:43.214','postgres                                     ');
INSERT INTO tbl_audit VALUES ('594','detalles_trabajo                             ','D','(66,Agregar,"",18,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:43.216','postgres                                     ');
INSERT INTO tbl_audit VALUES ('595','detalles_trabajo                             ','D','(64,"",20,17,"","",Servicio)',NULL,'2014-09-22 17:55:43.219','postgres                                     ');
INSERT INTO tbl_audit VALUES ('596','detalles_trabajo                             ','D','(63," ??  ","",17,Producto:,"","")',NULL,'2014-09-22 17:55:43.221','postgres                                     ');
INSERT INTO tbl_audit VALUES ('597','detalles_trabajo                             ','D','(62,Agregar,"",17,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:43.223','postgres                                     ');
INSERT INTO tbl_audit VALUES ('598','detalles_trabajo                             ','D','(60,"",20,16,"","",Servicio)',NULL,'2014-09-22 17:55:43.224','postgres                                     ');
INSERT INTO tbl_audit VALUES ('599','detalles_trabajo                             ','D','(59," ??  ","",16,Producto:,"","")',NULL,'2014-09-22 17:55:43.226','postgres                                     ');
INSERT INTO tbl_audit VALUES ('600','detalles_trabajo                             ','D','(57,"FORMATEO COMPUTADOR","",15,1,1,"")',NULL,'2014-09-22 17:55:43.229','postgres                                     ');
INSERT INTO tbl_audit VALUES ('601','detalles_trabajo                             ','D','(56,"",20,15,"","",Servicio)',NULL,'2014-09-22 17:55:43.231','postgres                                     ');
INSERT INTO tbl_audit VALUES ('602','detalles_trabajo                             ','D','(55," ??  ","",15,Producto:,"","")',NULL,'2014-09-22 17:55:43.233','postgres                                     ');
INSERT INTO tbl_audit VALUES ('603','detalles_trabajo                             ','D','(54,Agregar,"",15,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:43.235','postgres                                     ');
INSERT INTO tbl_audit VALUES ('604','detalles_trabajo                             ','D','(53,"FORMATEO COMPUTADOR","",14,1,1,"")',NULL,'2014-09-22 17:55:43.236','postgres                                     ');
INSERT INTO tbl_audit VALUES ('605','detalles_trabajo                             ','D','(52,"",20,14,"","",Servicio)',NULL,'2014-09-22 17:55:43.238','postgres                                     ');
INSERT INTO tbl_audit VALUES ('606','detalles_trabajo                             ','D','(51," ??  ","",14,Producto:,"","")',NULL,'2014-09-22 17:55:43.24','postgres                                     ');
INSERT INTO tbl_audit VALUES ('607','detalles_trabajo                             ','D','(50,Agregar,"",14,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:43.242','postgres                                     ');
INSERT INTO tbl_audit VALUES ('608','detalles_trabajo                             ','D','(49,"FORMATEO COMPUTADOR","",13,1,1,"")',NULL,'2014-09-22 17:55:43.244','postgres                                     ');
INSERT INTO tbl_audit VALUES ('609','detalles_trabajo                             ','D','(48,"",20,13,"","",Servicio)',NULL,'2014-09-22 17:55:43.246','postgres                                     ');
INSERT INTO tbl_audit VALUES ('610','detalles_trabajo                             ','D','(47," ??  ","",13,Producto:,"","")',NULL,'2014-09-22 17:55:43.247','postgres                                     ');
INSERT INTO tbl_audit VALUES ('611','detalles_trabajo                             ','D','(46,Agregar,"",13,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:43.249','postgres                                     ');
INSERT INTO tbl_audit VALUES ('612','detalles_trabajo                             ','D','(65,"FORMATEO COMPUTADOR","",17,1,1,"")',NULL,'2014-09-22 17:55:46.559','postgres                                     ');
INSERT INTO tbl_audit VALUES ('613','detalles_trabajo                             ','D','(61,"FORMATEO COMPUTADOR","",16,1,1,"")',NULL,'2014-09-22 17:55:46.562','postgres                                     ');
INSERT INTO tbl_audit VALUES ('614','detalles_trabajo                             ','D','(58,Agregar,"",16,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:46.565','postgres                                     ');
INSERT INTO tbl_audit VALUES ('615','detalles_trabajo                             ','D','(44,"",20,12,"","",Servicio)',NULL,'2014-09-22 17:55:46.566','postgres                                     ');
INSERT INTO tbl_audit VALUES ('616','detalles_trabajo                             ','D','(43," ??  ","",12,Producto:,"","")',NULL,'2014-09-22 17:55:46.567','postgres                                     ');
INSERT INTO tbl_audit VALUES ('617','detalles_trabajo                             ','D','(42,Agregar,"",12,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:46.568','postgres                                     ');
INSERT INTO tbl_audit VALUES ('618','detalles_trabajo                             ','D','(41,"FORMATEO COMPUTADOR","",11,1,1,"")',NULL,'2014-09-22 17:55:46.57','postgres                                     ');
INSERT INTO tbl_audit VALUES ('619','detalles_trabajo                             ','D','(39," ??  ","",11,Producto:,"","")',NULL,'2014-09-22 17:55:46.571','postgres                                     ');
INSERT INTO tbl_audit VALUES ('620','detalles_trabajo                             ','D','(38,Agregar,"",11,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:46.573','postgres                                     ');
INSERT INTO tbl_audit VALUES ('621','detalles_trabajo                             ','D','(37,"FORMATEO COMPUTADOR","",10,1,1,"")',NULL,'2014-09-22 17:55:46.627','postgres                                     ');
INSERT INTO tbl_audit VALUES ('622','detalles_trabajo                             ','D','(36,"",20,10,"","",Servicio)',NULL,'2014-09-22 17:55:46.63','postgres                                     ');
INSERT INTO tbl_audit VALUES ('623','detalles_trabajo                             ','D','(35," ??  ","",10,Producto:,"","")',NULL,'2014-09-22 17:55:46.632','postgres                                     ');
INSERT INTO tbl_audit VALUES ('624','detalles_trabajo                             ','D','(34,Agregar,"",10,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:46.635','postgres                                     ');
INSERT INTO tbl_audit VALUES ('625','detalles_trabajo                             ','D','(33,"FORMATEO COMPUTADOR","",9,1,1,"")',NULL,'2014-09-22 17:55:46.637','postgres                                     ');
INSERT INTO tbl_audit VALUES ('626','detalles_trabajo                             ','D','(32,"",20,9,"","",Servicio)',NULL,'2014-09-22 17:55:46.639','postgres                                     ');
INSERT INTO tbl_audit VALUES ('627','detalles_trabajo                             ','D','(31," ??  ","",9,Producto:,"","")',NULL,'2014-09-22 17:55:46.64','postgres                                     ');
INSERT INTO tbl_audit VALUES ('628','detalles_trabajo                             ','D','(30,Agregar,"",9,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:46.642','postgres                                     ');
INSERT INTO tbl_audit VALUES ('629','detalles_trabajo                             ','D','(29,"FORMATEO COMPUTADOR","",8,1,1,"")',NULL,'2014-09-22 17:55:46.644','postgres                                     ');
INSERT INTO tbl_audit VALUES ('630','detalles_trabajo                             ','D','(28,"",20,8,"","",Servicio)',NULL,'2014-09-22 17:55:46.646','postgres                                     ');
INSERT INTO tbl_audit VALUES ('631','detalles_trabajo                             ','D','(45,"FORMATEO COMPUTADOR","",12,1,1,"")',NULL,'2014-09-22 17:55:49.711','postgres                                     ');
INSERT INTO tbl_audit VALUES ('632','detalles_trabajo                             ','D','(40,"",20,11,"","",Servicio)',NULL,'2014-09-22 17:55:49.714','postgres                                     ');
INSERT INTO tbl_audit VALUES ('633','detalles_trabajo                             ','D','(25,"FORMATEO COMPUTADOR","",7,1,1,"")',NULL,'2014-09-22 17:55:49.716','postgres                                     ');
INSERT INTO tbl_audit VALUES ('634','detalles_trabajo                             ','D','(24,"",20,7,"","",Servicio)',NULL,'2014-09-22 17:55:49.717','postgres                                     ');
INSERT INTO tbl_audit VALUES ('635','detalles_trabajo                             ','D','(23," ??  ","",7,Producto:,"","")',NULL,'2014-09-22 17:55:49.719','postgres                                     ');
INSERT INTO tbl_audit VALUES ('636','detalles_trabajo                             ','D','(21,"FORMATEO COMPUTADOR","",6,1,1,"")',NULL,'2014-09-22 17:55:49.74','postgres                                     ');
INSERT INTO tbl_audit VALUES ('637','detalles_trabajo                             ','D','(20,"",20,6,"","",Servicio)',NULL,'2014-09-22 17:55:49.741','postgres                                     ');
INSERT INTO tbl_audit VALUES ('638','detalles_trabajo                             ','D','(19," ??  ","",6,Producto:,"","")',NULL,'2014-09-22 17:55:49.743','postgres                                     ');
INSERT INTO tbl_audit VALUES ('639','detalles_trabajo                             ','D','(17,"FORMATEO COMPUTADOR","",5,1,1,"")',NULL,'2014-09-22 17:55:49.746','postgres                                     ');
INSERT INTO tbl_audit VALUES ('640','detalles_trabajo                             ','D','(15," ??  ","",5,Producto:,"","")',NULL,'2014-09-22 17:55:49.748','postgres                                     ');
INSERT INTO tbl_audit VALUES ('641','detalles_trabajo                             ','D','(14,Agregar,"",5,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:49.749','postgres                                     ');
INSERT INTO tbl_audit VALUES ('642','detalles_trabajo                             ','D','(13,"FORMATEO COMPUTADOR","",4,1,1,"")',NULL,'2014-09-22 17:55:49.75','postgres                                     ');
INSERT INTO tbl_audit VALUES ('643','detalles_trabajo                             ','D','(12,"",20,4,"","",Servicio)',NULL,'2014-09-22 17:55:49.751','postgres                                     ');
INSERT INTO tbl_audit VALUES ('645','detalles_trabajo                             ','D','(10,Agregar,"",4,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:49.754','postgres                                     ');
INSERT INTO tbl_audit VALUES ('646','detalles_trabajo                             ','D','(9,"FORMATEO COMPUTADOR","",3,1,1,"")',NULL,'2014-09-22 17:55:49.756','postgres                                     ');
INSERT INTO tbl_audit VALUES ('647','detalles_trabajo                             ','D','(8,"",20,3,"","",Servicio)',NULL,'2014-09-22 17:55:49.758','postgres                                     ');
INSERT INTO tbl_audit VALUES ('648','detalles_trabajo                             ','D','(7," ??  ","",3,Producto:,"","")',NULL,'2014-09-22 17:55:49.759','postgres                                     ');
INSERT INTO tbl_audit VALUES ('649','detalles_trabajo                             ','D','(6,Agregar,"",3,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:49.76','postgres                                     ');
INSERT INTO tbl_audit VALUES ('650','detalles_trabajo                             ','D','(27," ??  ","",8,Producto:,"","")',NULL,'2014-09-22 17:55:54.198','postgres                                     ');
INSERT INTO tbl_audit VALUES ('651','detalles_trabajo                             ','D','(26,Agregar,"",8,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:54.2','postgres                                     ');
INSERT INTO tbl_audit VALUES ('652','detalles_trabajo                             ','D','(22,Agregar,"",7,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:54.202','postgres                                     ');
INSERT INTO tbl_audit VALUES ('653','detalles_trabajo                             ','D','(18,Agregar,"",6,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:54.204','postgres                                     ');
INSERT INTO tbl_audit VALUES ('654','detalles_trabajo                             ','D','(16,"",20,5,"","",Servicio)',NULL,'2014-09-22 17:55:54.206','postgres                                     ');
INSERT INTO tbl_audit VALUES ('655','detalles_trabajo                             ','D','(5,"FORMATEO COMPUTADOR","",2,1,1,"")',NULL,'2014-09-22 17:55:54.208','postgres                                     ');
INSERT INTO tbl_audit VALUES ('656','detalles_trabajo                             ','D','(4,"",20,2,"","",Servicio)',NULL,'2014-09-22 17:55:54.21','postgres                                     ');
INSERT INTO tbl_audit VALUES ('657','detalles_trabajo                             ','D','(3," ??  ","",2,Producto:,"","")',NULL,'2014-09-22 17:55:54.212','postgres                                     ');
INSERT INTO tbl_audit VALUES ('658','detalles_trabajo                             ','D','(2,Agregar,"",2,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 17:55:54.213','postgres                                     ');
INSERT INTO tbl_audit VALUES ('659','trabajo_tecnico                              ','D','(18,2,2,49,"")',NULL,'2014-09-22 17:56:06.038','postgres                                     ');
INSERT INTO tbl_audit VALUES ('660','trabajo_tecnico                              ','D','(17,2,2,20,"")',NULL,'2014-09-22 17:56:06.059','postgres                                     ');
INSERT INTO tbl_audit VALUES ('661','trabajo_tecnico                              ','D','(16,2,2,20,"")',NULL,'2014-09-22 17:56:06.061','postgres                                     ');
INSERT INTO tbl_audit VALUES ('662','trabajo_tecnico                              ','D','(15,2,2,20,"")',NULL,'2014-09-22 17:56:06.062','postgres                                     ');
INSERT INTO tbl_audit VALUES ('663','trabajo_tecnico                              ','D','(14,2,1,20,"")',NULL,'2014-09-22 17:56:06.063','postgres                                     ');
INSERT INTO tbl_audit VALUES ('664','trabajo_tecnico                              ','D','(13,2,1,20,"")',NULL,'2014-09-22 17:56:06.065','postgres                                     ');
INSERT INTO tbl_audit VALUES ('665','trabajo_tecnico                              ','D','(12,2,1,20,"")',NULL,'2014-09-22 17:56:06.066','postgres                                     ');
INSERT INTO tbl_audit VALUES ('666','trabajo_tecnico                              ','D','(11,2,1,20,"")',NULL,'2014-09-22 17:56:06.067','postgres                                     ');
INSERT INTO tbl_audit VALUES ('667','trabajo_tecnico                              ','D','(10,2,1,20,"")',NULL,'2014-09-22 17:56:06.069','postgres                                     ');
INSERT INTO tbl_audit VALUES ('668','trabajo_tecnico                              ','D','(9,2,1,20,"")',NULL,'2014-09-22 17:56:06.07','postgres                                     ');
INSERT INTO tbl_audit VALUES ('669','trabajo_tecnico                              ','D','(8,2,1,20,"")',NULL,'2014-09-22 17:56:06.071','postgres                                     ');
INSERT INTO tbl_audit VALUES ('676','registro_equipo                              ','D','(2,2,1,2,QWEQWE,"","",1,2,2014-09-22,1,QWE123123123,2014-09-22,0,"Willy Narv ez")',NULL,'2014-09-22 17:56:19.102','postgres                                     ');
INSERT INTO tbl_audit VALUES ('677','registro_equipo                              ','D','(1,1,1,2,434435,DFG,DFGG,1,2,2014-09-19,1,43535,2014-09-19,0,"Willy Narv ez")',NULL,'2014-09-22 17:56:19.156','postgres                                     ');
INSERT INTO tbl_audit VALUES ('678','registro_equipo                              ','I',NULL,'(1,2,1,2,ASDASD,QWEQWE,QWEQWE,0,2,2014-09-22,1,QWEQW,2014-09-22,0,"")','2014-09-22 17:56:45.032','postgres                                     ');
INSERT INTO tbl_audit VALUES ('679','registro_equipo                              ','I',NULL,'(2,3,1,3,QWEQWER4,W,"",0,2,2014-09-22,1,QWEQWEQ,2014-09-22,0,"")','2014-09-22 17:58:03.829','postgres                                     ');
INSERT INTO tbl_audit VALUES ('680','registro_equipo                              ','U','(2,3,1,3,QWEQWER4,W,"",0,2,2014-09-22,1,QWEQWEQ,2014-09-22,0,"")','(2,3,1,3,QWEQWER4,W,"",3,2,2014-09-22,1,QWEQWEQ,2014-09-22,0,"Willy Narv ez")','2014-09-22 17:58:29.125','postgres                                     ');
INSERT INTO tbl_audit VALUES ('681','trabajo_tecnico                              ','I',NULL,'(2,2,2,21.2,"")','2014-09-22 17:58:46.928','postgres                                     ');
INSERT INTO tbl_audit VALUES ('682','detalles_trabajo                             ','I',NULL,'(2,Agregar,"",2,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-22 17:58:46.953','postgres                                     ');
INSERT INTO tbl_audit VALUES ('683','detalles_trabajo                             ','I',NULL,'(3," ??  ","",2,Producto:,"SEPARADOR DE AURICULARES RLIP XTREME","")','2014-09-22 17:58:46.955','postgres                                     ');
INSERT INTO tbl_audit VALUES ('684','detalles_trabajo                             ','I',NULL,'(4,"",20,2,"","",Servicio)','2014-09-22 17:58:46.956','postgres                                     ');
INSERT INTO tbl_audit VALUES ('685','detalles_trabajo                             ','I',NULL,'(5,"FORMATEO COMPUTADOR",1.2,2,1,1,Producto)','2014-09-22 17:58:46.957','postgres                                     ');
INSERT INTO tbl_audit VALUES ('686','detalles_trabajo                             ','I',NULL,'(6,"SEPARADOR DE AURICULARES RLIP XTREME","",2,19,1,"")','2014-09-22 17:58:46.964','postgres                                     ');
INSERT INTO tbl_audit VALUES ('687','registro_equipo                              ','U','(2,3,1,3,QWEQWER4,W,"",3,2,2014-09-22,1,QWEQWEQ,2014-09-22,0,"Willy Narv ez")','(2,3,1,3,QWEQWER4,W,"",1,2,2014-09-22,1,QWEQWEQ,2014-09-22,0,"Willy Narv ez")','2014-09-22 17:58:46.965','postgres                                     ');
INSERT INTO tbl_audit VALUES ('688','trabajo_tecnico                              ','I',NULL,'(3,2,2,21.2,"")','2014-09-22 17:59:21.795','postgres                                     ');
INSERT INTO tbl_audit VALUES ('689','detalles_trabajo                             ','I',NULL,'(7,Agregar,"",3,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)','2014-09-22 17:59:21.801','postgres                                     ');
INSERT INTO tbl_audit VALUES ('690','detalles_trabajo                             ','I',NULL,'(8," ??  ","",3,Producto:,"SEPARADOR DE AURICULARES RLIP XTREME","")','2014-09-22 17:59:21.809','postgres                                     ');
INSERT INTO tbl_audit VALUES ('691','detalles_trabajo                             ','I',NULL,'(9,"",20,3,"","",Servicio)','2014-09-22 17:59:21.82','postgres                                     ');
INSERT INTO tbl_audit VALUES ('692','detalles_trabajo                             ','I',NULL,'(10,"FORMATEO COMPUTADOR",1.2,3,1,1,Producto)','2014-09-22 17:59:21.821','postgres                                     ');
INSERT INTO tbl_audit VALUES ('693','detalles_trabajo                             ','I',NULL,'(11,"SEPARADOR DE AURICULARES RLIP XTREME","",3,19,1,"")','2014-09-22 17:59:21.837','postgres                                     ');
INSERT INTO tbl_audit VALUES ('694','registro_equipo                              ','U','(2,3,1,3,QWEQWER4,W,"",1,2,2014-09-22,1,QWEQWEQ,2014-09-22,0,"Willy Narv ez")','(2,3,1,3,QWEQWER4,W,"",1,2,2014-09-22,1,QWEQWEQ,2014-09-22,0,"Willy Narv ez")','2014-09-22 17:59:21.842','postgres                                     ');
INSERT INTO tbl_audit VALUES ('695','registro_equipo                              ','U','(1,2,1,2,ASDASD,QWEQWE,QWEQWE,0,2,2014-09-22,1,QWEQW,2014-09-22,0,"")','(1,2,1,2,ASDASD,QWEQWE,QWEQWE,3,2,2014-09-22,1,QWEQW,2014-09-22,0,"Willy Narv ez")','2014-09-22 18:03:57.032','postgres                                     ');
INSERT INTO tbl_audit VALUES ('696','trabajo_tecnico                              ','I',NULL,'(4,2,1,49,"")','2014-09-22 18:04:04.998','postgres                                     ');
INSERT INTO tbl_audit VALUES ('697','detalles_trabajo                             ','I',NULL,'(12,"FORMATEO COMPUTADOR",20,4,1,1,Servicio)','2014-09-22 18:04:05.003','postgres                                     ');
INSERT INTO tbl_audit VALUES ('698','detalles_trabajo                             ','I',NULL,'(13,"TARJETA PCI WIRELESS N 150",29,4,6,2,Producto)','2014-09-22 18:04:05.005','postgres                                     ');
INSERT INTO tbl_audit VALUES ('699','registro_equipo                              ','U','(1,2,1,2,ASDASD,QWEQWE,QWEQWE,3,2,2014-09-22,1,QWEQW,2014-09-22,0,"Willy Narv ez")','(1,2,1,2,ASDASD,QWEQWE,QWEQWE,1,2,2014-09-22,1,QWEQW,2014-09-22,0,"Willy Narv ez")','2014-09-22 18:04:05.006','postgres                                     ');
INSERT INTO tbl_audit VALUES ('700','detalles_trabajo                             ','D','(13,"TARJETA PCI WIRELESS N 150",29,4,6,2,Producto)',NULL,'2014-09-22 18:04:50.031','postgres                                     ');
INSERT INTO tbl_audit VALUES ('701','detalles_trabajo                             ','D','(12,"FORMATEO COMPUTADOR",20,4,1,1,Servicio)',NULL,'2014-09-22 18:04:50.042','postgres                                     ');
INSERT INTO tbl_audit VALUES ('702','detalles_trabajo                             ','D','(11,"SEPARADOR DE AURICULARES RLIP XTREME","",3,19,1,"")',NULL,'2014-09-22 18:04:50.043','postgres                                     ');
INSERT INTO tbl_audit VALUES ('703','detalles_trabajo                             ','D','(10,"FORMATEO COMPUTADOR",1.2,3,1,1,Producto)',NULL,'2014-09-22 18:04:50.045','postgres                                     ');
INSERT INTO tbl_audit VALUES ('704','detalles_trabajo                             ','D','(9,"",20,3,"","",Servicio)',NULL,'2014-09-22 18:04:50.047','postgres                                     ');
INSERT INTO tbl_audit VALUES ('705','detalles_trabajo                             ','D','(8," ??  ","",3,Producto:,"SEPARADOR DE AURICULARES RLIP XTREME","")',NULL,'2014-09-22 18:04:50.1','postgres                                     ');
INSERT INTO tbl_audit VALUES ('739','detalles_trabajo                             ','I',NULL,'(2,"SISTEMA SICADI 2 USUARIOS",200,1,2,2,Producto)','2014-09-22 20:13:15.191','postgres                                     ');
INSERT INTO tbl_audit VALUES ('740','detalles_trabajo                             ','I',NULL,'(3,"TARJETA PCI WIRELESS N 150",29,1,6,2,Producto)','2014-09-22 20:13:15.213','postgres                                     ');
INSERT INTO tbl_audit VALUES ('706','detalles_trabajo                             ','D','(7,Agregar,"",3,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 18:04:50.102','postgres                                     ');
INSERT INTO tbl_audit VALUES ('707','detalles_trabajo                             ','D','(6,"SEPARADOR DE AURICULARES RLIP XTREME","",2,19,1,"")',NULL,'2014-09-22 18:04:50.104','postgres                                     ');
INSERT INTO tbl_audit VALUES ('708','detalles_trabajo                             ','D','(5,"FORMATEO COMPUTADOR",1.2,2,1,1,Producto)',NULL,'2014-09-22 18:04:50.107','postgres                                     ');
INSERT INTO tbl_audit VALUES ('709','detalles_trabajo                             ','D','(4,"",20,2,"","",Servicio)',NULL,'2014-09-22 18:04:50.109','postgres                                     ');
INSERT INTO tbl_audit VALUES ('710','detalles_trabajo                             ','D','(3," ??  ","",2,Producto:,"SEPARADOR DE AURICULARES RLIP XTREME","")',NULL,'2014-09-22 18:04:50.111','postgres                                     ');
INSERT INTO tbl_audit VALUES ('711','detalles_trabajo                             ','D','(2,Agregar,"",2,"Tipo Da¤o:","
                                                                            FORMATEO COMPUTADORMANTENIMIENTO FISICOMANTENIMIENTO IMPRESORAREVISION EQUIPOVISITA TECNICASOPORTE EN SITIOINSTALACION PUNTO DE REDRECARGA TONERREVISION RED DE DATOSCONFIGURACION EQUIPOINSTALACION SOFTWAREINSTALACION ROUTERCONFIGURACION ROUTERMANTENIMIENTO EQUIPO INFORMATICOORGANIZACION RED DE DATOSINSTALACION SISTEMA CONTABLEINSTALACION SISTEMA SICADIREINSTALACION SISTEMA SICADISOPORTE TECNICO SICADICONFIGURACION SISTEMA SICADIRESPALDO DE INFORMACIONACTIVACION SISTEMASERVICIOS 0%SERVICIOS 12%
                                                                        ",Agregar)',NULL,'2014-09-22 18:04:50.113','postgres                                     ');
INSERT INTO tbl_audit VALUES ('712','registro_equipo                              ','U','(1,2,1,2,ASDASD,QWEQWE,QWEQWE,1,2,2014-09-22,1,QWEQW,2014-09-22,0,"Willy Narv ez")','(1,2,1,2,ASDASD,QWEQWE,QWEQWE,0,2,2014-09-22,1,QWEQW,2014-09-22,0,"Willy Narv ez")','2014-09-22 18:05:07.955','postgres                                     ');
INSERT INTO tbl_audit VALUES ('713','registro_equipo                              ','U','(2,3,1,3,QWEQWER4,W,"",1,2,2014-09-22,1,QWEQWEQ,2014-09-22,0,"Willy Narv ez")','(2,3,1,3,QWEQWER4,W,"",0,2,2014-09-22,1,QWEQWEQ,2014-09-22,0,"Willy Narv ez")','2014-09-22 18:05:09.416','postgres                                     ');
INSERT INTO tbl_audit VALUES ('714','registro_equipo                              ','U','(1,2,1,2,ASDASD,QWEQWE,QWEQWE,0,2,2014-09-22,1,QWEQW,2014-09-22,0,"Willy Narv ez")','(1,2,1,2,ASDASD,QWEQWE,QWEQWE,3,2,2014-09-22,1,QWEQW,2014-09-22,0,"Willy Narv ez")','2014-09-22 18:05:13.159','postgres                                     ');
INSERT INTO tbl_audit VALUES ('715','trabajo_tecnico                              ','I',NULL,'(5,2,1,22.4,"")','2014-09-22 18:05:21.702','postgres                                     ');
INSERT INTO tbl_audit VALUES ('716','detalles_trabajo                             ','I',NULL,'(2,"FORMATEO COMPUTADOR",20,5,1,1,Servicio)','2014-09-22 18:05:21.708','postgres                                     ');
INSERT INTO tbl_audit VALUES ('717','detalles_trabajo                             ','I',NULL,'(3,"SEPARADOR DE AURICULARES RLIP XTREME",2.4,5,19,2,Producto)','2014-09-22 18:05:21.709','postgres                                     ');
INSERT INTO tbl_audit VALUES ('718','registro_equipo                              ','U','(1,2,1,2,ASDASD,QWEQWE,QWEQWE,3,2,2014-09-22,1,QWEQW,2014-09-22,0,"Willy Narv ez")','(1,2,1,2,ASDASD,QWEQWE,QWEQWE,1,2,2014-09-22,1,QWEQW,2014-09-22,0,"Willy Narv ez")','2014-09-22 18:05:21.711','postgres                                     ');
INSERT INTO tbl_audit VALUES ('719','detalles_trabajo                             ','D','(3,"SEPARADOR DE AURICULARES RLIP XTREME",2.4,5,19,2,Producto)',NULL,'2014-09-22 18:07:30.217','postgres                                     ');
INSERT INTO tbl_audit VALUES ('720','detalles_trabajo                             ','D','(2,"FORMATEO COMPUTADOR",20,5,1,1,Servicio)',NULL,'2014-09-22 18:07:30.27','postgres                                     ');
INSERT INTO tbl_audit VALUES ('721','registro_equipo                              ','U','(2,3,1,3,QWEQWER4,W,"",0,2,2014-09-22,1,QWEQWEQ,2014-09-22,0,"Willy Narv ez")','(2,3,1,3,QWEQWER4,W,"",3,2,2014-09-22,1,QWEQWEQ,2014-09-22,0,"Willy Narv ez")','2014-09-22 18:07:33.807','postgres                                     ');
INSERT INTO tbl_audit VALUES ('722','trabajo_tecnico                              ','I',NULL,'(6,2,2,22.4,"")','2014-09-22 18:07:41.093','postgres                                     ');
INSERT INTO tbl_audit VALUES ('723','detalles_trabajo                             ','I',NULL,'(1,"FORMATEO COMPUTADOR",20,6,1,1,Servicio)','2014-09-22 18:07:41.099','postgres                                     ');
INSERT INTO tbl_audit VALUES ('724','detalles_trabajo                             ','I',NULL,'(2,"SEPARADOR DE AURICULARES RLIP XTREME",2.4,6,19,2,Producto)','2014-09-22 18:07:41.101','postgres                                     ');
INSERT INTO tbl_audit VALUES ('725','registro_equipo                              ','U','(2,3,1,3,QWEQWER4,W,"",3,2,2014-09-22,1,QWEQWEQ,2014-09-22,0,"Willy Narv ez")','(2,3,1,3,QWEQWER4,W,"",1,2,2014-09-22,1,QWEQWEQ,2014-09-22,0,"Willy Narv ez")','2014-09-22 18:07:41.102','postgres                                     ');
INSERT INTO tbl_audit VALUES ('726','detalles_trabajo                             ','D','(2,"SEPARADOR DE AURICULARES RLIP XTREME",2.4,6,19,2,Producto)',NULL,'2014-09-22 20:11:41.45','postgres                                     ');
INSERT INTO tbl_audit VALUES ('727','detalles_trabajo                             ','D','(1,"FORMATEO COMPUTADOR",20,6,1,1,Servicio)',NULL,'2014-09-22 20:11:41.493','postgres                                     ');
INSERT INTO tbl_audit VALUES ('728','trabajo_tecnico                              ','D','(6,2,2,22.4,"")',NULL,'2014-09-22 20:11:47.115','postgres                                     ');
INSERT INTO tbl_audit VALUES ('729','trabajo_tecnico                              ','D','(5,2,1,22.4,"")',NULL,'2014-09-22 20:11:47.295','postgres                                     ');
INSERT INTO tbl_audit VALUES ('730','trabajo_tecnico                              ','D','(4,2,1,49,"")',NULL,'2014-09-22 20:11:47.297','postgres                                     ');
INSERT INTO tbl_audit VALUES ('731','trabajo_tecnico                              ','D','(3,2,2,21.2,"")',NULL,'2014-09-22 20:11:47.298','postgres                                     ');
INSERT INTO tbl_audit VALUES ('732','trabajo_tecnico                              ','D','(2,2,2,21.2,"")',NULL,'2014-09-22 20:11:47.3','postgres                                     ');
INSERT INTO tbl_audit VALUES ('733','registro_equipo                              ','D','(2,3,1,3,QWEQWER4,W,"",1,2,2014-09-22,1,QWEQWEQ,2014-09-22,0,"Willy Narv ez")',NULL,'2014-09-22 20:11:57.826','postgres                                     ');
INSERT INTO tbl_audit VALUES ('734','registro_equipo                              ','D','(1,2,1,2,ASDASD,QWEQWE,QWEQWE,1,2,2014-09-22,1,QWEQW,2014-09-22,0,"Willy Narv ez")',NULL,'2014-09-22 20:11:58.036','postgres                                     ');
INSERT INTO tbl_audit VALUES ('735','registro_equipo                              ','I',NULL,'(1,2,1,2,ASD,"","",0,2,2014-09-22,1,ASDASD,2014-09-22,0,"")','2014-09-22 20:12:28.275','postgres                                     ');
INSERT INTO tbl_audit VALUES ('736','registro_equipo                              ','U','(1,2,1,2,ASD,"","",0,2,2014-09-22,1,ASDASD,2014-09-22,0,"")','(1,2,1,2,ASD,"","",3,2,2014-09-22,1,ASDASD,2014-09-22,0,"Willy Narv ez")','2014-09-22 20:13:04.06','postgres                                     ');
INSERT INTO tbl_audit VALUES ('737','trabajo_tecnico                              ','I',NULL,'(1,2,1,249,"")','2014-09-22 20:13:15.172','postgres                                     ');
INSERT INTO tbl_audit VALUES ('738','detalles_trabajo                             ','I',NULL,'(1,"FORMATEO COMPUTADOR",20,1,1,1,Servicio)','2014-09-22 20:13:15.189','postgres                                     ');
INSERT INTO tbl_audit VALUES ('741','registro_equipo                              ','U','(1,2,1,2,ASD,"","",3,2,2014-09-22,1,ASDASD,2014-09-22,0,"Willy Narv ez")','(1,2,1,2,ASD,"","",1,2,2014-09-22,1,ASDASD,2014-09-22,0,"Willy Narv ez")','2014-09-22 20:13:15.215','postgres                                     ');
INSERT INTO tbl_audit VALUES ('742','registro_equipo                              ','U','(1,2,1,2,ASD,"","",1,2,2014-09-22,1,ASDASD,2014-09-22,0,"Willy Narv ez")','(1,2,1,2,ASD,"","",2,2,2014-09-22,1,ASDASD,2014-09-22,0,"Willy Narv ez")','2014-09-22 20:14:53.766','postgres                                     ');


--
-- Creating index for 'tbl_audit'
--

ALTER TABLE ONLY  tbl_audit  ADD CONSTRAINT  pk_audit  PRIMARY KEY  (pk_audit);


--
-- Creating relacionships for 'detalles_trabajo'
--

ALTER TABLE ONLY detalles_trabajo ADD CONSTRAINT r_trabajo_detalles FOREIGN KEY (id_trabajotecnico) REFERENCES trabajo_tecnico(id_trabajotecnico) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'registro_equipo'
--

ALTER TABLE ONLY registro_equipo ADD CONSTRAINT r_cliente_registro FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'registro_equipo'
--

ALTER TABLE ONLY registro_equipo ADD CONSTRAINT r_color_registro FOREIGN KEY (id_color) REFERENCES color(id_color) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'registro_equipo'
--

ALTER TABLE ONLY registro_equipo ADD CONSTRAINT r_categoria_registro FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'registro_equipo'
--

ALTER TABLE ONLY registro_equipo ADD CONSTRAINT r_marca_registro FOREIGN KEY (id_marca) REFERENCES marcas(id_marca) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'registro_equipo'
--

ALTER TABLE ONLY registro_equipo ADD CONSTRAINT r_usuario_registro FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Creating relacionships for 'trabajo_tecnico'
--

ALTER TABLE ONLY trabajo_tecnico ADD CONSTRAINT r_registro_trabajoregistro FOREIGN KEY (id_registro) REFERENCES registro_equipo(id_registro) ON UPDATE CASCADE ON DELETE CASCADE;
CREATE TRIGGER c_cobrarexternas_tg_audit AFTER INSERT OR UPDATE OR DELETE ON c_cobrarexternas FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER c_pagarexternas_tg_audit AFTER INSERT OR UPDATE OR DELETE ON c_pagarexternas FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER categoria_tg_audit AFTER INSERT OR UPDATE OR DELETE ON categoria FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER clientes_tg_audit AFTER INSERT OR UPDATE OR DELETE ON clientes FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER color_tg_audit AFTER INSERT OR UPDATE OR DELETE ON color FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER detalle_devolucion_compra_tg_audit AFTER INSERT OR UPDATE OR DELETE ON detalle_devolucion_compra FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER detalle_devolucion_venta_tg_audit AFTER INSERT OR UPDATE OR DELETE ON detalle_devolucion_venta FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER detalle_egreso_tg_audit AFTER INSERT OR UPDATE OR DELETE ON detalle_egreso FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER detalle_factura_compra_tg_audit AFTER INSERT OR UPDATE OR DELETE ON detalle_factura_compra FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER detalle_factura_venta_tg_audit AFTER INSERT OR UPDATE OR DELETE ON detalle_factura_venta FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER detalle_ingreso_tg_audit AFTER INSERT OR UPDATE OR DELETE ON detalle_ingreso FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER detalle_inventario_tg_audit AFTER INSERT OR UPDATE OR DELETE ON detalle_inventario FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER detalle_pagos_venta_tg_audit AFTER INSERT OR UPDATE OR DELETE ON detalle_pagos_venta FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER detalle_proforma_tg_audit AFTER INSERT OR UPDATE OR DELETE ON detalle_proforma FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER detalles_ordenes_tg_audit AFTER INSERT OR UPDATE OR DELETE ON detalles_ordenes FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER detalles_pagos_internos_tg_audit AFTER INSERT OR UPDATE OR DELETE ON detalles_pagos_internos FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER detalles_trabajo_tg_audit AFTER INSERT OR UPDATE OR DELETE ON detalles_trabajo FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER devolucion_compra_tg_audit AFTER INSERT OR UPDATE OR DELETE ON devolucion_compra FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER devolucion_venta_tg_audit AFTER INSERT OR UPDATE OR DELETE ON devolucion_venta FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER egresos_tg_audit AFTER INSERT OR UPDATE OR DELETE ON egresos FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER empresa_tg_audit AFTER INSERT OR UPDATE OR DELETE ON empresa FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER factura_compra_tg_audit AFTER INSERT OR UPDATE OR DELETE ON factura_compra FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER factura_venta_tg_audit AFTER INSERT OR UPDATE OR DELETE ON factura_venta FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER gastos_tg_audit AFTER INSERT OR UPDATE OR DELETE ON gastos FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER gastos_internos_tg_audit AFTER INSERT OR UPDATE OR DELETE ON gastos_internos FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER ingresos_tg_audit AFTER INSERT OR UPDATE OR DELETE ON ingresos FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER inventario_tg_audit AFTER INSERT OR UPDATE OR DELETE ON inventario FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER kardex_tg_audit AFTER INSERT OR UPDATE OR DELETE ON kardex FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER kardex_valorizado_tg_audit AFTER INSERT OR UPDATE OR DELETE ON kardex_valorizado FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER marcas_tg_audit AFTER INSERT OR UPDATE OR DELETE ON marcas FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER ordenes_produccion_tg_audit AFTER INSERT OR UPDATE OR DELETE ON ordenes_produccion FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER pagos_cobrar_tg_audit AFTER INSERT OR UPDATE OR DELETE ON pagos_cobrar FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER pagos_compra_tg_audit AFTER INSERT OR UPDATE OR DELETE ON pagos_compra FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER pagos_pagar_tg_audit AFTER INSERT OR UPDATE OR DELETE ON pagos_pagar FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER pagos_venta_tg_audit AFTER INSERT OR UPDATE OR DELETE ON pagos_venta FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER parametros_tg_audit AFTER INSERT OR UPDATE OR DELETE ON parametros FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER productos_tg_audit AFTER INSERT OR UPDATE OR DELETE ON productos FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER proforma_tg_audit AFTER INSERT OR UPDATE OR DELETE ON proforma FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER proveedores_tg_audit AFTER INSERT OR UPDATE OR DELETE ON proveedores FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER registro_equipo_tg_audit AFTER INSERT OR UPDATE OR DELETE ON registro_equipo FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER seguridad_tg_audit AFTER INSERT OR UPDATE OR DELETE ON seguridad FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER serie_venta_tg_audit AFTER INSERT OR UPDATE OR DELETE ON serie_venta FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER series_compra_tg_audit AFTER INSERT OR UPDATE OR DELETE ON series_compra FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tipoproducto_tg_audit AFTER INSERT OR UPDATE OR DELETE ON "tipoProducto" FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER trabajo_tg_audit AFTER INSERT OR UPDATE OR DELETE ON trabajo FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER trabajo_tecnico_tg_audit AFTER INSERT OR UPDATE OR DELETE ON trabajo_tecnico FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER usuario_tg_audit AFTER INSERT OR UPDATE OR DELETE ON usuario FOR EACH ROW EXECUTE PROCEDURE fn_log_audit();