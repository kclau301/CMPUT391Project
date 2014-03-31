<!-- Display screen for the data analysis module. Gets the parameters from analysisStart.jsp to be analyzed and used to create a sql statement. statement is queried through the db and is displayed for the user to view -->

<HTML>
<HEAD>
<TITLE>Analysis Results</TITLE>
</HEAD>

<BODY>
	<H1>Data Analysis</H1>
	<%@ page import="java.sql.*, db.Database"%>
	<%
		//get checkbox options from analysisStart.jsp
		String dType1 = request.getParameter("displayType");
		String dType2 = request.getParameter("displayType2");
		String dType3 = request.getParameter("displayType3");

		//if the checkbox is not checked - change value to "0"
		if (dType1 == null) {
			dType1 = "0";
		}
		if (dType2 == null) {
			dType2 = "0";
		}
		if (dType3 == null) {
			dType3 = "0";
		}

		//error checking: if none of the checkboxes are checked, print an error msg
		if (dType1.equals("0") && dType2.equals("0") && dType3.equals("0")) {
			String error = "<p><b><font color=ff0000>You have not entered in any display options!</font></b></p>";
			session.setAttribute("error", error);
			response.sendRedirect("analysisStart.jsp");
			return;
		}

		//if time period is checked, then create sql statements for the different periods
		String timePeriod = "";
		if (dType3.equals("1")) {
			if (request.getParameter("TIMETYPE") != null) {
				if (request.getParameter("TIMETYPE").equals("week")) {
					timePeriod = "IW";
				} else if (request.getParameter("TIMETYPE").equals("month")) {
					timePeriod = "MM";
				} else if (request.getParameter("TIMETYPE").equals("year")) {
					timePeriod = "Y";
				}
			}
			//if time period is checked but no period specification is selected, display an error msg
			else {
				String error = "<p><b><font color=ff0000>You have not entered any time period specifications!</font></b></p>";
				session.setAttribute("error", error);
				response.sendRedirect("analysisStart.jsp");
			}
		}

		String sql = "";
		String select = "select "; //"select x" in sql statement
		String group = "group by CUBE("; //"group by CUBE(x)" in sql statement
		String table = ""; // creates the table to make in the HTML
		int count = 1; // number of check boxes checked 

		//Patient ID is checked
		if (dType1.equals("1")) {
			if (count > 1) { //there is already another option, add a "," to the sql statement
				select = select + ", ";
				group = group + ", ";
			}
			select = select + "p.person_id";
			group = group + "p.person_id";
			table = "<th>Patient ID</th> ";
			count++;
		}

		//test type is checked
		if (dType2.equals("1")) {
			if (count > 1) {
				select = select + ", ";
				group = group + ", ";
			}
			select = select + "r.test_type";
			group = group + "r.test_type";
			table = table + "<th>Test Type</th> ";
			count++;
		}

		//test date is checked
		if (dType3.equals("1")) {
			if (count > 1) {
				select = select + ", ";
				group = group + ", ";
			}
			select = select + "trunc(r.test_date, '" + timePeriod
					+ "') as test_date";
			group = group + "test_date";
			table = table + "<th>Test Date</th>";
			count++;
		}

		//merge all the sql statements that are needed
		sql = select
				+ ", count(i.record_id) as image_count from persons p, radiology_record r, pacs_images i where p.person_id = r.patient_id AND r.record_id = i.record_id "
				+ group + ")";
		String sql2 = "select p.person_id, r.test_type, trunc(r.test_date, 'IW') as test_date, count(i.record_id) as image_count from persons p, radiology_record r, pacs_images i where p.person_id = r.patient_id AND r.record_id = i.record_id group by CUBE(p.person_id, r.test_type, test_date)";
		//make the HTML table headers
		table = table + "<th> Number of Images </th>";
	%>

	<table border="1">
		<tr>
			<%
				out.println(table); //create the HTML table
			%>
		</tr>
		<%
			//connect to db
			Database db = null;
			Connection conn = null;
			Statement stmt = null;
			ResultSet rset = null;

			try {
				db = new Database();
				db.connect();
				conn = db.getConnection();
				stmt = conn.createStatement();
				rset = stmt.executeQuery(sql);

				//prints out each row of data
				while (rset != null && rset.next()) {
					out.println("<tr>");
					//for every checkbox selected, print out that many columns
					for (int temp = 1; temp <= count; temp++) {
						String x = (rset.getString(temp));
						out.println("<td>" + x + "</td>");
					}
					out.println("</tr>");
				}
			}
			// close the db
			finally {
				db.close(conn, stmt, null, rset);
			}
		%>

	</table>
</BODY>
</HTML>
