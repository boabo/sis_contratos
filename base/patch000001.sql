/***********************************I-SCP-FEA-LEG-1-07/11/2018*****************************************/

CREATE TABLE leg.tcontrato (
  id_contrato SERIAL,
  id_estado_wf INTEGER NOT NULL,
  id_proceso_wf INTEGER NOT NULL,
  estado VARCHAR(50) NOT NULL,
  tipo VARCHAR(30),
  objeto TEXT,
  fecha_inicio DATE,
  fecha_fin DATE,
  numero VARCHAR(50),
  id_gestion INTEGER,
  id_persona INTEGER,
  id_institucion INTEGER,
  id_proveedor INTEGER,
  observaciones TEXT,
  solicitud TEXT,
  monto NUMERIC(18,2),
  id_moneda INTEGER,
  fecha_elaboracion DATE,
  plazo INTEGER,
  tipo_plazo VARCHAR,
  id_cotizacion INTEGER,
  marri VARCHAR(20),
  periodicidad_pago VARCHAR(50),
  tiene_retencion VARCHAR(2),
  fk_id_contrato INTEGER,
  modo VARCHAR(30),
  id_lugar INTEGER,
  id_contrato_fk INTEGER,
  id_concepto_ingas INTEGER[] [],
  id_orden_trabajo INTEGER[] [],
  cargo VARCHAR(50),
  forma_contratacion VARCHAR(30),
  modalidad VARCHAR(30),
  representante_legal VARCHAR(100),
  rpc VARCHAR(100),
  mae VARCHAR(100),
  contrato_adhesion VARCHAR(2),
  id_abogado INTEGER,
  id_funcionario INTEGER,
  rpc_regional VARCHAR DEFAULT 'no'::character varying NOT NULL,
  bancarizacion VARCHAR(2),
  tipo_monto VARCHAR,
  resolucion_bancarizacion VARCHAR,
  id_agencia INTEGER,
  tipo_agencia VARCHAR(30),
  moneda_restrictiva VARCHAR(2),
  cuenta_bancaria1 VARCHAR(30),
  entidad_bancaria1 VARCHAR(45),
  nombre_cuenta_bancaria1 VARCHAR(100),
  cuenta_bancaria2 VARCHAR(30),
  entidad_bancaria2 VARCHAR(45),
  nombre_cuenta_bancaria2 VARCHAR(100),
  formas_pago VARCHAR[] [],
  CONSTRAINT tcontrato_pkey PRIMARY KEY(id_contrato),
  CONSTRAINT fk_contrato__id_estado_wf FOREIGN KEY (id_estado_wf)
    REFERENCES wf.testado_wf(id_estado_wf)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE,
  CONSTRAINT fk_contrato__id_proceso_wf FOREIGN KEY (id_proceso_wf)
    REFERENCES wf.tproceso_wf(id_proceso_wf)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)

WITH (oids = false);

CREATE TRIGGER tcontrato_tr
  BEFORE UPDATE
  ON leg.tcontrato FOR EACH ROW
  EXECUTE PROCEDURE leg.f_tr_contrato();

CREATE TRIGGER tcontrato_tr_fechas
  BEFORE INSERT OR UPDATE
  ON leg.tcontrato FOR EACH ROW
  EXECUTE PROCEDURE leg.f_tr_contrato_fecha();

  CREATE TABLE leg.tanexo (
  id_anexo SERIAL,
  id_contrato INTEGER NOT NULL,
  tipo VARCHAR(30),
  descripcion VARCHAR(1000),
  fecha_desde DATE,
  fecha_hasta DATE,
  tipo_boleta VARCHAR(30),
  moneda VARCHAR(3),
  monto NUMERIC,
  banco VARCHAR(30),
  nro_documento VARCHAR,
  fecha_fin_uso DATE,
  estado VARCHAR(100),
  CONSTRAINT tanexo_pkey PRIMARY KEY(id_anexo),
  CONSTRAINT fk_anexo__id_contrato FOREIGN KEY (id_contrato)
    REFERENCES leg.tcontrato(id_contrato)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)

WITH (oids = false);

/***********************************F-SCP-FEA-LEG-1-07/11/2018*****************************************/

/***********************************I-SCP-IRVA-LEG-1-06/03/2019*****************************************/
CREATE TABLE leg.tdato_anterior_contrato (
  id_contrato INTEGER,
  id_estado_wf INTEGER,
  id_proceso_wf INTEGER,
  estado VARCHAR(50),
  tipo VARCHAR(30),
  objeto TEXT,
  fecha_inicio DATE,
  fecha_fin DATE,
  numero VARCHAR(50),
  id_gestion INTEGER,
  id_persona INTEGER,
  id_institucion INTEGER,
  id_proveedor INTEGER,
  observaciones TEXT,
  solicitud TEXT,
  monto NUMERIC(18,2),
  id_moneda INTEGER,
  fecha_elaboracion DATE,
  plazo INTEGER,
  tipo_plazo VARCHAR,
  id_cotizacion INTEGER,
  marri VARCHAR(20),
  periodicidad_pago VARCHAR(50),
  tiene_retencion VARCHAR(2),
  fk_id_contrato INTEGER,
  modo VARCHAR(30),
  id_lugar INTEGER,
  id_contrato_fk INTEGER,
  id_concepto_ingas INTEGER[][] [],
  id_orden_trabajo INTEGER[][] [],
  cargo VARCHAR(50),
  forma_contratacion VARCHAR(30),
  modalidad VARCHAR(30),
  representante_legal VARCHAR(100),
  rpc VARCHAR(100),
  mae VARCHAR(100),
  contrato_adhesion VARCHAR(2),
  id_abogado INTEGER,
  id_funcionario INTEGER,
  rpc_regional VARCHAR DEFAULT 'no'::character varying,
  bancarizacion VARCHAR(2),
  tipo_monto VARCHAR,
  resolucion_bancarizacion VARCHAR,
  id_agencia INTEGER,
  tipo_agencia VARCHAR(30),
  moneda_restrictiva VARCHAR(2),
  cuenta_bancaria1 VARCHAR(30),
  entidad_bancaria1 VARCHAR(45),
  nombre_cuenta_bancaria1 VARCHAR(100),
  cuenta_bancaria2 VARCHAR(30),
  entidad_bancaria2 VARCHAR(45),
  nombre_cuenta_bancaria2 VARCHAR(100),
  formas_pago VARCHAR[][] [],
  accion VARCHAR(200),
  responsable VARCHAR(50)
) INHERITS (pxp.tbase)

WITH (oids = false);

/***********************************F-SCP-IRVA-LEG-1-06/03/2019*****************************************/
/***********************************I-SCP-IRVA-LEG-2-06/03/2019*****************************************/
ALTER TABLE leg.tdato_anterior_contrato
  ADD COLUMN "current_user" VARCHAR(200) DEFAULT CURRENT_USER NOT NULL;
/***********************************F-SCP-IRVA-LEG-2-06/03/2019*****************************************/

/***********************************I-SCP-BVP-LEG-1-26/04/2019*****************************************/
ALTER TABLE leg.tanexo
  ADD COLUMN nro_hoja_ruta 		VARCHAR(250);

ALTER TABLE leg.tanexo
  ADD COLUMN id_proceso_wf		INTEGER;
  
ALTER TABLE leg.tanexo
  ADD COLUMN id_estado_wf	 	INTEGER;

ALTER TABLE leg.tanexo
  ADD COLUMN id_institucion	 	INTEGER;  
  
ALTER TABLE leg.tanexo
  ADD COLUMN origen				VARCHAR(250);    
/***********************************F-SCP-BVP-LEG-1-26/04/2019*****************************************/

/***********************************I-SCP-BVP-LEG-1-15/07/2019*****************************************/

ALTER TABLE leg.tanexo
  ADD COLUMN id_proveedor INTEGER;


ALTER TABLE leg.tanexo
  ALTER COLUMN id_contrato DROP NOT NULL;
/***********************************F-SCP-BVP-LEG-1-15/07/2019*****************************************/

/***********************************I-SCP-AFG-LEG-1-20/11/2019*****************************************/

COMMENT ON TABLE leg.tcontrato
IS 'Tabla que contiene la informacion del documento principal como ser el estado del contrato, el tipo del contrato, fecha de elaboracion, numero de contrato y otros';
COMMENT ON COLUMN leg.tcontrato.id_contrato
IS 'identificador del contrato';
COMMENT ON COLUMN leg.tcontrato.id_estado_wf
IS 'identificador del estado del flujo de trabajo';
COMMENT ON COLUMN leg.tcontrato.id_proceso_wf
IS 'identificador del proceso del flujo de trabajo';
COMMENT ON COLUMN leg.tcontrato.estado
IS 'estado del contrato';
COMMENT ON COLUMN leg.tcontrato.tipo
IS 'tipo de contrato';
COMMENT ON COLUMN leg.tcontrato.objeto
IS 'objeto del contrato';
COMMENT ON COLUMN leg.tcontrato.fecha_inicio
IS 'fecha de inicio del contrato';
COMMENT ON COLUMN leg.tcontrato.fecha_fin
IS 'fecha de fin del contrato';
COMMENT ON COLUMN leg.tcontrato.numero
IS 'numero del contrato';
COMMENT ON COLUMN leg.tcontrato.id_gestion
IS 'identificador de la gestion del contrato';
COMMENT ON COLUMN leg.tcontrato.id_proveedor
IS 'identificador del proveedor';
COMMENT ON COLUMN leg.tcontrato.observaciones
IS 'observaciones del contrato';
COMMENT ON COLUMN leg.tcontrato.solicitud
IS 'solicitud del contrato';
COMMENT ON COLUMN leg.tcontrato.monto
IS 'monto del contrato';
COMMENT ON COLUMN leg.tcontrato.id_moneda
IS 'identificador de en que moneda se hace el contrato';
COMMENT ON COLUMN leg.tcontrato.fecha_elaboracion
IS 'fecha de elaboracion del contrato';
COMMENT ON COLUMN leg.tcontrato.plazo
IS 'plazo del contrato';
COMMENT ON COLUMN leg.tcontrato.tipo_plazo
IS 'tipo de plazo del contrato';
COMMENT ON COLUMN leg.tcontrato.id_cotizacion
IS 'identificador de la cotizacion';
COMMENT ON COLUMN leg.tcontrato.periodicidad_pago
IS 'indica la periocidad del cumplimiento del contrato (mensual, anual,etc)';
COMMENT ON COLUMN leg.tcontrato.tiene_retencion
IS 'indica si tiene retenciones';
COMMENT ON COLUMN leg.tcontrato.id_concepto_ingas
IS 'identificador del concepto(s) de gasto';
COMMENT ON COLUMN leg.tcontrato.contrato_adhesion
IS 'indica si el contrato tiene adhesiones';
COMMENT ON COLUMN leg.tcontrato.id_abogado
IS 'identificador del abogado';
COMMENT ON COLUMN leg.tcontrato.tipo_monto
IS 'tipo de monto del contrato';
COMMENT ON COLUMN leg.tcontrato.moneda_restrictiva
IS 'indica si la moneda es restrictiva al contrato';
COMMENT ON COLUMN leg.tcontrato.formas_pago
IS 'formas de pago del contrato';

COMMENT ON TABLE leg.tanexo
IS 'tabla que contiene informacion de los documentos relacionados al contrato principal
ej: adendas, boletas de garantia,etc.';
COMMENT ON COLUMN leg.tanexo.id_contrato
IS 'identificador del contrato';
COMMENT ON COLUMN leg.tanexo.tipo
IS 'tipo del anexo';
COMMENT ON COLUMN leg.tanexo.descripcion
IS 'descripcion del anexo';
COMMENT ON COLUMN leg.tanexo.fecha_desde
IS 'fecha desde cual es valido';
COMMENT ON COLUMN leg.tanexo.fecha_hasta
IS 'fecha hasta donde es valido';
COMMENT ON COLUMN leg.tanexo.tipo_boleta
IS 'tipo de la boleta';
COMMENT ON COLUMN leg.tanexo.moneda
IS 'moneda de la boleta';
COMMENT ON COLUMN leg.tanexo.monto
IS 'monto del anexo';
COMMENT ON COLUMN leg.tanexo.banco
IS 'datos del banco relacionados al anexo';
COMMENT ON COLUMN leg.tanexo.nro_documento
IS 'numero de documento del anexo';
COMMENT ON COLUMN leg.tanexo.estado
IS 'estado del anexo';
COMMENT ON COLUMN leg.tanexo.id_proceso_wf
IS 'identificador del proceso de flujo de trabajo';
COMMENT ON COLUMN leg.tanexo.id_estado_wf
IS 'identificador del estado del flujo de trabajo';
COMMENT ON COLUMN leg.tanexo.id_institucion
IS 'identificador de la institucion';
COMMENT ON COLUMN leg.tanexo.origen
IS 'origen del anexo';
COMMENT ON COLUMN leg.tanexo.id_proveedor
IS 'identificador del proveedor';

COMMENT ON TABLE leg.tdato_anterior_contrato
IS 'tabla que contiene informacion original de un contrato que fue modificado por alguna razon';
COMMENT ON COLUMN leg.tdato_anterior_contrato.id_contrato
IS 'identificador del contrato que fue modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.id_estado_wf
IS 'identificador del estado del contrato en flujo de trabajo';
COMMENT ON COLUMN leg.tdato_anterior_contrato.id_proceso_wf
IS 'identificador del proceso del contrato en el flujo de trabajo';
COMMENT ON COLUMN leg.tdato_anterior_contrato.estado
IS 'estado original del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.tipo
IS 'tipo de contrato original del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.objeto
IS 'objeto original del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.fecha_inicio
IS 'fecha de inicio original del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.fecha_fin
IS 'fecha final original del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.numero
IS 'numero original del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.id_proveedor
IS 'identificador original del proveedor';
COMMENT ON COLUMN leg.tdato_anterior_contrato.observaciones
IS 'observaciones originales del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.solicitud
IS 'solicitud original del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.monto
IS 'monto original del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.id_moneda
IS 'identificador de la moneda original del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.fecha_elaboracion
IS 'fecha de elaboracion original del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.plazo
IS 'plazo original del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.id_cotizacion
IS 'identificador de la cotizacion original del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.periodicidad_pago
IS 'indica la periocidad del cumplimiento original del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.tiene_retencion
IS 'indica la retencion original del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.id_concepto_ingas
IS 'identificador original del concepto(s) original(es) del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.contrato_adhesion
IS 'indica adhesiones original del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.id_abogado
IS 'identificador original del abogado del contrato modificado';
COMMENT ON COLUMN leg.tdato_anterior_contrato.moneda_restrictiva
IS 'indica el valor original si la moneda es retringida a una sola moneda';
COMMENT ON COLUMN leg.tdato_anterior_contrato.formas_pago
IS 'formas de pago original del contrato modificado';


COMMENT ON FUNCTION leg.ft_poliza_boleta_sel(p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
IS 'Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla ''leg.tpoliza_voletos''';
COMMENT ON FUNCTION leg.f_fecha_dia_mes_literal_anio(p_fecha date)
IS 'funcion que devuelve la fecha en formato dia-mes literal abreviado-anio dos digitos        ';
COMMENT ON FUNCTION leg.f_lista_firma_contraparte_wf_sel(p_id_usuario integer, p_id_tipo_estado integer, p_fecha date, p_id_estado_wf integer, p_count boolean, p_limit integer, p_start integer, p_filtro varchar)
IS 'funcion que lista el abogado asignado para el proceso';
COMMENT ON FUNCTION leg.f_verificar_numero_contrato(p_nombre_tabla varchar, p_numero_contrato varchar)
IS 'funcion que revisa si un numero de contrato es duplicado al momento de hacer la insercion
del contrato o la modificacion de la misma';
COMMENT ON FUNCTION leg.ft_contrato_sel(p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
IS 'Funcion que devuelve conjuntos de registros de las
consultas relacionadas con la tabla ''leg.tcontrato''';
COMMENT ON FUNCTION leg.ft_poliza_boleta_ime(p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
IS 'Funcion que gestiona las operaciones basicas
(inserciones, modificaciones, eliminaciones de la tabla ''leg.tanexo''';
COMMENT ON FUNCTION leg.f_send_correo_boletas_vencidas(p_id_uo_funcionario integer, p_id_uo integer)
IS 'funcion que devuelve un mensaje con la lista de boletas vencidas';
COMMENT ON FUNCTION leg.f_tr_contrato_fecha()
IS 'FUNCION DE ACTUALIZACION PARA QUE EL TIPO DE PAGO EN CONTRATO SE ACTUALIZE EN AGENCIA';
COMMENT ON FUNCTION leg.f_tr_contrato()
IS 'funcion que actualiza las cotizaciones de un contrato dependiendo del flujo de trabajo';
COMMENT ON FUNCTION leg.f_control_actualizaciones_contrato()
IS 'FUNCION DE ACTUALIZACION PARA QUE EL TIPO DE PAGO EN CONTRATO SE ACTUALIZE EN AGENCIA';
COMMENT ON FUNCTION leg.f_control_eliminacion_datos_modificados()
IS 'funcion que controla la eliminacion de contratos con datos modificados';

/***********************************F-SCP-AFG-LEG-1-20/11/2019*****************************************/



