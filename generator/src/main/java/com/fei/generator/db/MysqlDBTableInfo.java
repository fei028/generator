package com.fei.generator.db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.fei.generator.model.ConnectionParam;
import com.fei.generator.model.Field;
import com.fei.generator.model.Table;
import com.fei.generator.util.DBUtil;


public class MysqlDBTableInfo implements DBTableInfo{

	private ConnectionParam param;
	
	public MysqlDBTableInfo(ConnectionParam param) {
		super();
		this.param = param;
	}
	@Override
	public Set<Table> getTables(String tableSchema, String... excludeTableNames) {
		String getTableSql = 
				  "SELECT DISTINCT TABLE_NAME "
				+ "FROM INFORMATION_SCHEMA.TABLES "
				+ "WHERE table_type='BASE TABLE' AND table_schema='" + tableSchema + "'";
		Set<Table> tableSet = null;
		Connection conn = null;
		try {
			conn = DBUtil.getConnection(param);
			ResultSet resultSet = DBUtil.execute(conn,getTableSql);
			tableSet = getTableSet(conn, resultSet, tableSchema, excludeTableNames);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				DBUtil.close(conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return tableSet;
	}
	
	private Set<Table> getTableSet(Connection conn, ResultSet resultSet,String tableSchema, String... excludeTableNames) throws SQLException {
		
		Set<Table> tableSet = new HashSet<Table>();
		
		Table table = null;
		Set<String> set = null;
		
		if(excludeTableNames != null && excludeTableNames.length > 0){
			// 去重 防止同一表名多个
			set = new HashSet<String>(Arrays.asList(excludeTableNames));
		}else{
			set = new HashSet<String>();
		}
		
		while(resultSet.next()){
			String tableName = resultSet.getString("TABLE_NAME");
			if(!isExcludeTableName(tableName, set)){
				table = new Table();
				table.setTableName(tableName);
				// 获取字段集合
				List<Field> fields = getFieldsByTableName(conn, tableSchema, table);
				table.setFields(fields);
				tableSet.add(table);
			}
		}
		
		return tableSet;
	}
	
	/**
	 * 判断是否是排除的表
	 * @param tableName
	 * @param set
	 * @return
	 */
	private boolean isExcludeTableName(String tableName, Set<String> set) {
		if(set != null && set.size() > 0){
			for (String tablePrefix : set) {
				if(tableName.startsWith(tablePrefix)){
					return true;
				}
			}
		}
		return false;
	}
	/**
	 * 获取数据库中表中字段集合
	 * @param tableSchema
	 * @param table
	 * @return
	 */
	public List<Field> getFieldsByTableName(Connection conn, String tableSchema,Table table){
		List<Field> fields = new ArrayList<Field>();
		
		String getTableFiledsSql = 
				  "SELECT COLUMN_NAME,COLUMN_DEFAULT,IS_NULLABLE,DATA_TYPE,COLUMN_KEY,EXTRA,COLUMN_COMMENT "
				+ "FROM information_schema.columns "
				+ "WHERE table_schema='"+tableSchema+"' and table_name='"+table.getTableName()+"'";
		try {
			ResultSet resultSet = DBUtil.execute(conn, getTableFiledsSql);
			Field field = null;
			while(resultSet.next()){
				
				field = getField(resultSet);
				
				if(!Field.isKey(field)){
					// 普通字段
					fields.add(field);
				}else{
					// 主键字段
					table.getPrimaryKeyFields().add(field);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fields;
	}
	
	private Field getField(ResultSet resultSet) throws SQLException {
		
		String columnName = resultSet.getString("COLUMN_NAME");
		String columnDefault = resultSet.getString("COLUMN_DEFAULT");
		boolean isNullAble = resultSet.getString("IS_NULLABLE").equals("YES");
		String dataType = resultSet.getString("DATA_TYPE");
		String columnKey = resultSet.getString("COLUMN_KEY");
		String extra = resultSet.getString("EXTRA");
		String columnComment = resultSet.getString("COLUMN_COMMENT");
		
		Field field = new Field(columnName, columnDefault, isNullAble, dataType, columnKey, extra, columnComment);
		
		return field;
	}
	
}
