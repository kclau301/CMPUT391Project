<html>
<head>
<title>Search</title>
</head>
<body>
	<H1>Search</H1>
	<form name="sResult" method="post" action="searchResult.jsp">
		Enter keywords <input type="text" name="searchKeyword" size="30"></input>

		and/or time period (Format: DD/MM/YYYY) between <input
			name="searchTime1" type="text" size="30"></input> and <input
			name="searchTime2" type="text" size="30"></input>


		<p>Select sorting method:</p>
		<input type="radio" name="SEARCHTYPE" value="recentFirst">Most
		Recent First<br> <input type="radio" name="SEARCHTYPE"
			value="recentLast">Most Recent Last<br> <input
			type="radio" name="SEARCHTYPE" value="relevant">Most Relevant<br>
		<input type="submit" name="SEARCHDATA" value="Search">
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
