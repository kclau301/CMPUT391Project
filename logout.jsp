<html>
<head>
<title>Logout</title>
</head>
<body>
	<%
		session.removeAttribute("username");
		session.removeAttribute("class");
		session.removeAttribute("person_id");

		// Redirect to the login page
		response.setHeader("Refresh", "3;url=login.jsp");
	%>
	<p>
		<b>You have successfully logged out.</b>
	</p>
</body>
</html>