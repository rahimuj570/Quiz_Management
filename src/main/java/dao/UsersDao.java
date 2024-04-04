package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entities.Users;

public class UsersDao {
	Connection con;

	public UsersDao(Connection con) {
		super();
		this.con = con;
	}

	public int saveUser(Users u) {
		int f = 0;
		String query = "insert into users (user_id,user_first_name,user_last_name,user_email,user_password,user_is_teacher,user_is_admin,user_is_approved) value(?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setInt(1, u.getUser_id());
			pst.setString(2, u.getUser_first_name());
			pst.setString(3, u.getUser_last_name());
			pst.setString(4, u.getUser_email());
			pst.setString(5, u.getUser_password());
			pst.setInt(6, u.getUser_is_teacher());
			pst.setInt(7, u.getUser_is_admin());
			pst.setInt(8, u.getUser_is_approved());
			pst.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + "from userDao; line 34");
			f = e.getErrorCode();
		}
		return f;
	}

	public Users getUser(String through, String email_id, String password) {
		Users u = null;
		String query_mail = "select * from users where user_email=? and user_password=?";
		String query_id = "select * from users where user_id=? and user_password=?";
		try {
			PreparedStatement pst;
			if (through.equals("email")) {
				pst = con.prepareStatement(query_mail);
			} else {
				pst = con.prepareStatement(query_id);
			}
			pst.setString(1, email_id);
			pst.setString(2, password);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				u = new Users();
				u.setUser_first_name(res.getString("user_first_name"));
				u.setUser_last_name(res.getString("user_last_name"));
				u.setUser_id(res.getInt("user_id"));
				u.setUser_email(res.getString("user_email"));
				u.setUser_password(res.getString("user_password"));
				u.setUser_is_teacher(res.getInt("user_is_teacher"));
				u.setUser_is_admin(res.getInt("user_is_admin"));
				u.setUser_is_approved(res.getInt("user_is_approved"));
			}
		} catch (SQLException e) {
			System.out.println(e + "from usersDao; line 67");
		}
		return u;
	}

	public ArrayList<Users> getUnapprovedUsers() {
		ArrayList<Users> uList = new ArrayList<Users>();
		Users u = null;
		String query = "select user_id, user_email, user_first_name,user_last_name,user_is_teacher from users where user_is_approved=0";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				u = new Users();
				u.setUser_email(res.getString("user_email"));
				u.setUser_id(res.getInt("user_id"));
				u.setUser_first_name(res.getString("user_first_name"));
				u.setUser_last_name(res.getString("user_last_name"));
				u.setUser_is_teacher(res.getInt("user_is_teacher"));
				uList.add(u);
			}

		} catch (SQLException e) {
			System.out.println(e + "from usersDao ; method getUnapproved; line 94");
		}
		return uList;
	}
}
