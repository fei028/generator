package com.fei.generator.db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.fei.generator.model.ConnectionParam;
import com.fei.generator.model.Field;
import com.fei.generator.model.Table;
import com.fei.generator.util.Constant;
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
				+ "FROM information_schema.columns "
				+ "WHERE table_schema='"+tableSchema+"'";
		
		Set<String> set = null;
		Set<Table> tableSet = new HashSet<Table>();
		Table table = null;
		try {
			Connection conn = DBUtil.getConnection(param);
			ResultSet resultSet = DBUtil.execute(conn,getTableSql);
			if(excludeTableNames != null && excludeTableNames.length > 0){
				// 去重 防止同一表名多个
				set=new HashSet<String>(Arrays.asList(excludeTableNames));
			}else{
				set=new HashSet<String>();
			}
			while(resultSet.next()){
				String tableName = resultSet.getString("TABLE_NAME");
				if(!set.contains(tableName)){
					table = new Table();
					table.setTableName(tableName);
					// 获取字段集合
					List<Field> fields = getFieldsByTableName(tableSchema, table);
					table.setFields(fields);
					tableSet.add(table);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tableSet;
	}
	/**
	 * 获取数据库中表中字段集合
	 * @param tableSchema
	 * @param table
	 * @return
	 */
	public List<Field> getFieldsByTableName(String tableSchema,Table table){
		List<Field> fields = new ArrayList<Field>();
		
		String getTableFiledsSql = 
				  "SELECT COLUMN_NAME,COLUMN_DEFAULT,IS_NULLABLE,DATA_TYPE,COLUMN_KEY,EXTRA,COLUMN_COMMENT "
				+ "FROM information_schema.columns "
				+ "WHERE table_schema='"+tableSchema+"' and table_name='"+table.getTableName()+"'";
		try {
			Connection conn = DBUtil.getConnection(param);
			ResultSet resultSet = DBUtil.execute(conn, getTableFiledsSql);
			Field field = null;
			while(resultSet.next()){
				String columnName = resultSet.getString("COLUMN_NAME");
				columnName = columnName.toLowerCase();
				String columnName2 = resultSet.getString("COLUMN_NAME");
				String columnDefault = resultSet.getString("COLUMN_DEFAULT");
				boolean isNullAble = resultSet.getString("IS_NULLABLE").equals("YES");
				String dataType = resultSet.getString("DATA_TYPE");
				String columnKey = resultSet.getString("COLUMN_KEY");
				
				String extra = resultSet.getString("EXTRA");
				String columnComment = resultSet.getString("COLUMN_COMMENT");
				
				field = new Field(columnName, columnDefault, isNullAble, dataType, columnKey, extra, columnComment);
				field.setColumnName2(columnName2);
				
				fields.add(field);
				
				if(columnKey.equals(Constant.FIELD_IS_KEY)){
					table.setPrimaryKeyField(field);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fields;
	}
}
