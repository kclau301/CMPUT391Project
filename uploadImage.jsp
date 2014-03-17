<html>
<title>Upload Image</title>
<body>
	<H1>Upload Image</H1>

	<form name="upload-image" method="POST" enctype="multipart/form-data"
		action="UploadImage">
		<table>
			<tr>
				<th>Radiology Record ID:</th>
				<td><input name="recordID" type="text" pattern="[0-9]+"
					title="ID number"></td>
			</tr>
		</table>
		Please input or select the path of the image:
		<table>
			<tr>
				<th>File path:</th>
				<td><input name="file-path" type="file" size="30"></input></td>
			</tr>
			<tr>
				<td ALIGN=LEFT COLSPAN="2"><input type="submit" name="Isubmit"
					value="Upload"></td>
			</tr>
		</table>
	</form>
	<%
		String error = (String) session.getAttribute("msg");
		if (error != null) {
			out.println(error);
			session.removeAttribute("msg");
		}
	%>

</body>
</html>

