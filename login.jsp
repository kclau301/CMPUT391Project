<HTML>
<HEAD>
<TITLE>Radiology Information System Login</TITLE>
</HEAD>

<BODY>

	<%@ page import="java.sql.*, db.Database"%>
	<%
		if (request.getParameter("bSubmit") != null) {

			//get the user input from the login page
			String username = (request.getParameter("USERID")).trim();
			String password = (request.getParameter("PASSWD")).trim();

			Database db = new Database();
			db.connect();
			Connection conn = db.getConnection();
			Statement stmt = null;
			ResultSet rset = null;
			String sql = "select password, class from users where user_name = '"
					+ username + "'";
			String truepwd = "";
			String userClass = "";

			try {
				stmt = conn.createStatement();
				rset = stmt.executeQuery(sql);

				while (rset != null && rset.next()) {
					truepwd = (rset.getString(1)).trim();
					userClass = rset.getString(2);
				}
			} catch (Exception e) {
				out.println("<hr>" + e.getMessage() + "<hr>");
			} finally {
				// Close the database connection
				db.close(conn, stmt, null, rset);
			}

			//display the result
			if (password.equals(truepwd) && !username.equals("")) {
				out.println("<p><b>Your Login is Successful!</b></p>");
				session.setAttribute("username", username);
				session.setAttribute("class", userClass);
				response.setHeader("Refresh", "3;url=menu.jsp");
				//response.sendRedirect("menu.jsp");
			} else {
				String error = "<p><b><font color=ff0000>Either your username or your password is invalid!</font></b></p>";
				session.setAttribute("error", error);
				response.sendRedirect("login.jsp");
			}
		} else {
			out.println("<H1><LEFT>Radiology Information System Login</LEFT></H1>");
			out.println("<form method=post action=login.jsp>");
			out.println("<table>");
			out.println("<tr><th>Username:</th>");
			out.println("<td><input type=text name=USERID maxlength=20></td></tr>");
			out.println("<tr><th>Password:</th>");
			out.println("<td><input type=password name=PASSWD maxlength=20></td></tr>");
			out.println("<tr><td><input type=submit name=bSubmit value=Submit></td></tr>");
			out.println("</table>");
			String invalid = (String) session.getAttribute("error");
			if (invalid != null) {
				out.println(invalid);
				session.removeAttribute("error");
			}
			out.println("</form>");
		}
	%>

</BODY>
</HTML>

