package ${controller_package};

import java.io.File;
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
import ${common_package}.utils.CollectionUtils;
import ${common_package}.utils.ExportFileUtils;
import ${common_package}.utils.FileUtils;
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
import ${dependProjectCommonPackage}.common.utils.CollectionUtils;
import ${dependProjectCommonPackage}.common.utils.ExportFileUtils;
import ${dependProjectCommonPackage}.common.utils.FileUtils;
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
	 * 删除
	 * @param userIds
	 */
	@RequestMapping(value = "/deleteByKey")
	@RequiresPermissions(value = {"${module}-${className?uncap_first}-delete"})
	@ResponseBody
	public String deleteByKey(Integer key){
		
		if(key != null){
			${className?uncap_first}Service.deleteByKey(key);
		} else {
			return "没有可删除的对象";
		}
		return "ok";
	}
	
	/**
	 * 批量删除
	 * @param ${table.primaryKeyFields[0].propertyName?uncap_first}s
	 */
	@RequestMapping(value = "/deleteByKeys")
	@RequiresPermissions(value = {"${module}-${className?uncap_first}-delete"})
	@ResponseBody
	public String deleteByKeys(@RequestParam(value="${table.primaryKeyFields[0].propertyName?uncap_first}s[]") List<${table.primaryKeyFields[0].dataType}> ${table.primaryKeyFields[0].propertyName?uncap_first}s){
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
	
	@RequestMapping(value = "/exportExcelTemplate")
	@RequiresPermissions(value = {"${module}-${className?uncap_first}-export"})
	public void exportExcelTemplate(HttpServletRequest request, HttpServletResponse response) throws CustomException{
		String realPath = request.getServletContext().getRealPath(File.separator);
		//File file = new File(realPath + File.separator + "template" + File.separator + *模版文件名称* + "Template.xls");
		//填入导出文件名称/String fileName = *** + "模版文件";
		//ExportFileUtils.exportFile(file, fileName , request, response);
	}
	
	@RequestMapping(value = "/import")
	@RequiresPermissions(value = {"${module}-${className?uncap_first}-import"})
	@NavPath
	public String import${className?cap_first}s(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException, CustomException{
		
		if(file == null || file.isEmpty()){
			String contentType="text/plain;charset=UTF-8";
			response.setContentType(contentType);
			response.getWriter().println("请刷新浏览器重新尝试该操作！！！");
			return null;
		}
		String sep = File.separator;
		String realPath = request.getServletContext().getRealPath(sep);
		
	    String fileName = FileUtils.generateNewFileName(file.getOriginalFilename());
	    
	    File tempDir = new File(realPath + sep + Constant.TEMP_DIR_NAME);
	    if(!tempDir.exists()){
	    	tempDir.mkdir();
	    }
	    
	    File f = new File(tempDir, fileName);
	    file.transferTo(f);
	    
	    ActiveUser activeUser = (ActiveUser) request.getSession().getAttribute(Constant.ACTIVEUSER_SESSION);
	   // List<String> errorMsgList = portalUserService.importUsers(f, type, activeUser.getUserId());
	    // 临时文件删除
	    f.delete();
	    
		Collection<?> errorMsgList = null;
		if(CollectionUtils.isNullOrEmpty(errorMsgList )){
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("<script>alert('导入成功');parent.$(window.parent.document.getElementById(\"sidebar-wrapper\"),parent.doucment).find('[class=\"active\"]').trigger('click');</script>");
		} else {
			request.setAttribute("errorMsgList", errorMsgList);
			return "portalUser/errorMsg";
		}
		return null;
	}
	<#if ((table.primaryKeyFields?size = 1))>
	@RequestMapping(value = "checkUniqueness")
	@RequiresPermissions(value = {"${module}-${className?uncap_first}-add","${module}-${className?uncap_first}-update"}, logical = Logical.OR)
	@ResponseBody
	public Result checkUniqueness(String property, String value, ${table.primaryKeyFields[0].dataType } ${table.primaryKeyFields[0].propertyName?uncap_first}) throws CustomException{
		boolean unique = ${className?uncap_first}Service.checkUniqueness(property, value, ${table.primaryKeyFields[0].propertyName?uncap_first}<#if use_baseservice_type == "0">,"${table.primaryKeyFields[0].propertyName?uncap_first}"</#if>);
		return unique ? Result.ok() : Result.error();
	}
	
	private String saveOrUpdate(${className?cap_first} ${className?uncap_first}, String tag, HttpServletRequest request) throws CustomException {
		
		ActiveUser activeUser = (ActiveUser) request.getSession().getAttribute(Constant.ACTIVEUSER_SESSION);
		
		String errorMsg = saveOrUpdateBeforeValidate(${className?uncap_first});
		
		if(errorMsg != null){
			return errorMsg;
		}

		String logContent = null;
		
		setSomeAttributeValToNull(${className?uncap_first});
		
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
	
	/**
	 * 将一些属性值置为NULL,防止用户的更新或者新增操作
	 * @param ${className?uncap_first}
	 */
	private void setSomeAttributeValToNull(${className?cap_first} ${className?uncap_first}) {
		${className?uncap_first}.setUpdateTime(null);
		${className?uncap_first}.setUpdateUser(null);
		${className?uncap_first}.setCreateTime(null);
		${className?uncap_first}.setCreateUser(null);
	}
	
	private String saveOrUpdateBeforeValidate(${className?cap_first} ${className?uncap_first}) throws CustomException {
		
		if(${className?uncap_first} != null){
			//判断存在
			/*
			if(!${className?uncap_first}Service.checkUniqueness("属性名称", ${className?uncap_first}.get*(), ${className?uncap_first}.get${table.primaryKeyFields[0].propertyName?cap_first}())){
				return "您输入的*已存在,请重新输入后保存";
			}
			*/
			
		} else {
			return "无法对空对象进行操作";
		}
		
		return null;
		
	}
	</#if>
}
