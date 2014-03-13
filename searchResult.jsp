<HTML>
<HEAD>
<TITLE>Search Results</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*" %>
<%
    out.println("<H1><LEFT>Search</LEFT></H1>");
%>

Results:

<table border=1>
<tr>
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
</table>
</BODY>
</HTML>


<!-- a patient can only view his/her own records; a doctor can only view records of their patients; a radiologist can only review records conducted by oneself; and an administrator can view any records. -->
