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
import com.fei.generator.model.ConnectionParam;
import com.fei.generator.model.Table;
import com.fei.generator.util.Constant;
import com.fei.generator.util.FreeMarkerUtil;
import com.fei.generator.util.StringUtil;

import freemarker.template.TemplateException;

/**
 * 生成文件[pojo,mapper xml,dao,service,controller]
 * 
 * @author fei
 *
 */
public class Generator {
	
	private Configuration configuration;
	
	public Generator(Configuration configuration) {
		this.configuration = configuration;
		
		if(configuration.getPojoPackage() != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.POJO, configuration.getPojoPackage());
		}
		if(configuration.getDaoPackage() != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.DAO_INTER, configuration.getDaoPackage());
		}
		if(configuration.getDaoImplPackage() != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.DAO_IMPL, configuration.getDaoImplPackage());
		}
		if(configuration.getServicePackage() != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.SERVICE_INTER, configuration.getServicePackage());
		}
		if(configuration.getServiceImplPackage() != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.SERVICE_IMPL, configuration.getServiceImplPackage());
		}
		if(configuration.getControllerPackage() != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.CONTROLLER, configuration.getControllerPackage());
		}
		if(configuration.getMapperPackage() != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.MAPPER, configuration.getMapperPackage());
		}
		if(configuration.getQueryPackage() != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.QUERY, configuration.getQueryPackage());
		}
		if(configuration.getBaseQueryPackage() != null){
			Constant.DEFAULT_PACKAGE_MAP.put(Constant.BASE_QUERY, configuration.getBaseQueryPackage());
		}
		
	}
	
	public Generator() {
		
	}

	

	public void start() throws IOException, TemplateException {
		
		DBTableInfo dbTableInfo = new MysqlDBTableInfo(configuration.getParam());
		Set<Table> tables = dbTableInfo.getTables(configuration.getDbName());
		if (configuration.isGeneratorPojo()) {
			generatorFile(tables,Constant.POJO);
		    generatorPojoKeyFile(tables,Constant.POJO_KEY);
		}
		if (configuration.isGeneratorQuery()) {
			generatorFile(tables,Constant.QUERY);
			generatorBaseQueryFile();
		}
		if (configuration.isGeneratorMapperXml()) {
			generatorFile(tables,Constant.MAPPER);
		}
		if (configuration.isGeneratorDao()) {
			generatorFile(tables,Constant.DAO_INTER);
		}
		if (configuration.isGeneratorDaoImpl()) {
			generatorFile(tables,Constant.DAO_IMPL);
		}
		if(configuration.isGeneratorService()){
			generatorFile(tables,Constant.SERVICE_INTER);
		}
		if(configuration.isGeneratorServiceImpl()){
			generatorFile(tables,Constant.SERVICE_IMPL);
		}
		if(configuration.isGeneratorController()){
			generatorFile(tables,Constant.CONTROLLER);
		}
	}

	private void generatorPojoKeyFile(Set<Table> tables, int pojoKey) throws IOException, TemplateException {
		for (Table table : tables) {
			if(table.getPrimaryKeyFields().size() > 1){
				Map<String, Object> root = new HashMap<String, Object>();
				root.put("table", table);
				root.put("key", pojoKey);
				root.put("className", getClassName(table.getTableName()));
				root.put("pojo_package", Constant.DEFAULT_PACKAGE_MAP.get(Constant.POJO));
				root.put("dir", new String(Constant.DEFAULT_PACKAGE_MAP.get(Constant.POJO)).replace(".", File.separator));
				File f = createFile(root);
				FreeMarkerUtil.generateFile(Constant.TEMPLATEFILE_MAP.get(Constant.POJO_KEY), f, root);
			}
		}
	}

	private void generatorBaseQueryFile() throws IOException, TemplateException {
		
		Map<String, Object> root = new HashMap<String, Object>();
		root.put("key", Constant.BASE_QUERY);
		root.put("className", "Base");
		root.put("base_query_package", Constant.DEFAULT_PACKAGE_MAP.get(Constant.BASE_QUERY));
		root.put("dir", new String(Constant.DEFAULT_PACKAGE_MAP.get(Constant.BASE_QUERY)).replace(".", File.separator));
		File f = createFile(root);
		FreeMarkerUtil.generateFile(Constant.TEMPLATEFILE_MAP.get(Constant.BASE_QUERY), f, root);
	}

	private void generatorFile(Set<Table> tables, int templateKey) throws IOException, TemplateException {
		if(tables != null && tables.size() > 0){
			
			String templateFileName = Constant.TEMPLATEFILE_MAP.get(templateKey);
			for(Table table : tables){
				Map<String, Object> root = getRootData(table,templateKey);
				File f = createFile(root);
				FreeMarkerUtil.generateFile(templateFileName, f, root);
			}
		}
		
	}

	private File createFile(Map<String, Object> root) {
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
		// 创建生成的文件
		String name = Constant.FILE_TYPE_NAME_MAP.get(key).equals(Constant.FILE_TYPE_NAME_MAP.get(Constant.POJO))?"": Constant.FILE_TYPE_NAME_MAP.get(key);
		File f = new File(file, root.get("className") + name + Constant.FILE_EXTENSION_MAP.get(key));

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
		
		String className = getClassName(table.getTableName());
		root.put("className", className);
		root.put("key", templateKey );
		root.put("table", table );
		String fPackage =  Constant.DEFAULT_PACKAGE_MAP.get(templateKey);
		root.put("dir",new String(fPackage).replace(".", File.separator));
		if(Constant.MAPPER.equals(templateKey)){
			fPackage = Constant.DEFAULT_PACKAGE_MAP.get(Constant.DAO_INTER);
		}
		
		root.put("pojo_package", Constant.DEFAULT_PACKAGE_MAP.get(Constant.POJO));
		root.put("dao_package", Constant.DEFAULT_PACKAGE_MAP.get(Constant.DAO_INTER));
		root.put("dao_impl_package", Constant.DEFAULT_PACKAGE_MAP.get(Constant.DAO_IMPL));
		root.put("service_package", Constant.DEFAULT_PACKAGE_MAP.get(Constant.SERVICE_INTER));
		root.put("service_impl_package", Constant.DEFAULT_PACKAGE_MAP.get(Constant.SERVICE_IMPL));
		root.put("controller_package", Constant.DEFAULT_PACKAGE_MAP.get(Constant.CONTROLLER));
		root.put("query_package", Constant.DEFAULT_PACKAGE_MAP.get(Constant.QUERY));
		root.put("base_query_package", Constant.DEFAULT_PACKAGE_MAP.get(Constant.BASE_QUERY));
		
		return root;
	}
	
	private String getClassName(String tableName) {
		
		if(tableName == null){
			return null;
		}
		// 文件名
		String[] split = tableName.split("_");
		StringBuilder sb = new StringBuilder("");
		sb.append(StringUtil.toUpperCaseFirstOne(split[0].toString()));
		for (int i = 1; i < split.length; i++) {
			sb.append(StringUtil.toUpperCaseFirstOne(split[i].toString()));
		}
		// 类名
		String className = StringUtil.toUpperCaseFirstOne(sb.toString());
		return className;
	}

	public static void main(String[] args) {
		Configuration _configuration = new Configuration();
		String dbName = "test";
		
		_configuration.setUrl("jdbc:mysql://localhost:3306/"+dbName+"?allowMultiQueries=true&useUnicode=true&characterEncoding=UTF-8");
		
		
		_configuration.setPojoPackage("com.xlkh.bdmp.pojo.server");
		_configuration.setDaoPackage("com.xlkh.bdmp.dao.server");
		_configuration.setMapperPackage("com.xlkh.bdmp.mapper.server");
		_configuration.setQueryPackage("com.xlkh.bdmp.query.server");
		_configuration.setBaseQueryPackage("com.xlkh.bdmp.query");
		_configuration.setServicePackage("com.xlkh.bdmp.service.server");
		_configuration.setServiceImplPackage("com.xlkh.bdmp.service.server");
		_configuration.setControllerPackage("com.xlkh.bdmp.controller.server");
		
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
