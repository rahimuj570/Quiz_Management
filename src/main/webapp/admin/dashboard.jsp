<%@page import="entities.Users"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dashboard - Admin</title>
<link rel="stylesheet" type="text/css" href="admin.css">
</head>
<body>
	<%Users me = (Users)session.getAttribute("current_user"); %>
	<%@include file="admin_nav.jsp" %>
	<center><h1>ADMIN DASHBOARD</h1></center>
</body>
</html>