<?php

include 'base.php';
conectarse();
error_reporting(0);
$cont = 0;

/////////////contador empresa/////////////

$consulta = pg_query("select * from empresa order by id_empresa asc");
while ($row = pg_fetch_row($consulta)) {
    $cont = $row[0];
}
$cont++;
/////////////////////////////////
//
///////////////valores imagen//////////
$extension = explode(".", $_FILES["archivo"]["name"]);

$extension = end($extension);
$type = $_FILES["archivo"]["type"];
$tmp_name = $_FILES["archivo"]["tmp_name"];
$size = $_FILES["archivo"]["size"];
$nombre = basename($_FILES["archivo"]["name"], "." . $extension);
//////////////////////////

$foto = $cont . '.' . $extension;
move_uploaded_file($_FILES["archivo"]["tmp_name"], "../fotos_empresa/" . $foto);

pg_query("insert into empresa values('$cont','$_POST[nombre_empresa]','$_POST[ruc_empresa]','$_POST[direccion_empresa]','$_POST[telefono_empresa]','$_POST[celular_empresa]','$_POST[fax_empresa]','$_POST[correo_empresa]','$_POST[pagina_empresa]','$_POST[descripcion_empresa]','$_POST[propietario_empresa]','$foto','Activo')");
$data = 1;
echo $data;
?>
