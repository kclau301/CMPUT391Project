package Db;
import java.sql.*;

public class Database {

	private Connection conn;
	private String username;
	private String password;

	public Database() {
		conn = null;

		// TODO: add username/password details once we setup the account
		username = "";
		password = "";
	}

    public void connect() {
   		String driverName = "oracle.jdbc.driver.OracleDriver";
    	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

    	try {
			//load and register the driver
        	Class drvClass = Class.forName(driverName); 
	        DriverManager.registerDriver((Driver) drvClass.newInstance());
	    }
	    catch(Exception ex) {
		    System.out.println("<hr>" + ex.getMessage() + "<hr>");
		}

		try{
	    	//establish the connection 
		    conn = DriverManager.getConnection(dbstring,"your_user_id","your_pass_word");
        	conn.setAutoCommit(false);
	    }
        catch(Exception ex){
        	System.out.println("<hr>" + ex.getMessage() + "<hr>");
        }
    }

    public Connection getConnection() {
    	return conn;
    }

}