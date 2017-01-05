package com.fei.generator.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import com.fei.generator.model.ConnectionParam;
/**
 * 数据库连接工具类
 * @author fei
 *
 */
public class DBUtil {

	/**
	 * 获取数据库连接
	 * @return
	 * @throws SQLException
	 */
	public static Connection getConnection(ConnectionParam param) throws Exception{
		Class.forName(param.getClassDriverName());
		Connection conn = DriverManager.getConnection(param.getUrl(), param.getUsername(), param.getPassword());
		return conn;
	}
	
	public static void close(Connection conn) throws SQLException{
		if(conn != null && !conn.isClosed()){
			conn.close();
		}
	}

	public static ResultSet execute(Connection conn,String sql) throws Exception {
		
		PreparedStatement prepareStatement = conn.prepareStatement(sql);
		ResultSet resultSet = prepareStatement.executeQuery();
		return resultSet;
		
	}
}
