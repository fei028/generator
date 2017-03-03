package ${controller_package};


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import ${service_package}.${className}Service;

/**
 * 
 * @author ${author}
 *
 */
@Controller
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
	public @ResponseBody ${className} get${className}(${table.primaryKeyFields[0].dataType} ${table.primaryKeyFields[0].propertyName?uncap_first}){
		${className} ${className?uncap_first} = ${className?uncap_first}Service.get${className}ByKey(${table.primaryKeyFields[0].propertyName?uncap_first});
		
		return ${className?uncap_first};
		
	}
	</#if>
	<#if table.primaryKeyFields?size gt 1>
	public @ResponseBody ${className} get${className}(${className?cap_first}Key ${className?uncap_first}Key){
		${className} ${className?uncap_first} = ${className?uncap_first}Service.get${className}ByKey(${className?uncap_first}Key);
		
		return ${className?uncap_first};
		
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
		${className?uncap_first}Service.add${className}(${className?uncap_first});
	    return msg;
	}
	<#if table.primaryKeyFields?size = 1>
	/**
	 * 批量删除
	 * @param ${table.primaryKeyFields[0].propertyName?uncap_first}s
	 */
	@RequestMapping(value = "/delete${className}s")
	@ResponseBody
	public String delete${className}s(@RequestParam(value="${table.primaryKeyFields[0].propertyName?uncap_first}s[]")List<${table.primaryKeyFields[0].dataType}> ${table.primaryKeyFields[0].propertyName?uncap_first}s,HttpServletRequest request){
		if(${table.primaryKeyFields[0].propertyName?uncap_first}s != null && !${table.primaryKeyFields[0].propertyName?uncap_first}s.isEmpty()){
			${className?uncap_first}Service.delete${className}s(${table.primaryKeyFields[0].propertyName?uncap_first}s);
		}
		return "ok";
	}
	</#if>
	
	/*
	@RequestMapping(value = "/search")
	public String search(
			@RequestParam(required = false) String beginTime,
			@RequestParam(required = false) String endTime,
			HttpSession session,HttpServletRequest request, Model model) {
		
		${className}Query ${className?uncap_first}Query = new ${className}Query();
		
		if(beginTime != null && !"".equals(beginTime.trim())){
			Date beginDate = null;
			try {
				beginDate = DateUtils.strToDate(beginTime + " 00:00:00", "yyyy/MM/dd HH:mm:ss");
			} catch (Exception e) {
				beginDate = null;
				System.out.println("转换出错");
			}
			searchSysUserInfo.setBeginDate(beginDate);
		}
		
		if(endTime != null && !"".equals(endTime.trim())){
			Date endDate = null;
			try {
				endDate = DateUtils.strToDate(endTime + " 23:59:59", "yyyy/MM/dd HH:mm:ss");
			} catch (Exception e) {
				endDate = null;
				System.out.println("转换出错");
			}
			searchSysUserInfo.setEndDate(endDate);
		}
		
		SearchUtils.handleSearchRequestParams(request, ${className?uncap_first}Query);
		
		${className?uncap_first}Query.orderbyCreateTime(false);
		SimplePage page = null;
		
		page = sysUserService.search(${className?uncap_first}Query);

		model.addAttribute("page", page);
		model.addAttribute("curPageSize", ${className?uncap_first}Query.getPageSize());
		
		return "${className?uncap_first}/_list";
	}
	*/
}
