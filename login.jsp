<HTML>
<HEAD>
<TITLE>Radiology Information System Login</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*, db.Database" %>
<%
	if(request.getParameter("bSubmit") != null) {

        Database db = new Database();
        db.connect();
        Connection conn = db.getConnection();

        //get the user input from the login page
    	String username = (request.getParameter("USERID")).trim();
        String password = (request.getParameter("PASSWD")).trim();

        //select the user table from the underlying db and validate the user name and password
    	Statement stmt = null;
        ResultSet rset = null;

    	String sql = "select password from users where user_name = '"+ username +"'";

    	try {
        	stmt = conn.createStatement();
	        rset = stmt.executeQuery(sql);
    	} catch(Exception e) {
	        out.println("<hr>" + e.getMessage() + "<hr>");
    	}
        String truepwd = "";
    	while(rset != null && rset.next()) {
        	truepwd = (rset.getString(1)).trim();
        }

		// Close the database connection
		db.close();
		try {
			stmt.close();
        	rset.close();
        }
        catch(Exception e) {
        	out.println("<hr>" + e.getMessage() + "<hr>");
        }

    	//display the result
        if(password.equals(truepwd)) {
	        out.println("<p><b>Your Login is Successful!</b></p>");
	        response.setHeader("Refresh", "3;url=menu.jsp");
	        //response.sendRedirect("menu.jsp");
	    } else {
	    	out.println("<p><b>Either your username or your password is invalid!</b></p>");
        	response.setHeader("Refresh", "3;url=login.jsp");
        	//response.sendRedirect("login.jsp");
		}
		
        

    } 
    else {
        out.println("<H1><LEFT>Radiology Information System Login</LEFT></H1>");
        out.println("<form method=post action=login.jsp>");
        out.println("<table>");
        out.println("<tr><th>Username:</th>");
        out.println("<td><input type=text name=USERID maxlength=20></td></tr>");
        out.println("<tr><th>Password:</th>");
        out.println("<td><input type=password name=PASSWD maxlength=20></td></tr>");
        out.println("<tr><td><input type=submit name=bSubmit value=Submit></td></tr>");       
        out.println("</table>");
        out.println("</form>");
        
    }
%>



</BODY>
</HTML>

