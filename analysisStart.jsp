<html>
<head>
<title>Data Analysis</title>
</head>
<body>
	<H1>Data Analysis</H1>
	<form name="aResult" method="post" action="analysisResult.jsp">
		Display Options: <input type="checkbox" name="displayType" size="30" value="patName"></input> Patient Name
						<input type="checkbox" name="displayType" size="30" value="testType"></input> Test Type
						<input type="checkbox" name="displayType" size="30" value="timePeriod"></input> Time Period

		<p>Order Time Period by:</p>
		<input type="radio" name="TIMETYPE" value="week">Week<br> 
		<input type="radio" name="TIMETYPE" value="month">Month<br> 
		<input type="radio" name="TIMETYPE" value="year">Year<br> 
		<input type="submit" name="ANALYZEDATA" value="Submit">
	</form>

	<%
		String error = (String) session.getAttribute("error");
		if (error != null) {
			out.println(error);
			session.removeAttribute("error");
		}
	%>

</BODY>
</HTML>