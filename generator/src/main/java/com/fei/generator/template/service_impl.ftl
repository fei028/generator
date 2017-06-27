<#-- Service层 实现文件-->
package ${service_package};
<#if use_baseservice_type == "0">
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
</#if>
import org.apache.commons.lang.StringUtils;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ${dao_package}.${className}${daoSuffix};
import ${service_package}.${className}Service;
import ${query_package}.${className}Query;
<#if table.primaryKeyFields?size gt 1>
import ${pojo_package}.${className}Key;
</#if>
<#if dependProjectCommonPackage == "">
<#if use_baseservice_type != "0">
import ${common_package}.service.BaseServiceImpl;
</#if>
import ${common_package}.common.page.SimplePage;
import ${common_package}.utils.SearchUtils;
import ${common_package}.utils.Underline2CamelUtils;
import ${common_package}.web.exception.CustomException;
<#else>
import ${dependProjectCommonPackage}.common.service.BaseServiceImpl;
</#if>
import ${pojo_package}.${className};

/**
 * 
 * @author ${author}
 *
 */
@Service
@Transactional(readOnly = true)
public class ${className}ServiceImpl <#if (table.primaryKeyFields?size = 1)><#if use_baseservice_type != "0">extends BaseServiceImpl<${className}, ${table.primaryKeyFields[0].dataType}, ${className}Query></#if></#if> implements ${className}Service{
	<#if ((table.primaryKeyFields?size lt 1)) || use_baseservice_type == "0">
	private static final Logger logger = LoggerFactory.getLogger(${className}ServiceImpl.class);
	</#if>
	private ${className}${daoSuffix} ${className?uncap_first}${daoSuffix};
	@Autowired
	public void set${className}${daoSuffix}(${className}${daoSuffix} ${className?uncap_first}${daoSuffix}){
		this.${className?uncap_first}${daoSuffix} = ${className?uncap_first}${daoSuffix};
		<#if use_baseservice_type != "0">
		setBaseDao(${className?uncap_first}${daoSuffix});
		</#if>
	}
	<#if ((table.primaryKeyFields?size != 1)) || use_baseservice_type == "0">
	<#if table.primaryKeyFields?size = 1>
	@Override
	public ${className} get${className}ByKey(${table.primaryKeyFields[0].dataType} ${table.primaryKeyFields[0].propertyName?uncap_first}){
		
		if(${table.primaryKeyFields[0].propertyName?uncap_first} != null){
			return ${className?uncap_first}${daoSuffix}.selectBy<#if use_basedao_type == "0">${table.primaryKeyFields[0].propertyName?cap_first}<#else>Key</#if>(${table.primaryKeyFields[0].propertyName?uncap_first});
		}
		return null;
	}
	</#if>
	<#if table.primaryKeyFields?size gt 1>
	@Override
	public ${className} get${className}ByKey(${className?cap_first}Key ${className?uncap_first}Key){
		if(${className?uncap_first}Key != null){
			retrun ${className?uncap_first}${daoSuffix}.selectBy${className?cap_first}Key(${className?uncap_first}Key);
		}
		return ${className?uncap_first};
	}
	</#if>

	@Transactional(readOnly = false)
	@Override
	public void update(${className} ${className?uncap_first}){
		if(${className?uncap_first} != null){
			${className?uncap_first}${daoSuffix}.update(${className?uncap_first});
		}
	}
	<#if table.primaryKeyFields?size = 1>
	@Transactional(readOnly = false)
	@Override
	public ${table.primaryKeyFields[0].dataType} add${className}(${className} ${className?uncap_first}){
		${className?uncap_first}${daoSuffix}.insertSelective(${className?uncap_first});
		return ${className?uncap_first}.get${table.primaryKeyFields[0].propertyName?cap_first}();
	}
	</#if> 
	@Transactional(readOnly = false)
	@Override
	public void batchInsert(List<${className}> ${className?uncap_first}s){
		if(${className?uncap_first}s != null && !${className?uncap_first}s.isEmpty()){
			${className?uncap_first}${daoSuffix}.batchInsert(${className?uncap_first}s);
		}
	}

    <#if table.primaryKeyFields?size = 1>
	@Transactional(readOnly = false)
	@Override
	public void deleteBy${table.primaryKeyFields[0].propertyName?cap_first}s(List<${table.primaryKeyFields[0].dataType}> ${table.primaryKeyFields[0].propertyName?uncap_first}s){
		if(${table.primaryKeyFields[0].propertyName?uncap_first}s != null && !${table.primaryKeyFields[0].propertyName?uncap_first}s.isEmpty()){
			${className?uncap_first}${daoSuffix}.deleteBy<#if use_basedao_type == "0">${table.primaryKeyFields[0].propertyName?cap_first}<#else>Key</#if>s(${table.primaryKeyFields[0].propertyName?uncap_first}s);
		}
	}
	</#if>
	
	@Override
	public SimplePage search(${className}Query ${className?uncap_first}Query) {
		
		// if ${className?uncap_first}Query 为null,则查询全部
		if(${className?uncap_first}Query == null){
			${className?uncap_first}Query = new ${className}Query();
		}
		
		// 获取记录总数 
		long totalCount = ${className?uncap_first}${daoSuffix}.getCountWithCondition(${className?uncap_first}Query);
		// 当前页记录集合[当没有符合的记录时,放弃列表的查询]
		List<${className}> list = null;
		if(totalCount > 0){
			SearchUtils.handleQueryObject(${className?uncap_first}Query, totalCount);
			list = ${className?uncap_first}${daoSuffix}.select<#if use_basedao_type == "0">${className}<#else>Object</#if>sWithCondition(${className?uncap_first}Query);
		} 
		SimplePage page = new SimplePage(${className?uncap_first}Query.getPageNo(), ${className?uncap_first}Query.getPageSize(), ${className?uncap_first}Query.getStartRow(), totalCount);
		page.setList(list);
		
		return page;
	}
	<#if table.primaryKeyFields?size = 1>
	@Override
	public boolean checkUniqueness(String property, String value, ${table.primaryKeyFields[0].dataType } ${table.primaryKeyFields[0].propertyName?uncap_first}) throws CustomException {
		if(StringUtils.isNotBlank(property) && StringUtils.isNotBlank(value)){
			${className?cap_first}Query ${className?uncap_first}Query = new ${className?cap_first}Query();
			${className?uncap_first}Query.setPageNo(1);
			${className?uncap_first}Query.setPageSize(2);
			
			${className?uncap_first}Query.setFields("${table.primaryKeyFields[0].columnName}," + Underline2CamelUtils.camel2Underline(property));
			Field field = null;
			try {
				field = ${className?uncap_first}Query.getClass().getDeclaredField(property);
				if(field != null){
					field.setAccessible(true);
					field.set(${className?uncap_first}Query, value);
					logger.debug("属性名称:{},值:{}", property, value);
				} else {
					logger.error("属性名称(property):{}, ${className?uncap_first}Query.getClass().getDeclaredField(property)获取Field为null", property);
					throw new CustomException("检查属性名称是否设置错误");
				}
			} catch (NoSuchFieldException | SecurityException | IllegalArgumentException | IllegalAccessException e) {
				logger.error("反射获取Field异常:", e);
				throw new CustomException("检查属性名称是否设置错误");
			}
			
			List<${className?cap_first}> ${className?uncap_first}s = ${className?uncap_first}Dao.select<#if use_basedao_type == "0">${className?cap_first}<#else>Object</#if>sWithCondition(${className?uncap_first}Query);
			if(${className?uncap_first}s == null || ${className?uncap_first}s.isEmpty()){
				return true;
			} else {
				if(${className?uncap_first}s.size() == 1 ){
					${className?cap_first} ${className?uncap_first} = ${className?uncap_first}s.get(0);
					return ${className?uncap_first}.get${table.primaryKeyFields[0].propertyName?cap_first}().equals(${table.primaryKeyFields[0].propertyName?uncap_first});
				}
			}
		}
		return false;
	}
	</#if>
	<#else>
	<#if table.primaryKeyFields?size == 1>
	@Override
	protected ${table.primaryKeyFields[0].dataType} getKeyValue(${className?cap_first} ${className?uncap_first}) {
		return ${className?uncap_first}.get${table.primaryKeyFields[0].propertyName?cap_first}();
	}

	@Override
	protected String getKeyPropertyName() {
		return "${table.primaryKeyFields[0].propertyName?uncap_first}";
	}
	
	@Override
	public void setLogger() {
		logger = LoggerFactory.getLogger(${className?cap_first}ServiceImpl.class);
	}
	</#if>
    </#if>
}
