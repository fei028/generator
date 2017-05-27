<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
     <%@ include file="../../common/header.jsp" %>
     <!-- Theme style -->
     <link href="${'$'}{pageContext.request.contextPath }/static/css/pages/_list.css" rel="stylesheet" type="text/css" />
  </head>
  <body class="fixedbody">
    <jsp:include page="../../common/navPath.jsp"></jsp:include>
    <div id="themeCondition" class="theme-condition">
	  <div class="form-inline" role="form" id="searchForm">
	  	<#list table.fields as field>
		<div class="form-group username-div">
		  <label for="username">${field.columnComment }</label>
		  <input type="text" class="form-control" name="${field.propertyName?uncap_first}" placeholder="请输入${field.columnComment }"/>
		</div>
		</#list>
		<#list table.fields as field>
		<#if field.dataType == "Date">
		<div class="form-group">
		  <label for="beginDate">创建时间</label>
		  <input type="text" class="form-control" id="beginDate" name="beginDate" placeholder="开始时间"/>
		</div>
		<div class="form-group">
		  <label id="endTime-label" for="endDate">至</label>
		  <input type="text" class="form-control" id="endDate" name="endDate" placeholder="结束时间" />
		</div>
		<span>&nbsp;</span>
		<#break>
		</#if>
		</#list>
		<div class="form-group">
		  <button class="btn btn-bg" id="searchBtn">查询</button>
		</div>
		<div class="form-group">
		  <button class="btn-3" id="resetBtn"><img src="${'$'}{pageContext.request.contextPath }/static/image/reset.png"/>重置</button>
		</div>
	  </div>
    </div>
  
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">新增修改***</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal" id="myForm" role="form" method="post">
	                <div class="form-group row" style="display:none">
						<label class="col-md-3 col-sm-3 dialog-label"></label>
						<input class="col-md-7 col-sm-7 dialog-input" id="${table.primaryKeyFields[0].propertyName?uncap_first}" name="${table.primaryKeyFields[0].propertyName?uncap_first}"/>
					</div>
					<#list table.fields as field>
					<div class="form-group">
						<label class="col-sm-3 control-label">${field.columnComment }</label>
						<div class="col-sm-8">
      						<input type="email" class="form-control" id="${field.propertyName?uncap_first}" name="${field.propertyName?uncap_first}"">
    					</div>
					</div>
					</#list>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-close" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-bg" id="saveBtn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	<%@ include file="../../common/table.jsp" %>
	<%@ include file="../../common/footer.jsp" %>
	<script src="${'$'}{pageContext.request.contextPath }/static/js/pages/verify.js" type="text/javascript"></script>
	<script src="${'$'}{pageContext.request.contextPath }/static/js/pages/table-pagination.js" type="text/javascript"></script>
	<script src="${'$'}{pageContext.request.contextPath }/static/js/pages/${module }/${className?uncap_first}/${className?uncap_first}.js" type="text/javascript"></script>
  </body>
</html>