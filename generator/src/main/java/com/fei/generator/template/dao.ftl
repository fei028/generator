<#-- dao层 接口模版文件-->
package ${dao_package};

import java.util.List;

import ${pojo_package}.${className};
import ${query_package}.${className}Query;
/**
 * 
 * @author fei
 *
 */
public interface ${className}Dao {

	/**
	 * 新增,pojo中属性为NULL值不插入对应数据库中字段
	 * @param ${className?uncap_first}
	 * @return
	 */
	public void insertSelective(${className} ${className?uncap_first});
	
	/**
	 * 通过主键删除
	 * @param 
	 */
	public void deleteBy${table.primaryKeyField.columnName?cap_first}(${table.primaryKeyField.dataType} ${table.primaryKeyField.columnName?uncap_first});
	
	/**
	 * 批量删除
	 * @param ${table.primaryKeyField.columnName?cap_first}s 主键集合
	 */
	public void deleteBy${table.primaryKeyField.columnName?cap_first}s(${table.primaryKeyField.dataType}[] ${table.primaryKeyField.columnName}s);
	
	/**
	 * 更新,pojo中属性为NULL值不更新对应数据库中字段
	 * @param ${className?uncap_first}
	 */
	public void update(${className} ${className?uncap_first});
	
	/**
	 * 通过主键查询获取${className}对象
	 * @param ${table.primaryKeyField.columnName} 主键id
	 * @return ${className}对象
	 */
	public ${className} selectBy${table.primaryKeyField.columnName?cap_first}(${table.primaryKeyField.dataType} ${table.primaryKeyField.columnName?uncap_first});
	
	/**
	 * 通过主键集合查询获取${className}对象集合
	 * @param ${table.primaryKeyField.columnName} 主键id
	 * @return ${className}对象集合
	 */
	public List<${className}> selectBy${table.primaryKeyField.columnName?cap_first}s(List<${table.primaryKeyField.dataType}> ${table.primaryKeyField.columnName?uncap_first}s);
	
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
	
}
