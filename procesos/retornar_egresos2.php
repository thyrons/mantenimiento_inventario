<?php

session_start();
include 'base.php';
conectarse();
error_reporting(0);
$id = $_GET['com'];
$arr_data = array();

$consulta = pg_query("select D.cod_productos, P.codigo, P.articulo, D.cantidad, D.precio_costo, D.descuento, D.total, P.iva_minorista, P.iva from egresos E, detalle_egreso D, productos P where D.cod_productos = P.cod_productos and E.id_egresos = D.id_egresos and D.id_egresos='" . $id . "'");
while ($row = pg_fetch_row($consulta)) {
    $arr_data[] = $row[0];
    $arr_data[] = $row[1];
    $arr_data[] = $row[2];
    $arr_data[] = $row[3];
    $arr_data[] = $row[4];
    $arr_data[] = $row[5];
    $arr_data[] = $row[6];
    $arr_data[] = $row[7];
    $arr_data[] = $row[8];
}
echo json_encode($arr_data);
?>
