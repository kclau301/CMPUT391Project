<HTML>
<HEAD>


<TITLE>System Menu</TITLE>
</HEAD>

<BODY>
<!--A simple example to demonstrate how to use JSP to 
    connect and query a database. 
    @author  Hong-Yu Zhang, University of Alberta
 -->
<%@ page import="java.sql.*" %>
<%

String checkClass = (String) session.getAttribute("class");

 if (checkClass.equals("a")){

                out.println("<H1><LEFT>Radiology Information System Menu</LEFT></H1>");
                out.println("<form method=post action=userManagementMenu.html>");
                out.println("<input type=submit name=usermanagement value=USER_MANAGEMENT>");
                out.println("</form>");

                out.println("<form method=post action=report.html>");
                out.println("<input type=submit name=reportgenerating value=REPORT_GENERATING>");
                out.println("</form>");

                out.println("<form method=post action=uploadStart.html>");
                out.println("<input type=submit name=upload value=UPLOAD>");
                out.println("</form>");

                out.println("<form method=post action=menu.html>");
                out.println("<input type=submit name=search value=SEARCH>");
                out.println("</form>");

                out.println("<form method=post action=menu.html>");
                out.println("<input type=submit name=dataanalysis value=DATA_ANALYSIS>");
                out.println("</form>");
}
else if (checkClass.equals("p")){

                out.println("<H1><LEFT>Radiology Information System Menu</LEFT></H1>");

                out.println("<form method=post action=menu.html>");
                out.println("<input type=submit name=search value=SEARCH>");
                out.println("</form>");
}

else if (checkClass.equals("d")){

                out.println("<H1><LEFT>Radiology Information System Menu</LEFT></H1>");

                out.println("<form method=post action=menu.html>");
                out.println("<input type=submit name=search value=SEARCH>");
                out.println("</form>");
}

else if (checkClass.equals("r")){


                out.println("<H1><LEFT>Radiology Information System Menu</LEFT></H1>");

                out.println("<form method=post action=uploadStart.html>");
                out.println("<input type=submit name=upload value=UPLOAD>");
                out.println("</form>");

                out.println("<form method=post action=menu.html>");
                out.println("<input type=submit name=search value=SEARCH>");
                out.println("</form>");
}

 else {
                out.println("<H1><LEFT>Radiology Information System Menu</LEFT></H1>");
                out.println("<form method=post action=userManagementMenu.html>");
                out.println("<input type=submit name=usermanagement value=USER_MANAGEMENT>");
                out.println("</form>");

                out.println("<form method=post action=report.html>");
                out.println("<input type=submit name=reportgenerating value=REPORT_GENERATING>");
                out.println("</form>");

                out.println("<form method=post action=uploadStart.html>");
                out.println("<input type=submit name=upload value=UPLOAD>");
                out.println("</form>");

                out.println("<form method=post action=menu.html>");
                out.println("<input type=submit name=search value=SEARCH>");
                out.println("</form>");

                out.println("<form method=post action=menu.html>");
                out.println("<input type=submit name=dataanalysis value=DATA_ANALYSIS>");
                out.println("</form>");
}

%>

</BODY>
</HTML>
