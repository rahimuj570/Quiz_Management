<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Forgot Password</title>
<style>
#sent_code_form ,#change_password_form{
display:flex;
flex-direction:column;
gap:10px;
align-items:center;
justify-content:center;
}
.danger_txt{
color:red;
}
.success_txt{
color:green;
}
</style>
</head>
<body>
	<form method="post" id='sent_code_form' action="ForgotePasswordSentCodeServlet">
	<h2>-STEP 1-</h2>
	<%if(session.getAttribute("user404")!=null){ %>	
	<p class="danger_txt"><%=session.getAttribute("user404")%></p>
	<%session.removeAttribute("user404");} %>
	<%if(session.getAttribute("not-approved")!=null){ %>	
	<p class="danger_txt"><%=session.getAttribute("not-approved")%></p>
	<%session.removeAttribute("not-approved");} %>
	<%if(session.getAttribute("sent_forgot_pass")!=null){ %>	
	<p class="success_txt"><%=session.getAttribute("sent_forgot_pass")%></p>
	<%session.removeAttribute("sent_forgot_pass");} %>
	<%if(session.getAttribute("already_sent_forgot_pass")!=null){ %>	
	<p class="success_txt"><%=session.getAttribute("already_sent_forgot_pass")%></p>
	<%session.removeAttribute("already_sent_forgot_pass");} %>
	<%if(session.getAttribute("expire_forgot_pass")!=null){ %>	
	<p class="danger_txt"><%=session.getAttribute("expire_forgot_pass")%></p>
	<%session.removeAttribute("expire_forgot_pass");} %>
		<div>
			<label for='email_id'>Email</label> <br /> <input
				name='email' type='email' required />
		</div>
		<div style="text-align:center">
			<input type='submit' value='Request for Code' />
		</div>
	</form>
			<br/>
		<br/>
		<hr style="width:50%"/>
		<br/>
		<br/>
		<form method="post" id='change_password_form' action="LoginServlet">
	<h2>-STEP 2-</h2>
	<%if(session.getAttribute("user404")!=null){ %>	
	<p class="danger_txt"><%=session.getAttribute("user404")%></p>
	<%session.removeAttribute("user404");} %>
	<%if(session.getAttribute("not-approved")!=null){ %>	
	<p class="danger_txt"><%=session.getAttribute("not-approved")%></p>
	<%session.removeAttribute("not-approved");} %>
		<div>
			<label for='email_id'>Code</label> <br /> <input
				name='code' type='text' required />
		</div>
		<div>
			<label for='email_id'>New Password</label> <br /> <input
				name='password' type='text' required />
		</div>
		<div>
			<label for='email_id'>Re-Type New Password</label> <br /> <input
				name='password' type='text' required />
		</div>
		<div style="text-align:center">
			<input type='submit' value='Change Password' />
		</div>
	</form>
</body>
</html>