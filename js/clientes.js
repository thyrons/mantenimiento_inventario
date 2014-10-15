$(document).on("ready", inicio);
function evento(e) {
    e.preventDefault();
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
    width: 860,
    height: 350,
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
    $("#clientes").dialog("open");
}

function guardar_cliente() {
    var iden = $("#ruc_ci").val();
    
    if ($("#tipo_docu").val() === "") {
        $("#tipo_docu").focus();
        alertify.alert("Seleccione un tipo de documento ");
    } else {
        if ($("#tipo_docu").val() === "Cedula" && iden.length < 10) {
            $("#ruc_ci").focus();
            alertify.alert("Error.. Minimo 10 digitos ");
        } else {
            if ($("#tipo_docu").val() === "Ruc" && iden.length < 13) {
                $("#ruc_ci").focus();
                alertify.alert("Error.. Minimo 13 digitos ");
            } else {
                if ($("#nombres_cli").val() === "") {
                    $("#nombres_cli").focus();
                    alertify.alert("Ingrese Nombres completos");
                } else {
                    if ($("#tipo_cli").val() === "") {
                        $("#tipo_cli").focus();
                        alertify.alert("Seleccione Tipo cliente");
                    } else {
                        if ($("#direccion_cli").val() === "") {
                            $("#direccion_cli").focus();
                            alertify.alert("Ingrese una dirección");
                        } else {
                            if ($("#pais_cli").val() === "") {
                                $("#pais_cli").focus();
                                alertify.alert("Ingrese un pais");
                            } else {
                                if ($("#ciudad_cli").val() === "") {
                                    $("#ciudad_cli").focus();
                                    alertify.alert("Ingrese una ciudad");
                                } else {
                                    if ($("#cupo_credito").val() === "") {
                                        $("#cupo_credito").focus();
                                        alertify.alert("Ingrese cantidad del crédito");
                                    }else{
                                        $.ajax({
                                            type: "POST",
                                            url: "../procesos/guardar_clientes.php",
                                            data: "tipo_docu=" + $("#tipo_docu").val() + "&ruc_ci=" + $("#ruc_ci").val() +
                                            "&nombres_cli=" + $("#nombres_cli").val() + "&tipo_cli=" + $("#tipo_cli").val() + "&direccion_cli=" + $("#direccion_cli").val() + "&nro_telefono=" + $("#nro_telefono").val() + "&nro_celular=" + $("#nro_celular").val() + "&pais_cli=" + $("#pais_cli").val() + "&ciudad_cli=" + $("#ciudad_cli").val() + "&email=" + $("#email").val() + "&cupo_credito=" + $("#cupo_credito").val() + "&notas_cli=" + $("#notas_cli").val(),
                                            success: function(data) {
                                                var val = data;
                                                if (val == 1) {
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
}

function modificar_cliente() {
    var iden = $("#ruc_ci").val();
    
    if ($("#id_cliente").val() === "") {
        alertify.alert("Seleccione un cliente");
    } else {
        if ($("#tipo_docu").val() === "") {
            $("#tipo_docu").focus();
            alertify.alert("Seleccione un tipo de documento ");
        } else {
            if ($("#tipo_docu").val() === "Cedula" && iden.length < 10) {
                $("#ruc_ci").focus();
                alertify.alert("Error.. Minimo 10 digitos ");
            } else {
                if ($("#tipo_docu").val() === "Ruc" && iden.length < 13) {
                    $("#ruc_ci").focus();
                    alertify.alert("Error.. Minimo 13 digitos ");
                } else {
                    if ($("#nombres_cli").val() === "") {
                        $("#nombres_cli").focus();
                        alertify.alert("Ingrese Nombres completos");
                    } else {
                        if ($("#tipo_cli").val() === "") {
                            $("#tipo_cli").focus();
                            alertify.alert("Seleccione Tipo cliente");
                        } else {
                            if ($("#direccion_cli").val() === "") {
                                $("#direccion_cli").focus();
                                alertify.alert("Ingrese una dirección");
                            } else {
                                if ($("#pais_cli").val() === "") {
                                    $("#pais_cli").focus();
                                    alertify.alert("Ingrese un pais");
                                } else {
                                    if ($("#ciudad_cli").val() === "") {
                                        $("#ciudad_cli").focus();
                                        alertify.alert("Ingrese una ciudad");
                                    } else {
                                        if ($("#cupo_credito").val() === "") {
                                            $("#cupo_credito").focus();
                                            alertify.alert("Ingrese cantidad del crédito");
                                        }else{
                                            $.ajax({
                                                type: "POST",
                                                url: "../procesos/modificar_clientes.php",
                                                data: "tipo_docu=" + $("#tipo_docu").val() + "&ruc_ci=" + $("#ruc_ci").val() + "&id_cliente=" + $("#id_cliente").val() +
                                                "&nombres_cli=" + $("#nombres_cli").val() + "&tipo_cli=" + $("#tipo_cli").val() + "&direccion_cli=" + $("#direccion_cli").val() + "&nro_telefono=" + $("#nro_telefono").val() + "&nro_celular=" + $("#nro_celular").val() + "&pais_cli=" + $("#pais_cli").val() + "&ciudad_cli=" + $("#ciudad_cli").val() + "&email=" + $("#email").val() + "&cupo_credito=" + $("#cupo_credito").val() + "&notas_cli=" + $("#notas_cli").val(),
                                                success: function(data) {
                                                    var val = data;
                                                    if (val == 1) {
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
}

function eliminar_cliente() {
    if ($("#id_cliente").val() === "") {
        alertify.alert("Seleccione un cliente");
    } else {
        $("#clave_permiso").dialog("open");     
    }
}

function validar_acceso(){
    if($("#clave").val() == "") {
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
        url: "../procesos/eliminar_clientes.php",
        data: "id_cliente=" + $("#id_cliente").val(),
        success: function(data) {
            var val = data;
            if (val == 1) {
                alertify.alert("Cliente Eliminado Correctamente",function(){ location.reload();});
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

function nuevo_cliente() {
    location.reload();
}


function ValidNum() {
    if (event.keyCode < 48 || event.keyCode > 57) {
        event.returnValue = false;
    }
    return true;
}

function Num_Let() {
    if ((event.keyCode !== 32) && (event.keyCode < 65) || (event.keyCode > 90) && (event.keyCode < 97) || (event.keyCode > 122)) {
        event.returnValue = false;
    }
    return true;
}


$(function() {
    guidely.init({
        startTrigger: false
    });
});

function inicio() {

    $("#cupo_credito").keypress(function(e) {
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

    //////////atributos////////////
    $("#ruc_ci").attr("disabled", "disabled");
    $("#nro_telefono").validCampoFranz("0123456789");
    $("#nro_celular").validCampoFranz("0123456789");


    ///////tipo pago//////////////
    $("#tipo_docu").change(function() {
        if ($("#tipo_docu").val() === "Cedula") {
            $("#ruc_ci").val("");
            $("#ruc_ci").keypress(ValidNum);
            $("#ruc_ci").removeAttr("disabled");
            $("#ruc_ci").attr("maxlength", "10");

        } else {
            if ($("#tipo_docu").val() === "Ruc") {
                $("#ruc_ci").val("");
                $("#ruc_ci").keypress(ValidNum);
                $("#ruc_ci").removeAttr("disabled");
                $("#ruc_ci").removeAttr("maxlength");
                $("#ruc_ci").attr("maxlength", "13");
            } else {
                if ($("#tipo_docu").val() === "Pasaporte") {
                    $("#ruc_ci").val("");
                    $("#ruc_ci").unbind("keypress");
                    $("#ruc_ci").removeAttr("disabled");
                    $("#ruc_ci").attr("maxlength", "30");
                }
            }
        }
    });
    /////////////////////////////

 //////para validar cedula//////
    $("#ruc_ci").keyup(function() {
        var ci = $("#ruc_ci").val();
        var pares = 0;
        var impares = 0;
        var cont = 0;
        var total = 0;
        var residuo = 0;
        if ($("#tipo_docu option:selected").text() === "Cedula") {
            if ($("#ruc_ci").val().length === 10) {
                for (var i = 0; i < 9; i++) {
                    if (i % 2 === 0) {
                        if (parseInt(ci.charAt(i)) * 2 > 9) {
                            cont = (parseInt(ci.charAt(i)) * 2) - 9;
                        }
                        else {
                            cont = (parseInt(ci.charAt(i)) * 2);
                        }
                        impares = impares + cont;
                    }
                    else {
                        pares = pares + parseInt(ci.charAt(i));
                    }
                }
                total = pares + impares;
                if (total % 10 === 0) {
                }
                else {
                    residuo = total % 10;
                    residuo = 10 - residuo;
                    if (parseInt(ci.charAt(9)) === residuo) {
                    }
                    else {
                        alertify.alert("Error.... Cédula Incorrecta");
                        $("#ruc_ci").val("");
                    }
                }
            }
        }else{
            if ($("#tipo_docu option:selected").text() === "Ruc") {
                ///////////validar limite ruc////////////////
                var ruc_ci = ci.substr(10,13);
                ///////////////////////////////////
                
                ///////////////ruc/////////////////
                var ruc = $("#ruc_ci").val();
                digito3 = ruc.substring(2,3);
                var digito3 = ruc.substring(2,3);
                ///////////////////////////////////////
                
                if(ruc_ci == "001" ){
                    if(digito3 == 6){
                        var psuma = 0;
                        var pcadena = 0;
                        var p;
                        var presiduo;
                        var pveri;
                        for(p=1 ; p<9 ; p++){
                            if(p==1){
                                pcadena = ruc.substring(p-1,p);
                                pcadena = parseInt(pcadena)*3;
                                psuma+=parseInt(pcadena);
                            }else{
                                if(p==2){
                                    pcadena = ruc.substring(p-1,p);
                                    pcadena = parseInt(pcadena)*2;
                                    psuma+= parseInt(pcadena);
                                }else{
                                    if(p==3){
                                        pcadena = ruc.substring(p-1,p);
                                        pcadena = parseInt(pcadena)*7;
                                        psuma+= parseInt(pcadena);	
                                    }else{
                                        if (p==4){
                                            pcadena = ruc.substring(p-1,p);
                                            pcadena = parseInt(pcadena)*6;
                                            psuma+= parseInt(pcadena);
                                        }else{
                                            if (p==5){
                                                pcadena = ruc.substring(p-1,p);
                                                pcadena = parseInt(pcadena)*5;
                                                psuma+= parseInt(pcadena);
                                            }else{
                                                if (p==6){
                                                    pcadena = ruc.substring(p-1,p);
                                                    pcadena = parseInt(pcadena)*4;
                                                    psuma+= parseInt(pcadena);
                                                }else{
                                                    if (p==7){
                                                        pcadena = ruc.substring(p-1,p);
                                                        pcadena = parseInt(pcadena)*3;
                                                        psuma+= parseInt(pcadena);
                                                    }else{
                                                        if (p==8){
                                                            pcadena = ruc.substring(p-1,p);
                                                            pcadena = parseInt(pcadena)*2;
                                                            psuma+= parseInt(pcadena);
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        presiduo = (psuma%11);
                        presiduo = 11-presiduo;
                        pveri = ruc.substring(8,9);
                        if(presiduo != pveri){
                            alertify.alert("Error.... Ruc de personas Públicas incorrecto!!!");
                            $("#ruc_ci").val("");
                        }else{
                        // alert("Ruc pertenece a personas publicas");
                        }
                    }else{
                        if(digito3 == 9){
                            var jsuma = 0;
                            var jcadena= 0;
                            var jresiduo;
                            var jveri;
                            for(var j = 1 ; j<10; j++){
                                if(j==1){
                                    jcadena = ruc.substring(j-1,j);
                                    jcadena  =parseInt(jcadena)*4;
                                    jsuma+=parseInt(jcadena);
                                }else{
                                    if(j==2){
                                        jcadena = ruc.substring(j-1,j);
                                        jcadena  = parseInt(jcadena)*3;
                                        jsuma+=parseInt(jcadena);
                                    }else{
                                        if(j==3){
                                            jcadena = ruc.substring(j-1,j);
                                            jcadena  = parseInt(jcadena)*2;
                                            jsuma+=parseInt(jcadena);
                                        }else{
                                            if(j==4){
                                                jcadena = ruc.substring(j-1,j);
                                                jcadena  = parseInt(jcadena)*7;
                                                jsuma+=parseInt(jcadena);
                                            }else{
                                                if(j==5){
                                                    jcadena = ruc.substring(j-1,j);
                                                    jcadena  = parseInt(jcadena)*6;
                                                    jsuma+=parseInt(jcadena);
                                                }else{
                                                    if(j==6){
                                                        jcadena = ruc.substring(j-1,j);
                                                        jcadena  = parseInt(jcadena)*5;
                                                        jsuma+=parseInt(jcadena);
                                                    }else{
                                                        if(j==7){
                                                            jcadena = ruc.substring(j-1,j);
                                                            jcadena  =parseInt(jcadena)*4;
                                                            jsuma+=parseInt(jcadena);
                                                        }else{
                                                            if(j==8){
                                                                jcadena = ruc.substring(j-1,j);
                                                                jcadena  =parseInt(jcadena)*3;
                                                                jsuma+=parseInt(jcadena);
                                                            }else{
                                                                if(j==9){
                                                                    jcadena = ruc.substring(j-1,j);
                                                                    jcadena  =parseInt(jcadena)*2;
                                                                    jsuma+=parseInt(jcadena);
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
                            jresiduo = (jsuma % 11);
                            jresiduo = 11-jresiduo;
                            jveri = ruc.substring(9,10);
                            if(jresiduo!=jveri){
                                alertify.alert("Error.... Ruc de personas Jurídicas incorrecto!!!");
                                $("#ruc_ci").val("");
                            }else{
                            //alert("Ruc pertenece a personas juridicas");
                            }
                        }else{
                            if(digito3 < 6){
                                var ce = ci.substr(0,10);
                                for (i = 0; i < 9; i++) {
                                    if (i % 2 === 0) {
                                        if (parseInt(ce.charAt(i)) * 2 > 9) {
                                            cont = (parseInt(ce.charAt(i)) * 2) - 9;
                                        }
                                        else {
                                            cont = (parseInt(ce.charAt(i)) * 2);
                                        }
                                        impares = impares + cont;
                                    }
                                    else {
                                        pares = pares + parseInt(ce.charAt(i));
                                    }
                                }
                                total = pares + impares;
                                if (total % 10 === 0) {
                                }
                                else {
                                    residuo = total % 10;
                                    residuo = 10 - residuo;
                                    if (parseInt(ce.charAt(9)) === residuo) {
                                    //alert("Ruc pertenece a personas naturales");  
                                    }else {
                                        alertify.alert("Error.... Ruc de personas Naturales incorrecto!!!");
                                        $("#ruc_ci").val("");
                                    }
                                }
                            }
                        }
                    }                       
                }else{
                    if($("#ruc_ci").val().length === 13){
                        alertify.alert("Error.... Ruc Incorrecto!!!");
                        $("#ruc_ci").val("");
                    }
                }
            }
        }
    });
    //////////////////////

    /////valida si ya existe/////
    $("#ruc_ci").keyup(function() {
        $.ajax({
            type: "POST",
            url: "../procesos/comparar_cedulas.php",
            data: "cedula=" + $("#ruc_ci").val(),
            success: function(data) {
                var val = data;
                if (val == 1) {
                    $("#ruc_ci").val("");
                    $("#ruc_ci").focus();
                    alertify.alert("Error... El cliente esta registrado");
                }
            }
        });
    });
    ////////////////////////////////

    //////////////////////
    $("#btnGuardar").click(function(e) {
        e.preventDefault();
    });
    $("#btnModificar").click(function(e) {
        e.preventDefault();
    });
    $("#btnBuscar").click(function(e) {
        e.preventDefault();
    });
    $("#btnEliminar").click(function(e) {
        e.preventDefault();
    });
    $("#btnNuevo").click(function(e) {
        e.preventDefault();
    });
    //////////////////////////

    ///////////////////////////
    $("#btnGuardar").on("click", guardar_cliente);
    $("#btnModificar").on("click", modificar_cliente);
    $("#btnBuscar").on("click", abrirDialogo);
    $("#btnEliminar").on("click", eliminar_cliente);
    $("#btnAceptar").on("click", aceptar);
    $("#btnSalir").on("click", cancelar);
    $("#btnAcceder").on("click", validar_acceso);
    $("#btnCancelar").on("click", cancelar_acceso);
    $("#btnNuevo").on("click", nuevo_cliente);
    //////////////////////////

    /////////////////////////// 
    $("#clientes").dialog(dialogo);
    $("#clave_permiso").dialog(dialogo3);
    $("#seguro").dialog(dialogo4);
/////////////////////////// 

 
///////////////////////////////////////
  /////////////tabla clientes/////////
    jQuery("#list").jqGrid({
        url: '../xml/datos_clientes.php',
        datatype: 'xml',
        colNames: ['Codigo', 'Tipo Documento', 'Identificacion', 'Nombres', 'Tipo Cliente', 'Fijo', 'Movil', 'Pais', 'Ciudad', 'Direccion', 'Correo', 'Credito', 'Nota'],
        colModel: [
            {name: 'id_cliente', index: 'id_cliente', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'tipo_docu', index: 'tipo_docu', editable: true, align: 'center', width: '120', search: false, frozen: true, formoptions: {elmsuffix: " (*)"}, editrules: {required: true}},
            {name: 'ruc_ci', index: 'ruc_ci', editable: true, align: 'center', width: '120', search: true, frozen: true, formoptions: {elmsuffix: " (*)"}, editrules: {required: true}},
            {name: 'nombres_cli', index: 'nombres_cli', editable: true, align: 'center', width: '120', search: true, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'tipo_cli', index: 'tipo_cli', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'nro_telefono', index: 'nro_telefono', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'nro_celular', index: 'nro_celular', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'pais_cli', index: 'pais_cli', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'ciudad_cli', index: 'ciudad_cli', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'direccion_cli', index: 'direccion_cli', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'email', index: 'email', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'cupo_credito', index: 'cupo_credito', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}},
            {name: 'notas_cli', index: 'notas_cli', editable: true, align: 'center', width: '120', search: false, frozen: true, editoptions: {readonly: 'readonly'}, formoptions: {elmprefix: ""}}
        ],
        rowNum: 10,
        width: 830,
        rowList: [10, 20, 30],
        pager: jQuery('#pager'),
        sortname: 'id_cliente',
        shrinkToFit: false,
        sortorder: 'asc',
        caption: 'Lista de Clientes',
        editurl: 'procesos/estadio_del.php',
        viewrecords: true,
        ondblClickRow: function(){
         var id = jQuery("#list").jqGrid('getGridParam', 'selrow');
         jQuery('#list').jqGrid('restoreRow', id);   
         jQuery("#list").jqGrid('GridToForm', id, "#clientes_form");
         $("#btnGuardar").attr("disabled", true);
         $("#clientes").dialog("close");    
        }
    }).jqGrid('navGrid', '#pager',
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
    /////////////////		
    jQuery("#list").jqGrid('navButtonAdd', '#pager', {caption: "Añadir",
        onClickButton: function() {
            var id = jQuery("#list").jqGrid('getGridParam', 'selrow');
            jQuery('#list').jqGrid('restoreRow', id);
            if (id) {
                jQuery("#list").jqGrid('GridToForm', id, "#clientes_form");
                $("#btnGuardar").attr("disabled", true);
                $("#clientes").dialog("close");
            }
            else {
                alertify.alert("Seleccione un fila");
            }
        }
    });
}

