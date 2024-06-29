package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.mysql.cj.xdevapi.PreparableStatement;

import entities.Exams;
import entities.QuestionSets;
import helper.ConnectionProvider;

public class ExamsDao {

	Connection con;

	public ExamsDao(Connection con) {
		this.con = con;
	}

	public int createExam(Exams e, String s[]) {
		int f = 0;
		try {
			con.setAutoCommit(false);
			String query = "INSERT INTO exams (exam_name, exam_teacher, exam_batch, exam_section, exam_course, exam_privacy, exam_duration, exam_question_amount, exam_mark, exam_start, exam_end, exam_isOver, exam_isApproved) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement pst = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			pst.setString(1, e.getExam_name());
			pst.setLong(2, e.getExam_teacher());
			pst.setInt(3, e.getExam_batch());
			pst.setInt(4, e.getExam_section());
			pst.setInt(5, e.getExam_course());
			pst.setInt(6, e.getExam_privacy());
			pst.setInt(7, e.getExam_duration());
			pst.setInt(8, e.getExam_question_amount());
			pst.setInt(9, e.getExam_marks());
			pst.setTimestamp(10, new Timestamp(e.getExam_start().getTime()));
			pst.setTimestamp(11, new Timestamp(e.getExam_end().getTime()));
			pst.setInt(12, e.getExam_isOver());
			pst.setInt(13, e.getExam_isApproved());
			f = pst.executeUpdate();

			QuestionSetsDao qsDao = new QuestionSetsDao(ConnectionProvider.main());

			if (f == 0) {
				con.rollback();
				return 0;
			} else {
				ResultSet res = pst.getGeneratedKeys();
				int exam_id = res.next() ? res.getInt(1) : 0;
				pst.close();
				for (String qs : s) {
					query = "insert into exam_to_question_set_relation values(?,?)";
					pst = con.prepareStatement(query);
					pst.setInt(1, exam_id);
					pst.setInt(2, Integer.parseInt(qs));
					if (e.getExam_teacher().toString().equals(qsDao.getTeacherOfQuestionSetId(qs).toString())) {
						f = pst.executeUpdate();
						if (f == 0) {
							con.rollback();
							return 0;
						}
					}
					;
				}
				con.commit();
				con.close();
			}
		} catch (SQLException e1) {
			System.out.println(e1 + " ExamsDao; method CreateExam; line 70");
		}
		return f;
	}

	public ArrayList<Exams> getAllExamById(Long uid) {
		ArrayList<Exams> examList = new ArrayList<Exams>();
		String query = "select * from exams where exam_teacher=" + uid + " order by exam_id desc";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				Exams e = new Exams();
				e.setExam_batch(res.getInt("exam_batch"));
				e.setExam_course(res.getInt("exam_course"));
				e.setExam_duration(res.getInt("exam_duration"));
				e.setExam_end(res.getTimestamp("exam_end"));
				e.setExam_id(res.getInt("exam_id"));
				e.setExam_isApproved(res.getInt("exam_isApproved"));
				e.setExam_isOver(res.getInt("exam_isOver"));
				e.setExam_marks(res.getInt("exam_mark"));
				e.setExam_name(res.getString("exam_name"));
				e.setExam_privacy(res.getInt("exam_privacy"));
				e.setExam_question_amount(res.getInt("exam_question_amount"));
				e.setExam_section(res.getInt("exam_section"));
				e.setExam_start(res.getTimestamp("exam_start"));
				e.setExam_teacher(res.getLong("exam_teacher"));
				examList.add(e);
			}
		} catch (SQLException e) {
			System.out.println(e + " in ExamsDao; gellAllExamById methon; line 103");
		}
		return examList;
	}

	public Exams getExamById(String id) {
		String query = "select * from exams where exam_id=" + id;
		Exams e = new Exams();
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				e.setExam_batch(res.getInt("exam_batch"));
				e.setExam_course(res.getInt("exam_course"));
				e.setExam_duration(res.getInt("exam_duration"));
				e.setExam_end(res.getTimestamp("exam_end"));
				e.setExam_id(res.getInt("exam_id"));
				e.setExam_isApproved(res.getInt("exam_isApproved"));
				e.setExam_isOver(res.getInt("exam_isOver"));
				e.setExam_marks(res.getInt("exam_mark"));
				e.setExam_name(res.getString("exam_name"));
				e.setExam_privacy(res.getInt("exam_privacy"));
				e.setExam_question_amount(res.getInt("exam_question_amount"));
				e.setExam_section(res.getInt("exam_section"));
				e.setExam_start(res.getTimestamp("exam_start"));
				e.setExam_teacher(res.getLong("exam_teacher"));
			}
		} catch (SQLException exc) {
			System.out.println(exc + " in ExamsDao; getAllExamById method; line 130");
		}
		return e;
	}

	public ArrayList<Integer> getAllQuestionSetById(String exam_id) {
		ArrayList<Integer> qs = new ArrayList<Integer>();
		String query = "select qs_id from exam_to_question_set_relation where exam_id=" + exam_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				qs.add(res.getInt(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + " in ExamsDao; getAllQuestioSetId method; line 146");
		}
		return qs;
	}
	
	
	public int updateExam(Exams e, String s[]) {
		int f = 0;
		try {
			con.setAutoCommit(false);
			String query = "update exams SET exam_name=?, exam_teacher=?, exam_batch=?, exam_section=?, exam_course=?, exam_privacy=?, exam_duration=?, exam_question_amount=?, exam_mark=?, exam_start=?, exam_end=?, exam_isOver=?, exam_isApproved=? where exam_id=?";
			PreparedStatement pst = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			pst.setString(1, e.getExam_name());
			pst.setLong(2, e.getExam_teacher());
			pst.setInt(3, e.getExam_batch());
			pst.setInt(4, e.getExam_section());
			pst.setInt(5, e.getExam_course());
			pst.setInt(6, e.getExam_privacy());
			pst.setInt(7, e.getExam_duration());
			pst.setInt(8, e.getExam_question_amount());
			pst.setInt(9, e.getExam_marks());
			pst.setTimestamp(10, new Timestamp(e.getExam_start().getTime()));
			pst.setTimestamp(11, new Timestamp(e.getExam_end().getTime()));
			pst.setInt(12, e.getExam_isOver());
			pst.setInt(13, e.getExam_isApproved());
			pst.setInt(14, e.getExam_id());
			f = pst.executeUpdate();

			QuestionSetsDao qsDao = new QuestionSetsDao(ConnectionProvider.main());

			if (f == 0) {
				con.rollback();
				return 0;
			} else {
				pst.close();
				f = deleteExams_QuestionSet_relation(e.getExam_id(), pst);
				pst.close();
				if(f==0) {
					con.rollback();
					return 0;
				}
				
				for (String qs : s) {
					query = "insert into exam_to_question_set_relation values(?,?)";
					pst = con.prepareStatement(query);
					pst.setInt(1, e.getExam_id());
					pst.setInt(2, Integer.parseInt(qs));
					if (e.getExam_teacher().toString().equals(qsDao.getTeacherOfQuestionSetId(qs).toString())) {
						f = pst.executeUpdate();
						if (f == 0) {
							con.rollback();
							return 0;
						}
					}
					;
				}
				con.commit();
				con.close();
			}
		} catch (SQLException e1) {
			System.out.println(e1 + " ExamsDao; method UpdateExam; line 205");
		}
		return f;
	}

	private int deleteExams_QuestionSet_relation(int exam_id, PreparedStatement pst) {
		int f = 0;
		String query = "delete from exam_to_question_set_relation where exam_id="+exam_id;
		try {
			con.setAutoCommit(false);
			pst = con.prepareStatement(query);
			f = pst.executeUpdate();
		} catch (SQLException e) {
			f = 0;
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return f;
	}
	
	public int deleteExam(int exam_id) {
		int f = 0;
		try {
			con.setAutoCommit(false);
			PreparedStatement pst = null;
			f = deleteExams_QuestionSet_relation(exam_id, pst);
			if(f==0) {
				pst.close();
				con.rollback();
				return f;
			}else {
				pst.close();
				String query = "delete from exams where exam_id="+exam_id;
				pst = con.prepareStatement(query);
				f = pst.executeUpdate();
				if(f==0) {
					pst.close();
					con.rollback();
					return f;
				}
				pst.close();
				con.commit();
			}
		} catch (SQLException e) {
			f=0;
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			System.out.println(e+" ExamsDao; deleteExam method; line 257");

		}
		return f;
	}

}
