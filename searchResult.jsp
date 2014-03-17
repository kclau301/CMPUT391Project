<HTML>
<HEAD>
<TITLE>Search Results</TITLE>
</HEAD>

<BODY>
<%@ page import="java.sql.*, db.Database" %>
<%
Database db = new Database();
db.connect();
Connection conn = db.getConnection();

Statement stmt = null;
ResultSet rset = null;

String kWord = request.getParameter("searchKeyword");
String kTime1 = request.getParameter("searchTime1");
String kTime2 = request.getParameter("searchTime2");
String SQLOrder = "";
String sql = "";

String checkClass = (String) session.getAttribute("class");
String userID = (String) session.getAttribute("person_id");

out.println("<H1><LEFT>Search</LEFT></H1>");


if (request.getParameter("SEARCHTYPE").equals("recentFirst")) { 
                out.println("<H1><LEFT>//Ordered recent first</LEFT></H1>");
        SQLOrder = "test_date DESC";
}
else if (request.getParameter("SEARCHTYPE").equals("recentLast")) { 
                out.println("<H1><LEFT>//Ordered recent last</LEFT></H1>");
        SQLOrder = "test_date";
}
else if (request.getParameter("SEARCHTYPE").equals("relavent")) { 
                out.println("<H1><LEFT>//ORdered by relevance</LEFT></H1>");
        //SQLOrder = ...
        //SQL order by  Rank(record_id) = 6*frequency(patient_name) + 3*frequency(diagnosis) + frequency(description)
}
else {
		String error = "<p><b><font color=ff0000>You have not entered any search order specifications!</font></b></p>";
		response.sendRedirect("searchStart.html");
}

/*TODO: need to add into SQL how to get images of record*/

//both entered
if (kWord != "" && kTime1 != "" && kTime2 != "") {
    out.println("//both entered");
    if (checkClass.equals("a")){
    //sql = "select * from radiology_record where ";

//  sample:      String sql = "select p.last_name, p.first_name, p.address, p.phone, r.test_date from persons p, radiology_record r where p.person_id = r.patient_id AND '"+ iDiag +"' = r.diagnosis AND r.test_date between to_date('"+ iDate1 +"', 'DD/MM/YYYY') AND to_date('"+ iDate2 +"', 'MM/DD/YYYY') ORDER BY p.last_name";
	}
	else if (checkClass.equals("p")){
	//sql = "select * from radiology_record where ";
	}
	else if (checkClass.equals("d")){
	//sql = "select * from radiology_record where ";
	}
	else if (checkClass.equals("r")){
	//sql = "select * from radiology_record where ";
	}

}

//no keyword entered
else if (kWord == "" && kTime1 != "" && kTime2 != "") {
    out.println("//no key word entered");
    if (checkClass.equals("a")){
    sql = "select * from radiology_record where test_date between to_date('"+ kTime1 +"', 'DD/MM/YYYY') AND to_date('"+ kTime2 +"', 'DD/MM/YYYY') ORDER BY '"+ SQLOrder +"'";
	}
	else if (checkClass.equals("p")){
	sql = "select * from radiology_record where '"+ userID + "' = patient_id AND test_date between to_date('"+ kTime1 +"', 'DD/MM/YYYY') AND to_date('"+ kTime2 +"', 'DD/MM/YYYY') ORDER BY '"+ SQLOrder +"'";
	}
	else if (checkClass.equals("d")){
	sql = "select * from radiology_record where '"+ userID + "' = doctor_id AND test_date between to_date('"+ kTime1 +"', 'DD/MM/YYYY') AND to_date('"+ kTime2 +"', 'DD/MM/YYYY') ORDER BY '"+ SQLOrder +"'";
	}
	else if (checkClass.equals("r")){
	sql = "select * from radiology_record where '"+ userID + "' = radiologist_id AND test_date between to_date('"+ kTime1 +"', 'DD/MM/YYYY') AND to_date('"+ kTime2 +"', 'DD/MM/YYYY') ORDER BY '"+ SQLOrder +"'";
	}
}

//no time period entered
else if (kWord != "" && kTime1 == "" || kTime2 == "") {
    out.println("//no time entered");
    if (checkClass.equals("a")){
    //sql = "select * from radiology_record where...
	}
	else if (checkClass.equals("p")){
	//sql = "select * from radiology_record where ";
	}
	else if (checkClass.equals("d")){
	//sql = "select * from radiology_record where ";
	}
	else if (checkClass.equals("r")){
	//sql = "select * from radiology_record where ";
	}
    //sql = "select * from radiology_record where ";
}

//neither entered 
else {
		String error = "<p><b><font color=ff0000>You have not entered any search specifications!</font></b></p>";
		response.sendRedirect("searchStart.html");
}
        try {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
        } catch(Exception e) {
            out.println("<hr>" + e.getMessage() + "<hr>");
        }

%>

Results:

<table border="1">
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
  <%
        while(rset != null && rset.next()) {
            String recordID = (rset.getString(1));
            String patientID = (rset.getString(2));
            String doctorID = (rset.getString(3));
            String radiologist = (rset.getString(4));
            String testType = (rset.getString(5));
            String pDate = (rset.getString(6));
            String tDate = (rset.getString(7));
            String diag = (rset.getString(8));
            String description = (rset.getString(9));

        out.println("<tr> <td>"+recordID+"</td> <td>"+patientID+"</td> <td>"+doctorID+"</td> <td>"+radiologist+"</td> <td>"+testType+"</td> <td>"+pDate+"</td> <td>"+tDate+"</td><td>"+diag+"</td><td>"+description+"</td></tr>");
    
        }
        
    %>
</table>
</BODY>
</HTML>


<!-- a patient can only view his/her own records; a doctor can only view records of their patients; a radiologist can only review records conducted by oneself; and an administrator can view any records. -->

