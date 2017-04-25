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

import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.stereotype.Controller;

import ${service_package}.${className}Service;
import ${pojo_package}.${className};
import ${query_package}.${className}Query;

/**
 * 
 * @author ${author}
 *
 */
@Controller
@RequestMapping(value = "/${className?uncap_first}")
public class ${className}Controller {
	
	@Autowired
	private ${className}Service ${className?uncap_first}Service;

	
	@RequestMapping(value = "/${className?uncap_first}")
	public String index(Model model){
		
		return "${className?uncap_first}";
	}
	
    /**
     * 获取${className}通过主键
     * 
     * */
	@RequestMapping(value = "/get${className}", method = RequestMethod.POST)
	<#if table.primaryKeyFields?size = 1>
	@ResponseBody
	public ${className} get${className}(${table.primaryKeyFields[0].dataType} ${table.primaryKeyFields[0].propertyName?uncap_first}){
		
		${className} ${className?uncap_first} = null;
		
		if(${table.primaryKeyFields[0].propertyName?uncap_first} != null){
			${className?uncap_first} = ${className?uncap_first}Service.get${className}ByKey(${table.primaryKeyFields[0].propertyName?uncap_first});
		}
		
		return ${className?uncap_first} != null ? ${className?uncap_first} : new ${className}();
		
	}
	</#if>
	<#if table.primaryKeyFields?size gt 1>
	@ResponseBody
	public ${className} get${className}(${className?cap_first}Key ${className?uncap_first}Key){
		
		${className} ${className?uncap_first} = null;
		
		if(${className?uncap_first}Key != null){
			${className?uncap_first} = ${className?uncap_first}Service.get${className}ByKey(${className?uncap_first}Key);
		}
		
		return ${className?uncap_first} != null ? ${className?uncap_first} : new ${className}();
		
	}
	</#if>

	/**
	 * 修改${className}
	 * @param ${className?uncap_first} 
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(${className} ${className?uncap_first},HttpServletRequest request){
		String msg = "ok";
		if(${className?uncap_first} != null){
			Date date = new Date();
			${className?uncap_first}Service.update(${className?uncap_first});
		} else {
			msg = "不能更新空对象";
		}
		return msg;
	}
	
	/**
	 * 新增
	 * @param ${className?uncap_first} 
	 * @return 
	 */
	@RequestMapping(value = "/add${className}",method = RequestMethod.POST)
	@ResponseBody
	public String add${className}( ${className}  ${className?uncap_first},HttpServletRequest request){
		
		String msg ="ok";
		if(${className?uncap_first} != null){
			${className?uncap_first}Service.add${className}(${className?uncap_first});
		} else {
			msg = "不能添加空对象";
		}
	    return msg;
	}
	<#if table.primaryKeyFields?size = 1>
	/**
	 * 批量删除
	 * @param ${table.primaryKeyFields[0].propertyName?uncap_first}s
	 */
	@RequestMapping(value = "/deleteByKeys")
	@ResponseBody
	public String deleteByKeys(@RequestParam(value="${table.primaryKeyFields[0].propertyName?uncap_first}s[]")List<${table.primaryKeyFields[0].dataType}> ${table.primaryKeyFields[0].propertyName?uncap_first}s,HttpServletRequest request){
		if(${table.primaryKeyFields[0].propertyName?uncap_first}s != null && !${table.primaryKeyFields[0].propertyName?uncap_first}s.isEmpty()){
			${className?uncap_first}Service.deleteBy${table.primaryKeyFields[0].propertyName?cap_first}s(${table.primaryKeyFields[0].propertyName?uncap_first}s);
		} else {
			return "没有可删除的对象";
		}
		return "ok";
	}
	</#if>

	@RequestMapping(value = "/search")
	@ResponseBody
	public Map<String,Object> search(HttpServletRequest request) {
		
		${className}Query ${className?uncap_first}Query = new ${className}Query();
		
		${className?uncap_first}Query.orderbyCreateTime(false);
		
		${className?uncap_first}Query.orderbyCreateTime(false);
		
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
}
