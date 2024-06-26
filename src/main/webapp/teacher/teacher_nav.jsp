
<%@page import="entities.Users"%>
<nav>
	<ul class="nav_ul">
		<li><a href="#">LOGO</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/dashboard.jsp">Home</a></li>
		<li><a href="create_question.jsp">Create Question</a></li>
		<li><a href="show_question_set.jsp">Question Sets</a></li>
		<li><a href="show_questions.jsp">Show Questions</a></li>
		<li><a href="create_exam.jsp">Create Exam</a></li>
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