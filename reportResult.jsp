<!-- Display screen for the report generation module. Gets the parameters from report.jsp to be analyzed and used to create a sql statement. statement is queried through the db and is displayed for the user to view -->
<html>
<title>Report Regeneration</title>
<body>
	<H1>Report Regeneration</H1>


	Results for patients with
	<%@ page import="java.sql.*, db.Database"%>
	<%
		//obtains the search parameters from report.jsp
		String iDiag = request.getParameter("DiagnosisInput");
		String iDate1 = request.getParameter("DateInput1");
		String iDate2 = request.getParameter("DateInput2");

		//error checks to make sure all parameters have a value
		if (iDiag == "" || iDate1 == "" || iDate2 == "") {
			String error = "<p><b><font color=ff0000>You have not entered in all required parameters!</font></b></p>";
			session.setAttribute("error", error);
			response.sendRedirect("report.jsp");
		}
		//connect to db
		Database db = new Database();
		db.connect();
		Connection conn = db.getConnection();

		Statement stmt = null;
		ResultSet rset = null;

		//sql statement to obtain the patient and radiology record info
		String sql = "select p.last_name, p.first_name, p.address, p.phone, r.test_date from persons p, radiology_record r where p.person_id = r.patient_id AND ('"
				+ iDiag
				+ "') = r.diagnosis AND r.test_date between to_date('"
				+ iDate1
				+ "', 'DD/MM/YYYY') AND to_date('"
				+ iDate2
				+ "', 'DD/MM/YYYY') ORDER BY p.last_name";

		//execute the sql statement 
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
		} catch (Exception e) {
			out.println("<hr>" + e.getMessage() + "<hr>");
		}

		out.print(iDiag);
	%>
	from
	<%
		out.print(iDate1);
	%>
	to
	<%
		out.print(iDate2);
	%>
	:

	<!-- create a HTML table for the results -->
	<table border="1">
		<tr>
			<th>Last Name</th>
			<th>First Name</th>
			<th>Address</th>
			<th>Phone Number</th>
			<th>Testing Date</th>
		</tr>

		<%
			//while there are still rows to be printed, print them in their cooresponding columns 
			while (rset != null && rset.next()) {
				String lName = (rset.getString(1));
				String fName = (rset.getString(2));
				String address = (rset.getString(3));
				String phone = (rset.getString(4));
				String tDate = (rset.getString(5));
				out.println("<tr> <td>" + lName + "</td> <td>" + fName
						+ "</td> <td>" + address + "</td> <td>" + phone
						+ "</td> <td>" + tDate + "</td> </tr>");

			}

			db.close(conn, stmt, null, rset);
		%>
	</table>
</body>
</html>