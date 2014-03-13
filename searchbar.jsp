
<HTML>
<HEAD>


<TITLE>Search</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*" %>
<%
                out.println("<H1><LEFT>Search</LEFT></H1>");
%>
Enter keywords
<%
        out.println("<input type=textfield name=searchKeyword size=30></input>");
%>
and/or time period
<%
        out.println("<input name=searchTime type=textfield size=30></input>");
%>           


<p>select sorting method:</p>
<%
                out.println("<form method=get action=searchResult.jsp>");
        out.println("<input type=radio name=SEARCHTYPE value=recentFirst>Most Recent First<br>");
        out.println("<input type=radio name=SEARCHTYPE value=recentLast>Most Recent Last<br>");
        out.println("<input type=radio name=SEARCHTYPE value=relavent>Most Relevant<br>");
                out.println("<input type=submit name=SEARCHDATA value=Search>");
                out.println("</form>");
%>

</BODY>
</HTML