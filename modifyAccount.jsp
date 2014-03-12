
<%@ page import="java.sql.*, java.util.ArrayList, db.Database"%>
<%
	String username = (String) session.getAttribute("username");
	Database db = new Database();
	db.connect();
	Connection conn = db.getConnection();
	Statement stmt = null;
	ResultSet rset = null;
	String sql_persons = "select * from persons where person_id in (select person_id from users where user_name = '"
			+ username + "')";
	String sql_users = "select password from users where user_name = '"
			+ username + "'";

	int id = 0;
	String fname = "";
	String lname = "";
	String address = "";
	String email = "";
	String phone = "";
	String password = "";

	try {
		stmt = conn.createStatement();

		// Get data from persons table
		rset = stmt.executeQuery(sql_persons);
		while (rset != null && rset.next()) {
			id = rset.getInt("person_id");
			fname = rset.getString("first_name");
			lname = rset.getString("last_name");
			address = rset.getString("address");
			email = rset.getString("email");
			phone = rset.getString("phone");
		}

		// Get data from users table
		rset = stmt.executeQuery(sql_users);
		while (rset != null && rset.next()) {
			password = rset.getString("password");
		}

	} catch (Exception e) {
		out.println("<hr>" + e.getMessage() + "<hr>");
	} finally {
		// Close the database connection
		db.close(conn, stmt, null, rset);
	}

	session.setAttribute("curr_id", id);
%>
<html>
<head>
<title>User Information</title>
</head>
<body>
	<form method=post action=ModifyAccountCheck>
		<table>
			<tr>
				<th>First Name:</th>
				<td><input type="text" name="fname" maxlength="24"
					value="<%out.println(fname);%>"></td>
			</tr>
			<tr>
				<th>Last Name:</th>
				<td><input type="text" name="lname" maxlength="24"
					value="<%out.println(lname);%>"></td>
			</tr>
			<tr>
				<th>Address:</th>
				<td><input type="text" name="address" maxlength="128"
					value="<%out.println(address);%>"></td>
			</tr>
			<tr>
				<th>Email:</th>
				<td><input type="email" name="email" maxlength="128"
					value="<%out.println(email);%>"></td>
			</tr>
			<tr>
				<th>Phone</th>
				<td><input type="tel" name="phone" maxlength="10"
					value="<%out.println(phone);%>"></td>
			</tr>
			<tr>
				<th>Old Password:</th>
				<td><input type="password" name="opassword" maxlength="24"></td>
			</tr>
			<tr>
				<th>New Password:</th>
				<td><input type="password" name="npassword" maxlength="24"></td>
			</tr>
			<tr>
				<td><input type=submit name=bSubmitModifyAccount
					value="Save Changes"></td>
			</tr>
		</table>
	</form>
	<%
		String error = (String) session.getAttribute("error");
		if (error != null && error != "") {
			out.println(error);
			session.removeAttribute("error");
		}
	%>
</body>
</html>
