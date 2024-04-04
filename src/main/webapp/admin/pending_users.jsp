<%@page import="entities.Users"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Pending Users</title>
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
	transition: .3s;
}

.nav_ul a {
	text-decoration: none;
	color: black;
}

.nav_ul li:hover {
	background: antiquewhite;
}

.center_txt {
	text-align: center
}

table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

td, th {
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
}

tr:nth-child(even) {
	background-color: #dddddd;
}

.danger_txt {
	color: red;
}

.success_txt {
	color: lime;
}
</style>
</head>
<body>
	<%
	UsersDao u = new UsersDao(ConnectionProvider.main());
	ArrayList<Users> uList = u.getUnapprovedUsers();
	%>
	<nav>
		<ul class="nav_ul">
			<li><a href="#">LOGO</a></li>
			<li><a href="#">Home</a></li>
			<li><a href="pending_users.jsp">Pending Users</a></li>
		</ul>
	</nav>
	<h1 class="center_txt">
		Pending Users (<%=uList.size()%>)
	</h1>
	<%
	if (session.getAttribute("success_approved") != null) {
	%>
	<p class="center_txt success_txt">
		<%=session.getAttribute("success_approved")%>
	</p>
	<%
	session.removeAttribute("success_approved");
	}
	%>
	<%
	if (session.getAttribute("fail_approved") != null) {
	%>
	<p class="center_txt danger_txt">
		<%=session.getAttribute("fail_approved")%>
	</p>
	<%
	session.removeAttribute("fail_approved");
	}
	%>
	<div style="overflow-x: auto;">
		<table>
			<tr>
				<th>ID</th>
				<th>Role</th>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Email</th>
				<th>Approved</th>
				<th>Decline</th>
			</tr>
			<%
			for (Users user : uList) {
			%>
			<tr>
				<td><%=user.getUser_id()%></td>
				<td>
					<%
					if (user.getUser_is_teacher() == 0) {
					%>Student<%
					} else {
					%>Teacher<%
					}
					%>
				</td>
				<td><%=user.getUser_first_name()%></td>
				<td><%=user.getUser_last_name()%></td>
				<td><%=user.getUser_email()%></td>
				<td><button style="background: lime">
						<a
							href="<%=request.getContextPath()%>/ApprovedUserServlet?user_id=<%=user.getUser_id()%>">Accept</a>
					</button></td>
				<td><button style="background: #ffc6c6">Reject</button></td>
			</tr>
			<%
			}
			%>

		</table>
	</div>
</body>
</html>