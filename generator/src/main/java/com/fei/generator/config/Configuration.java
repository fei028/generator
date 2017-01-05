package com.fei.generator.config;

import com.fei.generator.model.ConnectionParam;

public class Configuration {
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
	/** 生成文件 默认生成 **/
	private boolean isGeneratorPojo = true;
	private boolean isGeneratorQuery = true;
	private boolean isGeneratorMapperXml = true;
	private boolean isGeneratorDao = true;
	private boolean isGeneratorDaoImpl = true;
	private boolean isGeneratorService = true;
	private boolean isGeneratorServiceImpl = true;
	private boolean isGeneratorController = true;
	/** 数据库名称 */
	private String dbName;

	private ConnectionParam param;

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

}
