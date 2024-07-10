<%@page import="entities.Exams"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.ExamsDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Select Students</title>
<link rel="stylesheet" type="text/css" href="admin.css">
</head>
<body>
	<%
	ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
	Exams e = eDao.getExamById(request.getParameter("exam_id"));
	%>
	<%@include file="admin_nav.jsp"%>
	<h1>
		You need to provide the eligible students IDs, because the exam (ID:<%=e.getExam_id()%>;
		Name:<%=e.getExam_name()%>) is protected!
	</h1>
	<form style="text-align: center;"
		action="<%=request.getContextPath()%>/ApprovedExamServlet"
		method="post" enctype="multipart/form-data">
		<%
		if (session.getAttribute("no_list_added") != null) {
		%>
		<p class="danger_txt"><%=session.getAttribute("no_list_added")%></p>
		<%
		session.removeAttribute("no_list_added");
		}
		%>
		<%
		if (session.getAttribute("permission_BAD") != null) {
		%>
		<p class="danger_txt"><%=session.getAttribute("permission_BAD")%></p>
		<%
		session.removeAttribute("permission_BAD");
		}
		%>
		<input type="hidden"
			value="<%=request.getParameter("exam_id")%>" name="exam_id"/> <label
			for="id_list">Provide student IDs separated by comma(,). Ex:
			221010020,221010021, ...</label><br />
		<textarea name="id_list" id="id_list" rows="10" cols="100%"></textarea>
		<div style="display: flex; margin: 10px 0px">
			<hr style="width: 100%" />
			OR
			<hr style="width: 100%" />
		</div>
		<label for="csv_file">Provide CSV file of student IDs.</label><br />
		<input type="file" name="csv_file" id="csv_file" /><br />
		<div style="text-align: center; margin: 20px 0 0 0">
			<button>Approved</button>
		</div>
	</form>
</body>
</html>