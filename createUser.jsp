<HTML>
<HEAD>


<TITLE>Create Entry Form</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*" %>
<%

String checkClass = (String) session.getAttribute("class");

 if (checkClass.equals("a")){

	if (request.getParameter("CREATETYPE").equals("User")) {

                out.println("<H1><LEFT>User Creation</LEFT></H1>");
                out.println("<form method=post action=createSubmit.jsp>");
		out.println("Username: <input type=text name=USERNAME maxlength=20><br>");
		out.println("Password: <input type=text name=PASSWORD maxlength=20><br>");
		out.println("Class: <input type=text name=CLASS maxlength=20><br>");
		out.println("Person ID: <input type=text name=PERSONID maxlength=20><br>");
                out.println("<input type=submit name=create value=Create&nbsp;User>");
		out.println("<input type=hidden name=user value=Create&nbsp;User>");
                out.println("</form>");

	}else if (request.getParameter("CREATETYPE").equals("Person")) {
                out.println("<H1><LEFT>Person Creation</LEFT></H1>");
                out.println("<form method=post action=createSubmit.jsp>");
		out.println("First Name: <input type=text name=FIRSTNAME maxlength=20> <br>");
		out.println("Last Name: <input type=text name=LASTNAME maxlength=20><br>");
		out.println("Address: <input type=text name=ADDRESS maxlength=50><br>");
		out.println("Email: <input type=text name=EMAIL maxlength=30><br>");
		out.println("Phone: <input type=text name=PHONE maxlength=10><br>");
                out.println("<input type=submit name=create value=Create&nbsp;Person>");
		out.println("<input type=hidden name=person value=Create&nbsp;Person>");
                out.println("</form>");
	} else if (request.getParameter("CREATETYPE").equals("FamilyDoctor")) {
                out.println("<H1><LEFT>Family Doctor Creation</LEFT></H1>");
                out.println("<form method=post action=createSubmit.jsp>");
		out.println("Doctor ID: <input type=text name=DOCID maxlength=20><br>");
		out.println("Patient ID: <input type=text name=PATID maxlength=20><br>");
                out.println("<input type=submit name=create value=Create&nbsp;Family&nbsp;Doctor>");
		out.println("<input type=hidden name=famdoc value=Create&nbsp;Family&nbsp;Doctor>");
                out.println("</form>");
	} else {
		out.println("<form method=get action=createUser.jsp>");
		out.println("<input type=radio name=CREATETYPE value=User>User<br>");
		out.println("<input type=radio name=CREATETYPE value=Person>Person<br>");
		out.println("<input type=radio name=CREATETYPE value=FamilyDoctor>Family Doctor<br>");
                out.println("<input type=submit name=CREATEUSER value=Create>");
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
