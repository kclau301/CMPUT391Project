<HTML>
<HEAD>


<TITLE>Update Form</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*, db.Database" %>
<%
Database db = new Database();
db.connect();
Connection conn = db.getConnection();

String checkClass = (String) session.getAttribute("class");

if (checkClass.equals("a")){
	if (request.getParameter("SEARCH").equals(request.getParameter("user"))) {
		Statement stmt = null;
        	ResultSet rset = null;
		String username = request.getParameter("USERNAME");

		String sqlStatement = "select password, class from users where user_name = '"+ username +"'";

		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sqlStatement);

			rset.next();
			String password = (rset.getString("password"));
			String classStr = (rset.getString("class"));
		

                	out.println("<H1><LEFT>User Update</LEFT></H1>");
                	out.println("<form method=post action=updateSubmit.jsp>");
			out.println("Username: <input type=text name=USERNAME value="+username+"><br>");
			out.println("Password: <input type=text name=PASSWORD value="+password+"><br>");
			out.println("Class: <input type=text name=CLASS value="+classStr+"><br>");
                	out.println("<input type=submit name=updateuser value=Update>");
                	out.println("</form>");
			conn.close()
		} catch(Exception e) {
			out.println("<hr>" + e.getMessage() + "<hr>");
		}

	} else if (request.getParameter("SEARCH").equals(request.getParameter("person"))) {
		Statement stmt = null;
        	ResultSet rset = null;
		String personID = request.getParameter("PERSONID");

		String sqlStatement = "select first_name, last_name, address, email, phone from persons where person_id = '"+ personID +"'";

		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sqlStatement);

		
			rset.next();
			String firstName = (rset.getString("first_name"));
			String lastName = (rset.getString("last_name"));
			String address = (rset.getString("address"));
			String email = (rset.getString("email"));
			String phone = (rset.getString("phone"));

                	out.println("<H1><LEFT>Person Update</LEFT></H1>");
                	out.println("<form method=post action=updateSubmit.jsp>");
			out.println("First Name: <input type=text name=FIRSTNAME value="+firstName+"> <br>");
			out.println("Last Name: <input type=text name=LASTNAME value="+lastName+"><br>");
			out.println("Address: <input type=text name=ADDRESS value="+address+"><br>");
			out.println("Email: <input type=text name=EMAIL value="+email+"><br>");
			out.println("Phone: <input type=text name=PHONE value="+phone+"><br>");
                	out.println("<input type=submit name=updateperson value=Update>");
                	out.println("</form>");
			conn.close();
		} catch(Exception e) {
			out.println("<hr>" + e.getMessage() + "<hr>");
		}

	} else if (request.getParameter("SEARCH").equals(request.getParameter("famdoc"))) {
		Statement stmt = null;
        	ResultSet rset = null;
		String personID = request.getParameter("PERSONID");
		String docID = request.getParameter("DOCID");

		String sqlStatement = "select * from family_doctor where doctor_id = '"+ docID +"' AND patient_id = '"+ personID +"'";

		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sqlStatement);

			rset.next();
			String docIDT = (rset.getString(1));
			String personIDT = (rset.getString(2));

                	out.println("<H1><LEFT>Family Doctor Update</LEFT></H1>");
                	out.println("<form method=post action=updateSubmit.jsp>");
			out.println("Doctor ID: <input type=text name=DOCID value="+docIDT+"><br>");
			out.println("Patient ID: <input type=text name=PATID value="+personIDT+"><br>");
                	out.println("<input type=submit name=updatefamilydoc value=Update>");
                	out.println("</form>");
			conn.close()
		} catch(Exception e) {
			out.println("<hr> ERROR: " + e.getMessage() + "<hr>");
		}
	}

}


else {
	out.println("<H1><LEFT><font color=ff0000>ACCESS DENIED</font></LEFT></H1>");
	conn.close()
	response.setHeader("Refresh", "3;url=menu.jsp");
}

%>

</BODY>
</HTML>
