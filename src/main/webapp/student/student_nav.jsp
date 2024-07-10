
<%@page import="entities.Users"%>
<nav>
	<ul class="nav_ul">
		<li><a href="#">LOGO</a></li>
		<li><a href="<%=request.getContextPath()%>/student/dashboard.jsp">Home</a></li>
		<li><a href="my_exams.jsp">Upcoming Exams</a></li>
		<li><a href="participated_exams.jsp">Participated Exams</a></li>
		<%
		Users me = (Users) session.getAttribute("current_user");
		%>
		<li
			onclick="showProfileInfo('<%=me.getUser_last_name()%>','<%=me.getUser_email()%>','<%=me.getUser_id()%>')"><a
			href="#">Profile Info</a></li>
		<li><a href="<%=request.getContextPath()%>/LogoutServlet">LOGOUT</a></li>
	</ul>
</nav>