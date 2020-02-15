package project1;

import com.google.appengine.api.datastore.DatastoreService;

import com.google.appengine.api.datastore.DatastoreServiceFactory;

import com.google.appengine.api.datastore.Entity;

import com.google.appengine.api.datastore.Key;

import com.google.appengine.api.datastore.KeyFactory;

import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;

 

import java.io.IOException;

import java.util.Date;

 

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

public class UnsubscribeServlet extends HttpServlet{
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)

            throws IOException {

    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    
    if(user != null) {
    	resp.getWriter().println("Unsubscribed with the following email: " + user.getEmail());
    } else {
    	resp.getWriter().println("No user");
    }


//    String blogName = req.getParameter("blogName");
//    Key blogKey = KeyFactory.createKey("theDailyDigest", blogName);
//    String content = req.getParameter("content");
//    String title = req.getParameter("title");
//    Date date = new Date();
//    Entity blogpost = new Entity("Blogpost", blogKey);
//    blogpost.setProperty("user", user);
//    blogpost.setProperty("date", date);
//    blogpost.setProperty("title", title);
//    blogpost.setProperty("content", content);
//
//
//
//    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
//    datastore.put(blogpost);
//    resp.sendRedirect("/landingPage.jsp?blogName=" + blogName);

	}
}
