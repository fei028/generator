<#-- pojo 模版文件 -->
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${dao_package}.${className}Dao" >
  <resultMap id="${className?uncap_first}" type="${className}" >
    <id column="${table.primaryKeyField.columnName2}" property="${table.primaryKeyField.columnName?uncap_first}" javaType="${table.primaryKeyField.dataType?uncap_first}" />
    <#list table.fields as field>
    <result column="${field.columnName2}" property="${field.columnName?uncap_first}" javaType="${field.dataType?uncap_first}" />
    </#list>
  </resultMap>
  
  <sql id="Base_Column_List" >
  	<#list table.fields as field>
    ${field.columnName2}<#if field_index+1 < table.fields?size >,</#if><#if field.columnComment??><!-- ${field.columnComment} --></#if>
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
		<#list table.fields as field>
		<if test="${field.columnName?uncap_first} != null">
			AND ${field.columnName2} = ${'#'}{${field.columnName?uncap_first}}
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
  	SELECT count(1)
  	FROM ${table.tableName}
  	<include refid="where"/>
  </select>
  
  <!-- 通过主键批量查询 -->
  <select id="selectBy${table.primaryKeyField.columnName?cap_first}s" resultMap="${className?uncap_first}">
  	SELECT 
  	<include refid="Base_Column_List"/>
  	FROM ${table.tableName}
  	WHERE ${table.primaryKeyField.columnName2} IN
  	 <foreach collection="list" item="${table.primaryKeyField.columnName?uncap_first}" open="(" close=")" separator=",">
	 	${'$'}{${table.primaryKeyField.columnName?uncap_first}}
	 </foreach>
  </select>
  
  <!-- 通过主键查询  -->
  <select id="selectBy${table.primaryKeyField.columnName?cap_first}" resultMap="${className?uncap_first}" parameterType="${table.primaryKeyField.dataType?uncap_first}" >
    select 
    <include refid="Base_Column_List" />
    from ${table.tableName}
    where ${table.primaryKeyField.columnName2} = ${'#'}{${table.primaryKeyField.columnName?uncap_first}}
  </select>
  
<!--  *****查询有关  end***** -->

<!--  *****删除有关  start***** -->

  <!-- 通过主键批量删除 -->
  <delete id="deleteBy${table.primaryKeyField.columnName?cap_first}s">
  	 DELETE FROM ${table.tableName}
     WHERE ${table.primaryKeyField.columnName2} IN 
	 <foreach collection="array" item="${table.primaryKeyField.columnName?uncap_first}" open="(" close=")" separator=",">
	 	${'$'}{${table.primaryKeyField.columnName?uncap_first}}
	 </foreach>
  </delete>
  
  <!-- 通过主键删除 -->
  <delete id="deleteBy${table.primaryKeyField.columnName?cap_first}" parameterType="${table.primaryKeyField.dataType?uncap_first}" >
    delete from ${table.tableName}
    where ${table.primaryKeyField.columnName2} = ${'#'}{${table.primaryKeyField.columnName?uncap_first}}
  </delete>
  
<!--  *****删除有关  end***** -->

<!--  *****插入有关  start***** -->

  <!-- 有选择插入字段 NULL忽略-->
  <insert id="insertSelective" parameterType="${className}" useGeneratedKeys="true" keyProperty="${table.primaryKeyField.columnName?uncap_first}">
    insert into ${table.tableName}
    <trim prefix="(" suffix=")" suffixOverrides="," >
      <#list table.fields as field>
      <if test="${field.columnName?uncap_first} != null" >
        ${field.columnName2},
      </if>
      </#list>
    </trim>
    <trim prefix="values (" suffix=")" suffixOverrides="," >
      <#list table.fields as field>
      <if test="${field.columnName?uncap_first} != null" >
       ${'#'}{${field.columnName?uncap_first}},
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
      <if test="${field.columnName?uncap_first} != null" >
        ${field.columnName2} = ${'#'}{${field.columnName?uncap_first}},
      </if>
      </#if>
      </#list>
    </set>
    where ${table.primaryKeyField.columnName2} = ${'#'}{${table.primaryKeyField.columnName?uncap_first}}
  </update>

<!--  *****更新有关  end***** -->
</mapper>