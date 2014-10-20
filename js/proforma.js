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

var dialogos =
{
    autoOpen: false,
    resizable: false,
    width: 860,
    height: 560,
    modal: true
};

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
        entrar();
        return false;
    }
    return true;
}

function enter1(e) {
    if (e.which === 13 || e.keyCode === 13) {
        entrar2();
        return false;
    }
    return true;
}

function enter2(e) {
    if (e.which === 13 || e.keyCode === 13) {
        comprobar2();
        return false;
    }
    return true;
}

function enter3(e) {
    if (e.which === 13 || e.keyCode === 13) {
        comprobar();
        return false;
    }
    return true;
}

function comprobar() {
    if ($("#id_cliente").val() === "") {
        $("#ruc_ci").focus();
        alertify.alert("Ingrese un cliente");
    } 
}

function entrar() {
    if ($("#cod_producto").val() === "") {
        $("#codigo").focus();
        alertify.alert("Ingrese un producto");
    } else {
        if ($("#codigo").val() === "") {
            $("#codigo").focus();
            alertify.alert("Ingrese un producto");
        } else {
            if ($("#producto").val() === "") {
                $("#producto").focus();
                alertify.alert("Ingrese un producto");
            } else {
                if ($("#cantidad").val() === "") {
                    $("#cantidad").focus();
                    alertify.alert("Ingrese una cantidad");
                } else {
                    $("#p_venta").focus();
                }
            }
        }
    }
}

function entrar2() {
    if ($("#cod_producto").val() === "") {
        $("#codigo").focus();
        alertify.alert("Ingrese un producto");
    } else {
        if ($("#codigo").val() === "") {
            $("#codigo").focus();
            alertify.alert("Ingrese un producto");
        } else {
            if ($("#producto").val() === "") {
                $("#producto").focus();
                alertify.alert("Ingrese un producto");
            } else {
                if ($("#cantidad").val() === "") {
                    $("#cantidad").focus();
                    alertify.alert("Ingrese una cantidad");
                } else {
                    if ($("#p_venta").val() === "") {
                    $("#p_venta").focus();
                    alertify.alert("Ingrese un precio");
                  }else{
                    $("#descuento").focus();
                 }
                }
            }
        }
    }
}

function comprobar2() {
    if ($("#cod_producto").val() === "") {
        $("#codigo").focus();
        alertify.alert("Ingrese un producto");
    } else {
        if ($("#codigo").val() === "") {
            $("#codigo").focus();
            alertify.alert("Ingrese un producto");
        } else {
            if ($("#producto").val() === "") {
                $("#producto").focus();
                alertify.alert("Ingrese un producto");
            } else {
                if ($("#cantidad").val() === "") {
                    $("#cantidad").focus();
                    alertify.alert("Ingrese una cantidad");
                } else {
                    if ($("#p_venta").val() === "") {
                    $("#p_venta").focus();
                    alertify.alert("Ingrese un precio");
                }else{
                    var filas = jQuery("#list").jqGrid("getRowData");
                    var descuento = 0;
                    var cal = 0;
                    var total = 0;
                    var su = 0;
                    var desc = 0;
                    var precio = 0;
                    var multi = 0;
                    if (filas.length === 0) {
                        if ($("#descuento").val() !== "")
                        {
                            desc = $("#descuento").val();
                            precio = (parseFloat($("#p_venta").val())).toFixed(2);
                            multi = ($("#cantidad").val() * precio).toFixed(2);
                            descuento = ((multi * parseFloat($("#descuento").val())) / 100);
                            total = (multi - descuento).toFixed(2);
                        } else {
                            desc = 0;
                            precio = (parseFloat($("#p_venta").val())).toFixed(2);
                            total = ($("#cantidad").val() * precio).toFixed(2);
                        }
                        var datarow = {
                            cod_producto: $("#cod_producto").val(), 
                            codigo: $("#codigo").val(), 
                            detalle: $("#producto").val(), 
                            cantidad: $("#cantidad").val(), 
                            precio_u: precio, 
                            descuento: desc, 
                            total: total, 
                            iva: $("#iva_producto").val()
                            };
                        su = jQuery("#list").jqGrid('addRowData', $("#cod_producto").val(), datarow);
                        $("#cod_producto").val("");
                        $("#codigo").val("");
                        $("#producto").val("");
                        $("#cantidad").val("");
                        $("#p_venta").val("");
                        $("#descuento").val("");
                    } else {
                        var repe = 0;
                        for (var i = 0; i < filas.length; i++) {
                            var id = filas[i];
                            if (id['cod_producto'] === $("#cod_producto").val()) {
                                repe = 1;
                            }
                        }
                        if (repe === 1) {
                             if ($("#descuento").val() !== "")
                                {
                                    desc = $("#descuento").val();
                                    precio = (parseFloat($("#p_venta").val())).toFixed(2);
                                    multi = ($("#cantidad").val() * precio).toFixed(2);
                                    descuento = ((multi * parseFloat($("#descuento").val())) / 100);
                                    total = (multi - descuento).toFixed(2);
                                } else {
                                    desc = 0;
                                    precio = (parseFloat($("#p_venta").val())).toFixed(2);
                                    total = ($("#cantidad").val() * precio).toFixed(2);
                                }
                            datarow = {
                                cod_producto: $("#cod_producto").val(), 
                                codigo: $("#codigo").val(), 
                                detalle: $("#producto").val(), 
                                cantidad: $("#cantidad").val(), 
                                precio_u: precio, 
                                descuento: desc, 
                                total: total, 
                                iva: $("#iva_producto").val()
                                };
                            su = jQuery("#list").jqGrid('setRowData', $("#cod_producto").val(), datarow);
                            $("#cod_producto").val("");
                            $("#codigo").val("");
                            $("#producto").val("");
                            $("#cantidad").val("");
                            $("#p_venta").val("");
                            $("#descuento").val("");
                        } else {
                            if ($("#descuento").val() !== "")
                                {
                                    desc = $("#descuento").val();
                                    precio = (parseFloat($("#p_venta").val())).toFixed(2);
                                    multi = ($("#cantidad").val() * precio).toFixed(2);
                                    descuento = ((multi * parseFloat($("#descuento").val())) / 100);
                                    total = (multi - descuento).toFixed(2);
                                } else {
                                    desc = 0;
                                    precio = (parseFloat($("#p_venta").val())).toFixed(2);
                                    total = ($("#cantidad").val() * precio).toFixed(2);
                                }
                            datarow = {
                                cod_producto: $("#cod_producto").val(), 
                                codigo: $("#codigo").val(), 
                                detalle: $("#producto").val(), 
                                cantidad: $("#cantidad").val(), 
                                precio_u: precio, 
                                descuento: desc, 
                                total: total, 
                                iva: $("#iva_producto").val()
                                };
                            su = jQuery("#list").jqGrid('addRowData', $("#cod_producto").val(), datarow);
                            $("#cod_producto").val("");
                            $("#codigo").val("");
                            $("#producto").val("");
                            $("#cantidad").val("");
                            $("#p_venta").val("");
                            $("#descuento").val("");
                        }
                    }
                    
                    ////////////////operaciones/////////////////
                    var subtotal = 0;
                    var iva = 0;
                    var t_fc = 0;
                    var mu = 0;
                    var des = 0;
                    var descu = 0;
                    if ($("#iva_producto").val() === "Si") {
                        var fil = jQuery("#list").jqGrid("getRowData");
                        for (var t = 0; t < fil.length; t++) {
                            var dd = fil[t];
                            if (dd['iva'] === "Si") {
                                subtotal = (subtotal + parseFloat(dd['total']));
                                var sub = parseFloat(subtotal).toFixed(2);
                                mu = (dd['cantidad'] * dd['precio_u']).toFixed(2);
                                des = ((mu * dd['descuento'])/100).toFixed(2);
                                descu = (parseFloat(descu) + parseFloat(des)).toFixed(2); 
                                $("#iva_producto").val("");
                            }
                        }
                        
                        iva = ((subtotal * 12) / 100).toFixed(2);
                        t_fc = ((parseFloat(subtotal) + parseFloat(iva)) + parseFloat($("#total_p").val())).toFixed(2);
                        $("#total_p2").val(sub);
                        $("#iva").val(iva);
                        $("#desc").val(descu);
                        $("#tot").val(t_fc);
                    } else {
                        if ($("#iva_producto").val() === "No") {
                            fil = jQuery("#list").jqGrid("getRowData");
                            subtotal = 0;
                            t_fc = 0;
                            iva = 0;
                            mu = 0;
                            des = 0;
                            descu = 0;
                            for (t = 0; t < fil.length; t++) {
                                dd = fil[t];
                                if (dd['iva'] === "No") {
                                    subtotal = (subtotal + parseFloat(dd['total']));
                                    sub = parseFloat(subtotal).toFixed(2);
                                    mu = (dd['cantidad'] * dd['precio_u']).toFixed(2);
                                    des = ((mu * dd['descuento'])/100).toFixed(2);
                                    descu = (parseFloat(descu) + parseFloat(des)).toFixed(2);
                                    $("#iva_producto").val("");
                                }
                            }
                            iva = parseFloat($("#iva").val());
                            t_fc = ((parseFloat(subtotal) + parseFloat(iva)) + parseFloat($("#total_p2").val())).toFixed(2);
                            $("#total_p").val(sub);
                            $("#desc").val(descu);
                            $("#tot").val(t_fc);
                        }
                      /////////////////////////////////////////////////////////////////////  
                    }
                    $("#codigo").focus();
                }
            }
          }
        }
    }
}

function guardar_proforma() {
    var tam = jQuery("#list").jqGrid("getRowData");
    if ($("#id_cliente").val() === "") {
        $("#ruc_ci").focus();
        alertify.alert("Ingrese un cliente");
    } else {
        if ($("#tipo_precio").val() === "") {
            $("#tipo_precio").focus();
            alertify.alert("Error... Seleccione tipo de precio");
        } else {
            if (tam.length === 0) {
                alertify.alert("Error... Llene productos en la proforma");
            } else {
                var v1 = new Array();
                var v2 = new Array();
                var v3 = new Array();
                var v4 = new Array();
                var v5 = new Array();
                var string_v1 = "";
                var string_v2 = "";
                var string_v3 = "";
                var string_v4 = "";
                var string_v5 = "";
                var fil = jQuery("#list").jqGrid("getRowData");
                for (var i = 0; i < fil.length; i++) {
                    var datos = fil[i];
                    v1[i] = datos['cod_producto'];
                    v2[i] = datos['cantidad'];
                    v3[i] = datos['precio_u'];
                    v4[i] = datos['descuento'];
                    v5[i] = datos['total'];
                }
                for (i = 0; i < fil.length; i++) {
                    string_v1 = string_v1 + "|" + v1[i];
                    string_v2 = string_v2 + "|" + v2[i];
                    string_v3 = string_v3 + "|" + v3[i];
                    string_v4 = string_v4 + "|" + v4[i];
                    string_v5 = string_v5 + "|" + v5[i];
                }

                $.ajax({
                    type: "POST",
                    url: "../procesos/guardar_proforma.php",
                    data: "id_cliente=" + $("#id_cliente").val() + "&comprobante=" + $("#comprobante").val() + "&fecha_actual=" + $("#fecha_actual").val() + "&hora_actual=" + $("#hora_actual").val() + "&tipo_precio=" + $("#tipo_precio").val() + "&tarifa0=" + $("#total_p").val() + "&tarifa12=" + $("#total_p2").val() + "&iva=" + $("#iva").val() + "&desc=" + $("#desc").val() + "&tot=" + $("#tot").val() + "&campo1=" + string_v1 + "&campo2=" + string_v2 + "&campo3=" + string_v3 + "&campo4=" + string_v4 + "&campo5=" + string_v5 + "&observaciones=" + $("#observaciones").val(),
                    success: function(data) {
                        var val = data;
                        if (val == 1) {
                            alertify.alert("Proforma Guardada correctamente",function(){
                            window.open("../reportes/reportes/proforma.php?id="+$("#comprobante").val(),'_blank');    
                            location.reload();
                            });   
                        }
                    }
                });
            }
        }
    }
}

function flecha_atras(){
    $.ajax({
       type: "POST",
       url: "../procesos/flechas.php",
       data: "comprobante=" + $("#comprobante").val() + "&tabla=" + "proforma" + "&id_tabla=" + "id_proforma" + "&tipo=" + 1,
       success: function(data) {
           var val = data;
           if(val != ""){
                $("#comprobante").val(val);
                var valor = $("#comprobante").val();
                
                  ///////////////////llamar proforma flechas primera parte/////
                $("#btnGuardar").attr("disabled", true);
                $("#btnModificar").attr("disabled", true);

                $("#ruc_ci").attr("disabled", "disabled");
                $("#nombres_completos").attr("disabled", "disabled");

                $("#codigo").attr("disabled", "disabled");
                $("#producto").attr("disabled", "disabled");
                $("#cantidad").attr("disabled", "disabled");
                $("#p_venta").attr("disabled", "disabled");
                $("#descuento").attr("disabled", "disabled");
                $("#observaciones").attr("disabled", "disabled");

                $("#list").jqGrid("clearGridData", true);
                $("#total_p").val("0.00");
                $("#total_p2").val("0.00");
                $("#desc").val("0.00");
                $("#iva").val("0.00");
                $("#tot").val("0.00");

                $.getJSON('../procesos/retornar_proforma_venta.php?com=' + valor, function(data) {
                    var tama = data.length;
                    if (tama !== 0) {
                        for (var i = 0; i < tama; i = i + 15)
                        {
                            $("#fecha_actual").val(data[i]);
                            $("#hora_actual").val(data[i + 1 ]);
                            $("#digitador").val(data[i + 2 ] + " " + data[i + 3 ]);
                            $("#id_cliente").val(data[i + 4]);
                            $("#ruc_ci").val(data[i + 5]);
                            $("#nombres_completos").val(data[i + 6]);
                            $("#saldo").val(data[i + 7]);
                            $("#tipo_precio").val(data[i + 8]);
                            $("#total_p").val(data[i + 9]);
                            $("#total_p2").val(data[i + 10]);
                            $("#iva").val(data[i + 11]);
                            $("#desc").val(data[i + 12]);
                            $("#tot").val(data[i + 13]);
                            $("#observaciones").val(data[i + 14]);
                        }
                    }
                });
                ///////////////////////////////////////////////////   

                ////////////////////llamar facturas flechas tercera parte/////
                $.getJSON('../procesos/retornar_proforma_venta2.php?com=' + valor, function(data) {
                    var tama = data.length;
                    if (tama !== 0) {
                        for (var i = 0; i < tama; i = i + 8)
                        {
                            var datarow = {
                                cod_producto: data[i], 
                                codigo: data[i + 1], 
                                detalle: data[i + 2], 
                                cantidad: data[i + 3], 
                                precio_u: data[i + 4], 
                                descuento: data[i + 5], 
                                total: data[i + 6], 
                                iva: data[i + 7]
                                };
                            var su = jQuery("#list").jqGrid('addRowData', data[i], datarow);
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
       data: "comprobante=" + $("#comprobante").val() + "&tabla=" + "proforma" + "&id_tabla=" + "id_proforma" + "&tipo=" + 2,
       success: function(data) {
           var val = data;
           if(val != ""){
            $("#comprobante").val(val);
            var valor = $("#comprobante").val();
                 ///////////////////llamar facturas flechas primera parte/////
            $("#btnGuardar").attr("disabled", true);
            $("#btnModificar").attr("disabled", true);

            $("#ruc_ci").attr("disabled", "disabled");
            $("#nombres_completos").attr("disabled", "disabled");

            $("#codigo").attr("disabled", "disabled");
            $("#producto").attr("disabled", "disabled");
            $("#cantidad").attr("disabled", "disabled");
            $("#p_venta").attr("disabled", "disabled");
            $("#descuento").attr("disabled", "disabled");
            $("#observaciones").attr("disabled", "disabled");

            $("#list").jqGrid("clearGridData", true);
            $("#total_p").val("0.00");
            $("#total_p2").val("0.00");
            $("#desc").val("0.00");
            $("#iva").val("0.00");
            $("#tot").val("0.00");
            
            $.getJSON('../procesos/retornar_proforma_venta.php?com=' + valor, function(data) {
                var tama = data.length;
                if (tama !== 0) {
                    for (var i = 0; i < tama; i = i + 15)
                    {
                        $("#fecha_actual").val(data[i]);
                        $("#hora_actual").val(data[i + 1 ]);
                        $("#digitador").val(data[i + 2 ] + " " + data[i + 3 ] );
                        $("#id_cliente").val(data[i + 4]);
                        $("#ruc_ci").val(data[i + 5]);
                        $("#nombres_completos").val(data[i + 6]);
                        $("#saldo").val(data[i + 7]);
                        $("#tipo_precio").val(data[i + 8]);
                        $("#total_p").val(data[i + 9]);
                        $("#total_p2").val(data[i + 10]);
                        $("#iva").val(data[i + 11]);
                        $("#desc").val(data[i + 12]);
                        $("#tot").val(data[i + 13]);
                        $("#observaciones").val(data[i + 14]);
                    }
                }
            });
            ///////////////////////////////////////////////////   
    
            ////////////////////llamar proforma flechas segunda parte/////
            $.getJSON('../procesos/retornar_proforma_venta2.php?com=' + valor, function(data) {
                var tama = data.length;
                if (tama !== 0) {
                    for (var i = 0; i < tama; i = i + 8)
                    {
                        var datarow = {
                            cod_producto: data[i], 
                            codigo: data[i + 1], 
                            detalle: data[i + 2], 
                            cantidad: data[i + 3], 
                            precio_u: data[i + 4], 
                            descuento: data[i + 5], 
                            total: data[i + 6], 
                            iva: data[i + 7]
                            };
                        var su = jQuery("#list").jqGrid('addRowData', data[i], datarow);
                    }
                }
            });
           }else{
               alertify.alert("No hay mas registros superiores!!");
           }    
       }
   });
}

function limpiar_proforma(){
    location.reload(); 
}

function limpiar_campo(){
    if($("#ruc_ci").val() === ""){
        $("#id_cliente").val("");
        $("#nombres_completos").val("");
        $("#saldo").val("");
    }
}

function limpiar_campo2(){
    if($("#nombres_completos").val() === ""){
        $("#id_cliente").val("");
        $("#ruc_ci").val("");
        $("#saldo").val("");
    }
}

function limpiar_campo3(){
    if($("#codigo").val() === ""){
        $("#cod_producto").val("");
        $("#producto").val("");
        $("#cantidad").val("");
        $("#p_venta").val("");
        $("#descuento").val("");
        $("#iva_producto").val("");
    }
}

function limpiar_campo4(){
    if($("#producto").val() === ""){
        $("#cod_producto").val("");
        $("#codigo").val("");
        $("#cantidad").val("");
        $("#p_venta").val("");
        $("#descuento").val("");
        $("#iva_producto").val("");
    }
}

function inicio() {
      jQuery().UItoTop({ easingType: 'easeOutQuart' });
    //////////////para hora///////////
    show();
    ///////////////////

    //////////////botones//////////
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
        window.open("../reportes/reportes/proforma.php?id="+$("#comprobante").val(),'_blank');        
    });
    $("#btnAtras").click(function(e) {
        e.preventDefault();
    });
    $("#btnAdelante").click(function(e) {
        e.preventDefault();
    });

    $("#btnGuardar").on("click", guardar_proforma);
    $("#btnNuevo").on("click", limpiar_proforma);
    $("#btnAtras").on("click", flecha_atras);
    $("#btnAdelante").on("click", flecha_siguiente);
    
    ////////////////////////////////
    $("#buscar_proformas").dialog(dialogo2);

    $("#btnBuscar").click(function(e) {
        e.preventDefault();
        $("#buscar_proformas").dialog("open");  
    });
    ///////////////////////////////////

    $("#cantidad").validCampoFranz("0123456789");
    $("#descuento").validCampoFranz("0123456789");
    $("#descuento").attr("maxlength", "3");

    //////////////validaciones////////////
    $("#ruc_ci").on("keyup", limpiar_campo);
    $("#nombres_completos").on("keyup", limpiar_campo2);
    $("#codigo").on("keyup", limpiar_campo3);
    $("#producto").on("keyup", limpiar_campo4);
    $("#codigo").on("keypress", enter);
    $("#producto").on("keypress", enter);
    $("#cantidad").on("keypress", enter);
    $("#p_venta").on("keypress", enter1);
    $("#descuento").on("keypress", enter2);
    $("#ruc_ci").on("keypress", enter3);
    $("#nombres_completos").on("keypress", enter3);
    //////////////////////////////////////

    
    //////////////////buscar productos codigo////////////////
    $("#codigo").keyup(function(e) {
     var precio = $("#tipo_precio").val();
       if (precio === "MINORISTA") {
            $("#codigo").autocomplete({
                source: "../procesos/buscar_producto7.php?tipo_precio=" + precio,
                minLength: 1,
                focus: function(event, ui) {
                $("#codigo").val(ui.item.value);
                $("#producto").val(ui.item.producto);
                $("#p_venta").val(ui.item.p_venta);
                $("#iva_producto").val(ui.item.iva_producto);
                $("#cod_producto").val(ui.item.cod_producto);
                return false;
                },
                select: function(event, ui) {
                $("#codigo").val(ui.item.value);
                $("#producto").val(ui.item.producto);
                $("#p_venta").val(ui.item.p_venta);
                $("#iva_producto").val(ui.item.iva_producto);
                $("#cod_producto").val(ui.item.cod_producto);
                return false;
                }

                }).data("ui-autocomplete")._renderItem = function(ul, item) {
                return $("<li>")
                .append("<a>" + item.value + "</a>")
                .appendTo(ul);
            };
        } else {
            if (precio === "MAYORISTA") {
                $("#codigo").autocomplete({
                    source: "../procesos/buscar_producto7.php?tipo_precio=" + precio,
                    minLength: 1,
                    focus: function(event, ui) {
                    $("#codigo").val(ui.item.value);
                    $("#producto").val(ui.item.producto);
                    $("#p_venta").val(ui.item.p_venta);
                    $("#iva_producto").val(ui.item.iva_producto);
                    $("#cod_producto").val(ui.item.cod_producto);
                    return false;
                    },
                    select: function(event, ui) {
                    $("#codigo").val(ui.item.value);
                    $("#producto").val(ui.item.producto);
                    $("#p_venta").val(ui.item.p_venta);
                    $("#iva_producto").val(ui.item.iva_producto);
                    $("#cod_producto").val(ui.item.cod_producto);
                    return false;
                    }

                    }).data("ui-autocomplete")._renderItem = function(ul, item) {
                    return $("<li>")
                    .append("<a>" + item.value + "</a>")
                    .appendTo(ul);
                };
            }
        }
    });
    ////////////////////////////////////////////////
    
     //////////////////buscar productos articulo////////////////
    $("#producto").keyup(function(e) {
    var precio = $("#tipo_precio").val();
    if (precio === "MINORISTA") {
        $("#producto").autocomplete({
            source: "../procesos/buscar_producto8.php?tipo_precio=" + precio,
            minLength: 1,
            focus: function(event, ui) {
            $("#producto").val(ui.item.value);
            $("#codigo").val(ui.item.codigo);
            $("#p_venta").val(ui.item.p_venta);
            $("#iva_producto").val(ui.item.iva_producto);
            $("#cod_producto").val(ui.item.cod_producto);
            return false;
            },
            select: function(event, ui) {
            $("#producto").val(ui.item.value);
            $("#codigo").val(ui.item.codigo);
            $("#p_venta").val(ui.item.p_venta);
            $("#iva_producto").val(ui.item.iva_producto);
            $("#cod_producto").val(ui.item.cod_producto);
            return false;
            }

            }).data("ui-autocomplete")._renderItem = function(ul, item) {
            return $("<li>")
            .append("<a>" + item.value + "</a>")
            .appendTo(ul);
        };
    } else {
        if (precio === "MAYORISTA") {
            $("#producto").autocomplete({
                source: "../procesos/buscar_producto8.php?tipo_precio=" + precio,
                minLength: 1,
                focus: function(event, ui) {
                $("#producto").val(ui.item.value);
                $("#codigo").val(ui.item.codigo);
                $("#p_venta").val(ui.item.p_venta);
                $("#iva_producto").val(ui.item.iva_producto);
                $("#cod_producto").val(ui.item.cod_producto);
                return false;
                },
                select: function(event, ui) {
                $("#producto").val(ui.item.value);
                $("#codigo").val(ui.item.codigo);
                $("#p_venta").val(ui.item.p_venta);
                $("#iva_producto").val(ui.item.iva_producto);
                $("#cod_producto").val(ui.item.cod_producto);
                return false;
                }

                }).data("ui-autocomplete")._renderItem = function(ul, item) {
                return $("<li>")
                .append("<a>" + item.value + "</a>")
                .appendTo(ul);
            };
        }
     }   
  });
    /////////////////////////////////////////////
    
    ///////////////////limpiar combo//////////
    $("#tipo_precio").change(function() {
       $("#cod_producto").val("");
       $("#codigo").val("");
       $("#producto").val("");
       $("#cantidad").val("");
       $("#p_venta").val("");
       $("#descuento").val("");
       $("#iva_producto").val("");   
    });
    /////////////////////////////////////////

    /////buscador cliente identificacion///// 
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

    ///////////tabla local/////////////   

    var can;
       jQuery("#list").jqGrid({
        datatype: "local",
        colNames: ['', 'ID', 'Código', 'Producto', 'Cantidad', 'PVP', 'Descuento', 'Total', 'Iva'],
        colModel: [
            {name: 'myac', width: 50, fixed: true, sortable: false, resize: false, formatter: 'actions',
                formatoptions: {keys: false, delbutton: true, editbutton: false}
            },
            {name: 'cod_producto', index: 'cod_producto', editable: false, search: false, hidden: true, editrules: {edithidden: false}, align: 'center',
                frozen: true, width: 50},
            {name: 'codigo', index: 'codigo', editable: false, search: false, hidden: false, editrules: {edithidden: false}, align: 'center',
                frozen: true, width: 100},
            {name: 'detalle', index: 'detalle', editable: false, frozen: true, editrules: {required: true}, align: 'center', width: 290},
            {name: 'cantidad', index: 'cantidad', editable: true, frozen: true, editrules: {required: true}, align: 'center', width: 70},
            {name: 'precio_u', index: 'precio_u', editable: true, search: false, frozen: true, editrules: {required: true}, align: 'center', width: 110},
            {name: 'descuento', index: 'descuento', editable: false, frozen: true, editrules: {required: true}, align: 'center', width: 70},
            {name: 'total', index: 'total', editable: false, search: false, frozen: true, editrules: {required: true}, align: 'center', width: 110},
            {name: 'iva', index: 'iva', align: 'center', width: 100, hidden: true}
        ],
        rowNum: 30,
        width: 770,
        sortable: true,
        rowList: [10, 20, 30],
        pager: jQuery('#pager'),
        sortname: 'id_productos',
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
                var tarifa12 = 0;
                var tarifa0 = 0;
                var iva = 0;
                var total_iva = 0;
                var mul = 0;
                var des = 0;
                var total_des = 0;
                var total = 0;
                var total_to = 0;
                var total_to2 = 0;
                if (su === true) {
                    if (ret.iva === "Si") {
                        tarifa12 = ($("#total_p2").val() - ret.total).toFixed(2);
                        $("#total_p2").val(tarifa12);
                        iva = $("#iva").val();
                        total_iva = ((ret.total * 12) / 100).toFixed(2);
                        iva = ($("#iva").val() - total_iva).toFixed(2);
                        $("#iva").val(iva);
                        mul = (ret.cantidad * ret.precio_u).toFixed(2);
                        des = ((mul * ret.descuento)/100).toFixed(2);
                        total_des = (parseFloat($("#desc").val()) - des).toFixed(2);
                        total = (parseFloat(ret.total) + parseFloat(total_iva)).toFixed(2);
                        total_to = ($("#tot").val() - total).toFixed(2);
                        $("#desc").val(total_des);
                        $("#tot").val(total_to);
                    } else {
                        if (ret.iva === "No") {
                            tarifa0 = ($("#total_p").val() - ret.total).toFixed(2);
                            $("#total_p").val(tarifa0);
                            mul = (ret.cantidad * ret.precio_u).toFixed(2);
                            des = ((mul * ret.descuento)/100).toFixed(2);
                            total_des = (parseFloat($("#desc").val()) - des).toFixed(2);
                            total_to2 = ($("#tot").val() - ret.total).toFixed(2);
                            $("#desc").val(total_des);
                            $("#tot").val(total_to2);
                        }
                    }
                }
                $(".ui-icon-closethick").trigger('click');
                return true;
            },
            processing: true
        },
        afterSaveCell : function(rowid,name,val,iRow,iCol) {
            var subtotal = 0;
            var iva = 0;
            var t_fc = 0;
            var mu = 0;
            var des = 0;
            var descu = 0;
            
            var id = jQuery("#list").jqGrid('getGridParam', 'selrow');
            jQuery('#list').jqGrid('restoreRow', id);
            var ret = jQuery("#list").jqGrid('getRowData', id);
            
            if(name == 'cantidad') {
               var precio = jQuery("#list").jqGrid('getCell',rowid,iCol+1);
               var operacion = (parseFloat(val)* parseFloat(precio)).toFixed(2); 
               jQuery("#list").jqGrid('setRowData',rowid,{total: operacion });
               
               if (ret.iva === "Si") {
                   var fil = jQuery("#list").jqGrid("getRowData");
                   for (var t = 0; t < fil.length; t++) {
                        var dd = fil[t];
                        if (dd['iva'] === "Si") {
                            subtotal = (subtotal + parseFloat(dd['total']));
                            var sub = parseFloat(subtotal).toFixed(2);

                            mu = (dd['cantidad'] * dd['precio_u']).toFixed(2);
                            des = ((mu * dd['descuento'])/100).toFixed(2);
                            descu = (parseFloat(descu) + parseFloat(des)).toFixed(2);
                            $("#iva_producto").val("");
                        }
                    }
                    iva = ((subtotal * 12) / 100).toFixed(2);
                    t_fc = ((parseFloat(subtotal) + parseFloat(iva)) + parseFloat($("#total_p").val())).toFixed(2);
                    $("#total_p2").val(sub);
                    $("#iva").val(iva);
                    $("#desc").val(descu);
                    $("#tot").val(t_fc);
               }else{
                    fil = jQuery("#list").jqGrid("getRowData");
                    subtotal = 0;
                    t_fc = 0;
                    iva = 0;
                    mu = 0;
                    des = 0;
                    descu = 0;
                    for (t = 0; t < fil.length; t++) {
                    dd = fil[t];
                    if (dd['iva'] === "No") {
                        subtotal = (subtotal + parseFloat(dd['total']));
                        sub = parseFloat(subtotal).toFixed(2);
                        mu = (dd['cantidad'] * dd['precio_u']).toFixed(2);
                        des = ((mu * dd['descuento'])/100).toFixed(2);
                        descu = (parseFloat(descu) + parseFloat(des)).toFixed(2);
                        $("#iva_producto").val("");
                    }
                }
                iva = parseFloat($("#iva").val());
                t_fc = ((parseFloat(subtotal) + parseFloat(iva)) + parseFloat($("#total_p2").val())).toFixed(2);
                $("#total_p").val(sub);
                $("#desc").val(descu);
                $("#tot").val(t_fc);
               }
            }
            
            if(name == 'precio_u') {
               var cantidad = jQuery("#list").jqGrid('getCell',rowid,iCol-1);
               var operacion2 = (parseFloat(cantidad) * parseFloat(val)).toFixed(2); 
               jQuery("#list").jqGrid('setRowData',rowid,{total: operacion2});
               
               if (ret.iva === "Si") {
                   fil = jQuery("#list").jqGrid("getRowData");
                   for (t = 0; t < fil.length; t++) {
                        dd = fil[t];
                        if (dd['iva'] === "Si") {
                            subtotal = (subtotal + parseFloat(dd['total']));
                            sub = parseFloat(subtotal).toFixed(2);

                            mu = (dd['cantidad'] * dd['precio_u']).toFixed(2);
                            des = ((mu * dd['descuento'])/100).toFixed(2);
                            descu = (parseFloat(descu) + parseFloat(des)).toFixed(2);
                            $("#iva_producto").val("");
                        }
                    }
                    
                    iva = ((subtotal * 12) / 100).toFixed(2);
                    t_fc = ((parseFloat(subtotal) + parseFloat(iva)) + parseFloat($("#total_p").val())).toFixed(2);
                    $("#total_p2").val(sub);
                    $("#iva").val(iva);
                    $("#desc").val(descu);
                    $("#tot").val(t_fc);
               }else{
                    fil = jQuery("#list").jqGrid("getRowData");
                    subtotal = 0;
                    t_fc = 0;
                    iva = 0;
                    mu = 0;
                    des = 0;
                    descu = 0;
                    for (t = 0; t < fil.length; t++) {
                    dd = fil[t];
                    if (dd['iva'] === "No") {
                        subtotal = (subtotal + parseFloat(dd['total']));
                        sub = parseFloat(subtotal).toFixed(2);
                        mu = (dd['cantidad'] * dd['precio_u']).toFixed(2);
                        des = ((mu * dd['descuento'])/100).toFixed(2);
                        descu = (parseFloat(descu) + parseFloat(des)).toFixed(2);
                        $("#iva_producto").val("");
                    }
                }
                iva = parseFloat($("#iva").val());
                t_fc = ((parseFloat(subtotal) + parseFloat(iva)) + parseFloat($("#total_p2").val())).toFixed(2);
                $("#total_p").val(sub);
                $("#desc").val(descu);
                $("#tot").val(t_fc);
               }
            }
        }
    });
    //////////////////////////////////////
    ///////////calendarios/////
    $('#fecha_actual').datepicker({
        dateFormat: 'yy-mm-dd'
    });

         ////////////////////buscador proformas/////////////////////////
        jQuery("#list2").jqGrid({
        url: '../xml/xmlBuscarProformas.php',
        datatype: 'xml',
        colNames: ['ID','IDENTIFICACIÓN','CLIENTE','MONTO TOTAL','FECHA'],
        colModel: [
            {name: 'id_proforma', index: 'id_factura_venta', editable: false, search: false, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 50},
            {name: 'identificacion', index: 'identificacion', editable: false, search: true, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 150},
            {name: 'nombres_cli', index: 'nombres_cli', editable: true, search: true, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 200},
            {name: 'total_proforma', index: 'total_proforma', editable: true, search: false, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 100},
            {name: 'fecha_proforma', index: 'fecha_proforma', editable: true, search: false, hidden: false, editrules: {edithidden: false}, align: 'center',frozen: true, width: 100},
        ],
        rowNum: 30,
        width: 750,
        height:220,
        sortable: true,
        rowList: [10, 20, 30],
        pager: jQuery('#pager2'),
        sortname: 'id_proforma',
        sortorder: 'asc',
        viewrecords: true,              
        ondblClickRow: function(){
        var id = jQuery("#list2").jqGrid('getGridParam', 'selrow');
        jQuery('#list2').jqGrid('restoreRow', id);
        
        if (id) {
           var ret = jQuery("#list2").jqGrid('getRowData', id);
           var valor = ret.id_proforma;
         /////////////agregregar datos proforma////////
        $("#comprobante").val(ret.id_proforma);
        $("#btnGuardar").attr("disabled", true);
        $("#btnModificar").attr("disabled", true);

        $("#ruc_ci").attr("disabled", "disabled");
        $("#nombres_completos").attr("disabled", "disabled");

        $("#codigo").attr("disabled", "disabled");
        $("#producto").attr("disabled", "disabled");
        $("#cantidad").attr("disabled", "disabled");
        $("#p_venta").attr("disabled", "disabled");
        $("#descuento").attr("disabled", "disabled");
        $("#observaciones").attr("disabled", "disabled");

        $("#list").jqGrid("clearGridData", true);
        $("#total_p").val("0.00");
        $("#total_p2").val("0.00");
        $("#desc").val("0.00");
        $("#iva").val("0.00");
        $("#tot").val("0.00");

        $.getJSON('../procesos/retornar_proforma_venta.php?com=' + valor, function(data) {
            var tama = data.length;
            if (tama !== 0) {
                for (var i = 0; i < tama; i = i + 15)
                {
                    $("#fecha_actual").val(data[i]);
                    $("#hora_actual").val(data[i + 1 ]);
                    $("#digitador").val(data[i + 2 ] + " " + data[i + 3 ] );
                    $("#id_cliente").val(data[i + 4]);
                    $("#ruc_ci").val(data[i + 5]);
                    $("#nombres_completos").val(data[i + 6]);
                    $("#saldo").val(data[i + 7]);
                    $("#tipo_precio").val(data[i + 8]);
                    $("#total_p").val(data[i + 9]);
                    $("#total_p2").val(data[i + 10]);
                    $("#iva").val(data[i + 11]);
                    $("#desc").val(data[i + 12]);
                    $("#tot").val(data[i + 13]);
                    $("#observaciones").val(data[i + 14]);
                }
            }
        });
        ///////////////////////////////////////////////////   

        ////////////////////llamar facturas flechas segunda parte/////
        $.getJSON('../procesos/retornar_proforma_venta2.php?com=' + valor, function(data) {
            var tama = data.length;
            if (tama !== 0) {
                 for (var i = 0; i < tama; i = i + 8)
                {
                    var datarow = {
                        cod_producto: data[i], 
                        codigo: data[i + 1], 
                        detalle: data[i + 2], 
                        cantidad: data[i + 3], 
                        precio_u: data[i + 4], 
                        descuento: data[i + 5], 
                        total: data[i + 6], 
                        iva: data[i + 7]
                        };
                    var su = jQuery("#list").jqGrid('addRowData', data[i], datarow);
                }
            }
        });
 
         $("#buscar_proformas").dialog("close");
        }
        else {
            alertify.alert("Seleccione una Proforma");
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
           var valor = ret.id_proforma;
         /////////////agregregar datos proforma////////
        $("#comprobante").val(ret.id_proforma);
        $("#btnGuardar").attr("disabled", true);
        $("#btnModificar").attr("disabled", true);

        $("#ruc_ci").attr("disabled", "disabled");
        $("#nombres_completos").attr("disabled", "disabled");

        $("#codigo").attr("disabled", "disabled");
        $("#producto").attr("disabled", "disabled");
        $("#cantidad").attr("disabled", "disabled");
        $("#p_venta").attr("disabled", "disabled");
        $("#descuento").attr("disabled", "disabled");
        $("#observaciones").attr("disabled", "disabled");

        $("#list").jqGrid("clearGridData", true);
        $("#total_p").val("0.00");
        $("#total_p2").val("0.00");
        $("#desc").val("0.00");
        $("#iva").val("0.00");
        $("#tot").val("0.00");

        $.getJSON('../procesos/retornar_proforma_venta.php?com=' + valor, function(data) {
            var tama = data.length;
            if (tama !== 0) {
                for (var i = 0; i < tama; i = i + 15)
                {
                    $("#fecha_actual").val(data[i]);
                    $("#hora_actual").val(data[i + 1 ]);
                    $("#digitador").val(data[i + 2 ] + " " + data[i + 3 ] );
                    $("#id_cliente").val(data[i + 4]);
                    $("#ruc_ci").val(data[i + 5]);
                    $("#nombres_completos").val(data[i + 6]);
                    $("#saldo").val(data[i + 7]);
                    $("#tipo_precio").val(data[i + 8]);
                    $("#total_p").val(data[i + 9]);
                    $("#total_p2").val(data[i + 10]);
                    $("#iva").val(data[i + 11]);
                    $("#desc").val(data[i + 12]);
                    $("#tot").val(data[i + 13]);
                    $("#observaciones").val(data[i + 14]);
                }
            }
        });
        ///////////////////////////////////////////////////   

        ////////////////////llamar facturas flechas segunda parte/////
        $.getJSON('../procesos/retornar_proforma_venta2.php?com=' + valor, function(data) {
            var tama = data.length;
            if (tama !== 0) {
                for (var i = 0; i < tama; i = i + 8)
                {
                    var datarow = {
                        cod_producto: data[i], 
                        codigo: data[i + 1], 
                        detalle: data[i + 2], 
                        cantidad: data[i + 3], 
                        precio_u: data[i + 4], 
                        descuento: data[i + 5], 
                        total: data[i + 6], 
                        iva: data[i + 7]
                        };
                    var su = jQuery("#list").jqGrid('addRowData', data[i], datarow);
                }
            }
        });
       $("#buscar_proformas").dialog("close");
        } else {
          alertify.alert("Seleccione una Proforma");
        }
    }
});

}



