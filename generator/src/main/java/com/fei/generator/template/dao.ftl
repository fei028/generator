<#-- dao层 接口模版文件-->
package ${dao_package };

import java.util.List;

import org.apache.ibatis.annotations.Param;
<#if use_basedao_type == "1">
import ${base_dao_package}.BaseDao;
<#elseif use_basedao_type == "2">
import ${dependProjectCommonPackage}.common.dao.BaseDao;
</#if>
import ${pojo_package}.${className};
import ${query_package}.${className}Query;
<#if (table.primaryKeyFields?size gt 1)>
import ${pojo_package}.${className}Key;
</#if>
/**
 * 
 * @author ${author}
 *
 */
public interface ${className}${daoSuffix} <#if (table.primaryKeyFields?size = 1)><#if use_basedao_type != "0">extends Base<#if use_basedao_type == "1">${daoSuffix}<#else>Dao</#if><${className}, ${table.primaryKeyFields[0].dataType}, ${className}Query></#if></#if>{
<#if ((table.primaryKeyFields?size lt 1)) || use_basedao_type == "0">
	/**
	 * 新增,pojo中属性为NULL值不插入对应数据库中字段
	 * @param ${className?uncap_first}
	 */
	public void insertSelective(${className} ${className?uncap_first});
	/**
	* 批量插入
	* @param ${className?uncap_first}s
	*/
	public void batchInsert(List<${className}> ${className?uncap_first}s);
	<#if (table.primaryKeyFields?size = 1)>
	/**
	 * 通过主键删除
	 * @param ${table.primaryKeyFields[0].propertyName?uncap_first} 主键
	 */
	public void deleteBy${table.primaryKeyFields[0].propertyName?cap_first}(${table.primaryKeyFields[0].dataType} ${table.primaryKeyFields[0].propertyName?uncap_first});
	
	/**
	 * 批量删除
	 * @param ${table.primaryKeyFields[0].propertyName?cap_first}s 主键集合
	 */
	public void deleteBy${table.primaryKeyFields[0].propertyName?cap_first}s(List<${table.primaryKeyFields[0].dataType}> ${table.primaryKeyFields[0].propertyName}s);
	<#else>
	/**
	 * 通过主键删除
	 * @param ${className?uncap_first}Key 主键对象
	 */
	public void deleteBy${className?cap_first}Key(${className?cap_first}Key ${className?uncap_first}Key);
	
	</#if>

	/**
	 * 更新,pojo中属性为NULL值不更新对应数据库中字段
	 * @param ${className?uncap_first}
	 */
	public void update(${className} ${className?uncap_first});
	<#if (table.primaryKeyFields?size = 1)>
	/**
	 * 通过主键查询获取${className}对象
	 * @param ${table.primaryKeyFields[0].propertyName} 主键id
	 * @return ${className}对象
	 */
	public ${className} selectBy${table.primaryKeyFields[0].propertyName?cap_first}(${table.primaryKeyFields[0].dataType} ${table.primaryKeyFields[0].propertyName?uncap_first});
	<#else>
	/**
	 * 通过主键查询获取${className}对象
	 * @param ${className?uncap_first}Key 主键对象
	 * @return ${className}对象
	 */
	public ${className} selectBy${className?cap_first}Key(${className?cap_first}Key ${className?uncap_first}Key);
	</#if>

	/**
	 * 条件查询
	 * @param ${className?uncap_first}Query
	 * @return 符合条件的结果集
	 */
	public List<${className}> select${className}sWithCondition(${className}Query ${className?uncap_first}Query);
	
	/**
	 * 条件查询,对应结果集记录总数
	 * @param ${className?uncap_first}Query
	 * @return 记录总数
	 */
	public Long getCountWithCondition(${className}Query ${className?uncap_first}Query);
	
	<#if  (table.primaryKeyFields?size = 1)>
	/**
	 * 获取符合查询条件的对象的主键集合
	 * @param ${className?uncap_first}Query
	 * @return 主键集合
	 */
	public List<Integer> get${table.primaryKeyFields[0].propertyName?cap_first}s(${className}Query ${className?uncap_first}Query);
	</#if>
</#if>
}
