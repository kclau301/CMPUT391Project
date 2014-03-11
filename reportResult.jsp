<html>
<title>Report Regeneration</title> 
<body> 
<H1><LEFT>Report Regeneration</LEFT></H1>


    Results for patients with 
        <%@ page import="java.sql.*, db.Database" %>
        <%
        Database db = new Database();
        db.connect();
        Connection conn = db.getConnection();

        
        Statement stmt = null;
        ResultSet rset = null;
        
        String iDiag =     request.getParameter("DiagnosisInput");
        String iDate =     request.getParameter("DateInput");
        
        //TODO: still need to implement matching dates together!!!
        String sql = "select p.last_name, p.first_name, p.address, p.phone, r.test_date from persons p, radiology_record r where p.person_id = r.patient_id AND '"+ iDiag +"' = r.diagnosis ORDER BY p.last_name";

        try {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
        } catch(Exception e) {
            out.println("<hr>" + e.getMessage() + "<hr>");
        }

        out.print(iDiag);
        %>
    on
        <%
        out.print(iDate);
        %>
    :    

<table border="1">
<tr> <th>Last Name</th> <th> First Name </th> <th>Address</th> <th>Phone Number</th> <th>Testing Date</th> </tr>

    <%
        while(rset != null && rset.next()) {
            String lName = (rset.getString(1));
            String fName = (rset.getString(2));
            String address = (rset.getString(3));
            String phone = (rset.getString(4));
            String tDate = (rset.getString(5));
        out.println("<tr> <td>"+lName+"</td> <td>"+fName+"</td> <td>"+address+"</td> <td>"+phone+"</td> <td>"+tDate+"</td> </tr>");
    
        }
        
    %>
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