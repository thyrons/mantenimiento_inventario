<?php

session_start();
include 'base.php';
conectarse();
error_reporting(0);

/////////////////eliminar clientes////////////////////
pg_query("delete  from clientes where id_cliente='$_POST[id_cliente]'");
//////////////////////////////////////////////////////

$data = 1;
echo $data;
?>