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
			pst.setLong(1, u.getUser_id());
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
				pst.setString(1, email_id);
			} else {
				pst = con.prepareStatement(query_id);
				pst.setLong(1, Long.parseLong(email_id));
			}
			pst.setString(2, password);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				u = new Users();
				u.setUser_first_name(res.getString("user_first_name"));
				u.setUser_last_name(res.getString("user_last_name"));
				u.setUser_id(res.getLong("user_id"));
				u.setUser_email(res.getString("user_email"));
				u.setUser_password(res.getString("user_password"));
				u.setUser_is_teacher(res.getInt("user_is_teacher"));
				u.setUser_is_admin(res.getInt("user_is_admin"));
				u.setUser_is_approved(res.getInt("user_is_approved"));
				u.setUser_is_varified(res.getInt("user_is_verify"));
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

				// System.out.println(res.getLong("user_id"));
				u.setUser_id(res.getLong("user_id"));
				u.setUser_first_name(res.getString("user_first_name"));
				u.setUser_last_name(res.getString("user_last_name"));
				u.setUser_is_teacher(res.getInt("user_is_teacher"));
				// System.out.println(u.getUser_id());
				uList.add(u);
			}

		} catch (SQLException e) {
			System.out.println(e + "from usersDao ; method getUnapproved; line 94");
		}
		return uList;
	}

	public int approvedUser(Long user_id) {
		String query = "update users set user_is_approved=1 where user_id=?";
		int f = 0;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setLong(1, user_id);
			f = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + "from userDao; method approbvedUser; lne 105");
		}
		return f;
	}

	public int declineUser(Long user_id) {
		String query = "delete from users where user_id=?";
		int f = 0;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setLong(1, user_id);
			f = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + "from userDao; method declineUser; line 119");
		}
		return f;
	}

	public ArrayList<Users> getUsersList(int role) {
		// role:=> 0=admin; 1=teacher; 2=student;
		ArrayList<Users> uList = new ArrayList<Users>();
		Users u = null;
		String query;
		if (role == 1)
			query = "select * from users where user_is_teacher=1 and user_is_approved=1";
		else if (role == 2)
			query = "select * from users where user_is_teacher=0 and user_is_admin=0 and user_is_approved=1";
		else
			query = "select * from users where user_is_admin=1";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				u = new Users();
				u.setUser_email(res.getString("user_email"));
				u.setUser_id(res.getLong("user_id"));
				u.setUser_first_name(res.getString("user_first_name"));
				u.setUser_last_name(res.getString("user_last_name"));
				u.setUser_is_teacher(res.getInt("user_is_teacher"));
				u.setUser_is_admin(res.getInt("user_is_admin"));
				uList.add(u);
			}

		} catch (SQLException e) {
			System.out.println(e + "from usersDao ; method getUsersList; line 146");
		}
		return uList;
	}

	public int makeAdmin(Long user_id) {
		String query = "update users set user_is_admin=1 where user_id=?";
		int f = 0;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setLong(1, user_id);
			f = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + "from userDao; method makeAdmin; lne 160");
		}
		return f;
	}

	public int removeAdmin(Long user_id) {
		String query = "update users set user_is_admin=0 where user_id=?";
		int f = 0;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setLong(1, user_id);
			f = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + "from userDao; method removeAdmin; line 178");
		}
		return f;
	}

	public int verifiedUser(Long user_id) {
		String query = "update users set user_is_verify=1 where user_id=?";
		int f = 0;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setLong(1, user_id);
			f = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + "from userDao; method verifiedUser; lne 196");
		}
		return f;
	}

	public String checkExistUser(long user_id) {
		String f = null;
		String query = "select user_email as email from users where user_id=" + user_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				f = res.getString("email");
			}
		} catch (SQLException e) {
			System.out.println(e + " UsersDao ; method existUser; line 211");
		}
		return f;
	}
	public Users getUserByEmail(String email) {
		Users u=new Users();
		String query = "select user_id, user_email, user_is_approved from users where user_email=?";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, email);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				u.setUser_email(res.getString("user_email"));
				u.setUser_is_approved(res.getInt("user_is_approved"));
				u.setUser_id(res.getLong("user_id"));
			}
		} catch (SQLException e) {
			System.out.println(e + " UsersDao ; method getUserByEmail; line 227");
		}
		return u;
	}
	
	public int editPassword(long id, String password) {
		int f = 0;
		String query="update users set user_password=? where user_id=?";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setLong(2, id);
			pst.setString(1, password);
			f = pst.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e + " UsersDao ; method editPassword; line 243");
		}
		return f;
	}

}
