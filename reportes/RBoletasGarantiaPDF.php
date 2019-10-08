<?php
require_once dirname(__FILE__) . '/../../pxp/lib/lib_reporte/ReportePDF.php';

class RBoletasGarantiaPDF extends ReportePDF
{

    function Header()
    {
        $this->SetMargins(15, 9, 2);
        $this->Ln(5);
        $url_imagen = dirname(__FILE__) . '/../../pxp/lib/images/Logo-BoA.png';
        $html = <<<EOF
		<style>
		table {		
   			border: 5px black dashed;
		}		
		</style>
		<body>
		<table border="1" cellpadding="2" cellspacing = "0">
        	<tr>
            	<th style="width: 20%;vertical-align:middle;" align="center" rowspan="2"><img src="$url_imagen" ></th>
        	</tr>
        </table>
EOF;

        $this->writeHTML($html);
        $this->Ln();
    }

    function setDatos($datos)
    {

        $this->datos = $datos;
        //var_dump( $this->datos);exit;
    }

    function generarReporte()
    {
    	$fecha_desde = $this->objParam->getParametro('fecha_desde');
		$fecha_hasta = $this->objParam->getParametro('fecha_hasta');
		$boleta = 'VIGENTES';
        if($this->objParam->getParametro('boleta_filtro')=='vencida') $boleta = 'VENCIDAS';
        else if($this->objParam->getParametro('boleta_filtro')=='ejecutado') $boleta = 'EJECUTADAS';	
        else if($this->objParam->getParametro('boleta_filtro')=='devuelto') $boleta = 'DEVUELTAS';        
         $gestion = strstr($fecha_hasta,'201');
        if($fecha_desde == '') $gestion;
        $this->headAgen('AGENCIAS DE VIAJES NO IATA','VCTO',$fecha_desde,$fecha_hasta,$boleta, $gestion);				
        $this->Ln();
        $contador=1;

        $this->tablewidths=array(8, 50, 40, 15, 75, 23, 23, 22, 20);
        $this->tablealigns=array('C','L','L','C','L','C','C','R','R');
        $sum_no_iata = 0;
        foreach($this->datos as $record){
            if ($record['tipo_agencia'] == 'noiata') {
                $this->SetFont('', '', 6);
                $this->SetFillColor(224, 235, 255);
                $this->SetTextColor(0);

                $this->tableborders = array('LB', 'BLR', 'BLR', 'BLR', 'BLR', 'BLR', 'BLR', 'BLR', 'RB');
                $this->tablenumbers = array(0, 0, 0, 0, 0, 0, 0, 2, 0);
                $tipo = ($record['tipo'] == 'boleta') ? 'BG' : 'PLZ';
                if($record['gestion'] != $record['gestion']) {
                    $this->SetFillColor(224, 235, 233);
                    $this->SetTextColor(0);
                    $this->tableborders = array('LB', 'BLR', 'BLR', 'BLR', 'BLR', 'BLR', 'BLR', 'BLR', 'RB');
                    $this->tablenumbers = array(0, 0, 0, 0, 0, 0, 0, 0, 0);
                    $RowArray = array(
                        's0' => '',
                        's1' => '',
                        's2' => '',
                        's3' => '',
                        's4' => $record['gestion'],
                        's5' => '',
                        's6' => '',
                        's7' => '',
                        's8' => ''
                    );
                }else {
                    $RowArray = array(
                        's0' => $contador,
                        's1' => $record['banco'],
                        's2' => $record['nro_documento'],
                        's3' => $tipo,
                        's4' => $record['agencia'],
                        's5' => $record['fecha_desde'],
                        's6' => $record['fecha_hasta'],
                        's7' => $record['asegurado'],
                        's8' => ''
                    );
                }
                $this->MultiRow($RowArray, true, 1);
                $sum_no_iata = $sum_no_iata + $record['asegurado'];
                $contador++;
            }
        }
        $this->SetFont('', 'B', 7);
        $this->Cell(188,6,'TOTAL AGENCIAS DE VIAJE','TBL',0,'C');
        $this->Cell(68,6,number_format($sum_no_iata,2,',','.'),'TBL',0,'R');
        $this->Cell(20,6,'','TBR',0,'C');

        $this->headAgen('AGENCIAS DE VIAJES IATA','VCTO',$fecha_desde,$fecha_hasta,$boleta, $gestion);
        $this->Ln();
        $sum_iata = 0;
        foreach($this->datos as $record){
            if ($record['tipo_agencia'] == 'iata' || $record['origen']=='iata') {
                $this->SetFont('', '', 6);
                $this->SetFillColor(224, 235, 255);
                $this->SetTextColor(0);

                $this->tableborders = array('LB', 'BLR', 'BLR', 'BLR', 'BLR', 'BLR', 'BLR', 'BLR', 'RB');
                $this->tablenumbers = array(0, 0, 0, 0, 0, 0, 0, 2, 0);
                $tipo = ($record['tipo'] == 'boleta') ? 'BG' : 'PLZ';
                $RowArray = array(
                    's0' => $contador,
                    's1' => $record['banco'],
                    's2' => $record['nro_documento'],
                    's3' => $tipo,
                    's4' => $record['agencia'],
                    's5' => $record['fecha_desde'],
                    's6' => $record['fecha_hasta'],
                    's7' => $record['asegurado'],
                    's8' => ''
                );
                $this->MultiRow($RowArray, true, 1);
                $sum_iata = $sum_iata + $record['asegurado'];
                $contador++;
            }
        }
        $this->SetFont('', 'B', 7);
        $this->Cell(188,6,'TOTAL AGENCIAS DE VIAJE','TBL',0,'C');
        $this->Cell(68,6,number_format($sum_iata,2,',','.'),'TBL',0,'R');
        $this->Cell(20,6,'','TBR',0,'C');
        $this->headAgen('GARGA','HASTA',$fecha_desde,$fecha_hasta,$boleta, $gestion);
        $this->Ln();
        $sum_carga = 0;
        foreach($this->datos as $record){
            if (($record['tipo_agencia'] == '' || $record['tipo_agencia'] == null  || $record['tipo_agencia'] == 'corporativa')&&( $record['origen'] == 'carga' || $record['origen'] == null)) {
                $this->SetFont('', '', 6);
                $this->SetFillColor(224, 235, 255);
                $this->SetTextColor(0);

                $this->tableborders = array('LB', 'BLR', 'BLR', 'BLR', 'BLR', 'BLR', 'BLR', 'BLR', 'RB');
                $this->tablenumbers = array(0, 0, 0, 0, 0, 0, 0, 2, 0);
                $tipo = ($record['tipo'] == 'boleta') ? 'BG' : 'PLZ';
                $RowArray = array(
                    's0' => $contador,
                    's1' => $record['banco'],
                    's2' => $record['nro_documento'],
                    's3' => $tipo,
                    's4' => $record['agencia'],
                    's5' => $record['fecha_desde'],
                    's6' => $record['fecha_hasta'],
                    's7' => $record['asegurado'],
                    's8' => ''
                );
                $this->MultiRow($RowArray, true, 1);
                $sum_carga = $sum_carga + $record['asegurado'];
                $contador++;
            }
        }

        $total_general = $sum_no_iata + $sum_iata + $sum_serv + $sum_carga;
        $this->SetFont('', 'B', 7);
        $this->SetDrawColor(0, 0, 0, 50);
        $this->SetFillColor(0, 0, 0, 100);
        $this->cell(58,6,'','TBL',0,'c');
        $this->Cell(176,6,'TOTAL CARGA','TBL',0,'C');
        $this->Cell(22,6,number_format($sum_carga,2,',','.'),'TBL',0,'R');
        $this->Cell(20,6,'','TBRL',1,'C');
        
        $this->headAgen('SERVICIOS','HASTA',$fecha_desde,$fecha_hasta,$boleta, $gestion);
        $this->Ln();
        $sum_serv = 0;
        foreach($this->datos as $record){
            if ($record['origen'] == 'servicio') {
                $this->SetFont('', '', 6);
                $this->SetFillColor(224, 235, 255);
                $this->SetTextColor(0);

                $this->tableborders = array('LB', 'BLR', 'BLR', 'BLR', 'BLR', 'BLR', 'BLR', 'BLR', 'RB');
                $this->tablenumbers = array(0, 0, 0, 0, 0, 0, 0, 2, 0);
                $tipo = ($record['tipo'] == 'boleta') ? 'BG' : 'PLZ';
                $RowArray = array(
                    's0' => $contador,
                    's1' => $record['banco'],
                    's2' => $record['nro_documento'],
                    's3' => $tipo,
                    's4' => $record['agencia'],
                    's5' => $record['fecha_desde'],
                    's6' => $record['fecha_hasta'],
                    's7' => $record['asegurado'],
                    's8' => ''
                );
                $this->MultiRow($RowArray, true, 1);
                $sum_serv = $sum_serv + $record['asegurado'];
                $contador++;
            }
        }
        $total_general = $sum_no_iata + $sum_iata + $sum_serv + $sum_carga;
        $this->SetFont('', 'B', 7);
        $this->SetDrawColor(0, 0, 0, 50);
        $this->SetFillColor(0, 0, 0, 100);
        $this->cell(58,6,'','TBL',0,'c');
        $this->Cell(176,6,'TOTAL SERVICIOS Bs','TBL',0,'C');
        $this->Cell(22,6,number_format($sum_serv,2,',','.'),'TBL',0,'R');
        $this->Cell(20,6,'','TBRL',1,'C');

        $this->cell(58,6,'','TBL',0,'c');
        $this->Cell(176,6,'TOTAL AGENCIAS DE VIAJE NO IATA','TBL',0,'C');
        $this->Cell(22,6, number_format($sum_no_iata,2,',','.'),'TBL',0,'R');
        $this->Cell(20,6,'','TBRL',1,'C');
        $this->cell(58,6,'','TBL',0,'c');
        $this->Cell(176,6,'TOTAL AGENCIAS DE VIAJE IATA','TBL',0,'C');
        $this->Cell(22,6, number_format($sum_iata,2,',','.'),'TBL',0,'R');
        $this->Cell(20,6,'','TBRL',1,'C');
        $this->cell(58,6,'','TBL',0,'c');
        $this->Cell(176,6,'TOTAL CARGA Bs','TBL',0,'C');
        $this->Cell(22,6, number_format($sum_carga,2,',','.'),'TBL',0,'R');
        $this->Cell(20,6,'','TBRL',1,'C');
        $this->cell(58,6,'','TBL',0,'c');        
        $this->Cell(176,6,'TOTAL CARGA USD','TBL',0,'C');
        $this->Cell(22,6,'0,00','TRBL',0,'R');
        $this->Cell(20,6,'','TBRL',1,'C');
        $this->cell(58,6,'','TBL',0,'c');
        $this->Cell(176,6,'TOTAL GENERAL Bs','TBL',0,'C');
        $this->Cell(22,6,number_format($total_general,2,',','.'),'TBRL',0,'R');
        $this->Cell(20,6,'','TBRL',0,'C');

    }
    function headAgen($agen,$hasta,$fecha_desde,$fecha_hasta,$bol, $gestion) {
        $this->AddPage();
        $this->SetMargins(2, 10, 2);
        $this->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);
        $this->SetFont('','B',10);
        $this->Cell(0,5,"DETALLE DE POLIZAS Y BOLETAS DE GARANTIA",0,1,'C');
        $this->Cell(0,5,"$agen"." ".$bol,0,1,'C');
        if($fecha_desde == '') {
            $this->Cell(0,5," GESTION ".$gestion,0,1,'C');
        }else{
            $this->Cell(0,5,"DEL: ".$fecha_desde." AL ".$fecha_hasta,0,1,'C');
        }
        $this->Ln(10);

        $this->SetFont('','B',6);
        $h = 6;
        $h1 = 4;

        //primera linea
        $this->Cell(8,$h1,'','',0,'C');
        $this->Cell(60,$h1,'BG: Boleta de garantia','',0,'C');
        $this->Cell(40,$h1,' PLZ: Poliza de Boleta','',0,'C');
        $this->Cell(80,$h1,'','',0,'C');

        $this->Cell(46,$h1,'FECHA DE COBERTURA','TRL',0,'C');
        $this->Cell(42,$h1,'VALOR','TRL',0,'C');

        $this->Cell(17,$h1,'','',0,'C');
        $this->Cell(17,$h1,'','',0,'C');
        $this->Cell(19,$h1,'','',1,'C');

        //segunda linea
        $this->Cell(8,$h,'N°','TBRL',0,'C');
        $this->Cell(50,$h,'COMPAÑIA ASEGURADORA','TBRL',0,'C');
        $this->Cell(40,$h,'N° DE POLIZA','TBRL',0,'C');
        $this->Cell(15,$h,'TIPO','TBRL',0,'C');

        $this->Cell(75,$h,'AGENCIA DE TURISMO','TBRL',0,'C');

        $this->Cell(23,$h,'DESDE','TBRL',0,'C');
        $this->Cell(23,$h,$hasta,'TBRL',0,'C');
        $this->Cell(22,$h,'ASEGURADO Bs.','TBRL',0,'C');
        $this->Cell(20,$h,'ASEGURADO USD.','TBRL',0,'C');
    }
}

?>