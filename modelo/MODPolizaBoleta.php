<?php
/**
*@package pXP
*@file MODPolizaBoleta.php
*@author  (breydi.vasquez)
*@date 18-04-2018 20:02:21
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPolizaBoleta extends MODbase{

	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}

	function listarPolizaBoleta(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='leg.ft_poliza_boleta_sel';
		$this->transaccion='LG_POBOA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion

		$this->capturaCount('total_asegurado','numeric');

		$this->captura('id_anexo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('agencia','varchar');
		$this->captura('nro_documento','varchar');
		$this->captura('fecha_desde','date');
		$this->captura('fecha_fin_uso','date');
		$this->captura('moneda','varchar');
		$this->captura('asegurado','numeric');
		$this->captura('estado','varchar');
		$this->captura('codigo_noiata','varchar');
		$this->captura('codigo','varchar');
		$this->captura('fecha_hasta','date');
		$this->captura('fecha_corte','date');
		$this->captura('codigo_int','varchar');
		$this->captura('fecha_notif','date');
		$this->captura('tipo','varchar');
		$this->captura('numero','varchar');
		$this->captura('tipo_agencia','varchar');
		$this->captura('banco','varchar');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('observaciones','text');
		$this->captura('id_agencia','int4');
		$this->captura('estado_contrato','varchar');
		$this->captura('id_proceso_wf','integer');
		$this->captura('id_estado_wf','integer');
		$this->captura('nro_hoja_ruta','varchar');
		$this->captura('id_contrato','integer');
		$this->captura('id_gestion','integer');
		$this->captura('gestion','integer');
    $this->captura('id_proveedor','integer');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo($this->consulta);exit;
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	function listarPolizaBoletaOtra(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='leg.ft_poliza_boleta_sel';
		$this->transaccion='LG_POBOO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion

		$this->capturaCount('total_asegurado','numeric');
		//$this->setParametro('fecha_fin_uso','fecha_fin_uso','integer');
		//Definicion de la lista del resultado del query
		//$this->captura('id_poliza_voletos','int4');
		$this->captura('id_anexo','int4');
		$this->captura('banco','varchar');
		$this->captura('nro_documento','varchar');
		$this->captura('tipo','varchar');
		$this->captura('proveedor','varchar');
		$this->captura('numero','varchar');
		$this->captura('fecha_fin_uso','date');
		$this->captura('fecha_desde','date');
		$this->captura('fecha_notif','date');
		$this->captura('fecha_corte','date');
		$this->captura('fecha_hasta','date');
		$this->captura('moneda','varchar');
		$this->captura('asegurado','numeric');
		$this->captura('estado','varchar');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('tipo_agencia','varchar');
		$this->captura('observaciones','text');
		$this->captura('estado_contrato','varchar');
		$this->captura('id_proceso_wf','integer');
		$this->captura('id_estado_wf','integer');
		$this->captura('nro_hoja_ruta','varchar');
		$this->captura('id_contrato','integer');
		$this->captura('id_gestion','integer');
		$this->captura('gestion','integer');
		$this->captura('id_proveedor','integer');
		$this->captura('id_institucion','integer');
		$this->captura('institucion','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('estado_reg','varchar');
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo($this->consulta);exit;
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function RepBoletasGarantia() {
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='leg.ft_poliza_boleta_sel';
		$this->transaccion='LG_RBSGAR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		$this->setCount(false);
		$this->setParametro('fecha_desde','fecha_desde','date');
		$this->setParametro('fecha_hasta','fecha_hasta','date');
		$this->setParametro('boleta_filtro','boleta_filtro','varchar');

        $this->captura('banco','varchar');
        $this->captura('nro_documento','varchar');
        $this->captura('tipo','varchar');
        $this->captura('agencia','varchar');
        $this->captura('fecha_desde','text');
        $this->captura('fecha_hasta','text');
        $this->captura('asegurado','numeric');
        $this->captura('tipo_agencia','varchar');
        $this->captura('estado','varchar');
        $this->captura('gestion','integer');
        $this->captura('origen','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo($this->consulta);exit;
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function insertarPolizaBoleta(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='leg.ft_poliza_boleta_ime';
		$this->transaccion='LG_RBSGAR_INS';
		$this->tipo_procedimiento='IME';//tipo de transaccion

		$this->setParametro('origen','origen','varchar');
		$this->setParametro('id_proveedor','id_proveedor','integer');
		$this->setParametro('id_institucion','id_institucion','integer');
		$this->setParametro('id_agencia','id_agencia','integer');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('nro_documento','nro_documento','varchar');
		$this->setParametro('id_contrato','id_contrato','integer');
		$this->setParametro('fecha_desde','fecha_desde','date');
		$this->setParametro('fecha_hasta','fecha_hasta','date');
		$this->setParametro('asegurado','asegurado','numeric');
        $this->setParametro('nro_hoja_ruta','nro_hoja_ruta','varchar');
        $this->setParametro('estado', 'estado', 'varchar');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function modificarPolizaBoleta(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='leg.ft_poliza_boleta_ime';
		$this->transaccion='LG_UPBSGAR_MOD';
		$this->tipo_procedimiento='IME';//tipo de transaccion

        $this->setParametro('origen','origen','varchar');
		$this->setParametro('id_anexo','id_anexo','integer');
		$this->setParametro('fecha_fin_uso','fecha_fin_uso','date');
		$this->setParametro('nro_hoja_ruta','nro_hoja_ruta','varchar');
		$this->setParametro('id_contrato','id_contrato','integer');
        $this->setParametro('id_institucion','id_institucion','integer');
        $this->setParametro('id_proveedor','id_proveedor','integer');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('nro_documento','nro_documento','varchar');
		$this->setParametro('fecha_desde','fecha_desde','date');
		$this->setParametro('fecha_hasta','fecha_hasta','date');
		$this->setParametro('asegurado','asegurado','numeric');
        $this->setParametro('observaciones','observaciones','text');
        $this->setParametro('estado', 'estado', 'varchar');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function eliminarPolizaBoleta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='leg.ft_poliza_boleta_ime';
		$this->transaccion='LG_DEBSGAR_ELI';
		$this->tipo_procedimiento='IME';

		//Define los parametros para la funcion
		$this->setParametro('id_anexo','id_anexo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function listarContratoBoleta (){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='leg.ft_poliza_boleta_sel';
		$this->transaccion='LG_CONTRA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		//lista de resultado query
		$this->captura('id_contrato','integer');
		$this->captura('nro_tramite','varchar');
		$this->captura('numero','varchar');
		$this->captura('tipo','varchar');
		$this->captura('objeto','text');
		$this->captura('estado','varchar');
		$this->captura('desc_proveedor','varchar');
		$this->captura('monto','numeric');
		$this->captura('moneda','varchar');
		$this->captura('fecha_inicio','date');
		$this->captura('fecha_fin','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo($this->consulta);exit;
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function listarBancos(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='leg.ft_poliza_boleta_sel';
		$this->transaccion='LG_LISTBAN_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		//lista de resultado query
		$this->captura('id_institucion','integer');
		$this->captura('nombre','varchar');
		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo($this->consulta);exit;
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function siguienteEstadoBoleta() {
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='leg.ft_poliza_boleta_ime';
        $this->transaccion='LEG_SIGESBOL_IME';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_proceso_wf_act','id_proceso_wf_act','int4');
        $this->setParametro('id_estado_wf_act','id_estado_wf_act','int4');
        $this->setParametro('id_funcionario_usu','id_funcionario_usu','int4');
        $this->setParametro('id_tipo_estado','id_tipo_estado','int4');
        $this->setParametro('id_funcionario_wf','id_funcionario_wf','int4');
        $this->setParametro('id_depto_wf','id_depto_wf','int4');
        $this->setParametro('obs','obs','text');
        $this->setParametro('json_procesos','json_procesos','text');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
	}

}
?>
