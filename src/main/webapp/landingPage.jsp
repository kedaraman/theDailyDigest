<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<html>
	<head>
			<title>The Daily Digest</title>
			<!-- insert CSS files here -->
	</head>
	
	<body>
		<div id="header">
			<h1 id="title">the daily digest</h1>
			
			<%
			    UserService userService = UserServiceFactory.getUserService();
			    User user = userService.getCurrentUser();
			    if (user != null) {
			      pageContext.setAttribute("user", user);
			%>
			<p>	Hello, ${fn:escapeXml(user.nickname)}! </p>
			<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>"><button> Sign Out</button></a>
			<%
			    } else {
			%>
			<p>Hello!</p>
			<a href="<%= userService.createLoginURL(request.getRequestURI()) %>"><button> Sign In</button></a>
			<%
			    }
			%>
			
			<% 
				if(user != null){
			%>
			<a href="/createPost.jsp"><button>Create New Blog Post</button></a>
			<%
				}
			%>
		</div>
		
	</body>

</html>