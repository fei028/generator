package com.fei.generator.config;

import com.fei.generator.model.ConnectionParam;
import com.fei.generator.util.Constant;
/**
 * 
 * @author fei
 *
 */
public class Configuration {
	
	/** 作者[创建人] */
	private String author = "XuPengFei";
	/** 数据库连接配置 **/
	private String classDriverName = "com.mysql.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/platform?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull";
	private String username = "root";
	private String password = "1234";
	/** 包结构配置 **/
	private String pojoPackage;
	private String daoPackage;
	private String daoImplPackage;
	private String servicePackage;
	private String serviceImplPackage;
	private String controllerPackage;
	private String mapperPackage;
	private String queryPackage;
	private String baseQueryPackage;
	private String jsPackage;
	private String jspPackage;
	/** 模块名称 默认取包名称最后一个文件夹名称 */
	private String module;
	/** 生成文件 默认生成 **/
	private boolean isGeneratorPojo = true;
	private boolean isGeneratorQuery = true;
	private boolean isGeneratorMapperXml = true;
	private boolean isGeneratorDao = true;
	private boolean isGeneratorDaoImpl = true;
	private boolean isGeneratorService = true;
	private boolean isGeneratorServiceImpl = true;
	private boolean isGeneratorController = true;
	private boolean isGeneratorJs = true;
	private boolean isGeneratorJsp = true;
	/** Dao层java文件后缀名称 */
	private String daoSuffix = "Dao";
	/** 表名前缀 */
	private String tablePrefix;
	/** 是否忽视表名前缀 默认不忽略 */
	private boolean tablePrefixIgnore = false;
	/** 表名中单词间的分隔符 默认'_'*/
	private String separator = "_";
	/** 数据库名称 */
	private String dbName;

	private ConnectionParam param;

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getClassDriverName() {
		return classDriverName;
	}

	public String getUrl() {
		return url;
	}

	public String getUsername() {
		return username;
	}

	public String getPassword() {
		return password;
	}

	public String getPojoPackage() {
		return pojoPackage;
	}

	public String getDaoPackage() {
		return daoPackage;
	}

	public String getDaoImplPackage() {
		return daoImplPackage;
	}

	public String getServicePackage() {
		return servicePackage;
	}

	public String getServiceImplPackage() {
		return serviceImplPackage;
	}

	public String getControllerPackage() {
		return controllerPackage;
	}

	public String getMapperPackage() {
		return mapperPackage;
	}

	public String getQueryPackage() {
		return queryPackage;
	}

	public String getBaseQueryPackage() {
		return baseQueryPackage;
	}

	public void setClassDriverName(String classDriverName) {
		this.classDriverName = classDriverName;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setPojoPackage(String pojoPackage) {
		this.pojoPackage = pojoPackage;
	}

	public void setDaoPackage(String daoPackage) {
		this.daoPackage = daoPackage;
	}

	public void setDaoImplPackage(String daoImplPackage) {
		this.daoImplPackage = daoImplPackage;
	}

	public void setServicePackage(String servicePackage) {
		this.servicePackage = servicePackage;
	}

	public void setServiceImplPackage(String serviceImplPackage) {
		this.serviceImplPackage = serviceImplPackage;
	}

	public void setControllerPackage(String controllerPackage) {
		this.controllerPackage = controllerPackage;
	}

	public void setMapperPackage(String mapperPackage) {
		this.mapperPackage = mapperPackage;
	}

	public void setQueryPackage(String queryPackage) {
		this.queryPackage = queryPackage;
	}

	public void setBaseQueryPackage(String baseQueryPackage) {
		this.baseQueryPackage = baseQueryPackage;
	}

	public boolean isGeneratorPojo() {
		return isGeneratorPojo;
	}

	public boolean isGeneratorQuery() {
		return isGeneratorQuery;
	}

	public boolean isGeneratorMapperXml() {
		return isGeneratorMapperXml;
	}

	public boolean isGeneratorDao() {
		return isGeneratorDao;
	}

	public boolean isGeneratorDaoImpl() {
		return isGeneratorDaoImpl;
	}

	public boolean isGeneratorService() {
		return isGeneratorService;
	}

	public boolean isGeneratorServiceImpl() {
		return isGeneratorServiceImpl;
	}

	public boolean isGeneratorController() {
		return isGeneratorController;
	}

	public String getDbName() {
		return dbName;
	}

	public void setGeneratorPojo(boolean isGeneratorPojo) {
		this.isGeneratorPojo = isGeneratorPojo;
	}

	public void setGeneratorQuery(boolean isGeneratorQuery) {
		this.isGeneratorQuery = isGeneratorQuery;
	}

	public void setGeneratorMapperXml(boolean isGeneratorMapperXml) {
		this.isGeneratorMapperXml = isGeneratorMapperXml;
	}

	public void setGeneratorDao(boolean isGeneratorDao) {
		this.isGeneratorDao = isGeneratorDao;
	}

	public void setGeneratorDaoImpl(boolean isGeneratorDaoImpl) {
		this.isGeneratorDaoImpl = isGeneratorDaoImpl;
	}

	public void setGeneratorService(boolean isGeneratorService) {
		this.isGeneratorService = isGeneratorService;
	}

	public void setGeneratorServiceImpl(boolean isGeneratorServiceImpl) {
		this.isGeneratorServiceImpl = isGeneratorServiceImpl;
	}

	public void setGeneratorController(boolean isGeneratorController) {
		this.isGeneratorController = isGeneratorController;
	}

	public void setDbName(String dbName) {
		this.dbName = dbName;
	}

	public ConnectionParam getParam() {
		if(param == null){
			param = new ConnectionParam(classDriverName, url, username, password);
		}
		return param;
	}

	public void setParam(ConnectionParam param) {
		this.param = param;
	}

	public String getDaoSuffix() {
		return daoSuffix;
	}

	public void setDaoSuffix(String daoSuffix) {
		this.daoSuffix = daoSuffix != null ? daoSuffix.trim() : null;
		
		if(daoSuffix != null){
			Constant.FILE_TYPE_NAME_MAP.put(Constant.DAO_INTER, this.daoSuffix);
		}
	}

	public String getTablePrefix() {
		return tablePrefix;
	}

	public void setTablePrefix(String tablePrefix) {
		this.tablePrefix = tablePrefix != null ? tablePrefix.trim() : null;
	}

	public boolean isTablePrefixIgnore() {
		return tablePrefixIgnore;
	}

	public void setTablePrefixIgnore(boolean tablePrefixIgnore) {
		this.tablePrefixIgnore = tablePrefixIgnore;
	}

	public String getSeparator() {
		return separator;
	}

	public void setSeparator(String separator) {
		this.separator = separator != null ? separator.trim() : "";
	}

	public boolean isGeneratorJs() {
		return isGeneratorJs;
	}

	public void setGeneratorJs(boolean isGeneratorJs) {
		this.isGeneratorJs = isGeneratorJs;
	}

	public boolean isGeneratorJsp() {
		return isGeneratorJsp;
	}

	public void setGeneratorJsp(boolean isGeneratorJsp) {
		this.isGeneratorJsp = isGeneratorJsp;
	}

	public String getJsPackage() {
		return jsPackage;
	}

	public void setJsPackage(String jsPackage) {
		this.jsPackage = jsPackage;
	}

	public String getJspPackage() {
		return jspPackage;
	}

	public void setJspPackage(String jspPackage) {
		this.jspPackage = jspPackage;
	}

	public String getModule() {
		if(module == null){
			String[] pacArr = pojoPackage.split("\\.");
			module = pacArr[pacArr.length - 1];
		}
		return module;
	}

	public void setModule(String module) {
		this.module = module != null ? module.trim() : null;
	}

}
