<?php
function conectarse() {
	if (!($conexion = pg_pconnect("dbname=df2jp28bdkuafd host=ec2-54-204-32-91.compute-1.amazonaws.com port=5432 user=larfyvwbaurpxo password=WV84lJxFXf7aqF6BXCXgwcI-tC sslmode=require"))) {			   
        exit();
    } else {   
    echo "ok";      
    }
    return $conexion;
}
conectarse();

?>
