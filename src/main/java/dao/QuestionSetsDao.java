package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import entities.QuestionSets;

public class QuestionSetsDao {
	Connection con;

	public QuestionSetsDao(Connection con) {
		this.con = con;
	}

	public ArrayList<QuestionSets> getAllQuestionSet(Long uid) {
		ArrayList<QuestionSets> setList = new ArrayList<QuestionSets>();
		String query = "select * from question_sets where qs_teacher=" + uid+" order by qs_id desc";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				QuestionSets qs = new QuestionSets();
				qs.setQs_batch(res.getInt("qs_batch"));
				qs.setQs_course(res.getInt("qs_course"));
				qs.setQs_created(res.getTimestamp("qs_created"));
				qs.setQs_id(res.getInt("qs_id"));
				qs.setQs_name(res.getString("qs_name"));
				qs.setQs_teacher(res.getLong("qs_teacher"));
				qs.setQs_section(res.getInt("qs_section"));
				setList.add(qs);
			}
		} catch (SQLException e) {
			System.out.println(e + " in QuestionSetsDao; gellAllQSet methon; line 36");
		}
		return setList;
	}
	public ArrayList<QuestionSets> getAllQuestionSet(Long uid, String courseId, String batchhId) {
		ArrayList<QuestionSets> setList = new ArrayList<QuestionSets>();
		String query = "select * from question_sets where qs_teacher=" + uid+" and qs_course="+courseId+" and qs_batch="+batchhId+" order by qs_id desc";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				QuestionSets qs = new QuestionSets();
				qs.setQs_batch(res.getInt("qs_batch"));
				qs.setQs_course(res.getInt("qs_course"));
				qs.setQs_created(res.getTimestamp("qs_created"));
				qs.setQs_id(res.getInt("qs_id"));
				qs.setQs_name(res.getString("qs_name"));
				qs.setQs_teacher(res.getLong("qs_teacher"));
				qs.setQs_section(res.getInt("qs_section"));
				setList.add(qs);
			}
		} catch (SQLException e) {
			System.out.println(e + " in QuestionSetsDao; gellAllQSet methon; line 36");
		}
		return setList;
	}

	public QuestionSets getQuestionSetById(String qs_id) {
		QuestionSets qs = new QuestionSets();
		String query = "select * from question_sets where qs_id=" + qs_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				qs.setQs_batch(res.getInt("qs_batch"));
				qs.setQs_course(res.getInt("qs_course"));
				qs.setQs_created(res.getTimestamp("qs_created"));
				qs.setQs_id(res.getInt("qs_id"));
				qs.setQs_name(res.getString("qs_name"));
				qs.setQs_teacher(res.getLong("qs_teacher"));
				qs.setQs_section(res.getInt("qs_section"));
			}
		} catch (SQLException e) {
			System.out.println(e + " in QuestionSetsDao; gellQSet methon; line 58");
		}
		return qs;
	}
	public Long getTeacherOfQuestionSetId(String qs_id) {
		Long teacherId = null;
		String query = "select qs_teacher from question_sets where qs_id=" + qs_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				teacherId=res.getLong(1);
			}
		} catch (SQLException e) {
			System.out.println(e + " in QuestionSetsDao; gellTeacherIDQSet method; line 94");
		}
		return teacherId;
	}

	public int getTotalQuestionAmount(int id) {
		int amount = 0;
		String query = "select count(*) from question_set_to_question_relation where qs_id=" + id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			amount = res.next() ? res.getInt(1) : 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return amount;
	}

	public int createQuestionSet(QuestionSets qs) {
		int f = 0;
		String query = "insert into question_sets (qs_name,qs_teacher, qs_section, qs_batch, qs_course,qs_created) value (?,?,?,?,?,?)";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, qs.getQs_name());
			pst.setLong(2, qs.getQs_teacher());
			pst.setInt(3, qs.getQs_section());
			pst.setInt(4, qs.getQs_batch());
			pst.setInt(5, qs.getQs_course());
			pst.setTimestamp(6, new Timestamp(qs.getQs_created().getTime()));
			f = pst.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e + " QuestionSetDao; method createQuestionSet; line 67");
		}
		return f;
	}

	public int addToQuestionSet(String qs_id, String q_ids[]) {
		int f = 0;
		try {
			for (String s : q_ids) {
				String query = "insert into  question_set_to_question_relation values (" + s + "," + qs_id + ")";
				PreparedStatement pst = con.prepareStatement(query);
				f = pst.executeUpdate();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return f;
	}

	public int removeToQuestionSet(String qs_id, String q_id) {
		int f = 0;
		String query = "delete from question_set_to_question_relation where q_id=" + q_id + " and qs_id=" + qs_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			f = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return f;
	}
	
	public int deleteQuestionSetById(String qs_id) {
		int f = 0;
		try {
			con.setAutoCommit(false);
			String query = "delete from question_set_to_question_relation where qs_id="+qs_id;
			PreparedStatement pst = con.prepareStatement(query);
			f = pst.executeUpdate();
			pst.close();
			if(f!=0) {	
				System.out.println(22222);
				//if(!pst.isClosed())pst.close();
				query = "delete from question_sets where qs_id="+qs_id;
				PreparedStatement pst2 = con.prepareStatement(query);
//				pst = con.prepareStatement(query);
				f = pst2.executeUpdate();
				pst.close();
				con.commit();
			}
		} catch (SQLException e) {
			System.out.println(3333);
			f = 0;
			try {
				con.rollback();
				con.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			// TODO Auto-generated catch block
			System.out.println(e + "QuestionDao;" + " line 198");
		}
		
		return f;
	}
}
