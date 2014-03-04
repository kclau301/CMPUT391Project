
<html>
<title>Report Regeneration</title> 
<body> 
<H1><LEFT>Report Regeneration</LEFT></H1>
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://http://localhost:8080/project1/reportResult.jsp"
    user="[user]"  password="[pw]"/> 

	Results for patients with 
		<%
		String iDiag = 	request.getParameter("DiagnosisInput");
		String iDate = 	request.getParameter("DateInput");
		out.print(iDiag);
		%>
	on
		<%
		out.print(iDate);
		%>
	:

	<sql:query dataSource="${snapshot}" var="result">
	SELECT * FROM persons 
	</sql:query>


<table border="1">
<tr> <th>Last Name</th> <th> First Name </th> <th>Address</th> <th>Phone Number</th> <th>Testing Date</th> </tr>
<tr> <td>Gates</td> <td> Bill </td> <td>555 Street</td> <td> 555 333 2345</td> <td>05-23-13</td> </tr>
<c:forEach var="row" items="${result.rows}">
<tr>
<td><c:out value="${row.last_name}"/></td>
<td><c:out value="${row.first_name}"/></td>
<td><c:out value="${row.address}"/></td>
<td><c:out value="${row.phone}"/></td>
<td><c:out value="${row.test_date}"/></td>
</tr>
</c:forEach>
</table> 
</body>
</html> 

<!-- SQL: 
select p.last_name, p.first_name, p.address, p.phone, r.test_date
from persons p, radiology_record r
where p.person_id = r.patient_id 
	AND [diagnosis] = r.diagnosis
	AND [date] = r.test_date
ORDER BY p.last_name
 -->