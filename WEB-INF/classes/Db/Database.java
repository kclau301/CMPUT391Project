package db;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;

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
   		// Use this dbstring to connect to the campus databases from home
   		String dbstring = "jdbc:oracle:thin:@localhost:1525:CRS";
    	//String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

    	try {
			//load and register the driver
        	Class drvClass = Class.forName(driverName); 
	        DriverManager.registerDriver((Driver) drvClass.newInstance());
	    } catch(Exception e) {
		    System.out.println("<hr>" + e.getMessage() + "<hr>");
		}

		try {
	    	//establish the connection 
		    conn = DriverManager.getConnection(dbstring, username, password);
        	conn.setAutoCommit(false);
	    } catch(Exception e) {
        	System.out.println("<hr>" + e.getMessage() + "<hr>");
        }
    }

    public Connection getConnection() {
    	return conn;
    }
    
    public void close() {
    	try{
    		conn.close();
    	}
    	catch(Exception e) {
    		System.out.println("<hr>" + e.getMessage() + "<hr>");
    	}
    }
    
}