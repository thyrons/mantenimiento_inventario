<?php

session_start();
include 'base.php';
conectarse();
error_reporting(0);
$id = $_GET['com'];
$arr_data = array();

$consulta = pg_query("select F.forma_pago, P.adelanto, P.meses, P.monto_credito from pagos_compra P, factura_compra F where F.forma_pago = 'Credito' and F.id_factura_compra = P.id_factura_compra and P.id_factura_compra='" . $id . "'");
while ($row = pg_fetch_row($consulta)) {
    $arr_data[] = $row[0];
    $arr_data[] = $row[1];
    $arr_data[] = $row[2];
    $arr_data[] = $row[3];
}
echo json_encode($arr_data);
?>
