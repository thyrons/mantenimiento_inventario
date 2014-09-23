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
$result = pg_query("SELECT COUNT(*) AS count from factura_compra F, proveedores P, usuario U where F.id_proveedor = P.id_proveedor and F.id_usuario = U.id_usuario");
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
    $SQL = "select F.id_factura_compra, P.identificacion_pro, P.empresa_pro, F.num_serie, F.total_compra, F.fecha_actual from factura_compra F, proveedores P, usuario U where F.id_proveedor = P.id_proveedor and F.id_usuario = U.id_usuario ORDER BY $sidx $sord offset $start limit $limit";
} else {
    if ($_GET['searchOper'] == 'eq') {
        $SQL = "select F.id_factura_compra, P.identificacion_pro, P.empresa_pro, F.num_serie, F.total_compra, F.fecha_actual from factura_compra F, proveedores P, usuario U where F.id_proveedor = P.id_proveedor and F.id_usuario = U.id_usuario and $_GET[searchField] = '$_GET[searchString]' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'ne') {
        $SQL = "select F.id_factura_compra, P.identificacion_pro, P.empresa_pro, F.num_serie, F.total_compra, F.fecha_actual from factura_compra F, proveedores P, usuario U where F.id_proveedor = P.id_proveedor and F.id_usuario = U.id_usuarioand $_GET[searchField] != '$_GET[searchString]' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'bw') {
        $SQL = "select F.id_factura_compra, P.identificacion_pro, P.empresa_pro, F.num_serie, F.total_compra, F.fecha_actual from factura_compra F, proveedores P, usuario U where F.id_proveedor = P.id_proveedor and F.id_usuario = U.id_usuario and $_GET[searchField] like '$_GET[searchString]%' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'bn') {
        $SQL = "select F.id_factura_compra, P.identificacion_pro, P.empresa_pro, F.num_serie, F.total_compra, F.fecha_actual from factura_compra F, proveedores P, usuario U where F.id_proveedor = P.id_proveedor and F.id_usuario = U.id_usuario and $_GET[searchField] not like '$_GET[searchString]%' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'ew') {
        $SQL = "select F.id_factura_compra, P.identificacion_pro, P.empresa_pro, F.num_serie, F.total_compra, F.fecha_actual from factura_compra F, proveedores P, usuario U where F.id_proveedor = P.id_proveedor and F.id_usuario = U.id_usuario and $_GET[searchField] like '%$_GET[searchString]' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'en') {
        $SQL = "select F.id_factura_compra, P.identificacion_pro, P.empresa_pro, F.num_serie, F.total_compra, F.fecha_actual from factura_compra F, proveedores P, usuario U where F.id_proveedor = P.id_proveedor and F.id_usuario = U.id_usuario and $_GET[searchField] not like '%$_GET[searchString]' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'cn') {
        $SQL = "select F.id_factura_compra, P.identificacion_pro, P.empresa_pro, F.num_serie, F.total_compra, F.fecha_actual from factura_compra F, proveedores P, usuario U where F.id_proveedor = P.id_proveedor and F.id_usuario = U.id_usuario and $_GET[searchField] like '%$_GET[searchString]%' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'nc') {
        $SQL = "select F.id_factura_compra, P.identificacion_pro, P.empresa_pro, F.num_serie, F.total_compra, F.fecha_actual from factura_compra F, proveedores P, usuario U where F.id_proveedor = P.id_proveedor and F.id_usuario = U.id_usuario and $_GET[searchField] not like '%$_GET[searchString]%' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'in') {
        $SQL = "select F.id_factura_compra, P.identificacion_pro, P.empresa_pro, F.num_serie, F.total_compra, F.fecha_actual from factura_compra F, proveedores P, usuario U where F.id_proveedor = P.id_proveedor and F.id_usuario = U.id_usuario and $_GET[searchField] like '%$_GET[searchString]%' ORDER BY $sidx $sord offset $start limit $limit";
    }
    if ($_GET['searchOper'] == 'ni') {
        $SQL = "select F.id_factura_compra, P.identificacion_pro, P.empresa_pro, F.num_serie, F.total_compra, F.fecha_actual from factura_compra F, proveedores P, usuario U where F.id_proveedor = P.id_proveedor and F.id_usuario = U.id_usuario and $_GET[searchField] not like '%$_GET[searchString]%' ORDER BY $sidx $sord offset $start limit $limit";
    }
    //echo $SQL;
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
