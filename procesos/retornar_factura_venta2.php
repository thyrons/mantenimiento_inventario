<?php

session_start();
include 'base.php';
conectarse();
error_reporting(0);
$id = $_GET['com'];
$arr_data = array();

$consulta = pg_query("select D.cod_productos, P.codigo, P.articulo, D.cantidad, D.precio_venta, D.descuento_producto, D.total_venta, P.iva, D.pendientes from factura_venta F, detalle_factura_venta D, productos P where D.cod_productos = P.cod_productos and F.id_factura_venta = D.id_factura_venta and D.id_factura_venta='" . $id . "'");
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
