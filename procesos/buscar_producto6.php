<?php

session_start();
include 'base.php';
conectarse();
$texto2 = $_GET['term'];
$consulta = pg_query("select * from productos where articulo  like '%$texto2%'");
while ($row = pg_fetch_row($consulta)) {
    $data[] = array(
        'value' => $row[3],
        'cod_producto2' => $row[0],
        'codigo2' => $row[1],
        'precio2' => $row[6],
        'disponibles' => $row[13]
    );
}

echo $data = json_encode($data);
?>
