<#-- Service层 实现文件-->
package ${service_package};

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
@Service
@Transactional(readOnly = true)
public class ${className}ServiceImpl implements ${className}Service{

	@Autowired
	private ${className}Dao ${className?uncap_first}Dao;
	
	<#if table.primaryKeyFields?size = 1>
	@Override
	public ${className} get${className}ByKey(${table.primaryKeyFields[0].dataType} ${table.primaryKeyFields[0].propertyName?uncap_first}){
		
		if(${table.primaryKeyFields[0].propertyName?uncap_first} != null){
			return ${className?uncap_first}Dao.selectBy${table.primaryKeyFields[0].propertyName?cap_first}(${table.primaryKeyFields[0].propertyName?uncap_first});
		}
		return null;
	}
	</#if>
	<#if table.primaryKeyFields?size gt 1>
	@Override
	public ${className} get${className}ByKey(${className?cap_first}Key ${className?uncap_first}Key){
		if(${className?uncap_first}Key != null){
			retrun ${className?uncap_first}Dao.selectBy${className?cap_first}Key(${className?uncap_first}Key);
		}
		return ${className?uncap_first};
	}
	</#if>

	@Transactional(readOnly = false)
	@Override
	public void update(${className} ${className?uncap_first}){
		if(${className?uncap_first} != null){
			${className?uncap_first}Dao.update(${className?uncap_first});
		}
	}
	
	@Transactional(readOnly = false)
	@Override
	public void add${className}(${className}  ${className?uncap_first}){
		${className?uncap_first}Dao.insertSelective(${className?uncap_first});
	}
	
	<#if table.primaryKeyFields?size = 1>
	@Transactional(readOnly = false)
	@Override
	public void deleteBy${table.primaryKeyFields[0].propertyName?cap_first}s(List<${table.primaryKeyFields[0].dataType}> ${table.primaryKeyFields[0].propertyName?uncap_first}s){
		if(${table.primaryKeyFields[0].propertyName?uncap_first}s != null && !${table.primaryKeyFields[0].propertyName?uncap_first}s.isEmpty()){
			${className?uncap_first}Dao.deleteBy${table.primaryKeyFields[0].propertyName?cap_first}s(${table.primaryKeyFields[0].propertyName?uncap_first}s);
		}
	}
	</#if>
	
	@Override
	public SimplePage search(${className}Query ${className?uncap_first}Query) {
		
		// if ${className?uncap_first}Query 为null,则查询全部
		if(${className?uncap_first}Query == null){
			${className?uncap_first}Query = new ${className}Query();
		}
		
		if(${className?uncap_first}Query.getEndDate() == null){
			//${className?uncap_first}Query.setEndDate(new Date());
		}
		// 获取记录总数 
		long totalCount = ${className?uncap_first}Dao.getCountWithCondition(${className?uncap_first}Query);
		// 当前页记录集合[当没有符合的记录时,放弃列表的查询]
		List<${className}> list = null;
		if(totalCount > 0){
			SearchUtils.handleQueryObject(${className?uncap_first}Query, totalCount);
			list = ${className?uncap_first}Dao.select${className}sWithCondition(${className?uncap_first}Query);
		} 
		SimplePage page = new SimplePage(${className?uncap_first}Query.getPageNo(), ${className?uncap_first}Query.getPageSize(), ${className?uncap_first}Query.getStartRow(), totalCount);
		page.setList(list);
		
		return page;
	}

}
