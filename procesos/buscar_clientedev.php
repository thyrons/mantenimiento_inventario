<?php

session_start();
include 'base.php';
conectarse();
$texto2 = $_GET['term'];

$consulta = pg_query("select * from clientes where tipo_documento = '$_GET[tipo_docu]' and identificacion like '%$texto2%'");
while ($row = pg_fetch_row($consulta)) {
    $data[] = array(
        'value' => $row[2],
        'id_cliente' => $row[0],
        'nombre_cli' => $row[3],
        'telefono_cli' => $row[6],
        'direccion_cli' => $row[5]
    );
}
echo $data = json_encode($data);
?>
