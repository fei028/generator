package com.fei.generator.model;

import java.io.Serializable;

import com.fei.generator.util.Constant;
import com.fei.generator.util.StringUtil;

/**
 * 字段
 * @author fei
 *
 */
public class Field implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 26562449782653028L;
	
	private static final String COLUMN_PRIMARY_KEY ="PRI";
	@SuppressWarnings("unused")
	private static final String COLUMN_AUTO_INCREMENT ="auto_increment";
	
	/** 列名 */
	private String columnName;
	/** 属性名称[经列名转换而来按照规则] */
	private String propertyName;
	/** 默认值 */
	private String columnDefault;
	/** 能否为空 */
	private Boolean nullAble;
	/** 数据类型 */
	private String dataType;
	/** 主键 */
	private String columnKey;
	/** 自增判断 额外信息 */
	private String extra;
	/** 注释 */
	private String columnComment;
	
	public Field() {
		super();
	}
	public Field(String columnName, String columnDefault, boolean isNullAble, String dataType, String columnKey,
			String extra, String columnComment) {
		super();
		setColumnName(columnName);
		this.columnDefault = columnDefault;
		this.nullAble = isNullAble;
		this.dataType = Constant.DATATYPE_MAP.get(dataType) == null ? "Object" : Constant.DATATYPE_MAP.get(dataType);
		this.columnKey = columnKey;
		this.extra = extra;
		this.columnComment = columnComment;
	}
	public String getColumnName() {
		return columnName;
	}
	
	/**
	 * 该字段是否为主键字段
	 * @param field
	 * @return
	 */
	public static boolean isKey(Field field) {
		return field.getColumnKey().equals(COLUMN_PRIMARY_KEY);
	}
	
	public void setColumnName(String columnName) {
		this.columnName = columnName;
		
		StringBuilder sb = new StringBuilder("");
		String[] split = this.columnName.toLowerCase().split("_");
		sb.append(split[0]);
		for(int i = 1;i < split.length;i++){
			sb.append(StringUtil.toUpperCaseFirstOne(split[i]));
		}
		String propertyName = sb.toString();
		setPropertyName('_' != columnName.charAt(columnName.length() - 1) ?  propertyName : (propertyName + "_") );
	}
	public String getColumnDefault() {
		return columnDefault;
	}
	public void setColumnDefault(String columnDefault) {
		this.columnDefault = columnDefault;
	}
	
	public Boolean getNullAble() {
		return nullAble;
	}
	public void setNullAble(Boolean nullAble) {
		this.nullAble = nullAble;
	}
	public String getDataType() {
		return dataType;
	}
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	public String getColumnKey() {
		return columnKey;
	}
	public void setColumnKey(String columnKey) {
		this.columnKey = columnKey;
	}
	public String getExtra() {
		return extra;
	}
	public void setExtra(String extra) {
		this.extra = extra;
	}
	public String getColumnComment() {
		return columnComment;
	}
	public void setColumnComment(String columnComment) {
		this.columnComment = columnComment;
	}
	public String getPropertyName() {
		return propertyName;
	}
	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}
	
}
