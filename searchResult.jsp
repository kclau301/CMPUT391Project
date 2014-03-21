
<%
	String SQLOrder = "";
	if (request.getParameter("SEARCHTYPE") != null) {
		if (request.getParameter("SEARCHTYPE").equals("recentFirst")) {
			SQLOrder = "r.test_date DESC";
		} else if (request.getParameter("SEARCHTYPE").equals(
				"recentLast")) {
			SQLOrder = "r.test_date ASC";
		} else if (request.getParameter("SEARCHTYPE")
				.equals("relevant")) {
			//SQLOrder = ...
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
		Database db = new Database();
		db.connect();
		Connection conn = db.getConnection();

		Statement stmt = null;
		ResultSet rset = null;

		String kWord = request.getParameter("searchKeyword");
		String kTime1 = request.getParameter("searchTime1");
		String kTime2 = request.getParameter("searchTime2");

		String sql = "";

		String checkClass = (String) session.getAttribute("class");
		String userID = (String) session.getAttribute("person_id");

		out.println("<H1>Search</H1>");

		/*TODO: need to add into SQL how to get images of record*/

		//both entered
		if (kWord != "" && kTime1 != "" && kTime2 != "") {
			out.println("Records for keyword(s): " + kWord
					+ " between dates " + kTime1 + " and " + kTime2);
			if (checkClass.equals("a")) {
				String[] wordList = kWord.split(" ");
				sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where test_date between to_date('"
						+ kTime1
						+ "', 'DD/MM/YYYY') AND to_date('"
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
				sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where test_date between to_date('"
						+ kTime1
						+ "', 'DD/MM/YYYY') AND to_date('"
						+ kTime2 + "', 'DD/MM/YYYY') AND ";

				for (int i = 0; i < wordList.length; i++) {
					sql = sql + "'" + userID
							+ "' = patient_id AND r.DIAGNOSIS ='"
							+ wordList[i] + "' or p.LAST_NAME = '"
							+ wordList[i] + "' or p.first_name = '"
							+ wordList[i] + "'or r.DESCRIPTION like '%"
							+ wordList[i] + "%'";
					if (i != wordList.length - 1)
						sql = sql + "OR ";
				}
				sql = sql + "ORDER BY '" + SQLOrder + "'";
			}

			else if (checkClass.equals("d")) {
				String[] wordList = kWord.split(" ");
				sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where test_date between to_date('"
						+ kTime1
						+ "', 'DD/MM/YYYY') AND to_date('"
						+ kTime2 + "', 'DD/MM/YYYY') AND ";

				for (int i = 0; i < wordList.length; i++) {
					sql = sql + "'" + userID
							+ "' = doctor_id AND r.DIAGNOSIS ='"
							+ wordList[i] + "' or p.LAST_NAME = '"
							+ wordList[i] + "' or p.first_name = '"
							+ wordList[i] + "'or r.DESCRIPTION like '%"
							+ wordList[i] + "%'";
					if (i != wordList.length - 1)
						sql = sql + "OR ";
				}
				sql = sql + "ORDER BY '" + SQLOrder + "'";
			}

			else if (checkClass.equals("r")) {
				String[] wordList = kWord.split(" ");
				sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where test_date between to_date('"
						+ kTime1
						+ "', 'DD/MM/YYYY') AND to_date('"
						+ kTime2 + "', 'DD/MM/YYYY') AND ";

				for (int i = 0; i < wordList.length; i++) {
					sql = sql + "'" + userID
							+ "' = radiologist_id AND r.DIAGNOSIS ='"
							+ wordList[i] + "' or p.LAST_NAME = '"
							+ wordList[i] + "' or p.first_name = '"
							+ wordList[i] + "'or r.DESCRIPTION like '%"
							+ wordList[i] + "%'";
					if (i != wordList.length - 1)
						sql = sql + "OR ";
				}
				sql = sql + "ORDER BY '" + SQLOrder + "'";
			}

		}

		//no keyword entered
		else if (kWord.equals("") && !kTime1.equals("")
				&& !kTime2.equals("")) {
			out.println("Records of time period between " + kTime1
					+ " and " + kTime2);
			if (checkClass.equals("a")) {
				sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where test_date between to_date('"
						+ kTime1
						+ "', 'DD/MM/YYYY') AND to_date('"
						+ kTime2
						+ "', 'DD/MM/YYYY') ORDER BY '"
						+ SQLOrder
						+ "'";
			}

			else if (checkClass.equals("p")) {
				sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where '"
						+ userID
						+ "' = patient_id AND test_date between to_date('"
						+ kTime1
						+ "', 'DD/MM/YYYY') AND to_date('"
						+ kTime2
						+ "', 'DD/MM/YYYY') ORDER BY '"
						+ SQLOrder
						+ "'";
			}

			else if (checkClass.equals("d")) {
				sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where '"
						+ userID
						+ "' = doctor_id AND test_date between to_date('"
						+ kTime1
						+ "', 'DD/MM/YYYY') AND to_date('"
						+ kTime2
						+ "', 'DD/MM/YYYY') ORDER BY '"
						+ SQLOrder
						+ "'";
			}

			else if (checkClass.equals("r")) {
				sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where '"
						+ userID
						+ "' = radiologist_id AND test_date between to_date('"
						+ kTime1
						+ "', 'DD/MM/YYYY') AND to_date('"
						+ kTime2
						+ "', 'DD/MM/YYYY') ORDER BY '"
						+ SQLOrder
						+ "'";
			}
		}

		//no time period entered
		else if (kWord != "" && kTime1 == "" || kTime2 == "") {
			out.println("Records matching keyword(s): " + kWord);

			if (checkClass.equals("a")) {
				String[] wordList = kWord.split(" ");
				sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where ";

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
				sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where ";

				for (int i = 0; i < wordList.length; i++) {
					sql = sql + "'" + userID
							+ "' = patient_id AND r.DIAGNOSIS ='"
							+ wordList[i] + "' or p.LAST_NAME = '"
							+ wordList[i] + "' or p.first_name = '"
							+ wordList[i] + "'or r.DESCRIPTION like '%"
							+ wordList[i] + "%'";
					if (i != wordList.length - 1)
						sql = sql + "OR ";
				}
				sql = sql + "ORDER BY '" + SQLOrder + "'";
			}

			else if (checkClass.equals("d")) {
				String[] wordList = kWord.split(" ");
				sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where ";

				for (int i = 0; i < wordList.length; i++) {
					sql = sql + "'" + userID
							+ "' = doctor_id AND r.DIAGNOSIS ='"
							+ wordList[i] + "' or p.LAST_NAME = '"
							+ wordList[i] + "' or p.first_name = '"
							+ wordList[i] + "'or r.DESCRIPTION like '%"
							+ wordList[i] + "%'";
					if (i != wordList.length - 1)
						sql = sql + "OR ";
				}
				sql = sql + "ORDER BY '" + SQLOrder + "'";
			}

			else if (checkClass.equals("r")) {
				String[] wordList = kWord.split(" ");
				sql = "select r.*, p.first_name, p.last_name from radiology_record r FULL JOIN persons p ON r.patient_id = p.person_id where ";

				for (int i = 0; i < wordList.length; i++) {
					sql = sql + "'" + userID
							+ "' = radiologist_id AND r.DIAGNOSIS ='"
							+ wordList[i] + "' or p.LAST_NAME = '"
							+ wordList[i] + "' or p.first_name = '"
							+ wordList[i] + "'or r.DESCRIPTION like '%"
							+ wordList[i] + "%'";
					if (i != wordList.length - 1)
						sql = sql + "OR ";
				}
				sql = sql + "ORDER BY '" + SQLOrder + "'";
			}
		}

		//neither entered 
		else {
			String error = "<p><b><font color=ff0000>You have not entered any search specifications!</font></b></p>";
			session.setAttribute("error", error);
			response.sendRedirect("searchStart.jsp");
		}
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
		} catch (Exception e) {
			out.println("<hr>" + e.getMessage() + "<hr>");
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

				out.println("<tr> <td>" + lName + "</td> <td>" + fName
						+ "</td> <td>" + recordID + "</td> <td>" + patientID
						+ "</td> <td>" + doctorID + "</td> <td>" + radiologist
						+ "</td> <td>" + testType + "</td> <td>" + pDate
						+ "</td> <td>" + tDate + "</td><td>" + diag
						+ "</td><td>" + description + "</td></tr>");

			}

			db.close(conn, stmt, null, rset);
		%>
	</table>
</BODY>
</HTML>