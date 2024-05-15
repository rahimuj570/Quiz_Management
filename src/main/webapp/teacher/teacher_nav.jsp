
<%@page import="entities.Users"%>
<nav>
	<ul class="nav_ul">
		<li><a href="#">LOGO</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/dashboard.jsp">Home</a></li>
		<li><a href="pending_users.jsp">Create Question</a></li>
		<li><a href="show_teachers.jsp">Show Teachers</a></li>
		<li><a href="show_students.jsp">Show Student</a></li>
		<%
		Users me = (Users)session.getAttribute("current_user");
		if (me.getUser_is_admin() == 1) {
		%>
		<li><a href="<%=request.getContextPath()%>/admin/dashboard.jsp">Switch
				to Admin Privilege</a></li>
		<%
		}
		%>
		<li onclick="showProfileInfo('<%=me.getUser_last_name()%>','<%=me.getUser_email()%>','<%=me.getUser_id()%>')"><a href="#">Profile Info</a></li>
		<li><a href="<%=request.getContextPath()%>/LogoutServlet">LOGOUT</a></li>
	</ul>
</nav>