package com.fei.generator.util;

import freemarker.cache.ClassTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;

import java.io.*;
import java.util.Map;

@SuppressWarnings("deprecation")
public class FreeMarkerUtil {

	private static Configuration cfg;

	static {
		cfg = new Configuration();

		try {
			System.out.println(Constant.TEMPLATE_FILE_DIR.getAbsolutePath());
			System.out.print("new");
			ClassTemplateLoader loader = new ClassTemplateLoader(FreeMarkerUtil.class, "\\com\\fei\\generator\\template");
			cfg.setTemplateLoader(loader);
			//cfg.setDirectoryForTemplateLoading(Constant.TEMPLATE_FILE_DIR);
			cfg.setDefaultEncoding("UTF-8");
			cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public static void generateFile(String templateFileName, File f,Map<String, Object> root)
			throws IOException, TemplateException {
		Template template = cfg.getTemplate(templateFileName);
		
		Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(f), "UTF-8"));
		// 处理模版
		template.process(root, out);

		out.close();
	}

	public static void main(String[] args) throws IOException {
		String property = System.getProperty("db");
		System.out.println(property);
		File f = new File("src/main/java");
		System.out.println(f.getCanonicalPath());
		
	}
}
