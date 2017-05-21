<#-- service层 接口文件-->
package ${service_package};

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import ${service_package}.${className}Service;
import ${query_package}.${className}Query;
<#if table.primaryKeyFields?size gt 1>
import ${pojo_package}.${className}Key;
</#if>
import ${pojo_package}.${className};

/**
 * 
 * @author fei
 *
 */
public interface ${className}Service {
	
	<#if table.primaryKeyFields?size = 1>
	public ${className} get${className}ByKey(${table.primaryKeyFields[0].dataType} ${table.primaryKeyFields[0].propertyName?uncap_first});
	</#if>
	<#if table.primaryKeyFields?size gt 1>
	public ${className} get${className}ByKey(${className?cap_first}Key ${className?uncap_first}Key);
	</#if>

	public void update(${className} ${className?uncap_first});
	
	public void add${className}(${className}  ${className?uncap_first});
	
	<#if table.primaryKeyFields?size = 1>
	public void deleteBy${table.primaryKeyFields[0].propertyName?cap_first}s(List<${table.primaryKeyFields[0].dataType}> ${table.primaryKeyFields[0].propertyName?uncap_first}s);
	</#if>
	
	SimplePage search(${className}Query ${className?uncap_first}Query);
	
	/**
	 * 检查某个属性值在数据库中的唯一性(排除自身),查找不到则说明该值插入之后唯一
	 * @param property 属性名称
	 * @param value 属性值
	 * @param ${table.primaryKeyFields[0].propertyName?uncap_first} 主键(不为null时，排除主键值等于该${table.primaryKeyFields[0].propertyName?uncap_first}的记录)
	 * @return true[数据库中除其本身以外没有该值]
	 */
	boolean checkUniqueness(String property, String value, ${table.primaryKeyFields[0].dataType } ${table.primaryKeyFields[0].propertyName?uncap_first}) throws CustomException;
}
