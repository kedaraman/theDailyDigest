
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
			<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
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
			<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign Out</a>
			<%
			    } else {
			%>
			<p>Hello!</p>
			<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign In</a>
			<%
			    }
			%>
			
			<% 
				if(user != null){
			%>
			<a href="/createPost.jsp" class="but">Create New Blog Post</a>
			<a href= "/subscribe" class="but">Subscribe</a>
			<a href= "/unsubscribe" class="but">Unsubscribe</a>
			
			<!-- <a href= "/cronJob" ><button>Send Email</button></a>-->
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
				//response.getWriter().println("User Request Null");
			}
			
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		    Key blogKey = KeyFactory.createKey("theDailyDigest", blogName);
		    
		    // Run an ancestor query to ensure we see the most up-to-date
		    // view of the Greetings belonging to the selected Guestbook.
		    
		    Query query = new Query("Blogpost", blogKey).addSort("date", Query.SortDirection.DESCENDING);
		    List<Entity> blogposts = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(Integer.MAX_VALUE));

		    if (blogposts.isEmpty()) {

		        %>
		        <p>Blog '${fn:escapeXml(blogName)}' has no posts.</p>
		        <%

		    } else {

		        %>
		        
		        <%

		        for (Entity blogpost : blogposts) {
		        	
		        		String bpcat = (String) blogpost.getProperty("category");
		        	
			        	pageContext.setAttribute("blogpost_title", (String) blogpost.getProperty("title"));
			        	pageContext.setAttribute("blogpost_date", blogpost.getProperty("date"));
			            pageContext.setAttribute("blogpost_content", blogpost.getProperty("content"));
			            pageContext.setAttribute("blogpost_user", blogpost.getProperty("user"));
			            if(blogpost.getProperty("category") == null)
			            {
			            	pageContext.setAttribute("blogpost_category", "none");
			            	bpcat = "none";
			            }
			            else{
			            	pageContext.setAttribute("blogpost_category", blogpost.getProperty("category"));
			            }
			            
			        if(bpcat.equals("paleo")){   
			            %>
			            	<div id="divBlogPost">
			            	<h3 class="blogpost">${fn:escapeXml(blogpost_title)}</h3>
			            	<p id="byUser" class="blogpost">By ${fn:escapeXml(blogpost_user.nickname)}</p>
			            	<p class="blogpost">Date: ${fn:escapeXml(blogpost_date)}</p>
			            	<p class="blogpost">Category: ${fn:escapeXml(blogpost_category)}</p>
			            	
			            	<p class="blogpost">${fn:escapeXml(blogpost_content)}</p>
			            	
			            	<!-- <hr>-->
			            	</div>

			            	
	
			                
			                
			            
			            
			            <%
		            	
		        	}
		        }

		    }
			
		%>
		<a href="/landingPage.jsp">Go Back to Main Page</a>
		
		
	</body>

</html>