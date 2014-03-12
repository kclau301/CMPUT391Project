<HTML>
<HEAD>


<TITLE>Update Form</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*" %>
<%

String checkClass = (String) session.getAttribute("class");

 if (checkClass.equals("a")){
	if (request.getParameter("SEARCH").equals(request.getParameter("user"))) {

                out.println("<H1><LEFT>User Update</LEFT></H1>");
                out.println("<form method=post action=createSubmit.jsp>");
		out.println("Username: <input type=text name=USERNAME maxlength=20><br>");
		out.println("Password: <input type=text name=PASSWORD maxlength=20><br>");
		out.println("Class: <input type=text name=CLASS maxlength=20><br>");
                out.println("<input type=submit name=updateuser value=Update>");
                out.println("</form>");

	} else if (request.getParameter("SEARCH").equals(request.getParameter("person"))) {
                out.println("<H1><LEFT>Person Update</LEFT></H1>");
                out.println("<form method=post action=createSubmit.jsp>");
		out.println("First Name: <input type=text name=FIRSTNAME maxlength=20> <br>");
		out.println("Last Name: <input type=text name=LASTNAME maxlength=20><br>");
		out.println("Address: <input type=text name=ADDRESS maxlength=50><br>");
		out.println("Email: <input type=text name=EMAIL maxlength=30><br>");
		out.println("Phone: <input type=text name=PHONE maxlength=10><br>");
                out.println("<input type=submit name=updateperson value=Update>");
                out.println("</form>");

	} else if (request.getParameter("SEARCH").equals(request.getParameter("famdoc"))) {
                out.println("<H1><LEFT>Family Doctor Update</LEFT></H1>");
                out.println("<form method=post action=createSubmit.jsp>");
		out.println("Doctor ID: <input type=text name=DOCID maxlength=20><br>");
		out.println("Patient ID: <input type=text name=PATID maxlength=20><br>");
                out.println("<input type=submit name=updatefamilydoc value=Update>");
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
