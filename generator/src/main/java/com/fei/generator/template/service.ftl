<#-- service层 接口文件-->
package ${service_package};
/**
 * 
 * @author fei
 *
 */
public interface ${className}Service {
	
	<#if table.primaryKeyFields?size = 1>
	public ${className} get${className}(${table.primaryKeyFields[0].dataType} ${table.primaryKeyFields[0].propertyName?uncap_first});
	</#if>

	<#if table.primaryKeyFields?size gt 1>
	public ${className} get${className}(${className?cap_first}Key ${className?uncap_first}Key);
	</#if>

	public void update(${className} ${className?uncap_first});
	
	public void add${className}(${className}  ${className?uncap_first});
	
	<#if table.primaryKeyFields?size = 1>
	public void delete${className}s(List<${table.primaryKeyFields[0].dataType}> ${table.primaryKeyFields[0].propertyName?uncap_first}s);
	</#if>
	
	//SimplePage search(${className}Query ${className?uncap_first}Query);
}
