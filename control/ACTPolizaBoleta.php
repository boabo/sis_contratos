<?php
/**
*@package pXP
*@file gen-ACTPolizaBoleta.php
*@author  (breydi.vasquez)
*@date 18-04-2018 20:02:21
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPolizaBoleta extends ACTbase{
					
	function listarPolizaBoleta(){
		//$fecha = $this->objParam->getParametro('fecha_fin_uso');
		
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
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
}

?>