<#-- pojo 模版文件 -->
package ${pojo_package};
<#if table.primaryKeyFields?size = 1>
import java.io.Serializable;
</#if>
import java.util.Date;

<#if table.primaryKeyFields?size gt 1>
import ${pojo_package}.${className}Key;
</#if>

/**
 * 
 * @author fei
 *
 */
<#if table.primaryKeyFields?size gt 1>
@SuppressWarnings("serial")
</#if>
public class ${className} <#if table.primaryKeyFields?size gt 1>extends ${className}Key<#else> implements Serializable</#if>{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	<#if table.primaryKeyFields?size = 1>
	<#list table.primaryKeyFields as field>
	/** ${field.columnComment} */ 
	private ${field.dataType} ${field.propertyName?uncap_first}; // 主键 ${field.nullAble?string('非','')}必须
	</#list>
	</#if>
	<#list table.fields as field>
	/** ${field.columnComment} */ 
	private ${field.dataType} ${field.propertyName?uncap_first}; // ${field.nullAble?string('非','')}必须
	</#list>
	
<#if table.primaryKeyFields?size = 1>
	<#list table.primaryKeyFields as field>
	public ${field.dataType} get${field.propertyName?cap_first}() {
		return ${field.propertyName?uncap_first};
	}

	public void set${field.propertyName?cap_first}(${field.dataType} ${field.propertyName?uncap_first}) {
		<#if field.dataType == "String">
		this.${field.propertyName?uncap_first} = ${field.propertyName?uncap_first} == null ? null : ${field.propertyName?uncap_first}.trim();
		<#else>
		this.${field.propertyName?uncap_first} = ${field.propertyName?uncap_first};
		</#if>
	}
	</#list>
</#if>
	<#list table.fields as field>
	public ${field.dataType} get${field.propertyName?cap_first}() {
		return ${field.propertyName?uncap_first};
	}

	public void set${field.propertyName?cap_first}(${field.dataType} ${field.propertyName?uncap_first}) {
		<#if field.dataType == "String">
		this.${field.propertyName?uncap_first} = ${field.propertyName?uncap_first} == null ? null : ${field.propertyName?uncap_first}.trim();
		<#else>
		this.${field.propertyName?uncap_first} = ${field.propertyName?uncap_first};
		</#if>
	}
	</#list>

}
