package project1;

import java.io.IOException;
import javax.servlet.http.*;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class CreatePostServlet extends HttpServlet{
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException{

			String content = req.getParameter("content");
			String title = req.getParameter("title");
			resp.getWriter().println("CREATING POST: \nTitle: \t" + title + "\nContent: \n" + content);

		
	}
}
