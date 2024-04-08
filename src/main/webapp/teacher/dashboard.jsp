<%@page import="entities.Users"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dashboard - Teacher</title>
<link rel="stylesheet" type="text/css" href="./teacher.css">
</head>
<body>
	<%Users me = (Users)session.getAttribute("current_user"); %>
	<%@include file="./teacher_nav.jsp"%>
	<h2 class="center_txt">Teacher Dashboard</h2>
</body>
</html>