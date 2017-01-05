package com.fei.generator.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Map;



import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

@SuppressWarnings("deprecation")
public class FreeMarkerUtil {

	private static Configuration cfg;

	static {
		cfg = new Configuration();

		try {
			System.out.println(Constant.TEMPLATE_FILE_DIR.getAbsolutePath());
			cfg.setDirectoryForTemplateLoading(Constant.TEMPLATE_FILE_DIR);
			cfg.setDefaultEncoding("UTF-8");
		} catch (IOException e) {
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
