<?php
include 'base.php';
//session_set_cookie_params(86400);   //supongamos que queremos 1 día
//setcookie('PHPSESSID', $_COOKIE['PHPSESSID'], time()+86400); 
//session_set_cookie_params(1);
conectarse();
$data="";
$cont=0;
session_start();
//ini_set("session.gc_maxlifetime","1"); 
$consulta = pg_query("select * from usuario where usuario='$_POST[usuario]' and clave='$_POST[clave]'");   
while ($row = pg_fetch_row($consulta)) {
	$cont=1;
	$_SESSION['id'] = $row[0];
	$_SESSION['nombres'] = $row[1]." ". $row[2] ;
	$_SESSION['cargo'] = $row[6];
	$_SESSION['user'] = $row[10];
}
	$_SESSION['empresa'] ="P&S Systems";
	$_SESSION['slogan'] ="Fabricación de Prendas de Vestir";
	$_SESSION['propietario'] ="FARINANGO LEÓN MARÍA EUGENIA";
	$_SESSION['direccion'] ="Matriz: Carlos Barahona 2-51 y Pasaje J / Sucursal: Sánchez y Cifuentes 15-37";
	$_SESSION['telefono'] ="062 953 734 / 5 000 192";
	$_SESSION['celular'] ="0993 740 497";
	$_SESSION['pais_ciudad'] ="Ibarra - Ecuador";
if($cont==1){
	$data=1;
	if($_SESSION['cargo']==3)	
	{
		$data=2;
	}
}
else{
	$data=0;
}
echo $data;

?>
