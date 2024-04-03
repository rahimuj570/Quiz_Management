<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dashboard - Admin</title>
<style type="text/css">
.nav_ul {
	display: flex;
	list-style: none;
	gap: 10px;
	border-bottom: 2px solid cyan;
	padding: 2px;
	border-radius: 10px;
}

.nav_ul li {
	border: 2px solid cyan;
	padding: 2px 5px;
	border-radius: 5px;
	transition:.3s;
}
.nav_ul a {
	text-decoration: none;
	color:black;
}
.nav_ul li:hover {
background: antiquewhite;
}
</style>
</head>
<body>
	<nav>
		<ul class="nav_ul">
			<li><a href="#">LOGO</a></li>
			<li><a href="#">Home</a></li>
			<li><a href="#">Pending Users</a></li>
		</ul>
	</nav>
	<center><h1>ADMIN DASHBOARD</h1></center>
</body>
</html>