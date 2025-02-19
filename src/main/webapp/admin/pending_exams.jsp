<%@page import="java.util.Date"%>
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
<title>Pending Exams</title>
<link rel="stylesheet" type="text/css" href="admin.css">
<style type="text/css">
label {
	padding: 0 10px 0 18px;
}
</style>
</head>

<%
BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
Users cu = (Users) session.getAttribute("current_user");
ArrayList<Exams> examList = eDao.getPendingExam();
BatchSectionDao bsDao = new BatchSectionDao(ConnectionProvider.main());
%>

<body>
	<%@include file="admin_nav.jsp"%>
	<div
		style="text-align: center; margin: 20px 0px; ">

		<%
		if (session.getAttribute("permission_OK") != null) {
		%>
		<span class="center_txt success_txt"><%=session.getAttribute("permission_OK")%></span>
		<%
		session.removeAttribute("permission_OK");
		}
		%>
		<%
		if (session.getAttribute("update_exam_OK") != null) {
		%>
		<span class="center_txt success_txt"><%=session.getAttribute("update_exam_OK")%></span>
		<%
		session.removeAttribute("update_exam_OK");
		}
		%>
		<%
		if (session.getAttribute("update_exam_401") != null) {
		%>
		<span class="center_txt danger_txt"><%=session.getAttribute("update_exam_401")%></span>
		<%
		session.removeAttribute("update_exam_401");
		}
		%>

		<%
		if (session.getAttribute("delete_exam_OK") != null) {
		%>
		<span class="center_txt success_txt"><%=session.getAttribute("delete_exam_OK")%></span>
		<%
		session.removeAttribute("delete_exam_OK");
		}
		%>

	</div>
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
				<th>Exam Duration</th>
				<th>Exam Over</th>
				<th>Approved</th>
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
				<td><%=e.getExam_duration()%>
				<td>
					<%
					if (e.getExam_end().before(new Date(new Date().getTime())))
						out.print("Yes");
					else
						out.print("No");
					%>
				
				<td>
				
				<%
				if(e.getExam_privacy()==0){%>
				<button style="background: cyan">
						<a
							href="<%=request.getContextPath()%>/ApprovedAllStudent?exam_id=<%=e.getExam_id()%>">Approved</a>
					</button>
					
				<%}else{
				%>
					<button style="background: cyan">
						<a
							href="<%=request.getContextPath()%>/admin/select_students.jsp?exam_id=<%=e.getExam_id()%>">Approved</a>
					</button>
					<%} %>
				</td>

			</tr>
			<%
			}
			%>
		</table>
	</div>
	<script src="./admin.js"></script>
</body>
</html>