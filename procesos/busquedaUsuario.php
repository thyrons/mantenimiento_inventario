<?php

session_start();
include 'base.php';
conectarse();
$texto = $_GET['term'];

$consulta = pg_query("select * from usuario where nombre_usuario like '%$texto%' or apellido_usuario like '%$texto%'");
while ($row = pg_fetch_row($consulta)) {
    $data[] = array(
        'value' => $row[2] . " " . $row[1],
        'label' => $row[0]
    );
}
echo $data = json_encode($data);
?>
