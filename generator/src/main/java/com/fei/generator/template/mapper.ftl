<#-- pojo 模版文件 -->
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${dao_package}.${className}${daoSuffix}" >
  <resultMap id="${className?uncap_first}" type="${className}" >
  	<#if (table.primaryKeyFields?size gt 0)>
    <#list table.primaryKeyFields as field>
    <id column="${field.columnName}" property="${field.propertyName?uncap_first}" javaType="${field.dataType?uncap_first}" />
    </#list>
	</#if>
    <#if (table.fields?size gt 0)>
    <#list table.fields as field>
    <result column="${field.columnName}" property="${field.propertyName?uncap_first}" javaType="${field.dataType?uncap_first}" />
    </#list>
    </#if>
  </resultMap>
  
  <sql id="Base_Column_List" >
    <#if (table.primaryKeyFields?size gt 0)>
  	<#list table.primaryKeyFields as field>
    ${field.columnName}<#if table.primaryKeyFields?size gt (field_index+1)  >,<#elseif table.fields?size gt 0>,</#if><#if field.columnComment??><!-- ${field.columnComment} --></#if>
    </#list>
	</#if>
	<#if (table.fields?size gt 0)>
  	<#list table.fields as field>
    ${field.columnName}<#if table.fields?size gt (field_index+1) >,</#if><#if field.columnComment??><!-- ${field.columnComment} --></#if>
    </#list>
    </#if>
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
	    <#if (table.primaryKeyFields?size gt 0)>
		<#list table.primaryKeyFields as field>
		<if test="${field.propertyName?uncap_first} != null  and keys == null">
			AND ${field.columnName} = ${'#'}{${field.propertyName?uncap_first}}
		</if>
		</#list>
		<#if (table.primaryKeyFields?size=1)>
		<!-- 后期添加 -->
		<if test="keys != null">
			AND ${table.primaryKeyFields[0].columnName} in 
			<foreach collection="keys" item="key" open="(" close=")" separator=",">
				${r'#{key}'}
			</foreach>
		</if>
		</#if>
        </#if>
        <#if (table.fields?size gt 0)>
		<#list table.fields as field>
		<if test="${field.propertyName?uncap_first} != null <#if field.dataType == 'String'>and ${field.propertyName?uncap_first} != ''</#if>">
            <#if field.dataType == 'String'>
            <if test="${field.propertyName?uncap_first}Like == null or ${field.propertyName?uncap_first}Like == ''">
                AND ${field.columnName} = ${'#'}{${field.propertyName?uncap_first}}
            </if>
            <if test="${field.propertyName?uncap_first}Like != null and ${field.propertyName?uncap_first}Like != ''">
                AND ${field.columnName} LIKE ${'#'}{${field.propertyName?uncap_first}Like} ESCAPE '/'
            </if>
            <#else>
            AND ${field.columnName} = ${'#'}{${field.propertyName?uncap_first}}
            </#if>
		</if>
		</#list>
        </#if>
		<!-- 后期添加 -->
		<if test="beginDate != null">
			AND create_time &gt;= ${r'#{beginDate}'}
		</if>
		<if test="endDate != null">
			AND create_time &lt;= ${r'#{endDate}'}
		</if>
	</where>
  </sql>
  <!-- 查询分组语句 -->
  <sql id="groupBy">
  	<if test="groupByFields != null and groupByFields.size>0">
  		GROUP BY
  		<foreach collection="groupByFields" item="groupByField" separator=",">
  			${r'${groupByField.field}'}
  		</foreach>
  	</if>
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
  <select id="select<#if use_basedao_type == "0">${className?cap_first}<#else>Object</#if>sWithCondition" resultMap="${className?uncap_first}" parameterType="${className?cap_first}Query">
  	<include refid="selector"/>
  	<include refid="where"/>
  	<include refid="groupBy"/>
  	<include refid="orderBy"/>
  	<include refid="limit"/>
  </select>
  
  <!--  条件查询对应记录总数  -->
  <select id="getCountWithCondition" resultType="long" parameterType="${className?cap_first}Query">
  	SELECT count(*)
  	FROM ${table.tableName}
  	<include refid="where"/>
  </select>
  <#if (table.primaryKeyFields?size gt 0)>
  <#if table.primaryKeyFields?size = 1>
  <!-- 通过主键查询  -->
  <select id="selectBy<#if use_basedao_type == "0">${table.primaryKeyFields[0].propertyName?cap_first}<#else>Key</#if>" resultMap="${className?uncap_first}" parameterType="${table.primaryKeyFields[0].dataType?uncap_first}" >
    SELECT 
    <include refid="Base_Column_List" />
    FROM ${table.tableName}
    WHERE ${table.primaryKeyFields[0].columnName} = ${'#'}{${table.primaryKeyFields[0].propertyName?uncap_first}}
  </select>
  <#elseif use_basedao_type == "0">
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
  </#if>
  <#if (table.primaryKeyFields?size gt 0)>
  <#if table.primaryKeyFields?size = 1>
  <!-- 获取符合条件的对象的主键集合 -->
  <select id="get<#if use_basedao_type == "0">${table.primaryKeyFields[0].propertyName?cap_first}<#else>Key</#if>s" resultType="${table.primaryKeyFields[0].dataType?uncap_first}" parameterType="${className}Query">
    SELECT ${table.primaryKeyFields[0].columnName}
  	FROM ${table.tableName}
  	<include refid="where"/>
  	<include refid="orderBy"/>
  	<include refid="limit"/>
  </select>
  </#if>
  </#if>
<!--  *****查询有关  end***** -->
<#if (table.primaryKeyFields?size gt 0)>
<!--  *****删除有关  start***** -->
   
  <#if table.primaryKeyFields?size = 1>
  <!-- 通过主键批量删除 -->
  <delete id="deleteBy<#if use_basedao_type == "0">${table.primaryKeyFields[0].propertyName?cap_first}<#else>Key</#if>s">
  	 DELETE FROM ${table.tableName}
     WHERE ${table.primaryKeyFields[0].columnName} IN 
	 <foreach collection="list" item="${table.primaryKeyFields[0].propertyName?uncap_first}" open="(" close=")" separator=",">
	 	${'#'}{${table.primaryKeyFields[0].propertyName?uncap_first}}
	 </foreach>
  </delete>
  
  <!-- 通过主键删除 -->
  <delete id="deleteBy<#if use_basedao_type == "0">${table.primaryKeyFields[0].propertyName?cap_first}<#else>Key</#if>" parameterType="${table.primaryKeyFields[0].dataType?uncap_first}" >
    delete from ${table.tableName}
    where ${table.primaryKeyFields[0].columnName} = ${'#'}{${table.primaryKeyFields[0].propertyName?uncap_first}}
  </delete>
  <#elseif use_basedao_type == "0">
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
 </#if>
<!--  *****插入有关  start***** -->

  <!-- 有选择插入字段 NULL忽略-->
  <insert id="insertSelective" parameterType="${className}" <#if table.primaryKeyFields?size = 1>useGeneratedKeys="true" keyProperty="${table.primaryKeyFields[0].propertyName?uncap_first}"</#if>>
    <#if (table.primaryKeyFields?size gt 0)>
    <#if table.primaryKeyFields[0].dataType == 'String'>
    <selectKey keyProperty="${table.primaryKeyFields[0].propertyName?uncap_first}" order="BEFORE" resultType="string">
  		SELECT replace(uuid(),'-','') FROM dual
    </selectKey>
    </#if>
	</#if>
    insert into ${table.tableName}
    <trim prefix="(" suffix=")" suffixOverrides="," >
      <#if (table.primaryKeyFields?size gt 0)>
      <#list table.primaryKeyFields as field>
      <#if field.dataType == 'String'>
      	${field.columnName},
      <#else>
      <if test="${field.propertyName?uncap_first} != null" >
        ${field.columnName},
      </if>
	  </#if>
      </#list>
      </#if>
      <#if (table.fields?size gt 0)>
      <#list table.fields as field>
      <if test="${field.propertyName?uncap_first} != null" >
        ${field.columnName},
      </if>
      </#list>
      </#if>
    </trim>
    <trim prefix="values (" suffix=")" suffixOverrides="," >
      <#if (table.primaryKeyFields?size gt 0)>
      <#list table.primaryKeyFields as field>
      <#if field.dataType == 'String'>
      	replace(uuid(),'-',''),
      <#else>
      <if test="${field.propertyName?uncap_first} != null" >
        ${'#'}{${field.propertyName?uncap_first}},
      </if>
      </#if>
	  </#list>
      </#if>
      <#if (table.fields?size gt 0)>
      <#list table.fields as field>
      <if test="${field.propertyName?uncap_first} != null" >
       ${'#'}{${field.propertyName?uncap_first}},
      </if>
	  </#list>
      </#if>
    </trim>
  </insert>
  <!-- 批量插入 -->
  <insert id="batchInsert" parameterType="list">
    INSERT INTO ${table.tableName}
      <trim prefix="(" suffix=")" suffixOverrides="," >
          <#if (table.primaryKeyFields?size gt 0)>
          <#list table.primaryKeyFields as field>
          <#if field.dataType == 'String'>
          ${field.columnName},
		  </#if>
          </#list>
          </#if>
          <#if (table.fields?size gt 0)>
          <#list table.fields as field>
          ${field.columnName}<#if table.fields?size gt (field_index+1)>,</#if>
          </#list>
	      </#if>
      </trim>
     VALUES
     <foreach collection="list" item="item" separator=",">
     (
     <#if (table.primaryKeyFields?size gt 0)>
     <#list table.primaryKeyFields as field>
	     <#if field.dataType == 'String'>
	     replace(uuid(),'-',''),
		 </#if>
     </#list>
	 </#if>
	 <#if (table.fields?size gt 0)>
     <#list table.fields as field>
         ${'#'}{item.${field.propertyName?uncap_first}}<#if table.fields?size gt (field_index+1)>,</#if>
     </#list>
     </#if>
     )
     </foreach>
  </insert>
<!--  *****插入有关  end***** -->
<#if (table.primaryKeyFields?size gt 0)>
<!--  *****更新有关  start***** -->
  
  <!-- 选择更新字段 NULL忽略 -->
  <update id="update" parameterType="${className?cap_first}" >
    update ${table.tableName}
    <set>
      <#if (table.fields?size gt 0)>
      <#list table.fields as field>
      <#-- 主键忽略 -->
      <#if field.columnKey != "PRI">
      <if test="${field.propertyName?uncap_first} != null" >
        ${field.columnName} = ${'#'}{${field.propertyName?uncap_first}},
      </if>
      </#if>
      </#list>
	  </#if>
    </set>
    where 
    <#list table.primaryKeyFields as field>
	${field.columnName} = ${'#'}{${field.propertyName?uncap_first}} <#if table.primaryKeyFields?size gt (field_index+1)>AND</#if>
	</#list>
  </update>

<!--  *****更新有关  end***** -->
</#if>
</mapper>