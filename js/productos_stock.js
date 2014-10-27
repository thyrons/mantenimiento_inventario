$(document).on("ready", inicio);

$(function() {
    $('#main-menu').smartmenus({
        subMenusSubOffsetX: 1,
        subMenusSubOffsetY: -8
    });
});

function inicio() {
    $(window).bind('resize', function() {
    jQuery("#list").setGridWidth($('#centro').width() - 10);
    }).trigger('resize');
    
    jQuery("#list").jqGrid({
        url: '../xml/datos_productos2.php',
        datatype: 'xml',
        colNames: ['ID', 'CÓDIGO', 'ARTICULO', 'PRECIO COSTO', 'STOCK'],
        colModel: [
            {name: 'cod_productos', index: 'cod_productos', editable: true, align: 'center', width: '100', search: false, frozen: true, editoptions: {readonly: 'readonly'}},
            {name: 'codigo', index: 'codigo', editable: true, align: 'center', width: '150', size: '10', search: true, frozen: true, formoptions: {elmsuffix: " (*)"}, editrules: {required: true}},
            {name: 'articulo', index: 'articulo', editable: true, align: 'center', width: '300', search: true, frozen: true, formoptions: {elmsuffix: " (*)"}, editrules: {required: true}},
            {name: 'precio_compra', index: 'precio_compra', editable: true, align: 'center', width: '140', search: true, frozen: true, formoptions: {elmsuffix: " (*)"}, editrules: {required: true}},
            {name: 'stock', index: 'stock', editable: true, align: 'center', width: '140', search: false},
        ],
        rowNum: 10,
        rowList: [10, 20, 30],
        width: null,
        height: 230,
        pager: jQuery('#pager'),
        editurl: "../procesos/procesosUsuarios.php",
        sortname: 'cod_productos',
        shrinkToFit: false,
        sortordezr: 'asc',
        caption: 'Lista Productos',
        viewrecords: true,
        onSelectRow: function(rowid) {
       var id = jQuery("#list").jqGrid('getGridParam', 'selrow');
       jQuery('#list').jqGrid('restoreRow', id);
       var ret = jQuery("#list").jqGrid('getRowData', id);
       
       jQuery("#list2").jqGrid('addRowData',rowid,{cod_productos: ret.cod_productos, codigo2: ret.codigo, articulo2: ret.articulo}).trigger('reloadGrid');
        }
    }).jqGrid('navGrid', '#pager',
            {
                add: false,
                edit: false,
                del: false,
                refresh: true,
                search: true,
                view: true,
                viewtext: "Consultar",
                searchtext: "Buscar"
            },
    {
        recreateForm: true, closeAfterEdit: true, checkOnUpdate: true, reloadAfterSubmit: true, closeOnEscape: true
    },
    {
        reloadAfterSubmit: true, closeAfterAdd: true, checkOnUpdate: true, closeOnEscape: true,
        bottominfo: "Los campos marcados con (*) son obligatorios", width: 350, checkOnSubmit: false
    },
    {
        width: 300, closeOnEscape: true
    },
    {
        closeOnEscape: true,
        multipleSearch: false, overlay: false
    },
    {
        closeOnEscape: true,
        width: 400
    },
    {
        closeOnEscape: true
    });
    $("#search_codigo").keyup(function() {
      $("#list").jqGrid('setGridParam', {url: '../xml/search.php?valor=' + $("#search_codigo").val(), datatype: 'xml'}).trigger('reloadGrid');
    });
    
     $("#search_producto").keyup(function() {
      $("#list").jqGrid('setGridParam', {url: '../xml/search2.php?valor=' + $("#search_producto").val(), datatype: 'xml'}).trigger('reloadGrid');
    });
    
//    var timeoutHnd;
//    var flAuto = false;  
//    
//    function doSearch(ev){
//	if(!flAuto)
//		return;
////	var elem = ev.target||ev.srcElement;
//	if(timeoutHnd)
//		clearTimeout(timeoutHnd)
//	timeoutHnd = setTimeout(gridReload,500)
//}
//
//function gridReload(){
//	var nm_mask = jQuery("#item_nm").val();
//	var cd_mask = jQuery("#search_cd").val();
//	jQuery("#list").jqGrid('setGridParam',{url:"bigset.php?nm_mask="+nm_mask+"&cd_mask="+cd_mask,page:1}).trigger("reloadGrid");
//}
//function enableAutosubmit(state){
//	flAuto = state;
//	jQuery("#submitButton").attr("disabled",state);
//}

    
    jQuery("#list2").jqGrid({
	height: 100,
	datatype: "local",
   	colNames:['Cod','Codigo','Productos', 'Cantidad'],
   	colModel:[
                {name:'cod_productos',index:'cod_productos', width:50, hidden: true},
                {name:'codigo2',index:'codigo2', width:250},
   		{name:'articulo2',index:'articulo2', width:300},
   		{name:'cantidad',index:'cantidad', width:80, editable: true, align:"right"},
   	],
   	rowNum:5,
   	rowList:[5,10,20],
   	pager: '#pager2',
   	sortname: 'item',
        viewrecords: true,
        sortorder: "asc",
	multiselect: true,
	caption:"Productos Asignados"
}).navGrid('#pager2',{
    add:false,
    edit:false,
    del:false,
    refresh: true,
    view: true,
    viewtext: "Consultar",
    searchtext: "Buscar"
});
jQuery("#ms1").click( function() {
	var s;
	s = jQuery("#list10_d").jqGrid('getGridParam','selarrrow');
	alert(s);
});

    jQuery("#list").jqGrid('setFrozenColumns');
    jQuery("#list").setGridWidth($('#centro').width() - 10);
}

function Defecto(e) {
    e.preventDefault();
}

