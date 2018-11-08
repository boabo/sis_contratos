/***********************************I-SCP-FEA-LEG-1-7/11/2018*****************************************/
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
/***********************************F-SCP-FEA-LEG-1-7/11/2018*****************************************/