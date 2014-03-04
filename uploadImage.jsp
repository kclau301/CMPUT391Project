<html>
<title> Upload Image </title>
<body> 
<H1><LEFT>Upload Image</LEFT></H1>


	Insert image for radiology record ID 
		<%
		String iDiag = 	request.getParameter("RadiologyRecord");
		out.print(iDiag);
		%>
	:

<hr>
Please input or select the path of the image:
<form name="upload-image" method="POST" enctype="multipart/form-data" action="servlet/UploadImage">
<table>
  <tr>
    <th>File path: </th>
    <td><input name="file-path" type="file" size="30" ></input></td>
  </tr>
  <tr>
    <td ALIGN=CENTER COLSPAN="2"><input type="submit" name=".submit" 
     value="Upload"></td>
  </tr>
</table>
</form>

</body>
</html> 

<!--
	The following can be used to insert an image of BLOB type into an Oracle database.

Note that (1) the table in the database is created by
      CREATE TABLE pictures (
            pic_id int,
	    pic_desc  varchar(100),
	    pic  BLOB,
	    primary key(pic_id)
      )
(2) an SQL sequence in the database is created by
   CREATE SEQUENCE pic_id_sequence
   -->