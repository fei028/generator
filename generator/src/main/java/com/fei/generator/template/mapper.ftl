<#-- pojo 模版文件 -->
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${dao_package}.${className}Dao" >
  <resultMap id="${className?uncap_first}" type="${className}" >
    <#list table.primaryKeyFields as field>
    <id column="${field.columnName}" property="${field.propertyName?uncap_first}" javaType="${field.dataType?uncap_first}" />
    </#list>
    <#list table.fields as field>
    <result column="${field.columnName}" property="${field.propertyName?uncap_first}" javaType="${field.dataType?uncap_first}" />
    </#list>
  </resultMap>
  
  <sql id="Base_Column_List" >
  	<#list table.primaryKeyFields as field>
    ${field.columnName}<#if table.primaryKeyFields?size gt (field_index+1)  >,<#elseif table.fields?size gt 0>,</#if><#if field.columnComment??><!-- ${field.columnComment} --></#if>
    </#list>
  	<#list table.fields as field>
    ${field.columnName}<#if table.fields?size gt (field_index+1) >,</#if><#if field.columnComment??><!-- ${field.columnComment} --></#if>
    </#list>
  </sql>
  
  <!-- 查询select部分  -->
  <sql id="selector">
  	SELECT
  	<if test="fields != null">
  	 	${r'${fields}'}
  	</if>
  	<if test="fields == null">
  		<include refid="Base_Column_List"/>
  	</if>
  	FROM ${table.tableName}
  </sql>
  <!-- 查询where语句部分 -->
  <sql id="where">
	<where>
		<#list table.primaryKeyFields as field>
		<if test="${field.propertyName?uncap_first} != null">
			AND ${field.columnName} = ${'#'}{${field.propertyName?uncap_first}}
		</if>
		</#list>
		<#list table.fields as field>
		<if test="${field.propertyName?uncap_first} != null">
			AND ${field.columnName} = ${'#'}{${field.propertyName?uncap_first}}
		</if>
		</#list>
	</where>
  </sql>
  <!-- 查询语句order by 部分 -->
  <sql id="orderBy">
  	<if test="orderByFields != null and orderByFields.size>0">
  		ORDER BY
  		<foreach collection="orderByFields" item="orderByField" separator=",">
  			${r'${orderByField.field}'} ${r'${orderByField.order}'}
  		</foreach>
  	</if>
  </sql>
  
  <sql id="limit">
  	<if test="startRow != null">
  		LIMIT  ${r'${startRow}'},${r'${pageSize}'}
  	</if>
  </sql>
<!--  *****查询有关  start***** -->

  <!--  条件查询  -->
  <select id="select${className?cap_first}sWithCondition" resultMap="${className?uncap_first}" parameterType="${className?cap_first}Query">
  	<include refid="selector"/>
  	<include refid="where"/>
  	<include refid="orderBy"/>
  	<include refid="limit"/>
  </select>
  
  <!--  条件查询对应记录总数  -->
  <select id="getCountWithCondition" resultType="long" parameterType="${className?cap_first}Query">
  	SELECT count(*)
  	FROM ${table.tableName}
  	<include refid="where"/>
  </select>
  
  <#if table.primaryKeyFields?size = 1>
  <!-- 通过主键批量查询 -->
  <select id="selectBy${table.primaryKeyFields[0].propertyName?cap_first}s" resultMap="${className?uncap_first}" parameterType="map">
  	SELECT 
  	<if test="fields == null">
  		<include refid="Base_Column_List"/>
  	</if>
  	<if test="fields != null">
  		${'$'}{fields}
  	</if>
  	FROM ${table.tableName}
  	WHERE ${table.primaryKeyFields[0].columnName} IN
  	 <foreach collection="keys" item="${table.primaryKeyFields[0].propertyName?uncap_first}" open="(" close=")" separator=",">
	 	${'$'}{${table.primaryKeyFields[0].propertyName?uncap_first}}
	 </foreach>
  </select>
  
  <!-- 通过主键查询  -->
  <select id="selectBy${table.primaryKeyFields[0].propertyName?cap_first}" resultMap="${className?uncap_first}" parameterType="${table.primaryKeyFields[0].dataType?uncap_first}" >
    SELECT 
    <include refid="Base_Column_List" />
    FROM ${table.tableName}
    WHERE ${table.primaryKeyFields[0].columnName} = ${'#'}{${table.primaryKeyFields[0].propertyName?uncap_first}}
  </select>
  <#else>
  <!-- 通过主键查询  -->
  <select id="selectBy${className?cap_first}Key" resultMap="${className?uncap_first}" parameterType="${className?cap_first}Key" >
    SELECT 
    <include refid="Base_Column_List" />
    FROM ${table.tableName}
    WHERE 
	<#list table.primaryKeyFields as field>
	${field.columnName} = ${'#'}{${field.propertyName?uncap_first}} <#if table.primaryKeyFields?size != (field_index+1)>AND</#if>
	</#list>
  </select>
  </#if>
  
<!--  *****查询有关  end***** -->

<!--  *****删除有关  start***** -->
  <#if table.primaryKeyFields?size = 1>
  <!-- 通过主键批量删除 -->
  <delete id="deleteBy${table.primaryKeyFields[0].propertyName?cap_first}s">
  	 DELETE FROM ${table.tableName}
     WHERE ${table.primaryKeyFields[0].columnName} IN 
	 <foreach collection="array" item="${table.primaryKeyFields[0].propertyName?uncap_first}" open="(" close=")" separator=",">
	 	${'$'}{${table.primaryKeyFields[0].propertyName?uncap_first}}
	 </foreach>
  </delete>
  
  <!-- 通过主键删除 -->
  <delete id="deleteBy${table.primaryKeyFields[0].propertyName?cap_first}" parameterType="${table.primaryKeyFields[0].dataType?uncap_first}" >
    delete from ${table.tableName}
    where ${table.primaryKeyFields[0].columnName} = ${'#'}{${table.primaryKeyFields[0].propertyName?uncap_first}}
  </delete>
  <#else>
  <!-- 通过主键删除 -->
  <delete id="deleteBy${className?cap_first}Key" parameterType="${className?cap_first}Key" >
    delete from ${table.tableName}
    where 
	<#list table.primaryKeyFields as field>
	${field.columnName} = ${'#'}{${field.propertyName?uncap_first}} <#if table.primaryKeyFields?size gt (field_index+1)>AND</#if>
	</#list>
  </delete>
  </#if>
  
  
<!--  *****删除有关  end***** -->

<!--  *****插入有关  start***** -->

  <!-- 有选择插入字段 NULL忽略-->
  <insert id="insertSelective" parameterType="${className}" <#if table.primaryKeyFields?size = 1>useGeneratedKeys="true" keyProperty="${table.primaryKeyFields[0].propertyName?uncap_first}"</#if>>
    insert into ${table.tableName}
    <trim prefix="(" suffix=")" suffixOverrides="," >
      <#list table.primaryKeyFields as field>
      <if test="${field.propertyName?uncap_first} != null" >
        ${field.columnName},
      </if>
      </#list>
      <#list table.fields as field>
      <if test="${field.propertyName?uncap_first} != null" >
        ${field.columnName},
      </if>
      </#list>
    </trim>
    <trim prefix="values (" suffix=")" suffixOverrides="," >
      <#list table.primaryKeyFields as field>
      <if test="${field.propertyName?uncap_first} != null" >
       ${'#'}{${field.propertyName?uncap_first}},
      </if>
	  </#list>
      <#list table.fields as field>
      <if test="${field.propertyName?uncap_first} != null" >
       ${'#'}{${field.propertyName?uncap_first}},
      </if>
	  </#list>
    </trim>
  </insert>
  
<!--  *****插入有关  end***** -->

<!--  *****更新有关  start***** -->
  
  <!-- 选择更新字段 NULL忽略 -->
  <update id="update" parameterType="${className?cap_first}" >
    update ${table.tableName}
    <set >
      <#list table.fields as field>
      <#-- 主键忽略 -->
      <#if field.columnKey != "PRI">
      <if test="${field.propertyName?uncap_first} != null" >
        ${field.columnName} = ${'#'}{${field.propertyName?uncap_first}},
      </if>
      </#if>
      </#list>
    </set>
    where 
    <#list table.primaryKeyFields as field>
	${field.columnName} = ${'#'}{${field.propertyName?uncap_first}} <#if table.primaryKeyFields?size gt (field_index+1)>AND</#if>
	</#list>
  </update>

<!--  *****更新有关  end***** -->
</mapper>