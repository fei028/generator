package com.fei.generator;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import com.fei.generator.config.Configuration;
import com.fei.generator.db.DBTableInfo;
import com.fei.generator.db.MysqlDBTableInfo;
import com.fei.generator.factory.GeneratorFactory;
import com.fei.generator.model.Table;
import com.fei.generator.util.Constant;
import com.fei.generator.util.FreeMarkerUtil;
import com.fei.generator.util.StringUtil;

import freemarker.template.TemplateException;

/**
 * 生成文件[pojo,mapper xml,dao,service,controller,js,jsp]
 * 
 * @author fei
 *
 */
public class Generator {
	
	private Configuration configuration;
	
	public Generator(Configuration configuration) {
		this.configuration = configuration;
		
		String commonPackage = configuration.getCommonPackage();
		String pojoPackage = configuration.getPojoPackage();
		Constant.DEFAULT_BASE_PACKAGE = commonPackage;
		if(pojoPackage != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.POJO, commonPackage + "." + pojoPackage);
		}
		
		String daoPackage = configuration.getDaoPackage();
		if(daoPackage != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.DAO_INTER, commonPackage + "." + daoPackage);
		}
		
		String daoImplPackage = configuration.getDaoImplPackage();
		if(daoImplPackage != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.DAO_IMPL, commonPackage + "." + daoImplPackage);
		}
		
		String servicePackage = configuration.getServicePackage();
		if(servicePackage != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.SERVICE_INTER, commonPackage + "." + servicePackage);
		}
		
		String serviceImplPackage = configuration.getServiceImplPackage();
		if(serviceImplPackage != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.SERVICE_IMPL, commonPackage + "." + serviceImplPackage);
		}
		
		String controllerPackage = configuration.getControllerPackage();
		if(controllerPackage != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.CONTROLLER, commonPackage + "." + controllerPackage);
		}
		
		String mapperPackage = configuration.getMapperPackage();
		if(mapperPackage != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.MAPPER, commonPackage + "." + mapperPackage);
		}
		
		String queryPackage = configuration.getQueryPackage();
		if(queryPackage != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.QUERY, commonPackage + "." + queryPackage);
		}
		
		String baseQueryPackage = configuration.getBaseQueryPackage();
		if(baseQueryPackage != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.BASE_QUERY, commonPackage + "." + baseQueryPackage);
		}
		
		String jsCommonDir = configuration.getJsCommonDir();
		if(jsCommonDir != null){
			Constant.DEFAULT_DIR_MAP.put(Constant.JS, jsCommonDir);
		}
		
		String jspCommonDir = configuration.getJspCommonDir();
		if(jspCommonDir != null){
			Constant.DEFAULT_DIR_MAP.put(Constant.JSP, jspCommonDir);
		}
	}
	
	public Generator() {
		
	}

	

	public void start() throws IOException, TemplateException {
		
		DBTableInfo dbTableInfo = new MysqlDBTableInfo(configuration.getParam());
		Set<Table> tables = dbTableInfo.getTables(configuration.getDbName());
		if (configuration.isGeneratorPojo()) {
			generatorFile(tables, Constant.POJO);
		    generatorPojoKeyFile(tables, Constant.POJO_KEY);
		}
		if (configuration.isGeneratorQuery()) {
			generatorFile(tables, Constant.QUERY);
		}
		if (configuration.isGeneratorMapperXml()) {
			generatorFile(tables, Constant.MAPPER);
		}
		if (configuration.isGeneratorDao()) {
			generatorFile(tables, Constant.DAO_INTER);
		}
		if (configuration.isGeneratorDaoImpl()) {
			generatorFile(tables, Constant.DAO_IMPL);
		}
		if(configuration.isGeneratorService()){
			generatorFile(tables, Constant.SERVICE_INTER);
		}
		if(configuration.isGeneratorServiceImpl()){
			generatorFile(tables, Constant.SERVICE_IMPL);
		}
		if(configuration.isGeneratorController()){
			generatorFile(tables, Constant.CONTROLLER);
		}
		if(configuration.isGeneratorJs()){
			generatorFile(tables, Constant.JS);
		}
		if(configuration.isGeneratorJsp()){
			generatorFile(tables, Constant.JSP);
		}
		
		generatorBaseQueryFile();
		generatorSqlLikeFile();
	}

	private void generatorPojoKeyFile(Set<Table> tables, int pojoKey) throws IOException, TemplateException {
		for (Table table : tables) {
			if(table.getPrimaryKeyFields().size() > 1){
				Map<String, Object> root = new HashMap<String, Object>();
				root.put("author", configuration.getAuthor());
				root.put("table", table);
				root.put("key", pojoKey);
				String tableName = table.getTableName();
				root.put("className", getClassName(tableName));
				String moduleName = getModuleName(tableName);
				String pojoPackage = Constant.DEFAULT_PACKAGE_MAP.get(Constant.POJO) + "." + moduleName;
				root.put("pojo_package", pojoPackage);
				root.put("dir", new String(pojoPackage).replace(".", File.separator));
				File f = createFile(root);
				FreeMarkerUtil.generateFile(Constant.TEMPLATEFILE_MAP.get(Constant.POJO_KEY), f, root);
			}
		}
	}

	private void generatorBaseQueryFile() throws IOException, TemplateException {
		
		Map<String, Object> root = new HashMap<String, Object>();
		root.put("author", configuration.getAuthor());
		root.put("key", Constant.BASE_QUERY);
		root.put("className", "Base");
		root.put("base_query_package", Constant.DEFAULT_PACKAGE_MAP.get(Constant.BASE_QUERY));
		root.put("dir", new String(Constant.DEFAULT_PACKAGE_MAP.get(Constant.BASE_QUERY)).replace(".", File.separator));
		File f = createFile(root);
		FreeMarkerUtil.generateFile(Constant.TEMPLATEFILE_MAP.get(Constant.BASE_QUERY), f, root);
	}

	private void generatorSqlLikeFile() throws IOException, TemplateException {
		Map<String, Object> root = new HashMap<String, Object>();
		root.put("author", configuration.getAuthor());
		root.put("key", Constant.SQLLIKE_ENUM);
		root.put("className", "SqlLike");
		root.put("base_query_package", Constant.DEFAULT_PACKAGE_MAP.get(Constant.BASE_QUERY));
		root.put("dir", new String(Constant.DEFAULT_PACKAGE_MAP.get(Constant.BASE_QUERY)).replace(".", File.separator));
		File f = createFile(root);
		FreeMarkerUtil.generateFile(Constant.TEMPLATEFILE_MAP.get(Constant.SQLLIKE_ENUM), f, root);
	}
	
	private void generatorFile(Set<Table> tables, int templateKey) throws IOException, TemplateException {
		if(tables != null && tables.size() > 0){
			
			String templateFileName = Constant.TEMPLATEFILE_MAP.get(templateKey);
			for(Table table : tables){
				Map<String, Object> root = getRootData(table, templateKey);
				if(Constant.EXCLUDED_TABLEPREFIX_MAP.get(root.get("module")) == null){
					File f = createFile(root);
					FreeMarkerUtil.generateFile(templateFileName, f, root);
				}
			}
		}
		
	}

	private File createFile(Map<String, Object> root) {
		Integer key = (Integer) root.get("key");
		// 创建生成的文件
		if(key.equals(Constant.JS) || key.equals(Constant.JSP)){
			return createJsOrJspFile(root);
		} else {
			return createOtherFile(root);
		}
	}
	
	private File createJsOrJspFile(Map<String, Object> root) {
		Integer key = (Integer) root.get("key");
		// WebContent
		// src/main/webapp/
		String className = StringUtil.toLowerCaseFirstOne(root.get("className").toString());
		// 目录不存在时创建
		File file = new File("src" + File.separator + "main" + File.separator + "java");
		if(file.exists()){
			file = new File("src" + File.separator + "main" + File.separator + "webapp");
			if(!file.exists()){
				file.mkdirs();
			}
			file = new File(file, (String) root.get("dir") + File.separator + root.get("module") + File.separator + className);	
		}else{
			file = new File("WebContent" + File.separator + root.get("dir") + File.separator + root.get("module") + File.separator + className);		
		}
		if (!file.exists()) {
			file.mkdirs();
		}

		File f = new File(file, className + Constant.FILE_EXTENSION_MAP.get(key));
		
		if (!f.exists()) {
			try {
				f.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		System.out.println(f.getAbsolutePath() + "=" + f.isFile());
		
		return f;
	}

	private File createOtherFile(Map<String, Object> root) {
		Integer key = (Integer) root.get("key");
		// 目录不存在时创建
		File file = new File("src/main/java");
		if(file.exists()){
			file = new File("src/main/java" + File.separator + root.get("dir"));	
		}else{
			file = new File("src" + File.separator + root.get("dir"));	
		}
		if (!file.exists()) {
			file.mkdirs();
		}
		
		String nameSuffix = key.equals(Constant.POJO) ? "" : Constant.FILE_TYPE_NAME_MAP.get(key);
		File f = new File(file, root.get("className") + nameSuffix + Constant.FILE_EXTENSION_MAP.get(key));
		
		if (!f.exists()) {
			try {
				f.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		System.out.println(f.getAbsolutePath() + "=" + f.isFile());
		
		return f;
	}

	private Map<String, Object> getRootData(Table table, int templateKey) {
		Map<String, Object> root = new HashMap<String, Object>();
		root.put("author", configuration.getAuthor());
		// 获取模块名称，即默认表名称前缀
		String moduleName = getModuleName(table.getTableName());
		// 检查模块名称是否需要替换
		Map<String, String> moduleReplaceMap = configuration.getModuleReplaceMap();
		if(moduleReplaceMap.get(moduleName) != null){
			moduleName = moduleReplaceMap.get(moduleName);
		}
		
		String className = getClassName(table.getTableName());
		
		Map<Integer, String> defaultPackageMap = Constant.DEFAULT_PACKAGE_MAP;
		if(Constant.JS == templateKey || Constant.JSP == templateKey){
			className = StringUtil.toLowerCaseFirstOne(className);
			root.put("dir", Constant.DEFAULT_DIR_MAP.get(templateKey));
		} else {
			String fPackage =  defaultPackageMap.get(templateKey) + "." + moduleName;
			root.put("dir",new String(fPackage).replace(".", File.separator));
			if(Constant.MAPPER.equals(templateKey)){
				fPackage = defaultPackageMap.get(Constant.DAO_INTER) + "." + moduleName;
			}
		}
		root.put("className", className);
		root.put("key", templateKey);
		root.put("table", table);
		root.put("daoSuffix", configuration.getDaoSuffix());
		root.put("module", moduleName);
		
		root.put("common_package", Constant.DEFAULT_BASE_PACKAGE);
		root.put("pojo_package", defaultPackageMap.get(Constant.POJO) + "." + moduleName);
		root.put("dao_package", defaultPackageMap.get(Constant.DAO_INTER) + "." + moduleName);
		root.put("dao_impl_package", defaultPackageMap.get(Constant.DAO_IMPL) + "." + moduleName);
		root.put("service_package", defaultPackageMap.get(Constant.SERVICE_INTER) + "." + moduleName);
		root.put("service_impl_package", defaultPackageMap.get(Constant.SERVICE_IMPL) + "." + moduleName);
		root.put("controller_package", defaultPackageMap.get(Constant.CONTROLLER) + "." + moduleName);
		root.put("query_package", defaultPackageMap.get(Constant.QUERY) + "." + moduleName);
		root.put("base_query_package", defaultPackageMap.get(Constant.BASE_QUERY));
		
		return root;
	}
	
	private String getModuleName(String tableName) {
		if(tableName == null){
			throw new RuntimeException("传入的参数 表名称为空");
		}
	
		int arrStartIndex = 0; //根据分隔符分割后得到的数组split从第几个数组元素开始拼接字符串
		if(configuration.isTablePrefixIgnore()){
			arrStartIndex = configuration.getTablePrefixRule();
		}
		// 文件名
		String[] split = tableName.split(configuration.getSeparator());
		if(split.length <= arrStartIndex){
			throw new RuntimeException("分割后数组元素个数:" + split.length + ",您配置忽略前" + arrStartIndex + "个数组元素");
		}
		StringBuilder sb = new StringBuilder("");
		sb.append(StringUtil.toUpperCaseFirstOne(split[arrStartIndex].toString()));
		for (int i = 1; i < arrStartIndex; i++) {
			sb.append(StringUtil.toUpperCaseFirstOne(split[i].toString()));
		}
		// 模块名称
		String moduleName = StringUtil.toLowerCaseFirstOne(sb.toString());
		return moduleName;
	}

	private String getClassName(String tableName) {
		
		if(tableName == null){
			throw new RuntimeException("传入的参数 表名称为空");
		}
	
		int arrStartIndex = 0; //根据分隔符分割后得到的数组split从第几个数组元素开始拼接字符串
		if(configuration.isTablePrefixIgnore()){
			arrStartIndex = configuration.getTablePrefixRule();
		}
		// 文件名
		String[] split = tableName.split(configuration.getSeparator());
		if(split.length <= arrStartIndex){
			throw new RuntimeException("分割后数组元素个数:" + split.length + ",您配置忽略前" + arrStartIndex + "个数组元素");
		}
		StringBuilder sb = new StringBuilder("");
		sb.append(StringUtil.toUpperCaseFirstOne(split[arrStartIndex].toString()));
		for (int i = arrStartIndex + 1; i < split.length; i++) {
			sb.append(StringUtil.toUpperCaseFirstOne(split[i].toString()));
		}
		// 类名
		String className = StringUtil.toUpperCaseFirstOne(sb.toString());
		return className;
	}

	public static void main(String[] args) {
		Configuration _configuration = new Configuration();
		String dbName = "gen";
		
		_configuration.setUrl("jdbc:mysql://localhost:3306/"+dbName+"?allowMultiQueries=true&useUnicode=true&characterEncoding=UTF-8");
		
		
		_configuration.setPojoPackage("com.xlkh.bdmp.pojo.spark");
		_configuration.setDaoPackage("com.xlkh.bdmp.dao.spark");
		_configuration.setMapperPackage("com.xlkh.bdmp.mapper.spark");
		_configuration.setQueryPackage("com.xlkh.bdmp.query.spark");
		_configuration.setBaseQueryPackage("com.xlkh.bdmp.query");
		_configuration.setServicePackage("com.xlkh.bdmp.service.spark");
		_configuration.setServiceImplPackage("com.xlkh.bdmp.service.spark");
		_configuration.setControllerPackage("com.xlkh.bdmp.controller.spark");
		
		_configuration.setGeneratorDaoImpl(false);
		
		_configuration.setDbName(dbName );
		GeneratorFactory generatorFactory = new GeneratorFactory(_configuration );
		Generator generator = null;
		try {
			generator = generatorFactory.createGenerator();
			generator.start();
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}

}
