<%@page import="entities.Exams"%>
<%@page import="entities.QuestionSets"%>
<%@page import="entities.Users"%>
<%@page import="dao.ExamsDao"%>
<%@page import="entities.Course"%>
<%@page import="entities.BatchClass"%>
<%@page import="entities.Sections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.BatchSectionDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Show Exam</title>
<link rel="stylesheet" type="text/css" href="teacher.css">
<style type="text/css">
label {
	padding: 0 10px 0 18px;
}
</style>
</head>

<%
BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
ArrayList<Sections> sectiponList = bs.getAllSection();
ArrayList<BatchClass> classList = bs.getAllClass();
ArrayList<Course> courseList = bs.getAllCourse();

ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
Users cu = (Users) session.getAttribute("current_user");
ArrayList<Exams> examList = eDao.getAllExamById(cu.getUser_id());
BatchSectionDao bsDao = new BatchSectionDao(ConnectionProvider.main());
%>

<body>

	<%
	if (session.getAttribute("create_exam_OK") != null) {
	%>
	<p class="center_txt success_txt"><%=session.getAttribute("create_exam_OK")%></p>
	<%
	session.removeAttribute("create_exam_OK");
	}
	%>
	<%
	if (session.getAttribute("update_exam_OK") != null) {
	%>
	<p class="center_txt success_txt"><%=session.getAttribute("update_exam_OK")%></p>
	<%
	session.removeAttribute("update_exam_OK");
	}
	%>
	<%
	if (session.getAttribute("qs_delete_OK") != null) {
	%>
	<p class="center_txt success_txt"><%=session.getAttribute("qs_delete_OK")%></p>
	<%
	session.removeAttribute("qs_delete_OK");
	}
	%>

	<form
		style="margin: 20px 0px; border: 3px solid lime; padding: 10px 0px"
		action="<%=request.getContextPath()%>/CreateQuestionSetServlet"
		method="post">
		<label for="qs_name">Set Name</label> <input id="qs_name"
			name="qs_name" type="text" /> <label for="id">Course</label><select
			name="course" id="course">
			<%
			for (Course c : courseList) {
			%>
			<option value="<%=c.getCourse_id()%>"><%=c.getCourse_name()%></option>
			<%
			}
			%>
		</select> <label for="id">Batch</label><select name="batch" id="batch">
			<%
			for (BatchClass bc : classList) {
			%>
			<option value="<%=bc.getId()%>"><%=bc.getBatchClass()%></option>
			<%
			}
			%>
		</select> <label for="id">Section</label><select name="section" id="section">
			<%
			for (Sections s : sectiponList) {
			%>
			<option value="<%=s.getId()%>"><%=s.getSection()%></option>
			<%
			}
			%>
		</select>
		<button style="margin-left: 10px; background: cyan">Create
			Question Set</button>
		<%
		if (session.getAttribute("qs_create_success") != null) {
		%>
		<span class="success_txt"><%=session.getAttribute("qs_create_success")%></span>
		<%
		session.removeAttribute("qs_create_success");
		}
		%>
		<%
		if (session.getAttribute("qs_create_fail") != null) {
		%>
		<span class="success_txt"><%=session.getAttribute("qs_create_fail")%></span>
		<%
		session.removeAttribute("qs_create_fail");
		}
		%>
	</form>
	<div style="overflow-x: auto;">
		<table>
			<tr>
				<th>ID</th>
				<th>Exam Name</th>
				<th>Course</th>
				<th>Batch</th>
				<th>Section</th>
				<th>Total Questions</th>
				<th>Exam Mark</th>
				<th>Exam Start</th>
				<th>Privacy</th>
				<th>Approved by Admin</th>
				<th>Edit</th>
				<th>Delete</th>
			</tr>
			<%
			for (Exams e : examList) {
			%>
			<tr>
				<td><%=e.getExam_id()%></td>
				<td><%=e.getExam_name()%></td>
				<td><%=bsDao.getCourseNameById(e.getExam_course())%></td>
				<td><%=bsDao.getBatchNameById(e.getExam_batch())%></td>
				<td><%=bsDao.getSectionNameById(e.getExam_section())%></td>
				<td><%=e.getExam_question_amount()%>
				<td><%=e.getExam_marks()%>
				<td><%=e.getExam_start()%>
				<td><%=e.getExam_privacy()==0?"Public":"Protected"%></td>
				<td><%=e.getExam_isApproved()==1?"YES":"NO"%></td>
				<td>
					<button style="background: #ffc6c6">
						<a
							href="<%=request.getContextPath()%>/teacher/edit_exam.jsp?exam_id=<%=e.getExam_id()%>">Edit</a>
					</button>
				</td>
				<td>
					<button style="background: #ffc6c6">
						<a
							href="<%=request.getContextPath()%>">Delete</a>
					</button>
				</td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
</body>
</html>