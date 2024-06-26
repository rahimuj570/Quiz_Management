<%@page import="entities.Users"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.QuestionSetsDao"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="entities.Course"%>
<%@page import="entities.QuestionSets"%>
<%@page import="entities.Sections"%>
<%@page import="entities.BatchClass"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Exam</title>
<style>
#question_form {
	display: flex;
	flex-direction: column;
	gap: 10px;
	align-items: center;
	justify-content: center
}

.danger_txt {
	color: red;
	font-weight: bold;
}

.success_txt {
	font-weight: bold;
	color: green;
}

.how {
	background: chartreuse;
	width: 15px;
	display: inline-block;
	height: 18px;
	text-align: center;
	border-radius: 50%;
	font-weight: bold;
	border: 1px solid;
	cursor: help;
	margin-bottom: 2px;
}
</style>
<link rel="stylesheet" type="text/css" href="./teacher.css">
</head>
<body>
	<%
	BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
	QuestionSetsDao qs = new QuestionSetsDao(ConnectionProvider.main());
	Users cu = (Users) session.getAttribute("current_user");
	ArrayList<Sections> sectiponList = bs.getAllSection();
	ArrayList<BatchClass> classList = bs.getAllClass();
	ArrayList<Course> courseList = bs.getAllCourse();
	ArrayList<QuestionSets> qsList = qs.getAllQuestionSet(cu.getUser_id());
	%>
	<form action="<%=request.getContextPath()%>/CreateQuestionServlet"
		method='post' id="question_form" enctype="multipart/form-data">
		<h2>-Create Exam-</h2>
		<%
		if (session.getAttribute("question_create_success") != null) {
		%>
		<p class="success_txt"><%=session.getAttribute("question_create_success")%></p>
		<%
		session.removeAttribute("question_create_success");
		}
		%>
		<%
		if (session.getAttribute("question_create_fail") != null) {
		%>
		<p class="danger_txt"><%=session.getAttribute("question_create_fail")%></p>
		<%
		session.removeAttribute("question_create_fail");
		}
		%>
		<p>
			The fields that have this sign (<span class="danger_txt">*</span>)
			are mandatory to fill out!
		</p>
		<div>
			<label for="exam_name">Exam Name<span class="danger_txt">*</span></label><br />
			<input type="text" required name="exam_name" id="exam_name" />
		</div>
		<hr style="width: 100vh" />
		<div>
			<label for="exam_question_amount">Exam's Question Amount <span
				class='danger_txt'>*</span></label><br /> <input onchange="document.getElementById('per_mark').innerText=document.getElementById('exam_mark').value/document.getElementById('exam_question_amount').value" min='5' value='5' required
				name="exam_question_amount" id="exam_question_amount" type="number" />
		</div>
		<div>
			<label for="exam_mark">Exam's Total Mark <span
				class='danger_txt'>*</span></label><br /> <input onchange="document.getElementById('per_mark').innerText=document.getElementById('exam_mark').value/document.getElementById('exam_question_amount').value" min='5' value='5' required
				name="exam_mark" id="exam_mark" type="number" />
			<p>
				(Per question's mark will be: <span id='per_mark'>1</span>)
			</p>
		</div>

		<hr style="width: 100vh" />
		<div>
			<label for="exam_start">Exam Date <span class='danger_txt'>*</span></label><br />
			<input min="2024-06-21" required name="exam_start" id="exam_start" type="date" />
		</div>
		<div>
			<label for="exam_time">Exam Time <span class='danger_txt'>*</span></label><br />
			<input required name="exam_time" id="exam_time" type="time" />
		</div>
		<div>
			<label for="exam_duration">Exam Duration (in minutes) <span
				class='danger_txt'>*</span></label><br /> <input value='10' min="10"
				required name="exam_duration" id="exam_duration" type="number" />
		</div>

		<hr style="width: 100vh" />

		<div style="display: flex; gap: 30px">

			<div>
				<label for="id">Batch/Class</label><br /> <select name="batch"
					id="batch">
					<%
					for (BatchClass bc : classList) {
					%>
					<option value="<%=bc.getId()%>"><%=bc.getBatchClass()%></option>
					<%
					}
					%>
				</select>
			</div>
			<div>
				<label for="id">Section</label><br /> <select name="section"
					id="section">
					<%
					for (Sections s : sectiponList) {
					%>
					<option value="<%=s.getId()%>"><%=s.getSection()%></option>
					<%
					}
					%>
				</select>
			</div>
		</div>

		<div style="display: flex; gap: 30px">

			<div>
				<label for="id">Course</label><br /> <select name="course"
					id="course">
					<%
					for (Course c : courseList) {
					%>
					<option value="<%=c.getCourse_id()%>"><%=c.getCourse_name()%></option>
					<%
					}
					%>
				</select>
			</div>

			<div>
				<label for="id">Privacy</label><br /> <select name="privacy"
					id="batch">
					<option selected value="0">Public</option>
					<option value="1">Private</option>
				</select>
			</div>
		</div>

		<div>
			<input style="width: 100px; height: 30px" name="btn" id="btn"
				type="submit" value="Create" />
		</div>
	</form>
</body>
</html>