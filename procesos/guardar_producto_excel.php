<?php
session_start();
include 'base.php';
conectarse();
error_reporting(0);

function soloNumeros($laCadena) {
    $carsValidos = "0123456789";
    for ($i=0; $i<strlen($laCadena); $i++) {
      if (strpos($carsValidos, substr($laCadena,$i,1))===false) {
         return false; 
      }
    }
    return true; 
}

if(soloNumeros($_POST[var8]) ){
    
  echo "1";  
    
} 

/////////////////comparar codigos/////////////////////
$contt = 0;
$consulta = pg_query("select * from productos where codigo='$_POST[var]' or cod_barras = '$_POST[var1]' or articulo = '$_POST[var2]'");
while ($row = pg_fetch_row($consulta)) {
    $contt++;
}
/////////////////////////////////////////////////////

if ($contt == 0) {
/////////////contador productos//////////
    $cont = 0;
    $consulta = pg_query("select max(cod_productos) from productos");
    while ($row = pg_fetch_row($consulta)) {
        $cont = $row[0];
    }
    $cont++;
////////////////////////////////////////
/////////////////guardar productos///////
    $valor = number_format($_POST[var5], 2, '.', '');
    $precio_minorista = (($_POST[var5] * $_POST[var6]/100) + $valor);
    $precio_mayorista = (($_POST[var5] * $_POST[var7]/100) + $valor);
    pg_query("insert into productos values('$cont','$_POST[var]','$_POST[var1]','$_POST[var2]','$_POST[var3]','$_POST[var4]','$valor','$_POST[var6]','$_POST[var7]','$precio_minorista','$precio_mayorista','','','$_POST[var8]','$_POST[var9]','$_POST[var8]','26-09-2014','','','$_POST[var10]','Activo','$_POST[var11]','0','0')");
////////////////////////////////////////
    $data = 1;
} else {
    $data = 2;
}

echo $data;
?>