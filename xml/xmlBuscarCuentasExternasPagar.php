<?php

session_start();
include '../procesos/base.php';
$page = $_GET['page'];
$limit = $_GET['rows'];
$sidx = $_GET['sidx'];
$sord = $_GET['sord'];
$search = $_GET['_search'];

if (!$sidx)
    $sidx = 1;
$result = pg_query("SELECT COUNT(*) AS count from c_pagarexternas CP, proveedores P, usuario U where CP.id_proveedor = P.id_proveedor and CP.id_usuario = U.id_usuario");
$row = pg_fetch_row($result);
$count = $row[0];
if ($count > 0 && $limit > 0) {
    $total_pages = ceil($count / $limit);
} else {
    $total_pages = 0;
}

if ($page > $total_pages)
    $page = $total_pages;
$start = $limit * $page - $limit;
if ($start < 0)
    $start = 0;
if ($search == 'false') {
    $SQL = "select CP.id_c_pagarexternas, P.identificacion_pro, P.empresa_pro, CP.num_factura, CP.total, CP.fecha_actual from c_pagarexternas CP, proveedores P, usuario U where CP.id_proveedor = P.id_proveedor and CP.id_usuario = U.id_usuario ORDER BY $sidx $sord offset $start limit $limit";
} else {
    if ($_GET['searchOper'] == 'eq') {
        $SQL = "select CP.id_c_pagarexternas, P.identificacion_pro, P.empresa_pro, CP.num_factura, CP.total, CP.fecha_actual from c_pagarexternas CP, proveedores P, usuario U where CP.id_proveedor = P.id_proveedor and CP.id_usuario = U.id_usuario and $_GET[searchField] = '$_GET[searchString]' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'ne') {
        $SQL = "select CP.id_c_pagarexternas, P.identificacion_pro, P.empresa_pro, CP.num_factura, CP.total, CP.fecha_actual from c_pagarexternas CP, proveedores P, usuario U where CP.id_proveedor = P.id_proveedor and CP.id_usuario = U.id_usuario and $_GET[searchField] != '$_GET[searchString]' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'bw') {
        $SQL = "select CP.id_c_pagarexternas, P.identificacion_pro, P.empresa_pro, CP.num_factura, CP.total, CP.fecha_actual from c_pagarexternas CP, proveedores P, usuario U where CP.id_proveedor = P.id_proveedor and CP.id_usuario = U.id_usuario and $_GET[searchField] like '$_GET[searchString]%' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'bn') {
        $SQL = "select CP.id_c_pagarexternas, P.identificacion_pro, P.empresa_pro, CP.num_factura, CP.total, CP.fecha_actual from c_pagarexternas CP, proveedores P, usuario U where CP.id_proveedor = P.id_proveedor and CP.id_usuario = U.id_usuario and $_GET[searchField] not like '$_GET[searchString]%' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'ew') {
        $SQL = "select CP.id_c_pagarexternas, P.identificacion_pro, P.empresa_pro, CP.num_factura, CP.total, CP.fecha_actual from c_pagarexternas CP, proveedores P, usuario U where CP.id_proveedor = P.id_proveedor and CP.id_usuario = U.id_usuario and $_GET[searchField] like '%$_GET[searchString]' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'en') {
        $SQL = "select CP.id_c_pagarexternas, P.identificacion_pro, P.empresa_pro, CP.num_factura, CP.total, CP.fecha_actual from c_pagarexternas CP, proveedores P, usuario U where CP.id_proveedor = P.id_proveedor and CP.id_usuario = U.id_usuario and $_GET[searchField] not like '%$_GET[searchString]' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'cn') {
        $SQL = "select CP.id_c_pagarexternas, P.identificacion_pro, P.empresa_pro, CP.num_factura, CP.total, CP.fecha_actual from c_pagarexternas CP, proveedores P, usuario U where CP.id_proveedor = P.id_proveedor and CP.id_usuario = U.id_usuario and $_GET[searchField] like '%$_GET[searchString]%' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'nc') {
        $SQL = "select CP.id_c_pagarexternas, P.identificacion_pro, P.empresa_pro, CP.num_factura, CP.total, CP.fecha_actual from c_pagarexternas CP, proveedores P, usuario U where CP.id_proveedor = P.id_proveedor and CP.id_usuario = U.id_usuario and $_GET[searchField] not like '%$_GET[searchString]%' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'in') {
        $SQL = "select CP.id_c_pagarexternas, P.identificacion_pro, P.empresa_pro, CP.num_factura, CP.total, CP.fecha_actual from c_pagarexternas CP, proveedores P, usuario U where CP.id_proveedor = P.id_proveedor and CP.id_usuario = U.id_usuario and $_GET[searchField] like '%$_GET[searchString]%' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'ni') {
        $SQL = "select CP.id_c_pagarexternas, P.identificacion_pro, P.empresa_pro, CP.num_factura, CP.total, CP.fecha_actual from c_pagarexternas CP, proveedores P, usuario U where CP.id_proveedor = P.id_proveedor and CP.id_usuario = U.id_usuario and $_GET[searchField] not like '%$_GET[searchString]%' ORDER BY $sidx $sord offset $start limit $limit";
    }
}

$result = pg_query($SQL);
header("Content-type: text/xml;charset=utf-8");
$s = "<?xml version='1.0' encoding='utf-8'?>";
$s .= "<rows>";
$s .= "<page>" . $page . "</page>";
$s .= "<total>" . $total_pages . "</total>";
$s .= "<records>" . $count . "</records>";
while ($row = pg_fetch_row($result)) {
    $s .= "<row id='" . $row[0] . "'>";
    $s .= "<cell>" . $row[0] . "</cell>";
    $s .= "<cell>" . $row[1] . "</cell>";
    $s .= "<cell>" . $row[2] . "</cell>";
    $s .= "<cell>" . $row[3] . "</cell>";
    $s .= "<cell>" . $row[4] . "</cell>";
    $s .= "<cell>" . $row[5] . "</cell>";
    $s .= "</row>";
}
$s .= "</rows>";
echo $s;
?>
