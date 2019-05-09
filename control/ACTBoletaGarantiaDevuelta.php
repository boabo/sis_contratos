<?php
/**
*@package pXP
*@file ACTBoletaGarantiaDevuelta.php
*@author  (breydi.vasquez)
*@date 
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTBoletaGarantiaDevuelta extends ACTbase{
					
	function listarBoletaGarantiaDevuelta(){				
        $this->objParam->defecto('ordenacion','id_cargo');

        $this->objParam->defecto('dir_ordenacion','asc');
						
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODBoletaGarantiaDevuelta','listarBoletaGarantiaDevuelta');
		} else{
			$this->objFunc=$this->create('MODBoletaGarantiaDevuelta');			
			$this->res=$this->objFunc->listarBoletaGarantiaDevuelta($this->objParam);
		}		
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function siguienteEstadoBoleta(){
		$this->objFunc=$this->create('MODBoletaGarantiaDevuelta');
        $this->res=$this->objFunc->siguienteEstadoBoleta($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }	

}

?>