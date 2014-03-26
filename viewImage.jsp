<html>
<head>
</head>
<body bgcolor=#272727>
	<div align="center">
		<%
			String image_id = request.getQueryString();

			if (image_id.startsWith("regular")) {
				// specify the servlet when the regular sized image is clicked
				out.println("<a href=\"/CMPUT391/viewImage.jsp?"
						+ image_id.substring(7) + "\">");
				// display the regular sized image
				out.println("<img src=\"/CMPUT391/GetOnePic?regular"
						+ image_id.substring(7) + "\"></a>");
			} else {
				// specify the servlet when the full sized image is clicked
				out.println("<a href=\"/CMPUT391/viewImage.jsp?regular"
						+ image_id + "\">");
				// display the full sized image
				out.println("<img src=\"/CMPUT391/GetOnePic?" + image_id
						+ "\"></a>");
			}
		%>
	</div>
</body>
</html>