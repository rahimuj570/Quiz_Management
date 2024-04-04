package helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {
	public static Connection con;
	public static Connection main() {        
		if(con==null) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizemanagement2","root","root");
		} catch (Exception e) {
			System.out.println(e + "~~~from ConnectionProvider Class; line 14");
		}	
		}
		return con;
	}
}
