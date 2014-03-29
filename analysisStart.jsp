<!-- start up screen for the data analysis module. user inputs search parameters and click the submit button to display a "cube" of information for user to view. Can only be viewed by an admin -->
<html>
<head>
<title>Data Analysis</title>
</head>
<body>
	<H1>Data Analysis</H1>
	<!-- Creates the checkboxes for the display -->
	<form name="aResult" method="post" action="analysisResult.jsp">
		Display Options: <input type="checkbox" name="displayType" size="30"
			value="1"></input> Patient ID <input type="checkbox"
			name="displayType2" size="30" value="1"></input> Test Type <input
			type="checkbox" name="displayType3" size="30" value="1"></input> Time
		Period

		<!-- Creates the radio buttons for the test date option -->
		<p>Order Time Period by:</p>
		<input type="radio" name="TIMETYPE" value="week">Week<br>
		<input type="radio" name="TIMETYPE" value="month">Month<br>
		<input type="radio" name="TIMETYPE" value="year">Year<br>
		<input type="submit" name="ANALYZEDATA" value="Submit">
	</form>

	<%
		//displays the error msg if needed
		String error = (String) session.getAttribute("error");
		if (error != null) {
			out.println(error);
			session.removeAttribute("error");
		}
	%>

</BODY>
</HTML>