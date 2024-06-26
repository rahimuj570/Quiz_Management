package helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionProvider {
	public static Connection con;
	public static Connection main() {        
		try {
			if(con==null || con.isClosed()) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizemanagement2","root","root");
			} catch (Exception e) {
				System.out.println(e + "~~~from ConnectionProvider Class; line 14");
			}	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}
}
