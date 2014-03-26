import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import oracle.jdbc.OracleResultSet;
import oracle.sql.BLOB;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;

import db.Database;

/**
 * Servlet implementation class UploadImage. This servlet handles the image
 * uploading functionalities. It acquires the image from uploadImage.jsp and
 * uploads the image into the database.
 */
@SuppressWarnings({ "serial" })
public class UploadImage extends HttpServlet {

	private Database db = null;
	private Connection conn = null;
	private Statement stmt = null;
	private ResultSet rset = null;
	private final int THUMBNAIL_SHRINK = 10;
	private final int REGULAR_SHRINK = 5;
	private final String SQL_IMAGE_ID = "SELECT image_id_seq.nextval from dual";
	public String response_message;

	@SuppressWarnings({ "unchecked", "deprecation" })
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		response_message = "";
		HttpSession session = request.getSession();
		// PrintWriter out = response.getWriter();
		FileItem image_file = null;
		int record_id = 0;
		int image_id;
		InputStream instream = null;
		OutputStream full_outstream = null;
		OutputStream thumb_outstream = null;
		OutputStream regular_outstream = null;

		try {
			// Parse the HTTP request to get the image stream
			DiskFileUpload fu = new DiskFileUpload();
			List<FileItem> FileItems = fu.parseRequest(request);

			// Process the uploaded items, assuming only 1 image file uploaded
			Iterator<FileItem> i = FileItems.iterator();

			while (i.hasNext()) {
				FileItem item = (FileItem) i.next();
				if (item.isFormField()) {
					if (item.getFieldName().equals("recordID")) {
						record_id = Integer.parseInt(item.getString());
						if (!isValidID(record_id)) {
							response_message = "<p><font color=ff0000>Invalid record id!</font></p>";
							session.setAttribute("msg", response_message);
							response.sendRedirect("uploadImage.jsp");
						}
					}
					// out.println(item.getFieldName() + ": " +
					// item.getString());
				} else {
					image_file = item;
					if (image_file.getName().equals("")) {
						response_message = "<p><font color=ff0000>No file selected!</font></p>";
						session.setAttribute("msg", response_message);
						response.sendRedirect("uploadImage.jsp");
					}
				}
			}

			// Get the image stream
			instream = image_file.getInputStream();

			BufferedImage full_image = ImageIO.read(instream);
			BufferedImage thumbnail = shrink(full_image, THUMBNAIL_SHRINK);
			BufferedImage regular_image = shrink(full_image, REGULAR_SHRINK);

			// Connect to the database
			db = new Database();
			db.connect();
			conn = db.getConnection();
			stmt = conn.createStatement();

			/*
			 * First, to generate a unique pic_id using an SQL sequence
			 */
			ResultSet rset1 = stmt.executeQuery(SQL_IMAGE_ID);
			rset1.next();
			image_id = rset1.getInt(1);

			// Insert an empty blob into the table first. Note that you have to
			// use the Oracle specific function empty_blob() to create an empty
			// blob
			stmt.execute("INSERT INTO pacs_images VALUES(" + record_id + ","
					+ image_id + ", empty_blob(), empty_blob(), empty_blob())");

			// to retrieve the lob_locator
			// Note that you must use "FOR UPDATE" in the select statement
			String cmd = "SELECT * FROM pacs_images WHERE image_id = "
					+ image_id + " FOR UPDATE";
			ResultSet rset = stmt.executeQuery(cmd);
			rset.next();
			BLOB thumb = ((OracleResultSet) rset).getBLOB("thumbnail");
			BLOB regular = ((OracleResultSet) rset).getBLOB("regular_size");
			BLOB full = ((OracleResultSet) rset).getBLOB("full_size");

			// Write the image to the blob object
			full_outstream = full.getBinaryOutputStream();
			ImageIO.write(full_image, "jpg", full_outstream);
			thumb_outstream = thumb.getBinaryOutputStream();
			ImageIO.write(thumbnail, "jpg", thumb_outstream);
			regular_outstream = regular.getBinaryOutputStream();
			ImageIO.write(regular_image, "jpg", regular_outstream);

			stmt.executeUpdate("commit");
			response_message = "<p>Upload OK!</p>";
			session.setAttribute("msg", response_message);
			response.sendRedirect("uploadImage.jsp");

		} catch (Exception ex) {
			response_message = ex.getMessage();
		} finally {
			if (instream != null) {
				instream.close();
			}
			if (full_outstream != null) {
				full_outstream.close();
			}
			if (thumb_outstream != null) {
				thumb_outstream.close();
			}
			if (regular_outstream != null) {
				regular_outstream.close();
			}
			db.close(conn, stmt, null, rset);
		}
	}

	/**
	 * Shrink image by a factor of n, and return the shrunk image
	 * 
	 * @param image
	 *            the image
	 * @param n
	 *            the shrinking factor
	 * @return shrunkImage the shrunk image
	 */
	public static BufferedImage shrink(BufferedImage image, int n) {

		int w = image.getWidth() / n;
		int h = image.getHeight() / n;

		BufferedImage shrunkImage = new BufferedImage(w, h, image.getType());

		for (int y = 0; y < h; ++y)
			for (int x = 0; x < w; ++x)
				shrunkImage.setRGB(x, y, image.getRGB(x * n, y * n));

		return shrunkImage;
	}

	/**
	 * Checks to see if a valid record id has been entered.
	 * 
	 * @param record_id
	 *            the record id
	 * @return True if the id is valid. False otherwise.
	 */
	public boolean isValidID(int record_id) {
		db = new Database();
		db.connect();
		conn = db.getConnection();
		String sql = "select count(*) from radiology_record where record_id = "
				+ record_id;
		int count = 0;
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			while (rset != null && rset.next()) {
				count = (rset.getInt(1));
			}
		} catch (SQLException e) {
			response_message = e.getMessage();
		} finally {
			db.close(conn, stmt, null, rset);
		}

		if (count == 0) {
			return false;
		}
		return true;
	}

}
