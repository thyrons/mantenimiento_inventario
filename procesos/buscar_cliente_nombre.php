<?php

session_start();
include 'base.php';
conectarse();
$texto = $_GET['term'];
$consulta = pg_query("select * from clientes where nombres_cli like '%$texto%'");
while ($row = pg_fetch_row($consulta)) {
    $data[] = array(
        'value' => $row[3],
        'id_cliente' => $row[0],
        'ruc_ci' => $row[2],
        'direccion_cliente' => $row[5],
        'telefono_cliente' => $row[6],
        'correo' => $row[10]
    );
}
echo $data = json_encode($data);
?>
