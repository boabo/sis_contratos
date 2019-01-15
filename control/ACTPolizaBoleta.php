<?php
/**
*@package pXP
*@file gen-ACTPolizaBoleta.php
*@author  (breydi.vasquez)
*@date 18-04-2018 20:02:21
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/
require_once(dirname(__FILE__).'/../reportes/RBoletasGarantiaPDF.php');

class ACTPolizaBoleta extends ACTbase{
					
	function listarPolizaBoleta(){
		//$fecha = $this->objParam->getParametro('fecha_fin_uso');
		//$this->objParam->defecto('ordenacion','fecha_hasta');
		//$this->objParam->defecto('dir_ordenacion','asc');
		
        if($this->objParam->getParametro('pes_estado')=='vigente'){
        	//$this->objParam->addFiltro("FUNCIO.id_funcionario= ".$_SESSION["_ID_FUNCIOANRIO_OFUS"]);
             $this->objParam->addFiltro("COALESCE(fecha_fin_uso, pobo.fecha_hasta) >= now()");
        }else{
        	$this->objParam->addFiltro("COALESCE(fecha_fin_uso, pobo.fecha_hasta) < now()");
        }
		 if($this->objParam->getParametro('filtro_campo')!=''){
            $this->objParam->addFiltro($this->objParam->getParametro('filtro_campo')." = ".$this->objParam->getParametro('filtro_valor'));  
        }
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPolizaBoleta','listarPolizaBoleta');
		} else{
			$this->objFunc=$this->create('MODPolizaBoleta');
			
			$this->res=$this->objFunc->listarPolizaBoleta($this->objParam);
			$temp = Array();
			$temp['total_asegurado'] = $this->res->extraData['total_asegurado'];
			$temp['tipo_reg'] = 'summary';
			$temp['id_contrato'] = 0;
			
			$this->res->total++;
			$this->res->addLastRecDatos($temp);
		}		
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarPolizaBoletaOtra(){
			
		if($this->objParam->getParametro('pes_estado')=='vigente'){
        	
             $this->objParam->addFiltro("COALESCE(fecha_fin_uso, pobo.fecha_hasta) >= now()");
        }else{
        	$this->objParam->addFiltro("COALESCE(fecha_fin_uso, pobo.fecha_hasta) < now()");
        }
		 if($this->objParam->getParametro('filtro_campo')!=''){
            $this->objParam->addFiltro($this->objParam->getParametro('filtro_campo')." = ".$this->objParam->getParametro('filtro_valor'));  
        }
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPolizaBoleta','listarPolizaBoletaOtra');
		} else{
			$this->objFunc=$this->create('MODPolizaBoleta');			
			$this->res=$this->objFunc->listarPolizaBoletaOtra($this->objParam);
			$temp = Array();
			$temp['total_asegurado'] = $this->res->extraData['total_asegurado'];
			$temp['tipo_reg'] = 'summary';
			$temp['id_contrato'] = 0;
			
			$this->res->total++;
			$this->res->addLastRecDatos($temp);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function RepBoletasGarantia(){

		$nombreArchivo = 'BoletasGarantia'.uniqid(md5(session_id())).'.pdf';
        $this->objFunc=$this->create('MODPolizaBoleta');
        $this->res=$this->objFunc->RepBoletasGarantia($this->objParam);		
	    
        //parametros basicoss
        $tamano = 'LETTER';
        $orientacion = 'L';
        $titulo = 'Consolidado';


        $this->objParam->addParametro('orientacion',$orientacion);
        $this->objParam->addParametro('tamano',$tamano);
        $this->objParam->addParametro('titulo_archivo',$titulo);
        $this->objParam->addParametro('nombre_archivo',$nombreArchivo);
		
		$this->objReporteFormato = new RBoletasGarantiaPDF($this->objParam);
		$this->objReporteFormato->setDatos($this->res->datos);
		$this->objReporteFormato->generarReporte();
		$this->objReporteFormato->output($this->objReporteFormato->url_archivo, 'F');

		$this->mensajeExito=new Mensaje();
		$this->mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado','Se generó con éxito el reporte: '.$nombreArchivo,'control');
		$this->mensajeExito->setArchivoGenerado($nombreArchivo);
		$this->mensajeExito->imprimirRespuesta($this->mensajeExito->generarJson());

	}
	
}

?>