package com.fei.generator.config;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fei.generator.exception.FormatStringErrorException;
import com.fei.generator.exception.MapKeyAlreadyExistException;
import com.fei.generator.model.ConnectionParam;
import com.fei.generator.util.Constant;
/**
 * 
 * @author fei
 *
 */
public class Configuration {
	
	private static final Logger logger = LoggerFactory.getLogger(Configuration.class);
	
	/** 作者[创建人] */
	private String author = "XuPengFei";
	/** 数据库连接配置 **/
	private String classDriverName = "com.mysql.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/platform?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull";
	private String username = "root";
	private String password = "1234";
	/** 生成的代码是否依赖于platform——common工程 */
	private boolean dependPlatformCommon = false;
	private String platformCommonPackage = "com.xlkh.platform.common";
	/** 是否使用basedao 默认不使用 */
	private boolean useBaseDao = false;
	/** 是否使用baseService 默认不使用 */
	private boolean useBaseService = false;
	/** 包结构配置 **/
	private String commonPackage;// 公共包
	private String pojoPackage = "pojo";
	private String daoPackage = "dao";
	private String daoImplPackage = "dao";
	private String servicePackage = "service";
	private String serviceImplPackage = "service";
	private String controllerPackage = "controller";
	private String mapperPackage = "mapper";
	private String queryPackage = "query";
	private String baseQueryPackage = "query";
	/** js 公共文件夹 */  
	private String jsCommonDir = "static" + File.separator + "js" + File.separator + "pages";
	private String jspCommonDir = "WEB-INF" + File.separator + "pages";
	/** 模块名称替换map key:旧模块名称 value:替换成的新模块名称 */
	private Map<String,String> moduleReplaceMap;
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
	/** 表名前缀规则 */
	private int tablePrefixRule = 1;
	/** 是否忽视表名前缀 默认不忽略 */
	private boolean tablePrefixIgnore = false;
	/** 忽略的表名前缀 表名中如果没有其中的前缀 将忽略该张表 */
	private String[] includedTablePrefix;
	/** 忽略的表名前缀 表名中如果有其中的前缀 将忽略该张表 */
	private String[] excludedTablePrefix;
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
		this.pojoPackage = pojoPackage != null ? pojoPackage.trim() : this.pojoPackage;
		logger.debug("设置pojoPackage:{}", pojoPackage);
	}

	public void setDaoPackage(String daoPackage) {
		this.daoPackage = daoPackage != null ? daoPackage.trim() : this.daoPackage;
		logger.debug("设置daoPackage:{}", daoPackage);
	}

	public void setDaoImplPackage(String daoImplPackage) {
		this.daoImplPackage = daoImplPackage != null ? daoImplPackage.trim() : this.daoImplPackage;
		logger.debug("设置daoImplPackage:{}", daoImplPackage);
	}

	public void setServicePackage(String servicePackage) {
		this.servicePackage = servicePackage != null ? servicePackage.trim() : this.servicePackage;
		logger.debug("设置servicePackage:{}", servicePackage);
	}

	public void setServiceImplPackage(String serviceImplPackage) {
		this.serviceImplPackage = serviceImplPackage != null ? serviceImplPackage.trim() : this.serviceImplPackage;
		logger.debug("设置serviceImplPackage:{}", serviceImplPackage);
	}

	public void setControllerPackage(String controllerPackage) {
		this.controllerPackage = controllerPackage != null ? controllerPackage.trim() : this.controllerPackage;
		logger.debug("设置controllerPackage:{}", controllerPackage);
	}

	public void setMapperPackage(String mapperPackage) {
		this.mapperPackage = mapperPackage;
		logger.debug("设置mapperPackage:{}", mapperPackage);
	}

	public void setQueryPackage(String queryPackage) {
		this.queryPackage = queryPackage;
		logger.debug("设置queryPackage:{}", queryPackage);
	}

	public void setBaseQueryPackage(String baseQueryPackage) {
		this.baseQueryPackage = baseQueryPackage;
		logger.debug("设置baseQueryPackage:{}", baseQueryPackage);
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
		logger.debug("设置是否生成pojo文件:{}", isGeneratorPojo ? "生成" : "不生成");
	}

	public void setGeneratorQuery(boolean isGeneratorQuery) {
		this.isGeneratorQuery = isGeneratorQuery;
		logger.debug("设置是否生成query文件:{}", isGeneratorQuery ? "生成" : "不生成");
	}

	public void setGeneratorMapperXml(boolean isGeneratorMapperXml) {
		this.isGeneratorMapperXml = isGeneratorMapperXml;
		logger.debug("设置是否生成mapper文件:{}", isGeneratorMapperXml ? "生成" : "不生成");
	}

	public void setGeneratorDao(boolean isGeneratorDao) {
		this.isGeneratorDao = isGeneratorDao;
		logger.debug("设置是否生成dao文件:{}", isGeneratorDao ? "生成" : "不生成");
	}

	public void setGeneratorDaoImpl(boolean isGeneratorDaoImpl) {
		this.isGeneratorDaoImpl = isGeneratorDaoImpl;
		logger.debug("设置是否生成daoImpl文件:{}", isGeneratorDaoImpl ? "生成" : "不生成");
	}

	public void setGeneratorService(boolean isGeneratorService) {
		this.isGeneratorService = isGeneratorService;
		logger.debug("设置是否生成service文件:{}", isGeneratorService ? "生成" : "不生成");
	}

	public void setGeneratorServiceImpl(boolean isGeneratorServiceImpl) {
		this.isGeneratorServiceImpl = isGeneratorServiceImpl;
		logger.debug("设置是否生成serviceImpl文件:{}", isGeneratorServiceImpl ? "生成" : "不生成");
	}

	public void setGeneratorController(boolean isGeneratorController) {
		this.isGeneratorController = isGeneratorController;
		logger.debug("设置是否生成controller文件:{}", isGeneratorController ? "生成" : "不生成");
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
			Constant.FILE_TYPE_NAME_MAP.put(Constant.BASE_DAO, this.daoSuffix);
		}
		
		logger.debug("设置dao文件后缀:{}", daoSuffix);
	}


	public boolean isTablePrefixIgnore() {
		return tablePrefixIgnore;
	}

	public void setTablePrefixIgnore(boolean tablePrefixIgnore) {
		this.tablePrefixIgnore = tablePrefixIgnore;
		logger.debug("设置是否忽略表名称前缀:{}", tablePrefixIgnore ? "忽略" : "不忽略");
	}

	public String getSeparator() {
		return separator;
	}

	public void setSeparator(String separator) {
		this.separator = separator != null ? separator.trim() : "";
		logger.debug("设置表名称单词之间的分隔符:{}", separator);
	}

	public boolean isGeneratorJs() {
		return isGeneratorJs;
	}

	public void setGeneratorJs(boolean isGeneratorJs) {
		this.isGeneratorJs = isGeneratorJs;
		logger.debug("设置是否生成js文件:{}", isGeneratorJs ? "生成" : "不生成");
	}

	public boolean isGeneratorJsp() {
		return isGeneratorJsp;
	}

	public void setGeneratorJsp(boolean isGeneratorJsp) {
		this.isGeneratorJsp = isGeneratorJsp;
		logger.debug("设置是否生成jsp文件:{}", isGeneratorJsp ? "生成" : "不生成");
	}

	public String getCommonPackage() {
		return commonPackage;
	}

	public void setCommonPackage(String commonPackage) {
		this.commonPackage = commonPackage != null ? commonPackage.trim() : this.commonPackage;
		logger.debug("设置commonPackage:{}", commonPackage);
	}

	public String[] getExcludedTablePrefix() {
		return excludedTablePrefix;
	}

	public void setExcludedTablePrefix(String[] excludedTablePrefix) {
		this.excludedTablePrefix = excludedTablePrefix;
		if(excludedTablePrefix != null && excludedTablePrefix.length > 0){
			for (String tablePrefixName : excludedTablePrefix) {
				Constant.EXCLUDED_TABLEPREFIX_MAP.put(tablePrefixName.trim(), tablePrefixName);
			}
		}
		logger.debug("设置excludedTablePrefix:{}", excludedTablePrefix);
	}

	public int getTablePrefixRule() {
		return tablePrefixRule;
	}

	public void setTablePrefixRule(int tablePrefixRule) {
		this.tablePrefixRule = tablePrefixRule;
	}

	public String[] getIncludedTablePrefix() {
		return includedTablePrefix;
	}

	public void setIncludedTablePrefix(String[] includedTablePrefix) {
		this.includedTablePrefix = includedTablePrefix;
	}

	public String getJsCommonDir() {
		return jsCommonDir;
	}

	public void setJsCommonDir(String jsCommonDir) {
		this.jsCommonDir = jsCommonDir != null ? jsCommonDir.trim() : this.jsCommonDir;
	}

	public String getJspCommonDir() {
		return jspCommonDir;
	}

	public void setJspCommonDir(String jspCommonDir) {
		this.jspCommonDir = jspCommonDir != null ? jspCommonDir.trim() : this.jspCommonDir;
	}

	public Map<String, String> getModuleReplaceMap() {
		return moduleReplaceMap;
	}

	public void setModuleReplaceMap(Map<String, String> moduleReplaceMap) {
		this.moduleReplaceMap = moduleReplaceMap;
	}
	/**
	 * 输入指定格式的字符串 用于模块名称的更改
	 * @param moduleReplaceStr 格式 [旧模块名称,新模块名称],[旧模块名称,新模块名称],[旧模块名称,新模块名称],  注意新旧模块名称不能已数字开头
	 */
	public void setModuleReplaceStr(String moduleReplaceStr){//[旧模块名称,新模块名称],[旧模块名称,新模块名称],[旧模块名称,新模块名称],
		moduleReplaceStr = moduleReplaceStr == null ? null : moduleReplaceStr.trim();
		if(moduleReplaceStr != null && moduleReplaceStr != ""){
			String _moduleReplaceStr = null;
			if(!(moduleReplaceStr.charAt(moduleReplaceStr.length() - 1) == ',')){
				_moduleReplaceStr = moduleReplaceStr + ",";
			} else {
				_moduleReplaceStr = moduleReplaceStr;
			}
			String regex = "^(\\[[a-zA-Z]+[0-9]*,[a-zA-Z]+[0-9]*\\],)+$";
			if(!_moduleReplaceStr.matches(regex)){
				throw new FormatStringErrorException(moduleReplaceStr + "格式错误,示例正确格式 ==> [旧模块名称,新模块名称],[旧模块名称,新模块名称],[旧模块名称,新模块名称]  注意新旧模块名称不能已数字开头");
			}
			
			String[] moduleReplaceStrArr = _moduleReplaceStr.split("],");
			
			if(moduleReplaceStrArr != null && moduleReplaceStrArr.length > 0){
				moduleReplaceMap = new HashMap<>();
				for (String str : moduleReplaceStrArr) {
					String[] moduleArr = str.substring(1, str.length()).split(",");
					if(moduleReplaceMap.get(moduleArr[0]) == null){
						moduleReplaceMap.put(moduleArr[0], moduleArr[1]);
					} else {
						throw new MapKeyAlreadyExistException("根据moduleReplaceStr转化成map时,存在相同的key,检查moduleReplaceStr中多个[旧模块名称,新模块名称]之间是否存在多个相同的旧模块名称,请更正");
					}
				}
			}
		}
	}

	public boolean isDependPlatformCommon() {
		return dependPlatformCommon;
	}

	public void setDependPlatformCommon(boolean dependPlatformCommon) {
		this.dependPlatformCommon = dependPlatformCommon;
	}

	public String getPlatformCommonPackage() {
		return platformCommonPackage;
	}

	public void setPlatformCommonPackage(String platformCommonPackage) {
		this.platformCommonPackage = platformCommonPackage;
	}

	public boolean isUseBaseDao() {
		return useBaseDao;
	}

	public void setUseBaseDao(boolean useBaseDao) {
		this.useBaseDao = useBaseDao;
	}

	public boolean isUseBaseService() {
		return useBaseService;
	}

	public void setUseBaseService(boolean useBaseService) {
		this.useBaseService = useBaseService;
	}
	
}
