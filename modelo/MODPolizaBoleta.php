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
		//Ejecuta la instruccion
		$this->armarConsulta();
		//var_dump($this->consulta);exit; 
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
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		//var_dump($this->consulta);exit; 
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function RepBoletasGarantia() {
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='leg.ft_poliza_boleta_sel';
		$this->transaccion='LG_RBSGAR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		$this->setParametro('fecha_desde','fecha_desde','date');
		$this->setParametro('fecha_hasta','fecha_hasta','date');

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

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;		
	}
			
}
?>