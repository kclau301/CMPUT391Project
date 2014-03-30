<HTML>
<HEAD>


<TITLE>User Management Search Menu</TITLE>
</HEAD>

<BODY>

	<%@ page import="java.sql.*"%>
	<%
		String checkClass = (String) session.getAttribute("class");

		if (checkClass.equals("a")) {

			if (request.getParameter("SEARCHTYPE").equals("Users")) {
				out.println("<H1><LEFT>User Management Search Menu</LEFT></H1>");
				out.println("<form method=get action=updateEntry.jsp>");
				out.println("Username: <input type=text name=USERNAME maxlength=20><br>");
				out.println("<input type=submit name=SEARCH value=Search&nbsp;Users>");
				out.println("<input type=hidden name=user value=Search&nbsp;Users>");
				out.println("</form>");

			} else if (request.getParameter("SEARCHTYPE").equals("Persons")) {
				out.println("<H1><LEFT>User Management Search Menu</LEFT></H1>");
				out.println("<form method=get action=updateEntry.jsp>");
				out.println("Person ID: <input type=text name=PERSONID maxlength=20><br>");
				out.println("<input type=submit name=SEARCH value=Search&nbsp;Persons>");
				out.println("<input type=hidden name=person value=Search&nbsp;Persons>");
				out.println("</form>");

			} else if (request.getParameter("SEARCHTYPE").equals(
					"FamilyDoctors")) {
				out.println("<H1><LEFT>User Management Search Menu</LEFT></H1>");
				out.println("<form method=get action=updateEntry.jsp>");
				out.println("Doctor ID: <input type=text name=DOCID maxlength=20><br>");
				out.println("Person ID: <input type=text name=PERSONID maxlength=20><br>");
				out.println("<input type=submit name=SEARCH value=Search&nbsp;Family&nbsp;Doctors>");
				out.println("<input type=hidden name=famdoc value=Search&nbsp;Family&nbsp;Doctors>");
				out.println("</form>");

			} else {
				out.println("<H1><LEFT>User Management Menu</LEFT></H1>");
				out.println("<form method=get action=searchUserManagement.jsp>");
				out.println("<input type=radio name=SEARCHTYPE value=Users>Users<br>");
				out.println("<input type=radio name=SEARCHTYPE value=Persons>Persons<br>");
				out.println("<input type=radio name=SEARCHTYPE value=FamilyDoctors>Family Doctors<br>");
				out.println("<input type=submit name=SEARCHUSER value=Search>");
				out.println("</form>");
			}
		}

		else {
			out.println("<H1><LEFT><font color=ff0000>ACCESS DENIED</font></LEFT></H1>");
			response.setHeader("Refresh", "3;url=menu.jsp");
		}
	%>

</BODY>
</HTML>

