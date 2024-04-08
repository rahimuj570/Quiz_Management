
<%@page import="javax.print.attribute.standard.Media"%>
<nav>
	<ul class="nav_ul">
		<li><a href="#">LOGO</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/dashboard.jsp">Home</a></li>
		<li><a href="pending_users.jsp">Pending Users</a></li>
		<li><a href="show_teachers.jsp">Show Teachers</a></li>
		<li><a href="show_students.jsp">Show Student</a></li>
		<li><a href="show_admins.jsp">Show Administrators</a></li>
		<%
		if (me.getUser_is_admin() == 1) {
		%>
		<li><a href="<%=request.getContextPath()%>/admin/dashboard.jsp">Switch
				to Admin Privilege</a></li>
		<%
		}
		%>
		<li><a href="<%=request.getContextPath()%>/LogoutServlet">LOGOUT</a></li>
	</ul>
</nav>