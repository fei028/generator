package com.fei.generator.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class SysFunction implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2208932303598421483L;
	
	public static final Integer FUNCTION_TYPE_ALL = null;
	public static final Integer FUNCTION_TYPE_MENU = 1;
	public static final Integer FUNCTION_TYPE_BTN = 2;

	
	/** 功能ID */
	private Integer functionId;
	/** 功能代码 */
	private String functionCode;
	/** 功能名称 */
	private String functionName;
	/** 父级功能ID */
	private Integer parentId;
	/** 功能描述 */
	private String functionDesc; 
	/** 功能URL */
	private String functionUrl; 
	/** 功能备注 */
	private String functionRemark; 
	/** 功能类型 */
	private Integer functionType;
	/** 排序 */
	private Integer sort;
	/** 创建人 */
	private Integer createUser; 
	/** 创建时间 */
	private Date createTime;
	/** 更新人 */
	private Integer updateUser;
	/** 更新时间 */
	private Date updateTime;
	/** 子权限集合 */
	private List<SysFunction> sysFunctions = new ArrayList<SysFunction>();
	
	public List<SysFunction> getSysFunctions() {
		return sysFunctions;
	}

	public void setSysFunctions(List<SysFunction> sysFunctions) {
		this.sysFunctions = sysFunctions;
	}

	public Integer getFunctionId() {
		return functionId;
	}

	public void setFunctionId(Integer functionId) {
		this.functionId = functionId;
	}

	public String getFunctionCode() {
		return functionCode;
	}

	public void setFunctionCode(String functionCode) {
		this.functionCode = functionCode == null ? null : functionCode.trim();
	}

	public String getFunctionName() {
		return functionName;
	}

	public void setFunctionName(String functionName) {
		this.functionName = functionName == null ? null : functionName.trim();
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getFunctionDesc() {
		return functionDesc;
	}

	public void setFunctionDesc(String functionDesc) {
		this.functionDesc = functionDesc == null ? null : functionDesc.trim();
	}

	public String getFunctionUrl() {
		return functionUrl;
	}

	public void setFunctionUrl(String functionUrl) {
		this.functionUrl = functionUrl == null ? null : functionUrl.trim();
	}

	public String getFunctionRemark() {
		return functionRemark;
	}

	public void setFunctionRemark(String functionRemark) {
		this.functionRemark = functionRemark == null ? null : functionRemark
				.trim();
	}

	public Integer getFunctionType() {
		return functionType;
	}

	public void setFunctionType(Integer functionType) {
		this.functionType = functionType;
	}

	public Integer getCreateUser() {
		return createUser;
	}

	public void setCreateUser(Integer createUser) {
		this.createUser = createUser;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(Integer updateUser) {
		this.updateUser = updateUser;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

}
