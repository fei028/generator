<#-- pojo 模版文件 -->
package ${pojo_package};

import java.io.Serializable;
import java.util.Date;

/**
 * 
 * @author fei
 *
 */
public class ${className} implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	<#list table.fields as field>
	/** ${field.columnComment} */ 
	private ${field.dataType} ${field.columnName?uncap_first}; // ${field.nullAble?string('非','')}必须
	</#list>
	
	<#list table.fields as field>
	public ${field.dataType} get${field.columnName?cap_first}() {
		return ${field.columnName?uncap_first};
	}

	public void set${field.columnName?cap_first}(${field.dataType} ${field.columnName?uncap_first}) {
		<#if field.dataType == "String">
		this.${field.columnName?uncap_first} = ${field.columnName?uncap_first} == null ? null : ${field.columnName?uncap_first}.trim();
		<#else>
		this.${field.columnName?uncap_first} = ${field.columnName?uncap_first};
		</#if>
		
	}
	</#list>

}
