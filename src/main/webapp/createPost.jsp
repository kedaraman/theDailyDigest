
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>

<%@ page import="com.google.appengine.api.datastore.Query" %>

<%@ page import="com.google.appengine.api.datastore.Entity" %>

<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>

<%@ page import="com.google.appengine.api.datastore.Key" %>

<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<html>
	<head>
			<title>The Daily Digest- Create Post</title>
			<!-- insert CSS files here -->
	</head>
	
	<body>
		<%
			String blogName = request.getParameter("blogName");
			
			if(blogName == null){
				blogName = "default";
			}
			pageContext.setAttribute("blogName", blogName);
		%>
		
	
		<div id="header">
			<h1 id="title">the daily digest (Create Post)</h1>
			
			
		</div>
		
		<form action="/createPost" method="post">
		      <div>Title: <textarea name="title" rows="1" cols="150"></textarea></div>
		      <div>Blog Content: <textarea name="content" rows="20" cols="150"></textarea></div>
		      <div><input type="submit" value="Post Blog" /></div>
		      <input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>
    	</form>
    	<a href="/landingPage.jsp"><button>Delete Blog Post</button></a>
		
	</body>

</html>