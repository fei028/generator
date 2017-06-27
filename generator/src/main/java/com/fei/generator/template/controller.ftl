package ${controller_package};

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.stereotype.Controller;

import ${service_package}.${className}Service;
<#if dependProjectCommonPackage == "">
import ${common_package}.utils.LogUtils;
import ${common_package}.utils.SearchUtils;
import ${common_package}.web.Constant;
import ${common_package}.web.annotation.NavPath;
import ${common_package}.web.annotation.ParentPermission;
import ${common_package}.web.exception.CustomException;
import ${common_package}.common.page.SimplePage;
import ${common_package}.common.pojo.Result;
import ${common_package}.pojo.system.ActiveUser;
<#else>
import ${dependProjectCommonPackage}.utils.LogUtils;
import ${dependProjectCommonPackage}.common.utils.SearchUtils;
import ${dependProjectCommonPackage}.web.Constant;
import ${dependProjectCommonPackage}.web.annotation.NavPath;
import ${dependProjectCommonPackage}.web.annotation.ParentPermission;
import ${dependProjectCommonPackage}.common.web.exception.CustomException;
import ${dependProjectCommonPackage}.common.page.SimplePage;
import ${dependProjectCommonPackage}.common.pojo.Result;
import ${dependProjectCommonPackage}.pojo.system.ActiveUser;
</#if>
import ${pojo_package}.${className};
import ${query_package}.${className}Query;

/**
 * 
 * @author ${author}
 *
 */
@Controller
@RequestMapping(value = "/${module}/${className?uncap_first}")
public class ${className}Controller {
	
	@Autowired
	private ${className}Service ${className?uncap_first}Service;

	
	@RequestMapping(value = "/${className?uncap_first}")
	@RequiresPermissions(value = {"${module}-${className?uncap_first}"})
	@ParentPermission
	@NavPath
	public String index(Model model){
		
		return "${module}/${className?uncap_first}/${className?uncap_first}";
	}
	
    /**
     * 获取${className}通过主键
     * 
     * */
	@RequestMapping(value = "/get${className}", method = RequestMethod.POST)
	<#if table.primaryKeyFields?size = 1>
	@RequiresPermissions(value = {"${module}-${className?uncap_first}-update"})
	@ResponseBody
	public ${className} get${className}(${table.primaryKeyFields[0].dataType} ${table.primaryKeyFields[0].propertyName?uncap_first}){
		
		${className} ${className?uncap_first} = null;
		
		if(${table.primaryKeyFields[0].propertyName?uncap_first} != null){
			${className?uncap_first} = ${className?uncap_first}Service.get<#if use_baseservice_type == "0">${className}<#else>Object</#if>ByKey(${table.primaryKeyFields[0].propertyName?uncap_first});
		}
		
		return ${className?uncap_first};
		
	}
	</#if>
	<#if table.primaryKeyFields?size gt 1>
	@RequiresPermissions(value = {"${module}-${className?uncap_first}-update"})
	@ResponseBody
	public ${className} get${className}(${className?cap_first}Key ${className?uncap_first}Key){
		
		${className} ${className?uncap_first} = null;
		
		if(${className?uncap_first}Key != null){
			${className?uncap_first} = ${className?uncap_first}Service.get<#if use_baseservice_type == "0">${className}<#else>Object</#if>ByKey(${className?uncap_first}Key);
		}
		
		return ${className?uncap_first};
		
	}
	</#if>

	/**
	 * 修改${className}
	 * @param ${className?uncap_first} 
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@RequiresPermissions(value = {"${module}-${className?uncap_first}-update"})
	@ResponseBody
	public String update(${className} ${className?uncap_first},HttpServletRequest request) throws CustomException {
		return saveOrUpdate(${className?uncap_first}, "update", request);
	}
	
	/**
	 * 新增
	 * @param ${className?uncap_first} 
	 * @return 
	 */
	@RequestMapping(value = "/add",method = RequestMethod.POST)
	@RequiresPermissions(value = {"${module}-${className?uncap_first}-add"})
	@ResponseBody
	public String add${className}(${className}  ${className?uncap_first}, HttpServletRequest request) throws CustomException {
		return saveOrUpdate(${className?uncap_first}, "add", request);
	}
	<#if table.primaryKeyFields?size = 1>
	/**
	 * 批量删除
	 * @param ${table.primaryKeyFields[0].propertyName?uncap_first}s
	 */
	@RequestMapping(value = "/deleteByKeys")
	@RequiresPermissions(value = {"${module}-${className?uncap_first}-delete"})
	@ResponseBody
	public String deleteByKeys(@RequestParam(value="${table.primaryKeyFields[0].propertyName?uncap_first}s[]") List<${table.primaryKeyFields[0].dataType}> ${table.primaryKeyFields[0].propertyName?uncap_first}s,HttpServletRequest request){
		if(${table.primaryKeyFields[0].propertyName?uncap_first}s != null && !${table.primaryKeyFields[0].propertyName?uncap_first}s.isEmpty()){
			${className?uncap_first}Service.deleteBy<#if use_baseservice_type == "0">${table.primaryKeyFields[0].propertyName?cap_first}<#else>Key</#if>s(${table.primaryKeyFields[0].propertyName?uncap_first}s);
		} else {
			return "没有可删除的对象";
		}
		return "ok";
	}
	</#if>

	@RequestMapping(value = "/search")
	@RequiresPermissions(value = {"${module}-${className?uncap_first}-search"})
	@ResponseBody
	public Map<String,Object> search(${className}Query ${className?uncap_first}Query, HttpServletRequest request)  throws CustomException {
		
		//${className?uncap_first}Query.setFields(fields);
		
		//${className?uncap_first}Query.orderbyCreateTime(false);
		
		/* 模糊查询  自己在query对象自己添加 * 代表属性
		if(StringUtils.isNotBlank(*)){
			${className?uncap_first}Query.set*(*);
			${className?uncap_first}Query.set*Like(true);
		}
		*/
		
		/** 处理请求参数[pageNo,pageSize,beginDateStr,endDateStr] 不设置pageNo 就是查询全部*/
		SearchUtils.handleSearchRequestParams(request, ${className?uncap_first}Query);
		
		SimplePage page = ${className?uncap_first}Service.search(${className?uncap_first}Query);

		Map<String, Object> map = new HashMap<>(1); // 多个put 改变size
		map.put("page", page);
		
		return map;
	}
	<#if ((table.primaryKeyFields?size = 1))>
	@RequestMapping(value = "checkUniqueness")
	@RequiresPermissions(value = {"${module}-${className?uncap_first}-add","${module}-${className?uncap_first}-update"}, logical = Logical.OR)
	@ResponseBody
	public Result checkUniqueness(String property, String value, ${table.primaryKeyFields[0].dataType } ${table.primaryKeyFields[0].propertyName?uncap_first}) throws CustomException{
		boolean unique = ${className?uncap_first}Service.checkUniqueness(property, value, ${table.primaryKeyFields[0].propertyName?uncap_first}<#if use_baseservice_type != "0">,"${table.primaryKeyFields[0].propertyName?uncap_first}"</#if>);
		return unique ? Result.ok() : Result.error();
	}
	
	private String saveOrUpdate(${className?cap_first} ${className?uncap_first}, String tag, HttpServletRequest request) throws CustomException {
		
		//判断用户名是否已经存在
		/*
		if(!${className?uncap_first}Service.checkUniqueness("userName", ${className?uncap_first}.get*(), ${className?uncap_first}.get${table.primaryKeyFields[0].propertyName?cap_first}())){
			return "您输入的*已存在,请重新输入后保存";
		}
		*/
		// 添加人
		HttpSession session = request.getSession();
		ActiveUser activeUser = (ActiveUser) session.getAttribute(Constant.ACTIVEUSER_SESSION);
		
		String logContent = null;
		
		if("add".equals(tag)){// 新增用户
			
			// 添加时间
			Date date = new Date();
			${className?uncap_first}.setCreateTime(date);
			${className?uncap_first}.setCreateUser(activeUser.getUserId());
			${table.primaryKeyFields[0].dataType } ${table.primaryKeyFields[0].propertyName?uncap_first} = ${className?uncap_first}Service.add<#if use_baseservice_type == "0">${className?cap_first}</#if>(${className?uncap_first});
			
			logContent = activeUser.getUserName() + "创建了id[" + ${table.primaryKeyFields[0].propertyName?uncap_first} +"] ";
			
		} else {
			// 更新时间
			Date date = new Date();
			${className?uncap_first}.setUpdateTime(date);
			${className?uncap_first}.setUpdateUser(activeUser.getUserId());
			${className?uncap_first}Service.update(${className?uncap_first});
			
			logContent = activeUser.getUserName() + "修改了id[" + ${className?uncap_first}.get${table.primaryKeyFields[0].propertyName?cap_first}() + "] ";
		}
		
		LogUtils.setLogContent(request, logContent);
		
		return "ok";
	}
	</#if>
}
