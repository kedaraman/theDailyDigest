package project1;

import com.google.appengine.api.datastore.DatastoreService;

import com.google.appengine.api.datastore.DatastoreServiceFactory;

import com.google.appengine.api.datastore.Entity;

import com.google.appengine.api.datastore.Key;

import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.FetchOptions;

import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;

 

import java.io.IOException;

import java.util.Date;
import java.util.List;

 

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

public class UnsubscribeServlet extends HttpServlet{
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp)

            throws IOException {

    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    
    if(user != null) {
    	resp.getWriter().println("Unsubscribed with the following email: " + user.getEmail());
    } else {
    	resp.getWriter().println("No user");
    }
    
    
//    resp.sendRedirect("/landingPage.jsp?blogName=" + blogName);

	}
}
