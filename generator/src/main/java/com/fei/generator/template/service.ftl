<#-- service层 接口文件-->
package ${service_package};

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import ${dao_package}.${className}Dao;
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
	
	//SimplePage search(${className}Query ${className?uncap_first}Query);
}
