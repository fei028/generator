package com.fei.generator.model;
/**
 * 数据库连接参数类
 * @author fei
 *
 */
public class ConnectionParam {

	private String classDriverName;
	private String url;
	private String username;
	private String password;
	public ConnectionParam(String classDriverName, String url, String username, String password) {
		super();
		this.classDriverName = classDriverName;
		this.url = url;
		this.username = username;
		this.password = password;
	}
	public ConnectionParam() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getClassDriverName() {
		return classDriverName;
	}
	public void setClassDriverName(String classDriverName) {
		this.classDriverName = classDriverName;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

}
