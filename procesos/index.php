<?php

session_start();
include 'base.php';
conectarse();
$data = "";
$cont = 0;

$consulta = pg_query("select * from usuario where usuario='$_POST[usuario]' and clave='$_POST[clave]'");
while ($row = pg_fetch_row($consulta)) {
    $cont = 1;
    $_SESSION['id'] = $row[0];
    $_SESSION['nombres'] = $row[1] . " " . $row[2];
    $_SESSION['cargo'] = $row[6];
    $_SESSION['user'] = $row[10];
}

$_SESSION['empresa'] = "P&S Systems";
$_SESSION['slogan'] = "SERVICIOS INTEGRALES";
$_SESSION['propietario'] = "YEPEZ RIVERA PABLO SANTIAGO";
$_SESSION['direccion'] = "Av. Eugenio Espejo 9-66 y Juan Fransico Bonilla";
$_SESSION['telefono'] = "2603193";
$_SESSION['celular'] = "0987805075";
$_SESSION['pais_ciudad'] = "Ibarra - Ecuador";

if ($cont == 1) {
    $data = 1;
} else {
    $data = 0;
}

echo $data;
?>
