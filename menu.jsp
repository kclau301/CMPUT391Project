<HTML>
<HEAD>


<TITLE>System Menu</TITLE>
</HEAD>

<BODY>
	<div style="float: right">
		<a href="help.html">Help</a>
		<a href="logout.jsp">Logout</a>
	</div>
	<!--A simple example to demonstrate how to use JSP to 
    connect and query a database. 
    @author  Hong-Yu Zhang, University of Alberta
 -->
	<%@ page import="java.sql.*"%>
	<%
		String checkClass = (String) session.getAttribute("class");

		if (checkClass.equals("a")) {

			out.println("<H1><LEFT>Radiology Information System Menu</LEFT></H1>");
			out.println("<form method=post action=userManagementMenu.jsp>");
			out.println("<input type=submit name=usermanagement value=User&nbsp;Management>");
			out.println("</form>");

			out.println("<form method=post action=report.jsp>");
			out.println("<input type=submit name=reportgenerating value=Report&nbsp;Generating>");
			out.println("</form>");

			out.println("<form method=post action=searchStart.jsp>");
			out.println("<input type=submit name=search value=Search>");
			out.println("</form>");

			out.println("<form method=post action=analysisStart.jsp>");
			out.println("<input type=submit name=dataanalysis value=Data&nbsp;Analysis>");
			out.println("</form>");

			out.println("<form method=post action=modifyAccount.jsp>");
			out.println("<input type=submit name=modifyaccount value=Modify&nbsp;Account>");
			out.println("</form>");
		} else if (checkClass.equals("p")) {

			out.println("<H1><LEFT>Radiology Information System Menu</LEFT></H1>");

			out.println("<form method=post action=searchStart.jsp>");
			out.println("<input type=submit name=search value=SEARCH>");
			out.println("</form>");

			out.println("<form method=post action=modifyAccount.jsp>");
			out.println("<input type=submit name=modifyaccount value=Modify&nbsp;Account>");
			out.println("</form>");
		}

		else if (checkClass.equals("d")) {

			out.println("<H1><LEFT>Radiology Information System Menu</LEFT></H1>");

			out.println("<form method=post action=searchStart.jsp>");
			out.println("<input type=submit name=search value=SEARCH>");
			out.println("</form>");

			out.println("<form method=post action=modifyAccount.jsp>");
			out.println("<input type=submit name=modifyaccount value=Modify&nbsp;Account>");
			out.println("</form>");
		}

		else if (checkClass.equals("r")) {

			out.println("<H1><LEFT>Radiology Information System Menu</LEFT></H1>");

			out.println("<form method=post action=uploadImage.jsp>");
			out.println("<input type=submit name=upload value=UPLOAD>");
			out.println("</form>");

			out.println("<form method=post action=searchStart.jsp>");
			out.println("<input type=submit name=search value=SEARCH>");
			out.println("</form>");

			out.println("<form method=post action=modifyAccount.jsp>");
			out.println("<input type=submit name=modifyaccount value=Modify&nbsp;Account>");
			out.println("</form>");
		}

	%>

</BODY>
</HTML>
