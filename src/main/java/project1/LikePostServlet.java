package project1;

import java.io.IOException;
import javax.servlet.http.*;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class LikePostServlet extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	
			throws IOException{
		
		resp.getWriter().println(req.getParameter("blogPostTitle"));
		

		
		
	}
}