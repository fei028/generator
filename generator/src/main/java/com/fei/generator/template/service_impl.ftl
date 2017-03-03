<#-- Service层 实现文件-->
package ${service_package};

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Dao;
import org.springframework.transaction.annotation.Transactional;

import ${dao_package}.${className}Dao;
import ${service_package}.${className}Dao;

/**
 * 
 * @author fei
 *
 */
@Dao
@Transactional(readOnly = true)
public class ${className}DaoImpl implements ${className}Dao{

	@Autowired
	private ${className}Dao ${className?uncap_first}Dao;
	
	<#if table.primaryKeyFields?size = 1>
	@Override
	public ${className} get${className}(${table.primaryKeyFields[0].dataType} ${table.primaryKeyFields[0].propertyName?uncap_first}){
		
		if(${table.primaryKeyFields[0].propertyName?uncap_first} != null){
			return ${className?uncap_first}Dao.selectBy${table.primaryKeyFields[0].propertyName?cap_first}(${table.primaryKeyFields[0].propertyName?uncap_first});
		}
		return null;
	}
	</#if>
	<#if table.primaryKeyFields?size gt 1>
	@Override
	public ${className} get${className}(${className?cap_first}Key ${className?uncap_first}Key){
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
	public void delete${className}s(List<${table.primaryKeyFields[0].dataType}> ${table.primaryKeyFields[0].propertyName?uncap_first}s,HttpServletRequest request){
		if(${table.primaryKeyFields[0].propertyName?uncap_first}s != null && !${table.primaryKeyFields[0].propertyName?uncap_first}s.isEmpty()){
			${className?uncap_first}Dao.delete${className}s(${table.primaryKeyFields[0].propertyName?uncap_first}s);
		}
	}
	</#if>
	/*
	@Override
	public SimplePage search(${className}Query ${className?uncap_first}Query) {
		
		// if ${className?uncap_first}Query 为null,则查询全部
		if(${className?uncap_first}Query == null){
			${className?uncap_first}Query = new ${className}Query();
		}
		
		if(${className?uncap_first}Query.getEndDate() == null){
			${className?uncap_first}Query.setEndDate(new Date());
		}
		// 获取记录总数 
		long totalCount = ${className?uncap_first}Dao.getCountWithCondition(${className?uncap_first}Query);
		// 当前页记录集合[当没有符合的记录时,放弃列表的查询]
		List<${className}> list = null;
		if(totalCount > 0){
			SearchUtils.handleQueryObject(${className?uncap_first}Query, totalCount);
			List<Integer> ${table.primaryKeyFields[0].propertyName?uncap_first}s = ${className?uncap_first}Dao.get${table.primaryKeyFields[0].propertyName?uncap_first}s(${className?uncap_first}Query);
			Map<String,Object> map = new HashMap<>(2);
			// 设置查询字段
			String fields = ${className?uncap_first}Query.getFields();
			map.put("fields", fields);
			map.put("${table.primaryKeyFields[0].propertyName?uncap_first}s", ${table.primaryKeyFields[0].propertyName?uncap_first}s);
			list = ${className?uncap_first}Dao.selectBy${table.primaryKeyFields[0].propertyName?uncap_first}s(map);
		} 
		SimplePage page = new SimplePage(${className?uncap_first}Query.getPageNo(), ${className?uncap_first}Query.getPageSize(), ${className?uncap_first}Query.getStartRow(), totalCount);
		page.setList(list);
		
		return page;
	}
	*/
}
