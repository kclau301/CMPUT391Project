<!-- Display screen for the search module. Gets the parameters from searchStart.jsp to be analyzed and used to create a sql statement. statement is queried through the db and is displayed for the user to view -->
<%
	//retrieves the text field paramters from searchStart.jsp
	String kWord = request.getParameter("searchKeyword");
	String kTime1 = request.getParameter("searchTime1");
	String kTime2 = request.getParameter("searchTime2");

	//error checks to make sure required text fields have values
	if (kWord == "" && kTime1 == "" || kWord == "" && kTime2 == "") {
		String error = "<p><b><font color=ff0000>You have not entered in all required search parameters!</font></b></p>";
		session.setAttribute("error", error);
		response.sendRedirect("searchStart.jsp");
		return;
	}

	//depending on which order radio button is selected, create a relevant sql string for it
	String SQLOrder = "";
	if (request.getParameter("SEARCHTYPE") != null) {
		if (request.getParameter("SEARCHTYPE").equals("recentFirst")) {
			SQLOrder = "r.test_date DESC";
		} else if (request.getParameter("SEARCHTYPE").equals(
				"recentLast")) {
			SQLOrder = "r.test_date ASC";
		} else if (request.getParameter("SEARCHTYPE")
				.equals("relevant")) {
			SQLOrder = "rank desc";
		}
		//if there is no order option selected, display an error
	} else {			
		String error = "<p><b><font color=ff0000>You have not entered any search order specifications!</font></b></p>";
		session.setAttribute("error", error);
		response.sendRedirect("searchStart.jsp");
	}
%>

<HTML>
<HEAD>
<TITLE>Search Results</TITLE>
</HEAD>

<BODY>
	<%@ page import="java.sql.*,db.Database"%>
	<%
		//obtain the class and the ID of the current logged in user
		String checkClass = (String) session.getAttribute("class");
		String userID = (String) session.getAttribute("person_id");
		out.println("<H1>Search</H1>");

		String sql = "select r.*, p.first_name, p.last_name ";

		//depending on the class create a different sql statement
		String class_id = "";
		if (checkClass.equals("a")) {
			class_id = "";
		} else if (checkClass.equals("p")) {
			class_id = "r.patient_id = '" + userID + "' AND ";
		} else if (checkClass.equals("d")) {
			class_id = "r.doctor_id = '" + userID + "' AND ";
		} else if (checkClass.equals("r")) {
			class_id = "r.radiologist_id = '" + userID + "' AND ";
		}

		//both keyword and date are entered
		if (kWord != "" && kTime1 != "" && kTime2 != "") {
			sql = sql + ", ";
			String[] wordList = kWord.split(" ");			//split the keyword value by space into an array for multiple keywords
			int matchNum = 0;
			for (int i = 0; i < wordList.length; i++) {		//for every keyword create a sql statement for it
				sql = sql + "6*score(" + Integer.toString(matchNum + 1)
						+ ")+6*score(" + Integer.toString(matchNum + 2)
						+ ")+3*score(" + Integer.toString(matchNum + 3)
						+ ")+score(" + Integer.toString(matchNum + 4)
						+ ") ";
				//if there are still more keywords, keep going (adds "+")
				if (i != wordList.length - 1)
					sql = sql + "+ ";
				matchNum = matchNum + 4;
			}
			sql = sql + "as rank ";

			sql = sql
					+ "from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where ";

			out.println("Records for keyword(s): " + kWord
					+ " between dates " + kTime1 + " and " + kTime2);

			//sql statement to search for a certain time period
			sql = sql + "r.test_date between to_date('" + kTime1
					+ "', 'DD/MM/YYYY') AND to_date('" + kTime2
					+ "', 'DD/MM/YYYY') AND ";

			//creates sql statement for every key word to match with the score function 
			int countNum = 0;
			for (int i = 0; i < wordList.length; i++) {
				sql = sql + class_id + "contains(r.diagnosis, '"
						+ wordList[i] + "', "
						+ Integer.toString(countNum + 3)
						+ ") > 0 OR contains(r.description, '"
						+ wordList[i] + "', "
						+ Integer.toString(countNum + 4)
						+ ") > 0 OR contains(p.first_name, '" + wordList[i]
						+ "', " + Integer.toString(countNum + 1)
						+ ") > 0 OR contains(p.last_name, '" + wordList[i]
						+ "', " + Integer.toString(countNum + 2) + ") > 0 ";
				if (i != wordList.length - 1)
					sql = sql + "OR ";
				countNum = countNum + 4;
			}
			sql = sql + "ORDER BY " + SQLOrder;				//order by the order sql string made above
		}

		//no keyword entered
		else if (kWord.equals("") && !kTime1.equals("")
				&& !kTime2.equals("")) {
			out.println("Records of time period between " + kTime1
					+ " and " + kTime2);

			sql = sql
					+ "from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where ";

			sql = sql + class_id + "r.test_date between to_date('" + kTime1
					+ "', 'DD/MM/YYYY') AND to_date('" + kTime2
					+ "', 'DD/MM/YYYY') ORDER BY " + SQLOrder;
		}

		//no time period entered
		else if (!kWord.equals("") && kTime1.equals("")
				|| kTime2.equals("")) {
			out.println("Records matching keyword(s): " + kWord);
			sql = sql + ", ";
			String[] wordList = kWord.split(" ");
			int matchNum = 0;
			for (int i = 0; i < wordList.length; i++) {
				sql = sql + "6*score(" + Integer.toString(matchNum + 1)
						+ ")+6*score(" + Integer.toString(matchNum + 2)
						+ ")+3*score(" + Integer.toString(matchNum + 3)
						+ ")+score(" + Integer.toString(matchNum + 4)
						+ ") ";

				if (i != wordList.length - 1)
					sql = sql + "+ ";
				matchNum = matchNum + 4;
			}
			sql = sql + "as rank ";

			sql = sql
					+ "from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where ";

			int countNum = 0;
			for (int i = 0; i < wordList.length; i++) {
				sql = sql + class_id + "contains(r.diagnosis, '"
						+ wordList[i] + "', "
						+ Integer.toString(countNum + 3)
						+ ") > 0 OR contains(r.description, '"
						+ wordList[i] + "', "
						+ Integer.toString(countNum + 4)
						+ ") > 0 OR contains(p.first_name, '" + wordList[i]
						+ "', " + Integer.toString(countNum + 1)
						+ ") > 0 OR contains(p.last_name, '" + wordList[i]
						+ "', " + Integer.toString(countNum + 2) + ") > 0 ";
				if (i != wordList.length - 1)
					sql = sql + "OR ";
				countNum = countNum + 4;
			}
			sql = sql + "ORDER BY " + SQLOrder;
		}

		//neither entered: print out error msg
		else {
			String error = "<p><b><font color=ff0000>You have not entered any search specifications!</font></b></p>";
			session.setAttribute("error", error);
			response.sendRedirect("searchStart.jsp");
		}
	%>
	<!-- make a table for the required display columns -->
	<table border="1">
		<tr>
			<th>Last Name</th>
			<th>First Name</th>
			<th>Record ID</th>
			<th>Patient ID</th>
			<th>Doctor ID</th>
			<th>Radiologist ID</th>
			<th>Test Type</th>
			<th>Prescribing Date</th>
			<th>Test Date</th>
			<th>Diagnosis</th>
			<th>Description</th>
			<th>Images</th>
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
				String curr_id = null;

				//while there are rows to print, print them into the related column
				while (rset != null && rset.next()) {
					String recordID = (rset.getString(1));
					String patientID = (rset.getString(2));
					String doctorID = (rset.getString(3));
					String radiologist = (rset.getString(4));
					String testType = (rset.getString(5));
					String pDate = (rset.getString(6));
					String tDate = (rset.getString(7));
					String diag = (rset.getString(8));
					String description = (rset.getString(9));
					String fName = (rset.getString(10));
					String lName = (rset.getString(11));

					out.println("<tr>");
					out.println("<td>" + lName + "</td>");
					out.println("<td>" + fName + "</td>");
					out.println("<td>" + recordID + "</td>");
					out.println("<td>" + patientID + "</td>");
					out.println("<td>" + doctorID + "</td>");
					out.println("<td>" + radiologist + "</td>");
					out.println("<td>" + testType + "</td>");
					out.println("<td>" + pDate + "</td>");
					out.println("<td>" + tDate + "</td>");
					out.println("<td>" + diag + "</td>");
					out.println("<td>" + description + "</td>");

					// Get the thumbnail images
					try {
						String sql_images = "select image_id from pacs_images where record_id = "
								+ recordID;
						Statement stmt_images = conn.createStatement();
						ResultSet rset_images = stmt_images
								.executeQuery(sql_images);
						String image_id = "";

						out.println("<td>");
						while (rset_images != null && rset_images.next()) {
							image_id = (rset_images.getObject(1)).toString();

							// specify the servlet when thumbnail is clicked
							out.println("<a href=\"/CMPUT391/viewImage.jsp?regular"
									+ image_id + "\" target=" + "_blank" + ">");
							// display the thumbnail
							out.println("<img src=\"/CMPUT391/GetOnePic?thumbnail"
									+ image_id + "\"></a>");
						}
						out.println("</td>");

						rset_images.close();
						stmt_images.close();
					} catch (Exception e) {
						out.println(e.getMessage());
					}

					out.println("</tr>");
				}
			} catch (Exception e) {
				out.println("<hr>" + e.getMessage() + "<hr>");
			} finally {
				db.close(conn, stmt, null, rset);
			}
		%>
	</table>
</BODY>
</HTML>