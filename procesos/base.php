<?php
function conectarse() {/                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
	if (!($conexion = pg_connect("dbname=df2jp28bdkuafd host=ec2-54-204-32-91.compute-1.amazonaws.com port=5432 user=larfyvwbaurpxo password=WV84lJxFXf7aqF6BXCXgwcI-tC sslmode=require"))) {			
    //if (!($conexion = pg_connect("dbname=mantenimiento_inventario port=5432 user=postgres password=root host=localhost"))) {			
      
        exit();
    } else {         
    }
    return $conexion;
}
conectarse();
?>
