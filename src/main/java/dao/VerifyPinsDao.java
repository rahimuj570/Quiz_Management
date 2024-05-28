package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.mysql.cj.protocol.Resultset;

import entities.VerifyPin;

public class VerifyPinsDao {
	Connection con;

	public VerifyPinsDao(Connection con) {
		this.con = con;
	}

	public int saveVerifyCode(VerifyPin vpins) {
		int f = 0;
		String query = "insert into verify_pins value(?,?,?,?)";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setLong(1, vpins.getUser_id());
			pst.setString(2, vpins.getPin_code());
			pst.setInt(4, vpins.getIs_for_reset_password());
			pst.setTimestamp(3, new Timestamp(vpins.getExpire_date().getTime()));
			f = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + " in VerifyPinsDAo; line 29");
		}
		return f;
	}

	public VerifyPin getVerifyCode(long user_id) {
		String query = "select * from verify_pins where user_id=" + user_id+" and is_for_reset_password=0";
		VerifyPin pin = null;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			pin = new VerifyPin();
			while (res.next()) {
				pin.setUser_id(res.getLong("user_id"));
				pin.setPin_code(res.getString("pin_code"));
				pin.setExpire_date(res.getTimestamp("expire_date"));
				pin.setIs_for_reset_password(res.getInt("is_for_reset_password"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + " in VerifyPinsDAo; line 51");
		}
		return pin;
	}
	
	public VerifyPin getVerifyCode(long user_id, long is_forgot_pass) {
		String query = "select * from verify_pins where user_id=" + user_id+" and is_for_reset_password=1";
		VerifyPin pin = null;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			pin = new VerifyPin();
			while (res.next()) {
				pin.setUser_id(res.getLong("user_id"));
				pin.setPin_code(res.getString("pin_code"));
				pin.setExpire_date(res.getTimestamp("expire_date"));
				pin.setIs_for_reset_password(res.getInt("is_for_reset_password"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + " in VerifyPinsDAo; line 51");
		}
		return pin;
	}

	public int deleteVerifyCode(long user_id) {
		String query = "delete from verify_pins where user_id=" + user_id;
		int f = 0;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			f = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + " in VerifyPinsDAo; line 64");
		}
		return f;
	}
	
	public int deleteVerifyCode(long user_id, long is_forgot_pass) {
		String query = "delete from verify_pins where user_id=" + user_id+ " and is_for_reset_password=1";
		int f = 0;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			f = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + " in VerifyPinsDAo; line 64");
		}
		return f;
	}
}
