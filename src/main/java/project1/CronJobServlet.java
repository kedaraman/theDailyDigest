package project1;

import java.io.IOException;
import java.util.Properties;
import java.util.logging.Logger;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
// [END simple_includes]

// [START multipart_includes]
import java.io.InputStream;
import java.io.ByteArrayInputStream;
import java.io.UnsupportedEncodingException;
import javax.activation.DataHandler;
import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
// [END multipart_includes]
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class CronJobServlet extends HttpServlet {
	
	private static final Logger _logger = Logger.getLogger(CronJobServlet.class.getName());
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	
			throws IOException {
	
		Properties props = new Properties();
		Session session = Session.getDefaultInstance(props, null);

		try {
		  Message msg = new MimeMessage(session);
		  msg.setFrom(new InternetAddress("venkataravila@gmail.com", "Example.com Admin"));
		  msg.addRecipient(Message.RecipientType.TO,
		                   new InternetAddress("kedar.v.raman@gmail.com", "Mr. User"));
		  msg.setSubject("Your Example.com account has been activated");
		  msg.setText("This is a test");
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
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	
			throws ServletException, IOException {
	
		doGet(req, resp);
	}
	
}


