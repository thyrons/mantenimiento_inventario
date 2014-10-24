﻿$(document).on("ready", inicio);
function evento(e) {
    e.preventDefault();
}

$(function() {
    $('#main-menu').smartmenus({
        subMenusSubOffsetX: 1,
        subMenusSubOffsetY: -8
    });
});

function scrollToBottom() {
    $('html, body').animate({
        scrollTop: $(document).height()
    }, 'slow');
}

function scrollToTop() {
    $('html, body').animate({
        scrollTop: 0
    }, 'slow');
}

var dialogos =
{
    autoOpen: false,
    resizable: false,
    width: 860,
    height: 350,
    modal: true
};

var dialogos_categoria =
{
    autoOpen: false,
    resizable: false,
    width: 230,
    height: 180,
    modal: true
};

var dialogos_marca =
{
    autoOpen: false,
    resizable: false,
    width: 230,
    height: 180,
    modal: true
};

var dialogo3 =
{
    autoOpen: false,
    resizable: false,
    width: 400,
    height: 210,
    modal: true,
    position: "top",
    show: "explode",
    hide: "blind"    
}

var dialogo4 ={
    autoOpen: false,
    resizable: false,
    width: 240,
    height: 150,
    modal: true,
    position: "top",
    show: "explode",
    hide: "blind"
}

function abrirDialogo() {
    $("#productos").dialog("open");
}

function abrirCategoria() {
    $("#categorias").dialog("open");
}

function abrirMarca() {
    $("#marcas").dialog("open");
}

function descativar() {
    $("#utilidad_minorista").removeAttr("disabled");
    $("#utilidad_mayorista").removeAttr("disabled");
}

function guardar_producto() {
    if ($("#cod_prod").val() === "") {
        $("#cod_prod").focus();
        alertify.alert("Indique un Código");
    } else {
            if ($("#nombre_art").val() === "") {
                $("#nombre_art").focus();
                alertify.alert("Nombre del producto");
            } else {
                if ($("#iva").val() === "") {
                    $("#iva").focus();
                    alertify.alert("Seleccione una opción");
                } else {
                    if ($("#precio_compra").val() === "") {
                        $("#precio_compra").focus();
                        alertify.alert("Indique un precio");
                    } else {
                        if ($("#series").val() === "") {
                            $("#series").focus();
                            alertify.alert("Seleccione una opción");
                        } else {
                            if ($("#utilidad_minorista").val() === "") {
                                $("#utilidad_minorista").focus();
                                alertify.alert("Ingrese la utilidad al minorista");
                            } else {
                                if ($("#utilidad_mayorista").val() === "") {
                                    $("#utilidad_mayorista").focus();
                                    alertify.alert("Ingrese la utilidad al mayorista");
                                } else {
                                    if ($("#fecha_creacion").val() === "") {
                                        $("#fecha_creacion").focus();
                                        alertify.alert("Indique una fecha");
                                    }else{
                                        $.ajax({
                                            type: "POST",
                                            url: "../procesos/guardar_productos.php",
                                            data: "cod_prod=" + $("#cod_prod").val() + "&cod_barras=" + $("#cod_barras").val()
                                            + "&nombre_art=" + $("#nombre_art").val() + "&iva=" + $("#iva").val() + "&series=" + $("#series").val()
                                            + "&precio_compra=" + $("#precio_compra").val() + "&utilidad_minorista=" + $("#utilidad_minorista").val()
                                            + "&utilidad_mayorista=" + $("#utilidad_mayorista").val() + "&precio_minorista=" + $("#precio_minorista").val()
                                            + "&precio_mayorista=" + $("#precio_mayorista").val() + "&categoria=" + $("#categoria").val()
                                            + "&marca=" + $("#marca").val() + "&stock=" + $("#stock").val()
                                            + "&minimo=" + $("#minimo").val() + "&maximo=" + $("#maximo").val()
                                            + "&fecha_creacion=" + $("#fecha_creacion").val() + "&vendible=" + $("#vendible").val()
                                            + "&modelo=" + $("#modelo").val() + "&aplicacion=" + $("#aplicacion").val() + "&descuento=" + $("#descuento").val()+ "&inventario=" + $("#inventario").val(),
                                            success: function(data) {
                                                var val = data;
                                                if (val == 1)
                                                {
                                                    alertify.alert("Datos Guardados Correctamente",function(){location.reload();});
                                                }
                                            }
                                        });
                                        
                                    }
                                }
                            }
                    }
                }
            }
        }
    }
}


function modificar_producto() {
    if ($("#cod_productos").val() === "") {
        alertify.alert("Seleccione un producto");
    } else {
        if ($("#cod_prod").val() === "") {
            $("#cod_prod").focus();
            alertify.alert("Indique un Código");
        } else {
                if ($("#nombre_art").val() === "") {
                    $("#nombre_art").focus();
                    alertify.alert("Nombre del producto");
                } else {
                    if ($("#iva").val() === "") {
                        $("#iva").focus();
                        alertify.alert("Seleccione una opción");
                    } else {
                        if ($("#precio_compra").val() === "") {
                            $("#precio_compra").focus();
                            alertify.alert("Indique un precio");
                        } else {
                            if ($("#series").val() === "") {
                                $("#series").focus();
                                alertify.alert("Seleccione una opción");
                            } else {
                                if ($("#utilidad_minorista").val() === "") {
                                    $("#utilidad_minorista").focus();
                                    alertify.alert("Ingrese la utilidad al minorista");
                                } else {
                                    if ($("#utilidad_mayorista").val() === "") {
                                        $("#utilidad_mayorista").focus();
                                        alertify.alert("Ingrese la utilidad al mayorista");
                                    } else {
                                        if ($("#fecha_creacion").val() === "") {
                                            $("#fecha_creacion").focus();
                                            alertify.alert("Indique una fecha");
                                        }else{
                                            $.ajax({
                                                type: "POST",
                                                url: "../procesos/modificar_productos.php",
                                                data: "cod_prod=" + $("#cod_prod").val() + "&cod_barras=" + $("#cod_barras").val() + "&cod_productos=" + $("#cod_productos").val()
                                                + "&nombre_art=" + $("#nombre_art").val() + "&iva=" + $("#iva").val() + "&series=" + $("#series").val()
                                                + "&precio_compra=" + $("#precio_compra").val() + "&utilidad_minorista=" + $("#utilidad_minorista").val()
                                                + "&utilidad_mayorista=" + $("#utilidad_mayorista").val() + "&precio_minorista=" + $("#precio_minorista").val()
                                                + "&precio_mayorista=" + $("#precio_mayorista").val() + "&categoria=" + $("#categoria").val()
                                                + "&marca=" + $("#marca").val() + "&stock=" + $("#stock").val()
                                                + "&minimo=" + $("#minimo").val() + "&maximo=" + $("#maximo").val()
                                                + "&fecha_creacion=" + $("#fecha_creacion").val() + "&vendible=" + $("#vendible").val()
                                                + "&modelo=" + $("#modelo").val() + "&aplicacion=" + $("#aplicacion").val() + "&descuento=" + $("#descuento").val()+ "&inventario=" + $("#inventario").val(),
                                                success: function(data) {
                                                    var val = data;
                                                    if (val == 1)
                                                    {
                                                        alertify.alert("Datos Modificados Correctamente",function(){location.reload();});
                                                    }
                                                }
                                            });
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }


function eliminar_productos() {
    if ($("#cod_productos").val() === "") {
        alertify.alert("Seleccione un producto");
    } else {
        $("#clave_permiso").dialog("open");  
    }
}

function validar_acceso(){
    if($("#clave").val() == ""){
        $("#clave").focus();
        alertify.alert("Ingrese la clave");
    }else{
        $.ajax({
            url: '../procesos/validar_acceso.php',
            type: 'POST',
            data: "clave=" + $("#clave").val(),
            success: function(data) {
                var val = data;
                if (val == 0) {
                    $("#clave").val("");
                    $("#clave").focus();
                    alertify.alert("Error... La clave es incorrecta ingrese nuevamente");
                } else {
                    if (val == 1) {
                        $("#seguro").dialog("open");   
                    }
                }
            }
        });
    }   
}

function aceptar(){
$.ajax({
        type: "POST",
        url: "../procesos/eliminar_productos.php",
        data: "cod_productos=" + $("#cod_productos").val(),
        success: function(data) {
            var val = data;
            if (val == 1) {
                alertify.alert("Producto Eliminado Correctamente",function(){location.reload();});
            }
        }
    }); 
}

function cancelar(){
    $("#seguro").dialog("close");   
    $("#clave_permiso").dialog("close");    
    $("#clave").val("");    
}

function cancelar_acceso(){
    $("#clave_permiso").dialog("close");     
    $("#clave").val("");
}

function nuevo_producto() {
    location.reload();
}

function agregar_categoria() {
    if ($("#nombre_categoria").val() === "") {
        $("#nombre_categoria").focus();
        alertify.alert("Nombre Categoria");
    }else{
        $.ajax({
            type: "POST",
            url: "../procesos/guardar_categoria.php",
            data: "nombre_categoria=" + $("#nombre_categoria").val(),
            success: function(data) {
                var val = data;
                if (val == 1) {
                    $("#nombre_categoria").val("");
                    $("#categoria").load("../procesos/categorias_combos.php");
                    $("#categorias").dialog("close");
                }
            }
        });
    }
}

function agregar_marca() {
    if ($("#nombre_marca").val() === "") {
        $("#nombre_marca").focus();
        alertify.alert("Nombre Marca");
    }else{
        $.ajax({
            type: "POST",
            url: "../procesos/guardar_marca.php",
            data: "nombre_marca=" + $("#nombre_marca").val(),
            success: function(data) {
                var val = data;
                if (val == 1) {
                    $("#nombre_marca").val("");
                    $("#marca").load("../procesos/marcas_combos.php");
                    $("#marcas").dialog("close");
                }
            }
        });
    }
}

function Valida_punto() {
    var key;
    if (window.event)
    {
        key = event.keyCode;
    } else if (event.which)
{
        key = event.which;
    }

    if (key < 48 || key > 57)
    {
        if (key === 46 || key === 8)
        {
            return true;
        } else {
            return false;
        }
    }
    return true;
}

function ValidNum() {
    if (event.keyCode < 48 || event.keyCode > 57) {
        event.returnValue = false;
    }
    return true;
}

function inicio() {
     jQuery().UItoTop({ easingType: 'easeOutQuart' });
    /////////////////verificar repetidos/////////////
    /////valida si ya existe/////
    $("#cod_prod").blur(function() {
        if ($("#cod_prod").val().length > 0) {
            $.ajax({
                type: "POST",
                url: "../procesos/comparar_codigo.php",
                data: "codigo=" + $("#cod_prod").val(),
                success: function(data) {
                    var val = data;
                    if (val == 1) {
                        $("#cod_prod").val("");
                        $("#cod_prod").focus();
                        alertify.alert("Error... El código ya existe");
                    }
                }
            });
        }
    });
    /////////////////////////////////////////////////

    /////////atributos/////////////
    $("#utilidad_minorista").attr("disabled", "disabled");
    $("#utilidad_minorista").attr("maxlength", "5");
    $("#utilidad_mayorista").attr("disabled", "disabled");
    $("#utilidad_mayorista").attr("maxlength", "5");
    $("#precio_compra").keypress(Valida_punto);
    $("#utilidad_minorista").keypress(ValidNum);
    $("#utilidad_mayorista").keypress(ValidNum);
    $("#stock").keypress(ValidNum);
    $("#stock").attr("maxlength", "5");
    $("#maximo").keypress(ValidNum);
    $("#maximo").attr("maxlength", "5");
    $("#minimo").keypress(ValidNum);
    $("#minimo").attr("maxlength", "5");
    ////////////////////////////

    $("#precio_compra").on("keyup", descativar);

    /////////botones/////////////
    $("#btnCategoria").click(function(e) {
        e.preventDefault();
    });
    $("#btnMarca").click(function(e) {
        e.preventDefault();
    });
    $("#btnGuardarCategoria").click(function(e) {
        e.preventDefault();
    });
    $("#btnGuardarMarca").click(function(e) {
        e.preventDefault();
    });
    
    $("#btnGuardar").click(function(e) {
        e.preventDefault();
    });
    $("#btnModificar").click(function(e) {
        e.preventDefault();
    });
    $("#btnEliminar").click(function(e) {
        e.preventDefault();
    });
    $("#btnBuscar").click(function(e) {
        e.preventDefault();
    });
    $("#btnNuevo").click(function(e) {
        e.preventDefault();
    });

    $("#btnGuardarCategoria").on("click", agregar_categoria);
    $("#btnGuardarMarca").on("click", agregar_marca);
    $("#btnGuardar").on("click", guardar_producto);
    $("#btnModificar").on("click", modificar_producto);
    $("#btnNuevo").on("click", nuevo_producto);
    $("#btnCategoria").on("click", abrirCategoria);
    $("#btnMarca").on("click", abrirMarca);
    $("#btnBuscar").on("click", abrirDialogo);
    $("#btnEliminar").on("click", eliminar_productos);
    $("#btnAceptar").on("click", aceptar);
    $("#btnSalir").on("click", cancelar);
    $("#btnAcceder").on("click", validar_acceso);
    $("#btnCancelar").on("click", cancelar_acceso);
    
    $("#productos").dialog(dialogos);
    $("#categorias").dialog(dialogos_categoria);
    $("#marcas").dialog(dialogos_marca);
    $("#clave_permiso").dialog(dialogo3);
    $("#seguro").dialog(dialogo4);
    ///////////////////////////////////////////////
    
    /////////calendarios///////
    $("#fecha_creacion").datepicker({
        dateFormat: 'yy-mm-dd'
    });
    //////////////////////////

    ////calcular datos/////
    $("#utilidad_minorista").keyup(function() {
        if ($("#utilidad_minorista").val() === "") {
            $("#precio_minorista").val("");
        } else {
            var precio_minorista = ((parseFloat($("#precio_compra").val()) * parseFloat($("#utilidad_minorista").val())) / 100) + parseFloat($("#precio_compra").val());
            var entero = precio_minorista.toFixed(2);
            $("#precio_minorista").val(entero);
        }
    });

    $("#utilidad_mayorista").keyup(function() {
        if ($("#utilidad_mayorista").val() === "") {
            $("#precio_mayorista").val("");
        } else {
            var precio_mayorista = ((parseFloat($("#precio_compra").val()) * parseFloat($("#utilidad_mayorista").val())) / 100) + parseFloat($("#precio_compra").val());
            var entero2 = precio_mayorista.toFixed(2);
            $("#precio_mayorista").val(entero2);
        }
    });
//////////////////////////

    //////////////tabla Productos////////////////
    jQuery("#list").jqGrid({
        url: '../xml/datos_productos.php',
        datatype: 'xml',
        colNames: ['ID', 'CÓDIGO', 'CÓDIGO BARRAS', 'ARTICULO', 'IVA', 'SERIES', 'PRECIO COMPRA', 'UTILIDAD MINORISTA', 'PRECIO MINORISTA', 'UTILIDAD MAYORISTA', 'PRECIO MAYORISTA', 'CATEGORIA', 'MARCA', 'DESCUENTO', 'STOCK', 'MÍNIMO', 'MÁXIMO', 'FECHA COMPRA', 'CARACTERISTICAS', 'OBSERVACIONES', 'ESTADO','INVENTARIABLE'],
        colModel: [
            {name: 'cod_productos', index: 'cod_productos', editable: true, align: 'center', width: '60', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'cod_prod', index: 'cod_prod', editable: true, align: 'center', width: '120', search: true, frozen: true, formoptions: {elmsuffix: " (*)"}, editrules: {required: true}},
            {name: 'cod_barras', index: 'cod_barras', editable: true, align: 'center', width: '120', search: true, frozen: true, formoptions: {elmsuffix: " (*)"}, editrules: {required: true}},
            {name: 'nombre_art', index: 'nombre_art', editable: true, align: 'center', width: '180', search: true, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'iva', index: 'iva', editable: true, align: 'center', width: '50', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'series', index: 'series', editable: true, align: 'center', width: '50', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'precio_compra', index: 'precio_compra', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'utilidad_minorista', index: 'utilidad_minorista', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'precio_minorista', index: 'precio_minorista', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'utilidad_mayorista', index: 'utilidad_mayorista', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'precio_mayorista', index: 'precio_mayorista', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'categoria', index: 'categoria', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'marca', index: 'marca', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'descuento', index: 'descuento', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'stock', index: 'stock', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'minimo', index: 'minimo', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'maximo', index: 'maximo', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'fecha_creacion', index: 'fecha_creacion', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'modelo', index: 'modelo', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'aplicacion', index: 'aplicacion', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'vendible', index: 'vendible', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'inventario', index: 'inventario', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}}
        ],
        rowNum: 10,
        width: 830,
        rowList: [10, 20, 30],
        pager: jQuery('#pager'),
        sortname: 'cod_productos',
        shrinkToFit: false,
        sortorder: 'asc',
        caption: 'Lista de Productos',
        editurl: 'procesos/estadio_del.php',
        viewrecords: true,
         ondblClickRow: function(){
         var id = jQuery("#list").jqGrid('getGridParam', 'selrow');
         jQuery('#list').jqGrid('restoreRow', id);   
         jQuery("#list").jqGrid('GridToForm', id, "#productos_form");
         $("#btnGuardar").attr("disabled", true);
         $("#productos").dialog("close");
         }
    }).jqGrid('navGrid', '#pager',
            {
                add: false,
                edit: false,
                del: false,
                refresh: true,
                search: true,
                view: false
            },
    {
        recreateForm: true, closeAfterEdit: true, checkOnUpdate: true, reloadAfterSubmit: true, closeOnEscape: true
    },
    {
        reloadAfterSubmit: true, closeAfterAdd: true, checkOnUpdate: true, closeOnEscape: true,
        bottominfo: "Todos los campos son obligatorios son obligatorios"
    },
    {
        width: 300, closeOnEscape: true
    },
    {
        closeOnEscape: true,
        multipleSearch: false, overlay: false
    },
    {
    },
            {
                closeOnEscape: true
            }
    );
    /////////////////		
    jQuery("#list").jqGrid('navButtonAdd', '#pager', {caption: "Añadir",
        onClickButton: function() {
            var id = jQuery("#list").jqGrid('getGridParam', 'selrow');
            jQuery('#list').jqGrid('restoreRow', id);
            //var ret = jQuery("#list").jqGrid('getRowData', id);
            if (id) {
                jQuery("#list").jqGrid('GridToForm', id, "#productos_form");
                $("#btnGuardar").attr("disabled", true);
                $("#productos").dialog("close");
            } else {
                alertify.alert("Seleccione un fila");
            }

        }
    });
    ///////////////////fin tabla productos////////////   
}


