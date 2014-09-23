<?php
function conectarse() {
	if (!($conexion = pg_connect("dbname=dcf3ce05b4dp26 host=ec2-54-225-101-4.compute-1.amazonaws.com port=5432 user=zxldypgcuhasxn password=cNiUIdbRg8zzlbfa2NupQbHZVy sslmode=require"))) {			
    //if (!($conexion = pg_connect("dbname=mantenimiento_inventario port=5432 user=postgres password=root host=localhost"))) {			
        exit();
    } else {         
    }
    return $conexion;
}
conectarse();

?>
