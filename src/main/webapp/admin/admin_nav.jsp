
<%@page import="entities.Users"%>
<nav>
	<ul class="nav_ul">
		<li><a href="#">LOGO</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/dashboard.jsp">Home</a></li>
		<li><a href="pending_users.jsp">Pending Users</a></li>
		<li><a href="show_teachers.jsp">Show Teachers</a></li>
		<li><a href="show_students.jsp">Show Student</a></li>
		<li><a href="show_admins.jsp">Show Administrators</a></li>
		<%
		Users me = (Users) session.getAttribute("current_user");
		if (me.getUser_is_teacher() == 1) {
		%>
		<li><a href="<%=request.getContextPath()%>/teacher/dashboard.jsp">Switch
				to Teacher Privilege</a></li>
		<%
		}
		%>
		<li><a href="<%=request.getContextPath()%>/LogoutServlet">LOGOUT</a></li>
	</ul>
</nav>