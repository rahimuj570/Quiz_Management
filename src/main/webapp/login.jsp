<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<style>
#login_form{
height:100vh;
display:flex;
flex-direction:column;
gap:10px;
align-items:center;
justify-content:center;
}
.danger_txt{
color:red;
}
</style>
</head>
<body>
	<form method="post" id='login_form' action="LoginServlet">
	<h2>-Login-</h2>
	<%if(session.getAttribute("user404")!=null){ %>	
	<p class="danger_txt"><%=session.getAttribute("user404")%></p>
	<%session.removeAttribute("user404");} %>
	<%if(session.getAttribute("not-approved")!=null){ %>	
	<p class="danger_txt"><%=session.getAttribute("not-approved")%></p>
	<%session.removeAttribute("not-approved");} %>
		<div>
			<label for='email_id'>Email or ID</label> <br /> <input
				name='email_id' type='text' required />
		</div>
		<div>
			<label for='email_id'>Password</label> <br /> <input name='password'
				type='password' required />
		</div>
		<div style="text-align:center">
			<input type='submit' value='login' />
			<p>
				<a href="register.jsp">Don't have an account?</a>
			</p>
			<p>-OR-</p>
			<p>
				<a href="reset_password.jsp">Forgot Password?</a>
			</p>
			<p>-OR-</p>
			<p onclick="alert('Under Development!')"><a href="#">Login as guest!</a></p>
		</div>
	</form>
</body>
</html>