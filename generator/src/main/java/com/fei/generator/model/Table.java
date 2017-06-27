package com.fei.generator.model;

import java.io.Serializable;
import java.util.ArrayList;
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
	/** 该表中字段集合[不含主键] */
	private List<Field> fields;
	/** 该表中主键字段集合  */
	private List<Field> primaryKeyFields = new ArrayList<>();
	
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public List<Field> getFields() {
		return fields;
	}
	public void setFields(List<Field> fields) {
		this.fields = fields;
	}
	public List<Field> getPrimaryKeyFields() {
		return primaryKeyFields;
	}
	public void setPrimaryKeyFields(List<Field> primaryKeyFields) {
		this.primaryKeyFields = primaryKeyFields;
	}
	
	
	
}
