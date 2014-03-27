<HTML>
<HEAD>
<TITLE>Analysis Results</TITLE>
</HEAD>

<BODY>
	<H1>Data Analysis</H1>
	<%@ page import="java.sql.*, db.Database"%>
	<%

	String dType1 = request.getParameter("displayType");
	String dType2 = request.getParameter("displayType2");
	String dType3 = request.getParameter("displayType3");

	if (dType1 == null) {
		dType1 = "0";
	}
	if (dType2 == null) {
		dType2 = "0";
	}
	if (dType3 == null) {
		dType3 = "0";
	}

	if (dType1.equals("0") && dType2.equals("0") && dType3.equals("0")) {
		String error = "<p><b><font color=ff0000>You have not entered in any display options!</font></b></p>";
		session.setAttribute("error", error);
		response.sendRedirect("analysisStart.jsp");
		return;
	}

	String timePeriod = "";	
	if (dType3.equals("1")) {
		if (request.getParameter("TIMETYPE") != null) {
			if (request.getParameter("TIMETYPE").equals("Week")) {
				timePeriod = "IW";
			} else if (request.getParameter("TIMETYPE").equals("Month")) {
				timePeriod = "MM";
			} else if (request.getParameter("TIMETYPE").equals("Year")) {
				timePeriod = "Y";
			}
		} 
		else {
			String error = "<p><b><font color=ff0000>You have not entered any time period specifications!</font></b></p>";
			session.setAttribute("error", error);
			response.sendRedirect("analysisStart.jsp");
		}
	}

	String sql = "";
	String select = "select ";
	String group = "group by CUBE(";
	String table = "";
	int count = 1;

	if(dType1.equals("1")) {
		if(count > 1) {
			select = select + ", p.person_id";
			group = group + ", p.person_id";
		}
		else {
			select = select + "p.person_id";
			group = group + "p.person_id";
		}
		table = "<th>Patient ID</th> ";
		count++;
	}	

	if(dType2.equals("1")) {
		if(count > 1) {
			select = select + ", r.test_type";
			group = group + ", r.test_type";
		}
		else {
			select = select + "r.test_type";
			group = group + "r.test_type";
		}
		table = table + "<th>Test Type</th> ";
		count ++;
	}

	if(dType3.equals("1")){
		if(count > 1) {
			select = select + ", trunc(r.test_date, '" + timePeriod + "') as test_date";
			group = group + ", test_date";
		}
		else {
			select = select + "trunc(r.test_date, '" + timePeriod + "') as test_date";
			group = group + "test_date";
		}
		table = table + "<th>Test Date</th>";
		count ++;
	}

	sql = select + ", count(i.record_id) as image_count from persons p, radiology_record r, pacs_images i where p.person_id = r.patient_id AND r.record_id = i.record_id " + group + ")"; 
	table = table + "<th> Number of Images";
	%>

	<table border="1">
		<tr>
		<%
			out.println(table);
		%>
		</tr>
		<%
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

			while (rset != null && rset.next()) {
				out.println("<tr>");
				for(int temp=1; temp<=count; temp++){
					String x = (rset.getString(temp));
					out.println("<td>" + x + "</td>");
				}
				out.println("</tr>");
			}
			}	

			finally {
				db.close(conn, stmt, null, rset);
			}
		%>

	</table>
</BODY>
</HTML>
