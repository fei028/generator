package com.fei.generator.db;

import java.sql.SQLException;
import java.util.Set;

import com.fei.generator.model.Table;

/**
 * 数据库表信息接口
 * @author fei
 *
 */
public interface DBTableInfo {

	/**
	 * 获取数据库中表
	 * @param tableSchema 
	 * @param excludeTableNames [可选参数] 忽略的表集合 
	 * @return
	 */
	public Set<Table> getTables(String tableSchema,String...excludeTableNames);
}
