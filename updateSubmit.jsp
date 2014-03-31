<HTML>
<HEAD>


<TITLE>Create Submission</TITLE>
</HEAD>

<BODY>

	<%@ page import="java.sql.*, db.Database"%>
	<%
		Database db = new Database();
		db.connect();
		Connection conn = db.getConnection();

		String checkClass = (String) session.getAttribute("class");

		if (checkClass.equals("a")) {
			if (request.getParameter("update").equals(
					request.getParameter("user"))) {
				Statement stmt = null;

				String username = request.getParameter("USERNAME");
				String password = request.getParameter("PASSWORD");
				String personID = request.getParameter("PERSONID");

				String updateStr = "UPDATE users SET password='" + password
						+ "', person_id='" + personID 
						+ "' WHERE user_name='" + username + "'";

				try {
					stmt = conn.createStatement();
					stmt.executeUpdate(updateStr);
					conn.commit();
					conn.close();
					out.println("<H1><LEFT>User Updated</LEFT></H1>");
					out.println("Update successful.");
					response.setHeader("Refresh", "3;url=menu.jsp");
				} catch (Exception e) {
					out.println("<hr> ERROR: " + e.getMessage() + "<hr>");
				}

			} else if (request.getParameter("update").equals(
					request.getParameter("person"))) {
				Statement stmt = null;

				String firstName = request.getParameter("FIRSTNAME");
				String lastName = request.getParameter("LASTNAME");
				String address = request.getParameter("ADDRESS");
				String email = request.getParameter("EMAIL");
				String phone = request.getParameter("PHONE");
				String personID = request.getParameter("PERSONID");

				String updateStr = "UPDATE persons SET first_name='"
						+ firstName + "', last_name='" + lastName
						+ "', address='" + address + "', email='" + email
						+ "', phone='" + phone + "' WHERE person_id='"
						+ personID + "'";

				try {
					stmt = conn.createStatement();

					stmt.executeUpdate(updateStr);
					conn.commit();
					conn.close();
					out.println("<H1><LEFT>Person Updated</LEFT></H1>");
					out.println("Update Successful.");
					response.setHeader("Refresh", "3;url=menu.jsp");
				} catch (Exception e) {
					out.println("<hr>" + e.getMessage() + "<hr>");
				}

			} else if (request.getParameter("update").equals(
					request.getParameter("famdoc"))) {
				Statement stmt = null;
				String personID = request.getParameter("PATID");
				String docID = request.getParameter("DOCID");

				String updateStr = "UPDATE family_doctor SET doctor_id="
						+ docID + " WHERE patient_id=" + personID;

				try {
					stmt = conn.createStatement();
					stmt.executeUpdate(updateStr);
					conn.commit();
					conn.close();
					out.println("<H1><LEFT>Family Doctor Updated</LEFT></H1>");
					out.println("Updated Successful.");
					response.setHeader("Refresh", "3;url=menu.jsp");
				} catch (Exception e) {
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
