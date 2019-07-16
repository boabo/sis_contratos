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

		$this->objParam->getParametro('tipo_interfaz')=='noIata' && $this->objParam->addFiltro("pobo.tipo_agencia=''noiata''");		
		
        if($this->objParam->getParametro('pes_estado')=='vigente'){        	
             $this->objParam->addFiltro("COALESCE(fecha_fin_uso, pobo.fecha_hasta) >= now() and (pobo.estado <> ''ficticia'' or pobo.estado is null)");
        }else{
        	$this->objParam->addFiltro("COALESCE(fecha_fin_uso, pobo.fecha_hasta) < now() and (pobo.estado <> ''ficticia'' or pobo.estado is null)");
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
			
		$this->objParam->getParametro('tipo_interfaz') == 'noiata' && $this->objParam->addFiltro("(pobo.tipo_agencia <> ''iata'' or pobo.tipo_agencia is null)");
		
		$this->objParam->getParametro('tipo_interfaz') == 'iata' && $this->objParam->addFiltro("(pobo.tipo_agencia = ''iata'' or pobo.origen=''iata'')");
		
        $this->objParam->getParametro('tipo_interfaz') == 'carga' && $this->objParam->addFiltro("(pobo.origen = ''carga'' or pobo.origen is null) and
        (pobo.tipo_agencia is null or tipo_agencia = '''' or pobo.tipo_agencia = ''corporativa''
        and pobo.banco not like ''%FICTICI%'')");
		
		$this->objParam->getParametro('tipo_interfaz') == 'servicio' && $this->objParam->addFiltro("pobo.origen = ''servicio''");
		
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

	function listarContratoBoleta(){
		$this->objParam->getParametro('id_proveedor')!='' && $this->objParam->addFiltro("con.id_proveedor"." = ".$this->objParam->getParametro('id_proveedor'));
		$this->objParam->getParametro('vista')=='noIata' && $this->objParam->addFiltro("con.tipo_agencia=''noiata''");
		$this->objParam->getParametro('vista')=='otros' && $this->objParam->addFiltro("con.tipo_agencia not in (''noiata'',''iata'')");
		$this->objParam->getParametro('vista')=='Iata' && $this->objParam->addFiltro("con.tipo_agencia=''iata''");					
		$this->objFunc=$this->create('MODPolizaBoleta');			
		$this->res=$this->objFunc->listarContratoBoleta($this->objParam);		
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function insertarPolizaBoleta(){
		$this->objFunc=$this->create('MODPolizaBoleta');	
		if($this->objParam->insertar('id_anexo')){
			$this->res=$this->objFunc->insertarPolizaBoleta($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPolizaBoleta($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());		
	}

	function eliminarPolizaBoleta(){
		$this->objFunc=$this->create('MODPolizaBoleta');
		$this->res=$this->objFunc->eliminarPolizaBoleta($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarBancos(){			
		$this->objFunc=$this->create('MODPolizaBoleta');			
		$this->res=$this->objFunc->listarBancos($this->objParam);		
		$this->res->imprimirRespuesta($this->res->generarJson());		
	}	
	
	function siguienteEstadoBoleta() {
        $this->objFunc=$this->create('MODPolizaBoleta');  
        
        $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]); 
        
        $this->res=$this->objFunc->siguienteEstadoBoleta($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());		
	}
    function mailBoletasGarantia(){

        $this->objFunc=$this->create('MODPolizaBoleta');
        $this->res=$this->objFunc->mailBoletasGarantia($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
        exit;
    }		
}

?>