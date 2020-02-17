
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
			<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
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
			<h1 id="title">the daily digest</h1>
			
			
		</div>
		
		<form action="/createPost" method="post">
		      <div>Title: <br><textarea class="userinput" name="title" rows="1" cols="150" required></textarea></div>
		      <div>Category: 
		      	<select id="category" name="category" required>
		      		<option value="vegan">vegan</option>
		      		<option value="keto">keto</option>
		      		<option value="paleo">paleo</option>
		      		<option value="none" selected>none</option>
		      	</select>
		      </div>
		      <div>Blog Content: <br><textarea class="userinput" name="content" rows="20" cols="150" required></textarea></div><br>
		      <a><input id="postblog" type="submit" value="Post Blog" /></a>
		      <input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>
    	</form>
    	<a href="/landingPage.jsp" id="delete">Delete Blog Post</a>
		
	</body>

</html>