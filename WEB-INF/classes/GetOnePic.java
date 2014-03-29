import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.Database;

/**
 * Servlet implementation class GetOnePic. This servlet handles displaying the
 * images on the page.
 */
@SuppressWarnings("serial")
public class GetOnePic extends HttpServlet {

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String image_id = request.getQueryString();
		String sql;

		if (image_id.startsWith("thumbnail")) {
			sql = "select thumbnail from pacs_images where image_id="
					+ image_id.substring(9);
		} else if (image_id.startsWith("regular")) {
			sql = "select regular_size from pacs_images where image_id="
					+ image_id.substring(7);
		} else {
			sql = "select full_size from pacs_images where image_id="
					+ image_id;
		}

		ServletOutputStream out = response.getOutputStream();

		Database db = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;

		db = new Database();
		db.connect();
		conn = db.getConnection();
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);

			if (rset.next()) {
				response.setContentType("image/gif");
				InputStream input = rset.getBinaryStream(1);
				int imageByte;
				while ((imageByte = input.read()) != -1) {
					out.write(imageByte);
				}
				input.close();
			} else
				out.println("no picture available");
		} catch (Exception ex) {
			out.println(ex.getMessage());
		} finally {
			db.close(conn, stmt, null, rset);
		}

	}
}
