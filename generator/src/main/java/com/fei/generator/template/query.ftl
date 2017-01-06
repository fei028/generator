<#-- 查询对象 模版文件 -->
package ${query_package};

import ${base_query_package}.BaseQuery;
import java.util.Date;
/**
 * 
 * @author fei
 *
 */
public class ${className}Query extends BaseQuery{
	
	/**        设置批量条件查询where条件  set属性 在sql语句里相当于在where条件中 属性对应字段 = 设置的属性值     **/
	
	<#list table.primaryKeyFields as field>
	/** ${field.columnComment} */
	private ${field.dataType} ${field.propertyName?uncap_first}; // 主键
	</#list>
	<#list table.fields as field>
	/** ${field.columnComment} */
	private ${field.dataType} ${field.propertyName?uncap_first};
	</#list>
	
	<#list table.primaryKeyFields as field>
	public ${field.dataType} get${field.propertyName?cap_first}() {
		return ${field.propertyName?uncap_first};
	}

	public ${className}Query set${field.propertyName?cap_first}(${field.dataType} ${field.propertyName?uncap_first}) {
		<#if field.dataType == "String">
		this.${field.propertyName?uncap_first} = ${field.propertyName?uncap_first} == null ? null : ${field.propertyName?uncap_first}.trim();
		<#else>
		this.${field.propertyName?uncap_first} = ${field.propertyName?uncap_first};
		</#if>
		return this;
	}
	</#list>
	<#list table.fields as field>
	public ${field.dataType} get${field.propertyName?cap_first}() {
		return ${field.propertyName?uncap_first};
	}

	public ${className}Query set${field.propertyName?cap_first}(${field.dataType} ${field.propertyName?uncap_first}) {
		<#if field.dataType == "String">
		this.${field.propertyName?uncap_first} = ${field.propertyName?uncap_first} == null ? null : ${field.propertyName?uncap_first}.trim();
		<#else>
		this.${field.propertyName?uncap_first} = ${field.propertyName?uncap_first};
		</#if>
		return this;
	}
	</#list>
	/**        设置批量条件查询where条件  end       **/
	
	/**      设置排序字段 start                  **/
	<#list table.primaryKeyFields as field>
	/**
	 * 设置排序按属性：${field.propertyName?uncap_first}
	 * 
	 * @param isAsc true升序，否则为降序
	 *            
	 */
	public ${className}Query orderby${field.propertyName?cap_first}(boolean isAsc) {
		orderByFields.add(new OrderField("${field.columnName}", isAsc ? OrderField.ORDER_ASC : OrderField.ORDER_DESC));
		return this;
	}
	</#list>
	<#list table.fields as field>
	/**
	 * 设置排序按属性：${field.propertyName?uncap_first}
	 * 
	 * @param isAsc true升序，否则为降序
	 *            
	 */
	public ${className}Query orderby${field.propertyName?cap_first}(boolean isAsc) {
		orderByFields.add(new OrderField("${field.columnName}", isAsc ? OrderField.ORDER_ASC : OrderField.ORDER_DESC));
		return this;
	}
	</#list>
	/**      设置排序字段  end                   **/
}