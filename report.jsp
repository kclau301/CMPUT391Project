<!-- start up screen for the Report generation module. user inputs search parameters and click the submit button to display the patient information for user to view. Can only be accessed by an admin -->
<html>
<head>
<title>Report Regeneration</title>
</head>
<body>
	<H1>Report Regeneration</H1>
	<form name="Rresult" method="post" action="reportResult.jsp">
		<table>
			<tr>
				<th>Diagnosis</th>
				<td><input name="DiagnosisInput" type="text" size="30"></input></td>
			</tr>
			<tr>
				<th>Date Range (Format: DD/MM/YY)</th>
				<td><input name="DateInput1" type="text" size="30"></input></td>
				<th>to</th>
				<td><input name="DateInput2" type="text" size="30"></input></td>
			</tr>
			<tr>
				<td ALIGN=CENTER COLSPAN="2"><input type="submit"
					name="Rsubmit" value="Enter"></td>
			</tr>
		</table>
	</form>
	
<%	
	String error = (String) session.getAttribute("error");
		if (error != null) {
			out.println(error);
			session.removeAttribute("error");
		}
%>
	
</body>
</html>

