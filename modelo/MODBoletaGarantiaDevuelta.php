<?php
/**
*@package pXP
*@file MODBoletaGarantiaDevuelta.php
*@author  (breydi.vasquez)
*@date  
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODBoletaGarantiaDevuelta extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			  
	function listarBoletaGarantiaDevuelta(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='leg.ft_boleta_garantia_dev_sel';
		$this->transaccion='LG_POBODEV_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
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
		$this->captura('nro_hoja_ruta','integer');
		$this->captura('id_contrato','integer');
		$this->captura('id_gestion','integer');
		$this->captura('gestion','integer');
		$this->captura('id_proveedor','integer');
		//Ejecuta la instruccion
		$this->armarConsulta();		
		//echo($this->consulta);exit;
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function siguienteEstadoBoleta(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='leg.ft_boleta_garantia_dev_ime';
        $this->transaccion='LG_POBODEV_IME';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_proceso_wf','id_proceso_wf','int4');               
		$this->setParametro('id_estado_wf','id_estado_wf','int4');
		$this->setParametro('id_anexo','id_anexo','int4');
		
		

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }		
}
?>