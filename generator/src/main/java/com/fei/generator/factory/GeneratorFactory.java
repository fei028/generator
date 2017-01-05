package com.fei.generator.factory;

import com.fei.generator.Generator;
import com.fei.generator.config.Configuration;

public class GeneratorFactory {

	private Configuration configuration;
	
	public GeneratorFactory() {
	}
	
	public GeneratorFactory(Configuration configuration) {
		super();
		this.configuration = configuration;
	}

	public Generator createGenerator() throws Exception{
		if(configuration == null){
			throw new Exception("Configuration为NULL,必须传入Configuration实例化对象");
		}else{
			if(configuration.getDbName() == null || configuration.getDbName().trim().equals("")){
				throw new Exception("Configuration实例化对象中dbName，未设置");
			}
		}
		Generator generator = new Generator(configuration);
		
		return generator;
		
	}

	public Configuration getConfiguration() {
		return configuration;
	}

	public void setConfiguration(Configuration configuration) {
		this.configuration = configuration;
	}
	
	
}
