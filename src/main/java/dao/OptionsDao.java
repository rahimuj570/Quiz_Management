package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entities.Options;

public class OptionsDao {
	Connection con;

	public OptionsDao(Connection con) {
		super();
		this.con = con;
	}

	public ArrayList<Options> getAllOptionsByQid(int q_id, int wrong, int right) {
		ArrayList<Options> optList = new ArrayList<Options>();
		String query = "select * from options where opt_question=" + q_id;
		if (wrong != 0)
			query = "select * from options where opt_isAnswer=0 and opt_question=" + q_id;
		if (right != 0)
			query = "select * from options where opt_isAnswer=1 and opt_question=" + q_id;
		if (right != 0 && wrong != 0)
			query = "select * from options where opt_question=" + q_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				Options opt = new Options();
				opt.setIsAnswer(res.getInt("opt_isAnswer"));
				opt.setOpt_id(res.getInt("opt_id"));
				opt.setOpt_question(res.getInt("opt_question"));
				opt.setOpt_text(res.getString("opt_text"));
				optList.add(opt);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + " OptionDao; line 41");
		}
		return optList;
	}
}
