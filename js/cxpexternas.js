$(document).on("ready", inicio);
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

var dialogo2 =
{
    autoOpen: false,
    resizable: false,
    width: 800,
    height: 350,
    modal: true,
    position: "top",
    show: "explode",
    hide: "blind"    
}

function show() {
    var Digital = new Date();
    var hours = Digital.getHours();
    var minutes = Digital.getMinutes();
    var seconds = Digital.getSeconds();
    var dn = "AM";
    if (hours > 12) {
        dn = "PM";
        hours = hours - 12;
    }
    if (hours === 0)
        hours = 12;
    if (minutes <= 9)
        minutes = "0" + minutes;
    if (seconds <= 9)
        seconds = "0" + seconds;
    $("#hora_actual").val(hours + ":" + minutes + ":" + seconds + " " + dn);

    setTimeout("show()", 1000);
}

function enter(e) {
    if (e.which === 13 || e.keyCode === 13) {
        comprobar();
        return false;
    }
    return true;
}

function autocompletar() {
    var temp = "";
    var serie = $("#serie3").val();
    for (var i = serie.length; i < 9; i++) {
        temp = temp + "0";
    }
    return temp;
}

function comprobar() {
    if ($("#tipo_docu").val() === "") {
        $("#tipo_docu").focus();
        alertify.alert("Seleccione tipo documento");
    } else {
        if ($("#empresa").val() === "") {
            $("#ruc_ci").focus();
            alertify.alert("Indique una empresa");
        } else {
            if ($("#tipo_comprobante").val() === "") {
                $("#tipo_comprobante").focus();
                alertify.alert("Seleccione tipo comprobante");
            } else {
                if ($("#serie1").val() === "") {
                    $("#serie1").focus();
                } else {
                    if ($("#serie2").val() === "") {
                        $("#serie2").focus();
                    } else {
                        if ($("#serie3").val() === "") {
                            $("#serie3").focus();
                        } else {
                            if($("#serie1").val() != "" && $("#serie2").val() != "" && $("#serie3").val() != ""){
                                var a = autocompletar($("#serie3").val());
                                $("#serie3").val(a + "" + $("#serie3").val());
                                $("#tipo_documento").focus();
                            }else{
                                if ($("#total").val() === "") {
                                    $("#total").focus();
                                    alertify.alert("Ingrese el total de la factura");
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


function guardar_cxp() {
    if ($("#tipo_docu").val() === "") {
        $("#tipo_docu").focus();
        alertify.alert("Seleccione tipo documento");
    } else {
        if ($("#empresa").val() === "") {
            $("#ruc_ci").focus();
            alertify.alert("Indique una empresa");
        } else {
            if ($("#tipo_comprobante").val() === "") {
                $("#tipo_comprobante").focus();
                alertify.alert("Seleccione tipo comprobante");
            } else {
                if ($("#serie1").val() === "") {
                    alertify.alert("Ingrese la serie");
                    $("#serie1").focus();
                } else {
                    if ($("#serie2").val() === "") {
                        alertify.alert("Ingrese la serie");
                        $("#serie2").focus();
                    } else {
                        if ($("#serie3").val() === "") {
                            alertify.alert("Ingrese la serie");
                            $("#serie3").focus();
                        } else {
                            var num_fac = $("#serie1").val() + "-" + $("#serie2").val() + "-" + $("#serie3").val();
                            $.ajax({
                                type: "POST",
                                url: "../procesos/comparar_num_compra.php",
                                data: "num_fac=" + num_fac + "&id_proveedor=" + $("#id_proveedor").val(),
                                success: function(data) {
                                    var val = data;
                                    if (val == 1) {
                                        $("#serie3").val("");
                                        $("#serie3").focus();
                                        alertify.alert("Error... El número de factura ya existe");
                                    }else{
                                        if ($("#tipo_documento").val() === "") {
                                            $("#tipo_documento").focus();
                                            alertify.alert("Seleccione un documento");
                                        }else{
                                            if ($("#total").val() === "") {
                                                $("#total").focus();
                                                alertify.alert("Ingrese el total de la factura");
                                            }else{
                                                var num_factura = ($("#serie1").val() + "-" + $("#serie2").val() + "-" + $("#serie3").val()); 
                                                $.ajax({
                                                    type: "POST",
                                                    url: "../procesos/guardar_cxpexternas.php",
                                                    data: "id_proveedor=" + $("#id_proveedor").val() + "&comprobante=" + $("#comprobante").val() + "&fecha_actual=" + $("#fecha_actual").val() + "&hora_actual=" + $("#hora_actual").val() + "&num_factura=" + num_factura + "&tipo_documento=" + $("#tipo_documento").val() + "&total=" + $("#total").val(),
                                                    success: function(data) {
                                                        val = data;
                                                        if (val == 1) {
                                                            alertify.alert("Registro Guardado correctamente", function(){location.reload();});
                                                        }
                                                    }
                                                });
                                            }
                                        }
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

function flecha_atras(){
    $.ajax({
        type: "POST",
        url: "../procesos/flechas.php",
        data: "comprobante=" + $("#comprobante").val() + "&tabla=" + "c_pagarexternas" + "&id_tabla=" + "id_c_pagarexternas" + "&tipo=" + 1,
        success: function(data) {
            var val = data;
            if(val != ""){
                $("#comprobante").val(val);
                var valor = $("#comprobante").val();
                
                //////////////////////////////////////////////////
                $("#btnGuardar").attr("disabled", true);
                $("#btnModificar").attr("disabled", true);
                $("#ruc_ci").attr("disabled", "disabled");
                $("#nombres_completos").attr("disabled", "disabled");
                $("#serie1").attr("disabled", "disabled");
                $("#serie2").attr("disabled", "disabled");
                $("#serie3").attr("disabled", "disabled");
                $("#total").attr("disabled", "disabled");
                $("#id_proveedor").val("");
                $("#ruc_ci").val("");
                $("#empresa").val("");
                $("#serie1").val("");
                $("#serie2").val("");
                $("#serie3").val("");
                $("#total").val("");
                
                ///////////////////llamar cuentas flechas primera parte/////
                $.getJSON('../procesos/retornar_cuentas_externas2.php?com=' + valor, function(data) {
                    var tama = data.length;
                    if (tama !== 0) {
                        for (var i = 0; i < tama; i = i + 11)
                        {
                            $("#fecha_actual").val(data[i]);
                            $("#hora_actual").val(data[i + 1 ]);
                            $("#digitador").val(data[i + 2 ] + " " + data[i + 3 ] );
                            $("#tipo_docu").val(data[i + 4]);
                            $("#id_proveedor").val(data[i + 5]);
                            $("#ruc_ci").val(data[i + 6]);
                            $("#empresa").val(data[i + 7]);
                            var num_factura = data[i + 8];
                            var ser1 = num_factura.substr(0, 3)
                            var ser2 = num_factura.substr(4, 3)
                            var ser3 = num_factura.substr(8, 20)
                            $("#serie1").val(ser1);
                            $("#serie2").val(ser2);
                            $("#serie3").val(ser3);
                            $("#tipo_documento").val(data[i + 9]);
                            $("#total").val(data[i + 10]);
                        }
                    }
                });
                }else{
                alertify.alert("No hay mas registros posteriores!!");
            }
        }
    });
}

function flecha_siguiente(){
   $.ajax({
        type: "POST",
        url: "../procesos/flechas.php",
        data: "comprobante=" + $("#comprobante").val() + "&tabla=" + "c_pagarexternas" + "&id_tabla=" + "id_c_pagarexternas" + "&tipo=" + 2,
        success: function(data) {
            var val = data;
            if(val != ""){
                $("#comprobante").val(val);
                var valor = $("#comprobante").val();
                
                /////////////////////////////////////////////////
                $("#btnGuardar").attr("disabled", true);
                $("#btnModificar").attr("disabled", true);
                $("#ruc_ci").attr("disabled", "disabled");
                $("#nombres_completos").attr("disabled", "disabled");
                $("#serie1").attr("disabled", "disabled");
                $("#serie2").attr("disabled", "disabled");
                $("#serie3").attr("disabled", "disabled");
                $("#total").attr("disabled", "disabled");
                $("#id_proveedor").val("");
                $("#ruc_ci").val("");
                $("#empresa").val("");
                $("#serie1").val("");
                $("#serie2").val("");
                $("#serie3").val("");
                $("#total").val("");
                
                 ///////////////////llamar cuentas flechas primera parte/////
                $.getJSON('../procesos/retornar_cuentas_externas2.php?com=' + valor, function(data) {
                    var tama = data.length;
                    if (tama !== 0) {
                        for (var i = 0; i < tama; i = i + 11)
                        {
                            $("#fecha_actual").val(data[i]);
                            $("#hora_actual").val(data[i + 1 ]);
                            $("#digitador").val(data[i + 2 ] + " " + data[i + 3 ] );
                            $("#tipo_docu").val(data[i + 4]);
                            $("#id_proveedor").val(data[i + 5]);
                            $("#ruc_ci").val(data[i + 6]);
                            $("#empresa").val(data[i + 7]);
                            var num_factura = data[i + 8];
                            var ser1 = num_factura.substr(0, 3)
                            var ser2 = num_factura.substr(4, 3)
                            var ser3 = num_factura.substr(8, 20)
                            $("#serie1").val(ser1);
                            $("#serie2").val(ser2);
                            $("#serie3").val(ser3);
                            $("#tipo_documento").val(data[i + 9]);
                            $("#total").val(data[i + 10]);
                        }
                    }
                });
                }else{
                alertify.alert("No hay mas registros superiores!!");
            }
        }
    });
}

function limpiar_campo(){
    if($("#ruc_ci").val() === ""){
        $("#id_proveedor").val("");
        $("#empresa").val("");
    }
}

function limpiar_cuenta(){
    location.reload(); 
}

function inicio() {
    //////////////para hora///////////
    show();
    ///////////////////

    ///////botones ///////////////////
    $("#btnGuardar").click(function(e) {
        e.preventDefault();
    });
    $("#btnModificar").click(function(e) {
        e.preventDefault();
    });

    $("#btnNuevo").click(function(e) {
        e.preventDefault();
    });
    $("#btnAtras").click(function(e) {
        e.preventDefault();
    });
    $("#btnAdelante").click(function(e) {
        e.preventDefault();
    });

    $("#btnGuardar").on("click", guardar_cxp);
    $("#btnNuevo").on("click", limpiar_cuenta);
    $("#btnAtras").on("click", flecha_atras);
    $("#btnAdelante").on("click", flecha_siguiente);
    //////////////////////////

    $("#ruc_ci").on("keyup", limpiar_campo);
    /////////////////////////////////
    $("#serie1").validCampoFranz("0123456789");
    $("#serie1").attr("maxlength", "3");
    $("#serie2").validCampoFranz("0123456789");
    $("#serie2").attr("maxlength", "3");
    $("#serie3").validCampoFranz("0123456789");
    $("#serie3").attr("maxlength", "9");
    ///////////////////////////////////////////

    /////////////////////////// 
    $("#buscar_cartera_pagar").dialog(dialogo2);
    $("#btnBuscar").click(function(e) {
        e.preventDefault();
        $("#buscar_cartera_pagar").dialog("open");   
    });
    /////////////////////////// 


    ////////////////eventos////////////////////
    //$("input[type=text]").on("keyup", enter);

    $("#ruc_ci").on("keypress", enter);
    $("#empresa").on("keypress", enter);
    $("#serie1").on("keypress", enter);
    $("#serie2").on("keypress", enter);
    $("#serie3").on("keypress", enter);
    $("#total").on("keypress", enter);
    /////////////////////////////////////////

    //////////atributos////////////
    $("#ruc_ci").attr("disabled", "disabled");
    $("#empresa").attr("disabled", "disabled");
    /////////////////////////////////

    ///////////calendarios/////
    $('#fecha_actual').datepicker({
        dateFormat: 'yy-mm-dd'
    });
    
    ///////////total//////////////
    $("#total").keypress(function(e) {
        var key;
        if (window.event)
        {
            key = e.keyCode;
        }
        else if (e.which)
        {
            key = e.which;
        }

        if (key < 48 || key > 57)
        {
            if (key === 46 || key === 8)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        return true;
    });
    //////////////////////////////

    //////////////buscar proveedor///////////////////
    $("#tipo_docu").change(function() {
        var tipo = $("#tipo_docu").val();
        if (tipo === "Cedula") {
            $("#ruc_ci").validCampoFranz("0123456789");
            $("#ruc_ci").removeAttr("disabled");
            $("#ruc_ci").attr("maxlength", "10");
            $("#ruc_ci").autocomplete({
                source: "../procesos/buscar_empresa.php?tipo_docu=" + tipo,
                minLength: 1,
                focus: function(event, ui) {
                $("#ruc_ci").val(ui.item.value);
                $("#empresa").val(ui.item.empresa);
                $("#id_proveedor").val(ui.item.id_proveedor);
                return false;
                },
                select: function(event, ui) {
                $("#ruc_ci").val(ui.item.value);
                $("#empresa").val(ui.item.empresa);
                $("#id_proveedor").val(ui.item.id_proveedor);
                return false;
                }

                }).data("ui-autocomplete")._renderItem = function(ul, item) {
                return $("<li>")
                .append("<a>" + item.value + "</a>")
                .appendTo(ul);
            };
            //////////////////////////////
            $("#ruc_ci").val("");
            $("#empresa").val("");
            $("#id_proveedor").val("");
        } else {
            if (tipo === "Ruc") {
                $("#ruc_ci").validCampoFranz("0123456789");
                $("#ruc_ci").removeAttr("disabled");
                $("#ruc_ci").removeAttr("maxlength");
                $("#ruc_ci").attr("maxlength", "13");
                $("#ruc_ci").autocomplete({
                    source: "../procesos/buscar_empresa.php?tipo_docu=" + tipo,
                    minLength: 1,
                    focus: function(event, ui) {
                    $("#ruc_ci").val(ui.item.value);
                    $("#empresa").val(ui.item.empresa);
                    $("#id_proveedor").val(ui.item.id_proveedor);
                    return false;
                    },
                    select: function(event, ui) {
                    $("#ruc_ci").val(ui.item.value);
                    $("#empresa").val(ui.item.empresa);
                    $("#id_proveedor").val(ui.item.id_proveedor);
                    return false;
                    }

                    }).data("ui-autocomplete")._renderItem = function(ul, item) {
                    return $("<li>")
                    .append("<a>" + item.value + "</a>")
                    .appendTo(ul);
                };
                //////////////////////////////
                $("#ruc_ci").val("");
                $("#empresa").val("");
                $("#id_proveedor").val("");
            } else {
                if (tipo === "Pasaporte") {
                    $("#ruc_ci").unbind("keypress");
                    $("#ruc_ci").removeAttr("disabled");
                    $("#ruc_ci").attr("maxlength", "30");
                    $("#ruc_ci").autocomplete({
                        source: "../procesos/buscar_empresa.php?tipo_docu=" + tipo,
                        minLength: 1,
                        focus: function(event, ui) {
                        $("#ruc_ci").val(ui.item.value);
                        $("#empresa").val(ui.item.empresa);
                        $("#id_proveedor").val(ui.item.id_proveedor);
                        return false;
                        },
                        select: function(event, ui) {
                        $("#ruc_ci").val(ui.item.value);
                        $("#empresa").val(ui.item.empresa);
                        $("#id_proveedor").val(ui.item.id_proveedor);
                        return false;
                        }

                        }).data("ui-autocomplete")._renderItem = function(ul, item) {
                        return $("<li>")
                        .append("<a>" + item.value + "</a>")
                        .appendTo(ul);
                    };
                    //////////////////////////////
                    $("#ruc_ci").val("");
                    $("#empresa").val("");
                    $("#id_proveedor").val("");
                }
            }
        }
    });
    
    ///////////calendarios/////
    $('#fecha_actual').datepicker({
        dateFormat: 'yy-mm-dd'
    });
    
       ////////////////////tabla facturas compra/////////////////////////
        jQuery("#list2").jqGrid({
        url: '../xml/xmlBuscarCuentasExternasPagar.php',
        datatype: 'xml',
        colNames: ['ID','IDENTIFICACIÓN','EMPRESA', 'FACTURA NRO.','MONTO TOTAL','FECHA'],
        colModel: [
            {name: 'id_c_pagarexternas', index: 'id_c_pagarexternas', editable: false, search: false, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 50},
            {name: 'identificacion_pro', index: 'identificacion_pro', editable: false, search: true, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 150},
            {name: 'empresa_pro', index: 'empresa_pro', editable: true, search: true, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 200},
            {name: 'num_serie', index: 'num_serie', editable: true, search: true, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 200},
            {name: 'total_compra', index: 'total_compra', editable: true, search: false, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 100},
            {name: 'fecha_compra', index: 'fecha_compra', editable: true, search: false, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 100},
        ],
        rowNum: 30,
        width: 750,
        height:220,
        sortable: true,
        rowList: [10, 20, 30],
        pager: jQuery('#pager2'),
        sortname: 'id_c_pagarexternas',
        sortorder: 'asc',
        viewrecords: true,              
        ondblClickRow: function(){
        var id = jQuery("#list2").jqGrid('getGridParam', 'selrow');
        jQuery('#list2').jqGrid('restoreRow', id);
        
        if (id) {
            var ret = jQuery("#list2").jqGrid('getRowData', id);
             //alert(ret.id_factura_venta);
            var valor = ret.id_c_pagarexternas;
            /////////////agregregar datos factura////////
            $("#comprobante").val(ret.id_c_pagarexternas);
            $("#btnGuardar").attr("disabled", true);
            $("#btnModificar").attr("disabled", true);
            $("#ruc_ci").attr("disabled", "disabled");
            $("#nombres_completos").attr("disabled", "disabled");
            $("#serie1").attr("disabled", "disabled");
            $("#serie2").attr("disabled", "disabled");
            $("#serie3").attr("disabled", "disabled");
            $("#total").attr("disabled", "disabled");
            $("#id_proveedor").val("");
            $("#ruc_ci").val("");
            $("#empresa").val("");
            $("#serie1").val("");
            $("#serie2").val("");
            $("#serie3").val("");
            $("#total").val("");
            $.getJSON('../procesos/retornar_cuentas_externas2.php?com=' + valor, function(data) {
                var tama = data.length;
                if (tama !== 0) {
                    for (var i = 0; i < tama; i = i + 11)
                    {
                        $("#fecha_actual").val(data[i]);
                        $("#hora_actual").val(data[i + 1 ]);
                        $("#digitador").val(data[i + 2 ] + " " + data[i + 3 ] );
                        $("#tipo_docu").val(data[i + 4]);
                        $("#id_proveedor").val(data[i + 5]);
                        $("#ruc_ci").val(data[i + 6]);
                        $("#empresa").val(data[i + 7]);
                        var num_factura = data[i + 8];
                        var ser1 = num_factura.substr(0, 3)
                        var ser2 = num_factura.substr(4, 3)
                        var ser3 = num_factura.substr(8, 20)
                        $("#serie1").val(ser1);
                        $("#serie2").val(ser2);
                        $("#serie3").val(ser3);
                        $("#tipo_documento").val(data[i + 9]);
                        $("#total").val(data[i + 10]);
                    }
                }
            });
         $("#buscar_cartera_pagar").dialog("close");
        } else {
          alertify.alert("Seleccione una Cuenta");
        }
    }
        
        }).jqGrid('navGrid', '#pager2',
        {
            add: false,
            edit: false,
            del: false,
            refresh: true,
            search: true,
            view: true
        },{
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
        });
        
       jQuery("#list2").jqGrid('navButtonAdd', '#pager2', {caption: "Añadir",
       onClickButton: function() {
        var id = jQuery("#list2").jqGrid('getGridParam', 'selrow');
        jQuery('#list2').jqGrid('restoreRow', id);
        if (id) {
           var ret = jQuery("#list2").jqGrid('getRowData', id);

            var valor = ret.id_c_pagarexternas;
            /////////////agregregar datos factura////////
            $("#comprobante").val(ret.id_c_pagarexternas);
            $("#btnGuardar").attr("disabled", true);
            $("#btnModificar").attr("disabled", true);
            $("#ruc_ci").attr("disabled", "disabled");
            $("#nombres_completos").attr("disabled", "disabled");
            $("#serie1").attr("disabled", "disabled");
            $("#serie2").attr("disabled", "disabled");
            $("#serie3").attr("disabled", "disabled");
            $("#total").attr("disabled", "disabled");
            $("#id_proveedor").val("");
            $("#ruc_ci").val("");
            $("#empresa").val("");
            $("#serie1").val("");
            $("#serie2").val("");
            $("#serie3").val("");
            $("#total").val("");
            $.getJSON('../procesos/retornar_cuentas_externas2.php?com=' + valor, function(data) {
                var tama = data.length;
                if (tama !== 0) {
                    for (var i = 0; i < tama; i = i + 11)
                    {
                        $("#fecha_actual").val(data[i]);
                        $("#hora_actual").val(data[i + 1 ]);
                        $("#digitador").val(data[i + 2 ] + " " + data[i + 3 ] );
                        $("#tipo_docu").val(data[i + 4]);
                        $("#id_proveedor").val(data[i + 5]);
                        $("#ruc_ci").val(data[i + 6]);
                        $("#empresa").val(data[i + 7]);
                        var num_factura = data[i + 8];
                        var ser1 = num_factura.substr(0, 3)
                        var ser2 = num_factura.substr(4, 3)
                        var ser3 = num_factura.substr(8, 20)
                        $("#serie1").val(ser1);
                        $("#serie2").val(ser2);
                        $("#serie3").val(ser3);
                        $("#tipo_documento").val(data[i + 9]);
                        $("#total").val(data[i + 10]);
                    }
                }
            });
            $("#buscar_cartera_pagar").dialog("close");
        } else {
          alertify.alert("Seleccione una Cuenta");
        }
    }
  });   

}




