<#-- dao层 实现模版文件-->
package ${dao_impl_package};

import java.util.List;

import ${dao_package}.${className}Dao;
import ${pojo_package}.${className};
import ${query_package}.${className}Query;
/**
 * 
 * @author fei
 *
 */
public class ${className}DaoImpl implements ${className}Dao {

	@Override
	public void insertSelective(${className} ${className?uncap_first}){
	
	}
	
	@Override
	public void deleteBy${table.primaryKeyFields[0].columnName?cap_first}(${table.primaryKeyFields[0].dataType} ${table.primaryKeyFields[0].columnName?uncap_first}){
	
	}
	
	@Override
	public void update(${className} ${className?uncap_first}){
	
	}
	
	@Override
	public ${className} selectBy${table.primaryKeyFields[0].columnName?cap_first}(${table.primaryKeyFields[0].dataType} ${table.primaryKeyFields[0].columnName?uncap_first}){
		${className} ${className?uncap_first} = null;
		
		return ${className?uncap_first};
	}
	<#if table.primaryKeyFields?size = 1>
	@Override
	public List<${className}> selectBy${table.primaryKeyFields[0].columnName?cap_first}s(List<${table.primaryKeyFields[0].dataType}> ${table.primaryKeyFields[0].columnName?uncap_first}s){
		List<${className}> ${className?uncap_first}s = null;
		
		return ${className?uncap_first}s;
	}
	</#if>

	@Override
	public List<${className}> select${className}sWithCondition(${className}Query ${className?uncap_first}Query){
		List<${className}> ${className?uncap_first}s = null;
		
		return ${className?uncap_first}s;
	}
	
	@Override
	public Long getCountWithCondition(${className}Query ${className?uncap_first}Query){
		Long count = null;
		
		return count;
	
	}
	
	@Override
	public void deleteBy${table.primaryKeyFields[0].columnName?cap_first}s(${table.primaryKeyFields[0].dataType}[] ${table.primaryKeyFields[0].columnName}s){
	
	}

}