
<%
	String SQLOrder = "";
	if (request.getParameter("SEARCHTYPE") != null) {
		if (request.getParameter("SEARCHTYPE").equals("recentFirst")) {
			SQLOrder = "r.test_date DESC";
		} else if (request.getParameter("SEARCHTYPE").equals(
				"recentLast")) {
			SQLOrder = "r.test_date ASC";
		} else if (request.getParameter("SEARCHTYPE").equals("relevant")) {
			SQLOrder = "rank" ;
			//SQL order by  Rank(record_id) = 6*frequency(patient_name) + 3*frequency(diagnosis) + frequency(description)
		}
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
	<%@ page import="java.sql.*, db.Database"%>
	<%
		String kWord = request.getParameter("searchKeyword");
		String kTime1 = request.getParameter("searchTime1");
		String kTime2 = request.getParameter("searchTime2");

		String checkClass = (String) session.getAttribute("class");
		String userID = (String) session.getAttribute("person_id");
		out.println("<H1>Search</H1>");

		/*TODO: need to add into SQL how to get images of record*/
		String sql = "select r.*, p.first_name, p.last_name ";
		// Test sql for images:
		// String sql = "select r.*, p.first_name, p.last_name, pi.image_id from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id FULL JOIN pacs_images pi ON pi.record_id = r.record_id where ";

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

		//both entered
		if (kWord != "" && kTime1 != "" && kTime2 != "") {
		sql = sql + ", ";
		String[] wordList = kWord.split(" ");
		int count_score = 0;
		for (int i = 0; i < wordList.length; i++) {
			sql = sql + "6*score("+ Integer.toString(count_score+3) +")+6*score("+ Integer.toString(count_score+4) +")+3*score("+ Integer.toString(count_score+1) +")+score("+ Integer.toString(count_score+2)+") ";
							
			if (i != wordList.length - 1)
				sql = sql + "+ ";
		}
		sql = sql + "as rank ";

		sql = sql + "from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where ";

			out.println("Records for keyword(s): " + kWord
					+ " between dates " + kTime1 + " and " + kTime2);
			//String[] wordList = kWord.split(" ");

			sql = sql + "r.test_date between to_date('" + kTime1
					+ "', 'DD/MM/YYYY') AND to_date('" + kTime2
					+ "', 'DD/MM/YYYY') AND ";

			int count_contains = 0;
			for (int i = 0; i < wordList.length; i++) {
				sql = sql + class_id + "r.DIAGNOSIS ='" + wordList[i]
						+ "' or p.LAST_NAME = '" + wordList[i]
						+ "' or p.first_name = '" + wordList[i]
						+ "'or r.DESCRIPTION like '%" + wordList[i] + "%'";
				if (i != wordList.length - 1)
					sql = sql + "OR ";
				count_contains += 4;
			}
			sql = sql + "ORDER BY " + SQLOrder;

			/*
			if (checkClass.equals("a")) {
			String[] wordList = kWord.split(" ");
			sql = sql + "test_date between to_date('"
			//"select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where test_date between to_date('"
			+ kTime1 + "', 'DD/MM/YYYY') AND to_date('"
			+ kTime2 + "', 'DD/MM/YYYY') AND ";

			for (int i = 0; i < wordList.length; i++) {
			sql = sql + "r.DIAGNOSIS ='" + wordList[i]
			+ "' or p.LAST_NAME = '" + wordList[i]
			+ "' or p.first_name = '" + wordList[i]
			+ "'or r.DESCRIPTION like '%" + wordList[i]
			+ "%'";
			if (i != wordList.length - 1)
			sql = sql + "OR ";
			}
			sql = sql + "ORDER BY '" + SQLOrder + "'";
			}

			else if (checkClass.equals("p")) {
			String[] wordList = kWord.split(" ");
			sql = sql + "test_date between to_date('"
			//"select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where test_date between to_date('"
			+ kTime1 + "', 'DD/MM/YYYY') AND to_date('"
			+ kTime2 + "', 'DD/MM/YYYY') AND ";

			for (int i = 0; i < wordList.length; i++) {
			sql = sql + "r.patient_id = '" + userID
			+ "' AND r.DIAGNOSIS ='" + wordList[i]
			+ "' or p.LAST_NAME = '" + wordList[i]
			+ "' or p.first_name = '" + wordList[i]
			+ "'or r.DESCRIPTION like '%" + wordList[i]
			+ "%'";
			if (i != wordList.length - 1)
			sql = sql + "OR ";
			}
			sql = sql + "ORDER BY '" + SQLOrder + "'";
			}

			else if (checkClass.equals("d")) {
			String[] wordList = kWord.split(" ");
			sql = sql + "test_date between to_date('"
			//"select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where test_date between to_date('"
			+ kTime1 + "', 'DD/MM/YYYY') AND to_date('"
			+ kTime2 + "', 'DD/MM/YYYY') AND ";

			for (int i = 0; i < wordList.length; i++) {
			sql = sql + "r.doctor_id = '" + userID
			+ "' AND r.DIAGNOSIS ='" + wordList[i]
			+ "' or p.LAST_NAME = '" + wordList[i]
			+ "' or p.first_name = '" + wordList[i]
			+ "'or r.DESCRIPTION like '%" + wordList[i]
			+ "%'";
			if (i != wordList.length - 1)
			sql = sql + "OR ";
			}
			sql = sql + "ORDER BY '" + SQLOrder + "'";
			}

			else if (checkClass.equals("r")) {
			String[] wordList = kWord.split(" ");
			sql = sql + "test_date between to_date('"
			//"select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where test_date between to_date('"
			+ kTime1 + "', 'DD/MM/YYYY') AND to_date('"
			+ kTime2 + "', 'DD/MM/YYYY') AND ";

			for (int i = 0; i < wordList.length; i++) {
			sql = sql + "r.radiologist_id = '" + userID
			+ "' AND r.DIAGNOSIS ='" + wordList[i]
			+ "' or p.LAST_NAME = '" + wordList[i]
			+ "' or p.first_name = '" + wordList[i]
			+ "'or r.DESCRIPTION like '%" + wordList[i]
			+ "%'";
			if (i != wordList.length - 1)
			sql = sql + "OR ";
			}
			sql = sql + "ORDER BY '" + SQLOrder + "'";
			}
			 */

		}

		//no keyword entered
		else if (kWord.equals("") && !kTime1.equals("")
				&& !kTime2.equals("")) {
			out.println("Records of time period between " + kTime1
					+ " and " + kTime2);

			sql = sql + "from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where ";

			sql = sql + class_id + "r.test_date between to_date('" + kTime1
					+ "', 'DD/MM/YYYY') AND to_date('" + kTime2
					+ "', 'DD/MM/YYYY') ORDER BY " + SQLOrder;
			/*
			if (checkClass.equals("a")) {
			sql = sql
			//"select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where test_date between to_date('"
			+ kTime1 + "', 'DD/MM/YYYY') AND to_date('"
			+ kTime2 + "', 'DD/MM/YYYY') ORDER BY '" + SQLOrder
			+ "'";
			}

			else if (checkClass.equals("p")) {
			sql = sql
			//"select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where '"
			+ "r.patient_id = '" + userID
			+ "' AND test_date between to_date('" + kTime1
			+ "', 'DD/MM/YYYY') AND to_date('" + kTime2
			+ "', 'DD/MM/YYYY') ORDER BY '" + SQLOrder + "'";
			}

			else if (checkClass.equals("d")) {
			sql = sql
			//"select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where '"
			+ "r.doctor_id = '" + userID
			+ "'  AND test_date between to_date('" + kTime1
			+ "', 'DD/MM/YYYY') AND to_date('" + kTime2
			+ "', 'DD/MM/YYYY') ORDER BY '" + SQLOrder + "'";
			}

			else if (checkClass.equals("r")) {
			sql = sql
			//"select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where '"
			+ "r.radiologist_id = '" + userID
			+ "' AND test_date between to_date('" + kTime1
			+ "', 'DD/MM/YYYY') AND to_date('" + kTime2
			+ "', 'DD/MM/YYYY') ORDER BY '" + SQLOrder + "'";
			}
			 */
		}

		//no time period entered
		else if (!kWord.equals("") && kTime1.equals("")
				|| kTime2.equals("")) {
		out.println("Records matching keyword(s): " + kWord);
		sql = sql + ", ";
		String[] wordList = kWord.split(" ");
		int count_score = 0;
		for (int i = 0; i < wordList.length; i++) {
			sql = sql + "6*score("+ Integer.toString(count_score+3) +")+6*score("+ Integer.toString(count_score+4) +")+3*score("+ Integer.toString(count_score+1) +")+score("+ Integer.toString(count_score+2)+") ";
							
			if (i != wordList.length - 1)
				sql = sql + "+ ";
		}
		sql = sql + " as rank ";

		sql = sql + "from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where ";
			//String[] wordList = kWord.split(" ");
			int count_contains = 0;
			for (int i = 0; i < wordList.length; i++) {
				sql = sql + class_id + "contains(r.diagnosis, '" + wordList[i] + "', "+ Integer.toString(count_contains+1) +") > 0 OR contains(r.description, '" + wordList[i] + "', "+ Integer.toString(count_contains+2) +") > 0 OR contains(p.first_name, '" + wordList[i] + "', "+ Integer.toString(count_contains+3) +") > 0 OR contains(p.last_name, '" + wordList[i] + "', "+ Integer.toString(count_contains+4) +") > 0 ";
				if (i != wordList.length - 1)
					sql = sql + "OR ";
				count_contains += 4;
			}
			sql = sql + "ORDER BY " + SQLOrder;

			/*
			if (checkClass.equals("a")) {
			//String[] wordList = kWord.split(" ");
			//sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where ";

			for (int i = 0; i < wordList.length; i++) {
			sql = sql + "r.DIAGNOSIS ='" + wordList[i]
			+ "' or p.LAST_NAME = '" + wordList[i]
			+ "' or p.first_name = '" + wordList[i]
			+ "'or r.DESCRIPTION like '%" + wordList[i]
			+ "%'";
			if (i != wordList.length - 1)
			sql = sql + "OR ";
			}
			sql = sql + "ORDER BY '" + SQLOrder + "'";
			}

			else if (checkClass.equals("p")) {
			//String[] wordList = kWord.split(" ");
			//sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where ";

			for (int i = 0; i < wordList.length; i++) {
			sql = sql + "r.patient_id = '" + userID
			+ "' AND r.DIAGNOSIS ='" + wordList[i]
			+ "' or p.LAST_NAME = '" + wordList[i]
			+ "' or p.first_name = '" + wordList[i]
			+ "'or r.DESCRIPTION like '%" + wordList[i]
			+ "%'";
			if (i != wordList.length - 1)
			sql = sql + "OR ";
			}
			sql = sql + "ORDER BY '" + SQLOrder + "'";
			}

			else if (checkClass.equals("d")) {
			//String[] wordList = kWord.split(" ");
			//sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where ";

			for (int i = 0; i < wordList.length; i++) {
			sql = sql + "r.doctor_id = '" + userID
			+ "' AND r.DIAGNOSIS ='" + wordList[i]
			+ "' or p.LAST_NAME = '" + wordList[i]
			+ "' or p.first_name = '" + wordList[i]
			+ "'or r.DESCRIPTION like '%" + wordList[i]
			+ "%'";
			if (i != wordList.length - 1)
			sql = sql + "OR ";
			}
			sql = sql + "ORDER BY '" + SQLOrder + "'";
			}

			else if (checkClass.equals("r")) {
			//String[] wordList = kWord.split(" ");
			//sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where ";

			for (int i = 0; i < wordList.length; i++) {
			sql = sql + "r.radiologist_id = '" + userID
			+ "' AND r.DIAGNOSIS ='" + wordList[i]
			+ "' or p.LAST_NAME = '" + wordList[i]
			+ "' or p.first_name = '" + wordList[i]
			+ "'or r.DESCRIPTION like '%" + wordList[i]
			+ "%'";
			if (i != wordList.length - 1)
			sql = sql + "OR ";
			}
			sql = sql + "ORDER BY '" + SQLOrder + "'";
			}
			 */

		}

		//neither entered 
		else {
			String error = "<p><b><font color=ff0000>You have not entered any search specifications!</font></b></p>";
			session.setAttribute("error", error);
			response.sendRedirect("searchStart.jsp");
		}
	%>

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
							out.println("<a href=\"/CMPUT391/GetOnePic?regular"
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