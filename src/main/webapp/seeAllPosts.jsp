
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
		
		
		<%
			String blogName = request.getParameter("blogName");
		
			if(blogName == null){
				blogName = "default";
			}
			pageContext.setAttribute("blogName", blogName);
			
			//UserService userService = UserServiceFactory.getUserService();
			//User user = userService.getCurrentUser();

			if (user != null) {
				pageContext.setAttribute("user", user);
			} else {
				response.getWriter().println("User Request Null");
			}
			
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		    Key blogKey = KeyFactory.createKey("theDailyDigest", blogName);
		    
		    // Run an ancestor query to ensure we see the most up-to-date
		    // view of the Greetings belonging to the selected Guestbook.
		    
		    Query query = new Query("Blogpost", blogKey).addSort("user", Query.SortDirection.DESCENDING).addSort("date", Query.SortDirection.DESCENDING);
		    List<Entity> blogposts = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(Integer.MAX_VALUE));

		    if (blogposts.isEmpty()) {

		        %>
		        <p>Blog '${fn:escapeXml(blogName)}' has no posts.</p>
		        <%

		    } else {

		        %>
		        <p>Messages in Blog '${fn:escapeXml(blogName)}'.</p>
		        <%

		        for (Entity blogpost : blogposts) {
		        	
		        	pageContext.setAttribute("blogpost_title", blogpost.getProperty("title"));
		        	pageContext.setAttribute("blogpost_date", blogpost.getProperty("date"));
		            pageContext.setAttribute("blogpost_content", blogpost.getProperty("content"));
		            
		            if (blogpost.getProperty("user") == null) {
		            	
		                %>
		                <p>An anonymous person wrote:</p>
		                <%
		                
		            } else {
		            	
		                pageContext.setAttribute("blogpost_user", blogpost.getProperty("user"));
		                %>
		                <p><b>${fn:escapeXml(blogpost_user.nickname)}</b> wrote:</p>
		                <%
		                
		            }

		            %>
		            <blockquote>${fn:escapeXml(blogpost_title)}</blockquote>
		            <blockquote>${fn:escapeXml(blogpost_date)}</blockquote>
		            <blockquote>${fn:escapeXml(blogpost_content)}</blockquote>
		            <%

		        }

		    }
			
		%>
		
		<a href="/landingPage.jsp">Go Back to Main Page</a>
		
		
	</body>
	
	
	<!--  <input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>-->
	

</html>