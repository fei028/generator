$(function(){
	<#list table.fields as field>
	<#if field.dataType == "Date">
	$("#beginDate").on("click",function(){
		WdatePicker({dateFmt:'yyyy/MM/dd'});
	});
	
	$("#endDate").on("click",function(){
		WdatePicker({dateFmt:'yyyy/MM/dd'});
	});
	<#break>
	</#if>
	</#list>
	var tp = new $.fn.tp();
	tp.init({
		fields : [ 
		<#list table.fields as field>
		{
			field : "${field.propertyName?uncap_first}",
			text : '${field.columnComment }',
			width : "",
			isDateType : <#if field.dataType == "Date">true<#else>false</#if>,
			map : ''
		},
		</#list>
		],
		keyField: '${table.primaryKeyFields[0].propertyName?uncap_first}',
		modalAddTitle: '新增**',
		modalEditTitle: '修改**信息',
		searchFormEleNames: [
		<#list table.fields as field>
			'${field.propertyName?uncap_first}',
		</#list>
			'beginDate',
			'endDate'],
		getUrl: 'get${className?cap_first}.do',
		callback: {
			saveOrUpdateBefore: function(){
				<#list table.fields as field>
				var ${field.propertyName?uncap_first} = $.trim($("#${field.propertyName?uncap_first}").val());
				if(${field.propertyName?uncap_first} == ""){
					alert("输入的${field.columnComment }不能为空");
					return false;
				}
				</#list>
				return true;
			},
			// 新增或者修改时，需要在模态框中显示的数据，在此操作
			otherDataDisplay: function(){
			/*
				$.ajax({  
			        type: "POST",  
			        url: '####url',
			        data: '',  
			        dataType:"json",
			        async: false,
			        success: function(result){
			        	
			        }, 
			    });
			    */
			},
		}
	});
});