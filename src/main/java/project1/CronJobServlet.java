package project1;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.logging.Logger;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import java.io.InputStream;
import java.io.ByteArrayInputStream;
import java.io.UnsupportedEncodingException;

import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@SuppressWarnings("serial")
public class CronJobServlet extends HttpServlet {
	
	private static final Logger _logger = Logger.getLogger(CronJobServlet.class.getName());
//	public final static long MILLISECONDS_PER_DAY = 24 * 60 * 60 * 1000;
	public final static long MILLISECONDS_PER_DAY = 5 * 60 * 1000;//TODO: CHANGE back to 24 HR

	
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	
			throws IOException {
		
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	    Key blogKey = KeyFactory.createKey("theDailyDigest", "default");
	    
	    Query queryBlog = new Query("Blogpost", blogKey).addSort("date", Query.SortDirection.DESCENDING);
	    List<Entity> blogposts = datastore.prepare(queryBlog).asList(FetchOptions.Builder.withLimit(Integer.MAX_VALUE));
	    String emailContent = "";
	    boolean atLeastOnePostToSend = false;
	    for(Entity blogpost : blogposts)
	    {
	    	Date d = (Date) blogpost.getProperty("date");
	    	Date currentDate = new Date();
	    	if(Math.abs(d.getTime() - currentDate.getTime()) <= MILLISECONDS_PER_DAY)
	    	{
	    		atLeastOnePostToSend = true;
	    		resp.getWriter().println(blogpost.getProperty("title") + "  :  " + d.toString() + "---------");
		    	emailContent += "Title: " + blogpost.getProperty("title") + "\n";
		    	emailContent += "Date: " + blogpost.getProperty("date") + "\n";
		    	emailContent += "User: " + blogpost.getProperty("user") + "\n";
		    	emailContent += "\t" + blogpost.getProperty("content") + "\n\n\n";
	    	}
	    	
	    }
	    if(atLeastOnePostToSend)
	    {
	    	resp.getWriter().println("Sent message:\n\n" + emailContent);
		    
		    
		    Key emailKey = KeyFactory.createKey("emailList", "default");
		    Query queryEmail = new Query("Email", emailKey);
		    List<Entity> emails = datastore.prepare(queryEmail).asList(FetchOptions.Builder.withLimit(Integer.MAX_VALUE));
		    
		    Properties props = new Properties();
			Session session = Session.getDefaultInstance(props, null);
			
		    for(Entity em: emails) {
		    	resp.getWriter().println("Em.gv: " + em.getProperty("isSubscribed"));
		    	if((boolean) em.getProperty("isSubscribed")) {
		    		resp.getWriter().println("Send to :" + em.getProperty("email")+"\n");
		    		String recipient = (String) em.getProperty("email");
		    		
		    		try {
		    			  Message msg = new MimeMessage(session);
		    			  msg.setFrom(new InternetAddress("kedar.v.raman@gmail.com", "The Daily Digest"));
		    			  msg.addRecipient(Message.RecipientType.TO,
		    			                   new InternetAddress(recipient, "Subscriber"));
		    			  msg.setSubject("the daily digest Daily Digest");
		    			  msg.setText(emailContent);
		    			  Transport.send(msg);
		    			  resp.getWriter().println("Sent message");
		    			} catch (AddressException e) {
		    			  // ...
		    			} catch (MessagingException e) {
		    			  // ...
		    			} catch (UnsupportedEncodingException e) {
		    			  // ...
		    			}
		    		
		    	}
		    }
	    }
	    else
	    {
	    	resp.getWriter().println("Nothing recent to send\n");
	    }
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	
			throws ServletException, IOException {
	
		doGet(req, resp);
	}
	
}


