import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PictureBrowse
 */
@SuppressWarnings("serial")
public class PictureBrowse extends HttpServlet {

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// send out the HTML file
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		out.println("<html>");
		out.println("<head>");
		out.println("<title> Photo List </title>");
		out.println("</head>");
		out.println("<body bgcolor=\"#000000\" text=\"#cccccc\" >");
		out.println("<center>");
		out.println("<h3>The List of Images </h3>");
	}

}
