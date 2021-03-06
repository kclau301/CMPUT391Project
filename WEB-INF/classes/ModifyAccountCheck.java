import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.Database;

/**
 * Servlet implementation class ModifyAccountCheck. This servlet validates the
 * user inputted data in the account modification form. If there are no errors,
 * the update succeeds and the user is brought back to the main menu.
 */
@SuppressWarnings("serial")
public class ModifyAccountCheck extends HttpServlet {

	private Connection conn = null;
	private Statement stmt = null;
	private ResultSet rset = null;
	private int curr_id;

	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String error_msg = "";
		boolean error = false;

		curr_id = (Integer) session.getAttribute("curr_id");
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String address = request.getParameter("address");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String old_password = request.getParameter("opassword");
		String new_password = request.getParameter("npassword");

		Database db = new Database();
		db.connect();
		conn = db.getConnection();
		try {
			stmt = conn.createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		changeFName(fname);
		changeLName(lname);
		changeAddress(address);
		error = changeEmail(email); // Email has a unique constraint
		if (error) { // Check is email is unique
			error_msg += "<font color=ff0000>Email already exists!</font><br>";
		}
		changePhone(phone);
		error = changePassword(old_password, new_password);
		if (error) { // Check if password is entered correctly
			error_msg += "<font color=ff0000>Incorrect old password!</font><br>";
		}

		db.close(conn, stmt, null, rset);
		session.removeAttribute("curr_id");

		if (error_msg != "") {
			session.setAttribute("error", error_msg);
			response.sendRedirect("modifyAccount.jsp");
		} else {
			// Check if password has been updated
			if (new_password.equals("")) {
				out.println("Password not changed.<br>");
			}
			out.println("<font color=00bb00>Successfully updated user information.</font>");
			response.setHeader("Refresh", "3;url=userManagementMenu.jsp");
		}
	}

	/**
	 * Update the user's first name
	 * 
	 * @param fname
	 *            the first name
	 */
	private void changeFName(String fname) {
		String sql = "update persons set first_name = '" + fname
				+ "' where person_id = " + curr_id;

		try {
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Update the user's last name
	 * 
	 * @param lname
	 *            the last name
	 */
	private void changeLName(String lname) {
		String sql = "update persons set last_name = '" + lname
				+ "' where person_id = " + curr_id;

		try {
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Update the user's address
	 * 
	 * @param address
	 *            the address
	 */
	private void changeAddress(String address) {
		String sql = "update persons set address = '" + address
				+ "' where person_id = " + curr_id;

		try {
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Update the user's email
	 * 
	 * @param email
	 *            the email
	 * @return error False if the email is unique. True otherwise.
	 */
	private boolean changeEmail(String email) {
		boolean error = false;
		int count = 0;
		String sql = "select count(*) from persons where person_id != "
				+ curr_id + " and email = '" + email + "'";

		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			while (rset != null && rset.next()) {
				count = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		if (count > 0) {
			error = true;
		} else {
			sql = "update persons set email = '" + email
					+ "' where person_id = " + curr_id;
			try {
				stmt.executeUpdate(sql);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return error;
	}

	/**
	 * Update the user's phone
	 * 
	 * @param phone
	 *            the phone number
	 */
	private void changePhone(String phone) {
		String sql = "update persons set phone = '" + phone
				+ "' where person_id = " + curr_id;

		try {
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Update the user's password
	 * 
	 * @param old_password
	 *            the current password
	 * @param new_password
	 *            the new password
	 * @return error False if there is no error. True otherwise.
	 */
	private boolean changePassword(String old_password, String new_password) {
		boolean error = false;
		// Only do an update if there is input in the new password field
		if (!new_password.equals("")) {
			String sql = "select password from users where person_id = "
					+ curr_id;

			try {
				stmt = conn.createStatement();
				rset = stmt.executeQuery(sql);

				String tpassword = "";
				while (rset != null && rset.next()) {
					tpassword = rset.getString(1);
				}

				// Error if old password doesn't match true password
				if (!old_password.equals(tpassword)) {
					error = true;
				} else {
					sql = "update users set password = '" + new_password
							+ "' where person_id = " + curr_id;

					try {
						stmt.executeUpdate(sql);
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return error;
	}

}
