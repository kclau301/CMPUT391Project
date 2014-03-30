<HTML>
<HEAD>


<TITLE>User Management Menu</TITLE>
</HEAD>

<BODY>

	<%@ page import="java.sql.*"%>
	<%
		String checkClass = (String) session.getAttribute("class");

		if (checkClass.equals("a")) {

			out.println("<H1><LEFT>User Management Menu</LEFT></H1>");
			out.println("<H3><LEFT>Search for and update existing entry:</LEFT></H3>");
			out.println("<form method=get action=searchUserManagement.jsp>");
			out.println("<input type=radio name=SEARCHTYPE value=Users>Users<br>");
			out.println("<input type=radio name=SEARCHTYPE value=Persons>Persons<br>");
			out.println("<input type=radio name=SEARCHTYPE value=FamilyDoctors>Family Doctors<br>");
			out.println("<input type=submit name=SEARCHUSER value=Search>");
			out.println("</form>");

			out.println("<H3><LEFT>Create new entry:</LEFT></H3>");
			out.println("<form method=get action=createEntry.jsp>");
			out.println("<input type=radio name=CREATETYPE value=User>User<br>");
			out.println("<input type=radio name=CREATETYPE value=Person>Person<br>");
			out.println("<input type=radio name=CREATETYPE value=FamilyDoctor>Family Doctor<br>");
			out.println("<input type=submit name=CREATEUSER value=Create>");
			out.println("</form>");

		}

		else {
			out.println("<H1><LEFT><font color=ff0000>ACCESS DENIED</font></LEFT></H1>");
			response.setHeader("Refresh", "3;url=menu.jsp");
		}
	%>

</BODY>
</HTML>
