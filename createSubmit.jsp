<HTML>
<HEAD>


<TITLE>Create Submission</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*, java.util.Date, java.text.SimpleDateFormat, db.Database" %>
<%
Database db = new Database();
db.connect();
Connection conn = db.getConnection();

String checkClass = (String) session.getAttribute("class");

if (checkClass.equals("a")){
	if (request.getParameter("create").equals(request.getParameter("user"))) {
		Statement stmt = null;

		String username = request.getParameter("USERNAME");
		String password = request.getParameter("PASSWORD");
		String classStr = request.getParameter("CLASS");
		String personID = request.getParameter("PERSONID");
		Date date = new Date();
		String dateStr = new SimpleDateFormat("MM/dd/yyyy").format(date);

		String insertStr = "INSERT INTO users VALUES('"+username+"', '"+password+"', '"+classStr+"', '"+personID+"', to_date('"+dateStr+"', 'MM/DD/YYYY'))";
		
		try {
			stmt = conn.createStatement();
			stmt.executeUpdate(insertStr);
			conn.commit();
			conn.close();
                	out.println("<H1><LEFT>User Created</LEFT></H1>");
			out.println("Creation successful.");
			response.setHeader("Refresh", "3;url=menu.jsp");
		} catch(Exception e) {
			out.println("<hr> ERROR: " + e.getMessage() + "<hr>");
		}
		

	} else if (request.getParameter("create").equals(request.getParameter("person"))) {
		Statement stmt = null;
        	ResultSet rset = null;
		String firstName = request.getParameter("FIRSTNAME");
		String lastName = request.getParameter("LASTNAME");
		String address = request.getParameter("ADDRESS");
		String email = request.getParameter("EMAIL");
		String phone = request.getParameter("PHONE");
		int personID;

		String sqlStatement = "select MAX(person_id) from persons";
		String insertStr;

		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sqlStatement);
			rset.next();
			personID = (rset.getInt(1));
			personID++;
			insertStr = "INSERT INTO persons VALUES("+personID+", '"+firstName+"', '"+lastName+"', '"+address+"', '"+email+"', '"+phone+"')";
			stmt.executeUpdate(insertStr);
			conn.commit();
			conn.close();
                	out.println("<H1><LEFT>Person Creation</LEFT></H1>");
			out.println("Creation Successful.");
			response.setHeader("Refresh", "3;url=menu.jsp");
		} catch(Exception e) {
			out.println("<hr>" + e.getMessage() + "<hr>");
		}

	} else if (request.getParameter("create").equals(request.getParameter("famdoc"))) {
		Statement stmt = null;
		String personID = request.getParameter("PATID");
		String docID = request.getParameter("DOCID");


		String insertStr = "INSERT INTO family_doctor VALUES("+docID+", "+personID+")";

		try {
			stmt = conn.createStatement();
			stmt.executeUpdate(insertStr);
			conn.commit();
			conn.close();
                	out.println("<H1><LEFT>Family Doctor Creation</LEFT></H1>");
			out.println("Creation Successful.");
			response.setHeader("Refresh", "3;url=menu.jsp");
		} catch(Exception e) {
			out.println("<hr>" + e.getMessage() + "<hr>");
		}
	}

}


else {
	out.println("<H1><LEFT><font color=ff0000>ACCESS DENIED</font></LEFT></H1>");
	response.setHeader("Refresh", "3;url=menu.jsp");
}

%>

</BODY>
</HTML>
