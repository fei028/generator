<#-- pojo 模版文件 -->
package ${pojo_package};

import java.io.Serializable;

/**
 * 
 * @author ${author}
 *
 */
public class ${className}Key implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
    <#list table.primaryKeyFields as field>
	/** ${field.columnComment} */ 
	private ${field.dataType} ${field.propertyName?uncap_first}; // 主键 ${field.nullAble?string('非','')}必须
	</#list>

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
}