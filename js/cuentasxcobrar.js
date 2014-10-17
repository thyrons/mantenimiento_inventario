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

var dialogo =
{
    autoOpen: false,
    resizable: false,
    width: 530,
    height: 320,
    modal: true,
    position: "top",
    show: "explode",
    hide: "blind",
    Cancelar: function() {
        $(this).dialog("close");
        $('#list2').trigger('reloadGrid');
    }
};
var dialogo3 =
{
    autoOpen: false,
    resizable: false,
    width: 800,
    height: 350,
    modal: true,
    position: "top",
    show: "explode",
    hide: "blind"   
};

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

function enter1(e) {
    if (e.which === 13 || e.keyCode === 13) {
        entrar();
        return false;
    }
    return true;
}

function comprobar() {
    if ($("#id_cliente").val() === "") {
        $("#ruc_ci").focus();
        alertify.alert("Ingrese un cliente");
    } else {
        if ($("#ruc_ci").val() === "") {
            $("#ruc_ci").focus();
            alertify.alert("Identificación del cliente");
        }else{
            if ($("#forma_pago").val() === "") {
                $("#forma_pago").focus();
                alertify.alert("Error... Seleccione forma de pago");
            }
        }
    }
}

function entrar() {
    if ($("#num_factura").val() === "") {
        alertify.alert("Error... Seleccione una factura");
    } else {
        if ($("#valor_pagado").val() === "") {
            $("#valor_pagado").focus();
            alertify.alert("Ingrese un valor");
        } else {
            $("#list").jqGrid("clearGridData", true);
            var filas = jQuery("#list").jqGrid("getRowData");
            var su = 0;
            var saldo = 0;
            var valor = parseFloat($("#valor_pagado").val());
            var entero = ((valor).toFixed(2));
            saldo = (parseFloat($("#saldo2").val()) - parseFloat($("#valor_pagado").val()));
            var entero2 = ((saldo).toFixed(2));
            if (filas.length === 0) {
                var datarow = {ids_pagos: $("#ids").val(), num_factura: $("#num_factura").val(), tipo_factura: $("#tipo_factura").val(), fecha_factura: $("#fecha_factura").val(), totalcxc: $("#totalcxc").val(), valor_pagado: entero, saldo: entero2};
                su = jQuery("#list").jqGrid('addRowData', $("#num_factura").val(), datarow);
                ////////limpiar///////////
                $("#ids").val("");
                $("#num_factura").val("");
                $("#tipo_factura").val("");
                $("#fecha_factura").val("");
                $("#totalcxc").val("");
                $("#valor_pagado").val("");
                $("#saldo2").val("");
            ///////////////////////////
            }
        }
    }
}

function cargar_facturas(){
    var id = $("#id_cliente").val();
    if (id === "") {
        $("#num_factura").val("");
        $("#ruc_ci").focus();
        alertify.alert("Error... Seleccione un cliente");
    } else {
        $("#list2").jqGrid('setGridParam', {
            url: '../xml/xmlFacturas_venta.php?id_cliente=' + id + '&tipo=' + $("#tipo_pago").val()   , 
            datatype: 'xml'
        }).trigger('reloadGrid');
        $("#buscar_facturas").dialog("open");
    }
}

function guardar_pagos(){
    var tam = jQuery("#list").jqGrid("getRowData");

    if ($("#id_cliente").val() === "") {
        $("#ruc_ci").focus();
        alertify.alert("Ingrese un cliente");
    } else {
        if ($("#ruc_ci").val() === "") {
            $("#ruc_ci").focus();
            alertify.alert("Identificación del cliente");
        }else{
            if ($("#forma_pago").val() === "0") {
                $("#forma_pago").focus();
                alertify.alert("Error... Seleccione forma de pago");
            }else{
                if ($("#tipo_pago").val() === "") {
                    $("#tipo_pago").focus();
                    alertify.alert("Error... Seleccione tipo de pago");
                }else{
                    if (tam.length === 0) {
                        alertify.alert("Error... Ingrese un pago");
                    }else{
                        var v1 = new Array();
                        var v2 = new Array();
                        var v3 = new Array();
                        var v4 = new Array();
                        var v5 = new Array();
                        var v6 = new Array();
                        var v7 = new Array();
                        var string_v1 = "";
                        var string_v2 = "";
                        var string_v3 = "";
                        var string_v4 = "";
                        var string_v5 = "";
                        var string_v6 = "";
                        var string_v7 = "";
                        var fil = jQuery("#list").jqGrid("getRowData");
                        for (var i = 0; i < fil.length; i++) {
                            var datos = fil[i];
                            v1[i] = datos['ids_pagos'];
                            v2[i] = datos['num_factura'];
                            v3[i] = datos['tipo_factura'];
                            v4[i] = datos['fecha_factura'];
                            v5[i] = datos['totalcxc'];
                            v6[i] = datos['valor_pagado'];
                            v7[i] = datos['saldo'];
                        }
                        for (i = 0; i < fil.length; i++) {
                            string_v1 = string_v1 + "|" + v1[i];
                            string_v2 = string_v2 + "|" + v2[i];
                            string_v3 = string_v3 + "|" + v3[i];
                            string_v4 = string_v4 + "|" + v4[i];
                            string_v5 = string_v5 + "|" + v5[i];
                            string_v6 = string_v6 + "|" + v6[i];
                            string_v7 = string_v7 + "|" + v7[i];
                        }
                        
                        $.ajax({
                            type: "POST",
                            url: "../procesos/guardar_pagos_cobrar.php",
                            data: "id_cliente=" + $("#id_cliente").val() + "&comprobante=" + $("#comprobante").val() + "&fecha_actual=" + $("#fecha_actual").val() + "&hora_actual=" + $("#hora_actual").val() + "&forma_pago=" + $("#forma_pago").val() + "&tipo_pago=" + $("#tipo_pago").val() + "&observaciones=" + $("#observaciones").val() + "&campo1=" + string_v1 + "&campo2=" + string_v2 + "&campo3=" + string_v3 + "&campo4=" + string_v4 + "&campo5=" + string_v5 + "&campo6=" + string_v6+ "&campo7=" + string_v7 ,
                            success: function(data) {
                                var val = data;
                                if (val == 1) {
                                    if($("#tipo_pago").val()=="EXTERNA")
                                    {
                                        window.open("../reportes/reportes/reporte_cxc.php?tipo_pago="+$("#tipo_pago").val()+"&id="+v2[0]+"&comprobante="+$("#comprobante").val(),'_blank');
                                    }else{
                                        window.open("../reportes/reportes/reporte_cxc.php?tipo_pago="+$("#tipo_pago").val()+"&id="+v2[0]+"&comprobante="+$("#comprobante").val()+"&temp2="+v6[0]+"&temp3="+v7[0],'_blank');
                                    }    
                                    alertify.alert("Pago Guardado correctamente", function(){location.reload();});
                                }
                            }
                        });
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
        data: "comprobante=" + $("#comprobante").val() + "&tabla=" + "pagos_cobrar" + "&id_tabla=" + "id_cuentas_cobrar" + "&tipo=" + 1,
        success: function(data) {
            var val = data;
            if(val != ""){
                $("#comprobante").val(val);
                var valor = $("#comprobante").val();
                
                ///////////////////////////////////////////////////
                $("#btnGuardar").attr("disabled", true);
                $("#btnModificar").attr("disabled", true);
                $("#btnfacturas").attr("disabled", "disabled");
                $("#valor_pagado").attr("disabled", "disabled");
                $("#ruc_ci").attr("disabled", "disabled");
                $("#nombres_completos").attr("disabled", "disabled");
                $("#observaciones").attr("disabled", "disabled");
                $("#id_cliente").val("");
                $("#ruc_ci").val("");
                $("#nombres_completos").val("");
                $("#saldo").val("");
                $("#forma_pago").val(0);
                $('#tipo_pago').children().remove().end();
                $("#list").jqGrid("clearGridData", true);
                $("#tablaNuevo").css('display','none');

                ///////////////////llamar cuentas flechas primera parte/////
                $.getJSON('../procesos/retornar_pagos_venta.php?com=' + valor, function(data) {
                var tama = data.length;
                if (tama !== 0) {
                for (var i = 0; i < tama; i = i + 9)
                    {
                    $("#fecha_actual").val(data[i]);
                    $("#hora_actual").val(data[i + 1 ]);
                    $("#digitador").val(data[i + 2 ] + " " + data[i + 3 ] );
                    $("#id_cliente").val(data[i + 4]);
                    $("#ruc_ci").val(data[i + 5]);
                    $("#nombres_completos").val(data[i + 6]);
                    $("#forma_pago").val(data[i + 7]);
                    $("#tipo_pago").append('<option value='+data[i + 8]+' selected>'+data[i + 8]+'</option>');
                  }
                }
               });
             ///////////////////////////////////////////////////   

             ////////////////////llamar cuentas flechas segunda parte/////
                $.getJSON('../procesos/retornar_pagos_venta2.php?com=' + valor, function(data) {
                var tama = data.length;
                if (tama !== 0) {
                for (var i = 0; i < tama; i = i + 8)
                {
                   var datarow = {ids_pagos: data[i], num_factura: data[i + 1], tipo_factura: data[i + 2], fecha_factura: data[i + 3], totalcxc: data[i + 4], valor_pagado: data[i + 5], saldo: data[i + 6]};
                   var su = jQuery("#list").jqGrid('addRowData', data[i], datarow);
                   $("#observaciones").val(data[i + 7]);
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
        data: "comprobante=" + $("#comprobante").val() + "&tabla=" + "pagos_cobrar" + "&id_tabla=" + "id_cuentas_cobrar" + "&tipo=" + 2,
        success: function(data) {
            var val = data;
            if(val != ""){
                $("#comprobante").val(val);
                var valor = $("#comprobante").val();
                ////////////////////////////////////////////////
                $("#btnGuardar").attr("disabled", true);
                $("#btnModificar").attr("disabled", true);
                $("#btnfacturas").attr("disabled", "disabled");
                $("#valor_pagado").attr("disabled", "disabled");
                $("#ruc_ci").attr("disabled", "disabled");
                $("#nombres_completos").attr("disabled", "disabled");
                $("#observaciones").attr("disabled", "disabled");
                $("#id_cliente").val("");
                $("#ruc_ci").val("");
                $("#nombres_completos").val("");
                $("#saldo").val("");
                $("#forma_pago").val(0);
                $('#tipo_pago').children().remove().end();
                $("#list").jqGrid("clearGridData", true);
                $("#tablaNuevo").css('display','none');

                ///////////////////llamar pagos flechas primera parte/////
                $.getJSON('../procesos/retornar_pagos_venta.php?com=' + valor, function(data) {
                var tama = data.length;
                if (tama !== 0) {
                for (var i = 0; i < tama; i = i + 9)
                    {
                    $("#fecha_actual").val(data[i]);
                    $("#hora_actual").val(data[i + 1 ]);
                    $("#digitador").val(data[i + 2 ] + " " + data[i + 3 ] );
                    $("#id_cliente").val(data[i + 4]);
                    $("#ruc_ci").val(data[i + 5]);
                    $("#nombres_completos").val(data[i + 6]);
                    $("#forma_pago").val(data[i + 7]);
                    $("#tipo_pago").append('<option value='+data[i + 8]+' selected>'+data[i + 8]+'</option>');
                  }
                }
               });
             ///////////////////////////////////////////////////   

             ////////////////////llamar pagos flechas segunda parte/////
                $.getJSON('../procesos/retornar_pagos_venta2.php?com=' + valor, function(data) {
                var tama = data.length;
                if (tama !== 0) {
                for (var i = 0; i < tama; i = i + 8)
                {
                   var datarow = {ids_pagos: data[i], num_factura: data[i + 1], tipo_factura: data[i + 2], fecha_factura: data[i + 3], totalcxc: data[i + 4], valor_pagado: data[i + 5], saldo: data[i + 6]};
                   var su = jQuery("#list").jqGrid('addRowData', data[i], datarow);
                   $("#observaciones").val(data[i + 7]);
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
       $("#id_cliente").val("");
       $("#nombres_completos").val("");
       $("#saldo").val("");
       $("#forma_pago").val(0);
       $("#tipo_pago").val("");
       $("#list2").jqGrid("clearGridData", true);
    }
}

function limpiar_campo2(){
    if($("#nombres_completos").val() === ""){
       $("#id_cliente").val("");
       $("#ruc_ci").val("");
       $("#saldo").val("");
       $("#forma_pago").val(0);
       $("#tipo_pago").val("");
       $("#list2").jqGrid("clearGridData", true);
    }
}

function limpiar_cuenta(){
   location.reload(); 
}

function inicio() {
jQuery().UItoTop({ easingType: 'easeOutQuart' });
    //////////////para hora///////////
    show();
    ///////////////////

    //////////////botones//////////
    $("#buscar_cuentas_cobrar").dialog(dialogo3);

    $("#btnBuscar").click(function (){
        $("#buscar_cuentas_cobrar").dialog("open");   
    })
    $("#btnfacturas").click(function(e) {
        e.preventDefault();
    });
    
    $("#btnGuardar").click(function(e) {
        e.preventDefault();
    });
    
    $("#btnModificar").click(function(e) {
        e.preventDefault();
    });
    
    
    $("#btnNuevo").click(function(e) {
        e.preventDefault();
    });
    
    $("#btnImprimir").click(function (){
        var temp=0;
        var temp2=0;
        var temp3=0;
        var fil = jQuery("#list").jqGrid("getRowData");
        for (var i = 0; i < fil.length; i++) {
            var datos = fil[i];        
            temp = datos['num_factura'];    
            temp2 = datos['valor_pagado'];    
            temp3 = datos['saldo'];                            
        }
        if($("#tipo_pago").val()=="EXTERNA") {
            window.open("../reportes/reportes/reporte_cxc.php?tipo_pago="+$("#tipo_pago").val()+"&id="+temp+"&comprobante="+$("#comprobante").val(),'_blank');
        }else{
            window.open("../reportes/reportes/reporte_cxc.php?tipo_pago="+$("#tipo_pago").val()+"&id="+temp+"&comprobante="+$("#comprobante").val()+"&temp2="+temp2+"&temp3="+temp3,'_blank');
        }
    });
    
     $("#btnAtras").click(function(e) {
        e.preventDefault();
    });
    
    $("#btnAdelante").click(function(e) {
        e.preventDefault();
    });
    
    $("#valor_pagado").on("keyup",comprobar2);
    $("#btnfacturas").on("click", cargar_facturas);
    $("#btnGuardar").on("click", guardar_pagos);
    $("#btnNuevo").on("click", limpiar_cuenta);
    $("#btnAtras").on("click", flecha_atras);
    $("#btnAdelante").on("click", flecha_siguiente);
    
    
    $("#ruc_ci").on("keyup", limpiar_campo);
    $("#nombres_completos").on("keyup", limpiar_campo2);
    $("#buscar_facturas").dialog(dialogo);

     $("#valor_pagado").keypress(function(e) {
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
    ////////////////////////////////

    //////////////validaciones////////////
    $("#ruc_ci").on("keypress", enter);
    $("#valor_pagado").on("keypress", enter1);

    /////buscador clientes ci///// 
    $("#ruc_ci").autocomplete({
        source: "../procesos/buscar_cliente2.php",
        minLength: 1,
        focus: function(event, ui) {
        $("#ruc_ci").val(ui.item.value);
        $("#nombres_completos").val(ui.item.nombres_completos);
        $("#id_cliente").val(ui.item.id_cliente);
        $("#saldo").val(ui.item.saldo);
        return false;
        },
        select: function(event, ui) {
        $("#ruc_ci").val(ui.item.value);
        $("#nombres_completos").val(ui.item.nombres_completos);
        $("#id_cliente").val(ui.item.id_cliente);
        $("#saldo").val(ui.item.saldo);
        var id = $('#id_cliente').val();
        $('#tipo_pago').load('../procesos/cargar_tipo_pago.php?cod=' + id);
        return false;
        }
        }).data("ui-autocomplete")._renderItem = function(ul, item) {
        return $("<li>")
        .append("<a>" + item.value + "</a>")
        .appendTo(ul);
    };
    //////////////////////////////
    
     /////buscador clientes nombres///// 
    $("#nombres_completos").autocomplete({
        source: "../procesos/buscar_cliente_pagos.php",
        minLength: 1,
        focus: function(event, ui) {
        $("#nombres_completos").val(ui.item.value);
        $("#ruc_ci").val(ui.item.ruc_ci);
        $("#id_cliente").val(ui.item.id_cliente);
        $("#saldo").val(ui.item.saldo);
        return false;
        },
        select: function(event, ui) {
        $("#nombres_completos").val(ui.item.value);
        $("#ruc_ci").val(ui.item.ruc_ci);
        $("#id_cliente").val(ui.item.id_cliente);
        $("#saldo").val(ui.item.saldo);
        var id = $('#id_cliente').val();
        $('#tipo_pago').load('../procesos/cargar_tipo_pago.php?cod=' + id);
        return false;
        }
        }).data("ui-autocomplete")._renderItem = function(ul, item) {
        return $("<li>")
        .append("<a>" + item.value + "</a>")
        .appendTo(ul);
    };
    //////////////////////////////
    
    ///////////calendarios/////
    $('#fecha_actual').datepicker({
        dateFormat: 'yy-mm-dd'
    });

    ///////////tabla local/////////////   
        var can;
        jQuery("#list").jqGrid({
        datatype: "local",
        colNames: ['','id', 'Factura a Pagar', 'Tipo Factura', 'Fecha Factura', 'Total CxC', 'Valor a Pagar', 'Saldo'],
        colModel: [
            {name: 'myac', width: 50, fixed: true, sortable: false, resize: false, formatter: 'actions',
                formatoptions: {keys: false, delbutton: true, editbutton: false}
            },
            {name: 'ids_pagos', index: 'ids_pagos', editable: false, search: false, hidden: true, editrules: {edithidden: false}, align: 'center', frozen: true, width: 50},
            {name: 'num_factura', index: 'num_factura', editable: false, search: false, hidden: false, editrules: {edithidden: false}, align: 'center', frozen: true, width: 100},
            {name: 'tipo_factura', index: 'tipo_factura', editable: false, frozen: true, editrules: {required: true}, align: 'center', width: 150},
            {name: 'fecha_factura', index: 'fecha_factura', editable: false, frozen: true, editrules: {required: true}, align: 'center', width: 100},
            {name: 'totalcxc', index: 'totalcxc', editable: false, search: false, frozen: true, editrules: {required: true}, align: 'center', width: 110},
            {name: 'valor_pagado', index: 'valor_pagado', editable: false, frozen: true, editrules: {required: true}, align: 'center', width: 100},
            {name: 'saldo', index: 'saldo', editable: false, search: false, frozen: true, editrules: {required: true}, align: 'center', width: 100},
        ],
        rowNum: 30,
        width: 750,
        sortable: true,
        rowList: [10, 20, 30],
        pager: jQuery('#pager'),
        sortorder: 'asc',
        viewrecords: true,
        cellEdit: true,
        cellsubmit: 'clientArray',
        shrinkToFit: true,
        delOptions: {
            modal: true,
            jqModal: true,
            onclickSubmit: function(rp_ge, rowid) {
                var id = jQuery("#list").jqGrid('getGridParam', 'selrow');
                jQuery('#list').jqGrid('restoreRow', id);
                var ret = jQuery("#list").jqGrid('getRowData', id);
                rp_ge.processing = true;
                var su = jQuery("#list").jqGrid('delRowData', rowid);
                $(".ui-icon-closethick").trigger('click');
                return true;
            },
            processing: true
        }
    });

//////////busqueda facturas////////
jQuery("#list2").jqGrid({
    url: '../xml/xmlFacturas_compra.php',
    datatype: 'xml',
    colNames: ['ID', 'Factura a Pagar', 'Tipo Factura', 'Fecha Factura', 'Total CxC', 'Valor a Pagar', 'Saldo'],
        colModel: [
            {name: 'ids', index: 'ids', editable: false, search: false, hidden: true, editrules: {edithidden: false}, align: 'center',
                frozen: true, width: 50},
            {name: 'num_factura', index: 'num_factura', editable: false, search: false, hidden: false, editrules: {edithidden: false}, align: 'center',
                frozen: true, width: 180},
            {name: 'tipo_factura', index: 'tipo_factura', editable: false, frozen: true, hidden: true, editrules: {required: true}, align: 'center', width: 250},
            {name: 'fecha_factura', index: 'fecha_factura', editable: true, frozen: true, hidden: true, editrules: {required: true}, align: 'center', width: 180},
            {name: 'totalcxc', index: 'totalcxc', editable: true, search: false, frozen: true, hidden: true, editrules: {required: true}, align: 'center', width: 110},
            {name: 'valor_pagado', index: 'valor_pagado', editable: true, frozen: true, hidden: true, editrules: {required: true}, align: 'center', width: 120},
            {name: 'saldo', index: 'saldo', editable: false, search: false, frozen: true, hidden: false, editrules: {required: true}, align: 'center', width: 110},
        ],
    rowNum: 10,
    width: 500,
    rowList: [10, 20, 30],
    pager: jQuery('#pager2'),
    shrinkToFit: true,
    sortorder: 'asc',
    caption: 'Lista de Facturas',
    editurl: '../procesos/facturas_del.php',
    viewrecords: true,
    ondblClickRow: function(rowid){
        var id = jQuery("#list2").jqGrid('getGridParam', 'selrow');
        jQuery('#list2').jqGrid('restoreRow', id);
        if (id) {
           var ret = jQuery("#list2").jqGrid('getRowData', id);
           $("#ids").val(ret.ids);
           $("#num_factura").val(ret.num_factura);
           $("#tipo_factura").val(ret.tipo_factura);
           $("#fecha_factura").val(ret.fecha_factura);
           $("#totalcxc").val(ret.totalcxc);
           $("#saldo2").val(ret.saldo);
           
            //////////////////////
            $("#buscar_facturas").dialog("close");
            if($("#tipo_pago").val() == "INTERNA"){
              $("#tablaNuevo tbody").empty(); 
              $.ajax({
                type: "POST",
		url: "../procesos/buscar_pagos.php",	
		data: "id="+ret.ids,
		dataType: 'json',
		success: function(response) {
                $("#tablaNuevo").css('display','inline-table');
                for (var i = 0; i < response.length; i=i+3) {
                        $("#tablaNuevo tbody").append( "<tr>" +
                        "<td align=center >" + response[i+0] + "</td>" +
                        "<td align=center>" + response[i+1] + "</td>" +	            
                        "<td align=center>" + response[i+2] + "</td>" +                        	
                       "<tr>");                    
                    }
               }                    
           });
          }else{
             $("#tablaNuevo").css('display','none'); 
          }
            $("#valor_pagado").focus();
            $("#list").jqGrid("clearGridData", true);
        } else {
          alertify.alert("Seleccione una Cuenta");
        }
    }
}).jqGrid('navGrid', '#pager2', {
    add: false,
    edit: false,
    del: false,
    refresh: true,
    search: false,
    view: true
});
/////////////////	

jQuery("#list2").jqGrid('navButtonAdd', '#pager2', {caption: "Añadir",
    onClickButton: function() {
        var id = jQuery("#list2").jqGrid('getGridParam', 'selrow');
        jQuery('#list2').jqGrid('restoreRow', id);
        if (id) {
           var ret = jQuery("#list2").jqGrid('getRowData', id);
           $("#ids").val(ret.ids);
           $("#num_factura").val(ret.num_factura);
           $("#tipo_factura").val(ret.tipo_factura);
           $("#fecha_factura").val(ret.fecha_factura);
           $("#totalcxc").val(ret.totalcxc);
           $("#saldo2").val(ret.saldo);
           
            //////////////////////
           $("#buscar_facturas").dialog("close");
           if($("#tipo_pago").val() == "INTERNA"){
              $("#tablaNuevo tbody").empty(); 
              $.ajax({
                type: "POST",
		url: "../procesos/buscar_pagos.php",	
		data: "id="+ret.ids,
		dataType: 'json',
		success: function(response) {
                $("#tablaNuevo").css('display','inline-table');
                for (var i = 0; i < response.length; i=i+3) {
                        $("#tablaNuevo tbody").append( "<tr>" +
                        "<td align=center >" + response[i+0] + "</td>" +
                        "<td align=center>" + response[i+1] + "</td>" +	            
                        "<td align=center>" + response[i+2] + "</td>" +                        	
                       "<tr>");                    
                    }
               }                    
           });
          }else{
             $("#tablaNuevo").css('display','none'); 
          }
          $("#valor_pagado").focus();
          $("#list").jqGrid("clearGridData", true);
        } else {
          alertify.alert("Seleccione una Cuenta");
        }
    }
});

//////////// BUSCAR CUENTRAS POR COBRAR/////////
    jQuery("#list3").jqGrid({
        url: '../xml/xmlBuscarCuentasCobrar.php',
        datatype: 'xml',
        colNames: ['ID','IDENTIFICACIÓN','CLIENTE', 'FACTURA NRO.','MONTO TOTAL','FECHA'],
        colModel: [
            {name: 'id_cuentas_cobrar', index: 'id_cuentas_cobrar', editable: false, search: false, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 50},
            {name: 'identificacion', index: 'identificacion', editable: false, search: true, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 150},
            {name: 'nombres_cli', index: 'nombres_cli', editable: true, search: true, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 200},
            {name: 'num_factura', index: 'num_factura', editable: true, search: true, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 200},
            {name: 'total_venta', index: 'total_venta', editable: true, search: false, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 100},
            {name: 'fecha_actual', index: 'fecha_actual', editable: true, search: false, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 100},
        ],
        rowNum: 10,
        width: 760,
        height:220,
        rowList: [10, 20, 30],
        pager: jQuery('#pager3'),
        sortname: 'id_cuentas_cobrar',
        shrinkToFit: true,
        sortorder: 'asc',        
        viewrecords: true,
        ondblClickRow: function(){
        var id = jQuery("#list3").jqGrid('getGridParam', 'selrow');
        jQuery('#list3').jqGrid('restoreRow', id);
        
        if (id) {
           var ret = jQuery("#list3").jqGrid('getRowData', id);
           var valor = ret.id_cuentas_cobrar;
           
            $("#comprobante").val(valor);
            $("#btnGuardar").attr("disabled", true);
            $("#btnModificar").attr("disabled", true);
            $("#btnfacturas").attr("disabled", "disabled");
            $("#valor_pagado").attr("disabled", "disabled");
            $("#ruc_ci").attr("disabled", "disabled");
            $("#nombres_completos").attr("disabled", "disabled");
            $("#observaciones").attr("disabled", "disabled");
            $("#id_cliente").val("");
            $("#ruc_ci").val("");
            $("#nombres_completos").val("");
            $("#saldo").val("");
            $("#forma_pago").val(0);
            $('#tipo_pago').children().remove().end();
            $("#list").jqGrid("clearGridData", true);
            $("#tablaNuevo").css('display','none');

            $.getJSON('../procesos/retornar_pagos_venta.php?com=' + valor, function(data) {
            var tama = data.length;
            if (tama !== 0) {
            for (var i = 0; i < tama; i = i + 9)
                {
                $("#fecha_actual").val(data[i]);
                $("#hora_actual").val(data[i + 1 ]);
                $("#digitador").val(data[i + 2 ] + " " + data[i + 3 ] );
                $("#id_cliente").val(data[i + 4]);
                $("#ruc_ci").val(data[i + 5]);
                $("#nombres_completos").val(data[i + 6]);
                $("#forma_pago").val(data[i + 7]);
                $("#tipo_pago").append('<option value='+data[i + 8]+' selected>'+data[i + 8]+'</option>');
              }
            }
           });
      ///////////////////////////////////////////////////   
    
      ////////////////////llamar pagos flechas tercera parte/////
         $.getJSON('../procesos/retornar_pagos_venta2.php?com=' + valor, function(data) {
         var tama = data.length;
         if (tama !== 0) {
         for (var i = 0; i < tama; i = i + 8)
         {
            var datarow = {ids_pagos: data[i], num_factura: data[i + 1], tipo_factura: data[i + 2], fecha_factura: data[i + 3], totalcxc: data[i + 4], valor_pagado: data[i + 5], saldo: data[i + 6]};
            var su = jQuery("#list").jqGrid('addRowData', data[i], datarow);
            $("#observaciones").val(data[i + 7]);
         }
         }
      });
      $("#buscar_cuentas_cobrar").dialog("close"); 
        } else {
          alertify.alert("Seleccione una Cuenta a pagar");
        }
    }
    }).jqGrid('navGrid', '#pager3',
            {
                add: false,
                edit: false,
                del: false,
                refresh: true,
                search: true,
                view: true
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
    
    jQuery("#list3").jqGrid('navButtonAdd', '#pager3', {caption: "Añadir",
    onClickButton: function() {
        var id = jQuery("#list3").jqGrid('getGridParam', 'selrow');
        jQuery('#list3').jqGrid('restoreRow', id);
        
         if (id) {
         var ret = jQuery("#list3").jqGrid('getRowData', id);
         var valor = ret.id_cuentas_cobrar;
           
         $("#comprobante").val(valor);
         $("#btnGuardar").attr("disabled", true);
         $("#btnModificar").attr("disabled", true);
         $("#btnfacturas").attr("disabled", "disabled");
         $("#valor_pagado").attr("disabled", "disabled");
         $("#ruc_ci").attr("disabled", "disabled");
         $("#nombres_completos").attr("disabled", "disabled");
         $("#observaciones").attr("disabled", "disabled");
         $("#id_cliente").val("");
         $("#ruc_ci").val("");
         $("#nombres_completos").val("");
         $("#saldo").val("");
         $("#forma_pago").val(0);
         $('#tipo_pago').children().remove().end();
         $("#list").jqGrid("clearGridData", true);
         $("#tablaNuevo").css('display','none');
           
         $.getJSON('../procesos/retornar_pagos_venta.php?com=' + valor, function(data) {
         var tama = data.length;
         if (tama !== 0) {
         for (var i = 0; i < tama; i = i + 9)
             {
             $("#fecha_actual").val(data[i]);
             $("#hora_actual").val(data[i + 1 ]);
             $("#digitador").val(data[i + 2 ] + " " + data[i + 3 ] );
             $("#id_cliente").val(data[i + 4]);
             $("#ruc_ci").val(data[i + 5]);
             $("#nombres_completos").val(data[i + 6]);
             $("#forma_pago").val(data[i + 7]);
             $("#tipo_pago").append('<option value='+data[i + 8]+' selected>'+data[i + 8]+'</option>');
           }
         }
        });
      ///////////////////////////////////////////////////   
    
      ////////////////////llamar pagos flechas tercera parte/////
         $.getJSON('../procesos/retornar_pagos_venta2.php?com=' + valor, function(data) {
         var tama = data.length;
         if (tama !== 0) {
         for (var i = 0; i < tama; i = i + 8)
         {
            var datarow = {ids_pagos: data[i], num_factura: data[i + 1], tipo_factura: data[i + 2], fecha_factura: data[i + 3], totalcxc: data[i + 4], valor_pagado: data[i + 5], saldo: data[i + 6]};
            var su = jQuery("#list").jqGrid('addRowData', data[i], datarow);
            $("#observaciones").val(data[i + 7]);
         }
         }
      });
      $("#buscar_cuentas_cobrar").dialog("close");
        } else {
          alertify.alert("Seleccione una Cuenta a pagar");
        }
    }
});
    
}

function comprobar2(){
    if(parseFloat($("#valor_pagado").val())<= parseFloat($("#saldo2").val())){
        
    }else{
        alert("Error.. el valor supero el saldo");
        $("#valor_pagado").val("");
        $("#valor_pagado").focus();
    }
}
