package com.fei.generator.util;

import java.io.File;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public abstract class Constant {
	/**
	 * 模版文件所在目录
	 */
	public static final File TEMPLATE_FILE_DIR ;
	static {
		URL resource = Thread.currentThread().getContextClassLoader().getResource("com/fei/generator/template");
		TEMPLATE_FILE_DIR = new File(resource.getFile());
	}
	/**
	 * 默认基础包
	 */
	public static String DEFAULT_BASE_PACKAGE = "com.default.package";
	/* 文件标志 */
	public static final int POJO = 0;
	public static final int POJO_KEY = 1;

	public static final Integer DAO_INTER = 2;// 接口
	public static final Integer DAO_IMPL = 3;// 实现

	public static final Integer SERVICE_INTER = 4;// 接口
	public static final Integer SERVICE_IMPL = 5;// 实现

	public static final Integer CONTROLLER = 6;
	
	public static final Integer MAPPER = 7;
	
	public static final Integer QUERY = 8;
	public static final Integer BASE_QUERY = 9;
	
	public static final Integer JS = 10;
	public static final Integer JSP = 11;
	
	public static final Integer SQLLIKE_ENUM = 12;
	
	public static final Integer BASE_DAO = 13;
	
	public static final Integer BASE_SERVICE = 14;
	
	public static final Integer BASE_SERVICE_IMPL = 15;
	/* end */
	/**
	 * 模版文件名称map<文件标志,文件名称>
	 */
	@SuppressWarnings("serial")
	public static final Map<Integer, String> TEMPLATEFILE_MAP = new HashMap<Integer, String>() {
		{
			put(Constant.POJO, "pojo.ftl");
			put(Constant.POJO_KEY, "pojo_key.ftl");
			put(Constant.DAO_INTER, "dao.ftl");
			put(Constant.DAO_IMPL, "dao_impl.ftl");
			put(Constant.SERVICE_INTER, "service.ftl");
			put(Constant.SERVICE_IMPL, "service_impl.ftl");
			put(Constant.CONTROLLER, "controller.ftl");
			put(Constant.MAPPER, "mapper.ftl");
			put(Constant.QUERY, "query.ftl");
			put(Constant.BASE_QUERY, "base_query.ftl");
			put(Constant.JS, "js.ftl");
			put(Constant.JSP, "jsp.ftl");
			put(Constant.SQLLIKE_ENUM, "sqlLike.ftl");
			put(Constant.BASE_DAO, "baseDao.ftl");
			put(Constant.BASE_SERVICE, "base_service.ftl");
			put(Constant.BASE_SERVICE_IMPL, "base_service_impl.ftl");
		}
	};
	
	@SuppressWarnings("serial")
	public static final Map<String, String> DATATYPE_MAP = new HashMap<String, String>() {
		{
			put("varchar", "String");
			put("char", "String");
			put("blob", "byte[]");
			put("text", "String");
			put("longtext", "String");
			put("integer", "Long");
			put("tinyint", "Byte");
			put("int", "Integer");
			put("smallint", "Integer");
			
			put("mediumin", "Integer");
			put("bit", "Boolean");
			put("bigint", "Long");
			put("float", "Float");
			put("double", "Double");
			put("decimal", "BigDecimal");
			put("int", "Integer");
			put("boolean", "Boolean");
			
			put("id", "Long");
			put("date", "Date");
			put("time", "Time");
			put("datetime", "Date");
			put("timestamp", "Date");
			put("year", "Date");
		}
	};
	@SuppressWarnings("serial")
	public static final Map<Integer,String> FILE_TYPE_NAME_MAP = new HashMap<Integer, String>(){
		{
			put(Constant.POJO,"pojo");
			put(Constant.POJO_KEY,"Key");
			put(Constant.DAO_INTER,"Dao");
			put(Constant.DAO_IMPL,"DaoImpl");
			put(Constant.SERVICE_INTER,"Service");
			put(Constant.SERVICE_IMPL,"ServiceImpl");
			put(Constant.CONTROLLER,"Controller");
			put(Constant.MAPPER,"Mapper");
			put(Constant.QUERY,"Query");
			put(Constant.BASE_QUERY, "Query");
			put(Constant.JS, "");
			put(Constant.JSP, "");
			put(Constant.SQLLIKE_ENUM, "");
			put(Constant.BASE_DAO, "Dao");
			put(Constant.BASE_SERVICE, "Service");
			put(Constant.BASE_SERVICE_IMPL, "ServiceImpl");
		}
	};
	@SuppressWarnings("serial")
	public static final Map<Integer,String> FILE_EXTENSION_MAP = new HashMap<Integer, String>(){
		{
			put(Constant.POJO,".java");
			put(Constant.POJO_KEY,".java");
			put(Constant.DAO_INTER,".java");
			put(Constant.DAO_IMPL,".java");
			put(Constant.SERVICE_INTER,".java");
			put(Constant.SERVICE_IMPL,".java");
			put(Constant.CONTROLLER,".java");
			put(Constant.MAPPER,".xml");
			put(Constant.QUERY,".java");
			put(Constant.BASE_QUERY, ".java");
			put(Constant.JS, ".js");
			put(Constant.JSP, ".jsp");
			put(Constant.SQLLIKE_ENUM, ".java");
			put(Constant.BASE_DAO, ".java");
			put(Constant.BASE_SERVICE, ".java");
			put(Constant.BASE_SERVICE_IMPL, ".java");
		}
	};
	@SuppressWarnings("serial")
	public static final Map<Integer,String> DEFAULT_PACKAGE_MAP = new HashMap<Integer, String>(){
		{
			put(Constant.POJO,"com.mypackage.pojo");
			put(Constant.DAO_INTER,"com.mypackage.dao");
			put(Constant.DAO_IMPL,"com.mypackage.dao.impl");
			put(Constant.SERVICE_INTER,"com.mypackage.service");
			put(Constant.SERVICE_IMPL,"com.mypackage.service.impl");
			put(Constant.CONTROLLER,"com.mypackage.controller");
			put(Constant.MAPPER,"com.mypackage.mapper");
			put(Constant.QUERY,"com.mypackage.query");
			put(Constant.BASE_QUERY, "com.mypackage.query");
			put(Constant.JS, "com.mypackage.js");
			put(Constant.JSP, "com.mypackage.jsp");
			put(Constant.BASE_DAO, "com.mypackage.dao");
			put(Constant.BASE_SERVICE, "com.mypackage.service");
			put(Constant.BASE_SERVICE_IMPL, "com.mypackage.service");
		}
	};
	
	@SuppressWarnings("serial")
	public static final Map<Integer,String> DEFAULT_DIR_MAP = new HashMap<Integer, String>(){
		{
			put(Constant.JS, "static" + File.separator + "js" + File.separator + "pages");
			put(Constant.JSP, "WEB-INF" + File.separator + "pages");
		}
	};
	public static final Map<String,String> EXCLUDED_TABLEPREFIX_MAP = new HashMap<>();
	
}
