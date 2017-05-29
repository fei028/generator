<#-- 查询对象 模版文件 -->
package ${query_package};

import ${common_package}.common.enumeration.SqlLike;

import ${base_query_package}.BaseQuery;
import java.util.Date;
/**
 * 
 * @author ${author}
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
	<#if field.dataType == 'String'>
    /** ${field.columnComment}模糊查询，默认null 不模糊*/
	private String ${field.propertyName?uncap_first}Like;
	</#if>
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

	<#if field.dataType == 'String'>
	public ${className}Query set${field.propertyName?cap_first}Like(SqlLike likeType){
		// 用户模糊查询时，设置模糊查询字段值
		if(this.${field.propertyName?uncap_first} != null && likeType != null && likeType != SqlLike.NO_LIKE){
			String ${field.propertyName?uncap_first}AfterEscape = sqlLikeWildcardEscape(${field.propertyName?uncap_first});
			if (likeType == SqlLike.ALL){
				this.${field.propertyName?uncap_first}Like = PERCENT_SIGN + ${field.propertyName?uncap_first}AfterEscape + PERCENT_SIGN;
			} else if(likeType == SqlLike.LEFT_LIKE){
    			this.${field.propertyName?uncap_first}Like = PERCENT_SIGN + ${field.propertyName?uncap_first}AfterEscape;
			} else if(likeType == SqlLike.RIGHT_LIKE){
    			this.${field.propertyName?uncap_first}Like = ${field.propertyName?uncap_first}AfterEscape + PERCENT_SIGN;
			}
		}
		return this;
	}
	
	public String get${field.propertyName?cap_first}Like() {
		return ${field.propertyName?uncap_first}Like;
	}
	</#if>
	</#list>
	/**        设置批量条件查询where条件  end       **/
	
	/**   设置分组字段 start                     */
	<#list table.primaryKeyFields as field>
	/**
	 * 设置分组按属性：${field.propertyName?uncap_first}
	 *            
	 */
	public ${className}Query groupBy${field.propertyName?cap_first}() {
		groupByFields.add(new GroupField("${field.columnName}"));
		return this;
	}
	</#list>
	<#list table.fields as field>
	/**
	 * 设置分组按属性：${field.propertyName?uncap_first}
	 *            
	 */
	public ${className}Query groupBy${field.propertyName?cap_first}() {
		groupByFields.add(new GroupField("${field.columnName}"));
		return this;
	}
	</#list>
	/**   设置分组字段 end                     */
	
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