package com.fei.generator.model;

import java.io.Serializable;
import java.util.List;
/**
 * 数据库表
 * @author fei
 *
 */
public class Table implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4773621982599516868L;
	/** 表名 */
	private String tableName;
	/** 该表中字段集合 */
	private List<Field> fields;
	
	private Field primaryKeyField;
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName.toLowerCase();;
	}
	public List<Field> getFields() {
		return fields;
	}
	public void setFields(List<Field> fields) {
		this.fields = fields;
	}
	public Field getPrimaryKeyField() {
		return primaryKeyField;
	}
	public void setPrimaryKeyField(Field primaryKeyField) {
		this.primaryKeyField = primaryKeyField;
	}
	
	
}
