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
    
    Key blogKey = KeyFactory.createKey("emailList", "default");
	Entity email = new Entity("Email", blogKey);
	email.setProperty("isSubscribed", false);
	email.setProperty("email", user.getEmail());

	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	
	Query query = new Query("Email", blogKey);
    List<Entity> emails = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(Integer.MAX_VALUE));
    boolean isFound = false;
	
    for(Entity e: emails) {
    	
    	if(e.getProperty("email").equals(email.getProperty("email"))) {
    		e.setProperty("isSubscribed", false);
    		datastore.put(e);
    		isFound = true;
    		break;
    	}
    }
    
	if(!isFound) {
		datastore.put(email);
	}
	resp.sendRedirect("/landingPage.jsp?blogName=" + "default");
    
    
//    resp.sendRedirect("/landingPage.jsp?blogName=" + blogName);

	}
}
