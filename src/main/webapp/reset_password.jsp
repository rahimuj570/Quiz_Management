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
	<%if(session.getAttribute("something_wrong")!=null){ %>	
	<p class="danger_txt"><%=session.getAttribute("something_wrong")%></p>
	<%session.removeAttribute("something_wrong");} %>
	<%if(session.getAttribute("already_sent_forgot_pass")!=null){ %>	
	<p class="success_txt"><%=session.getAttribute("already_sent_forgot_pass")%></p>
	<%session.removeAttribute("already_sent_forgot_pass");} %>
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
		<form method="post" id='change_password_form' action="ForgotePasswordCheckCodeServlet">
	<h2>-STEP 2-</h2>
		<%if(session.getAttribute("expire_forgot_pass")!=null){ %>	
	<p class="danger_txt"><%=session.getAttribute("expire_forgot_pass")%></p>
	<%session.removeAttribute("expire_forgot_pass");} %>
	<%if(session.getAttribute("user4042")!=null){ %>	
	<p class="danger_txt"><%=session.getAttribute("user4042")%></p>
	<%session.removeAttribute("user4042");} %>
	<%if(session.getAttribute("pin404")!=null){ %>	
	<p class="danger_txt"><%=session.getAttribute("pin404")%></p>
	<%session.removeAttribute("pin404");} %>
	<%if(session.getAttribute("verify404")!=null){ %>	
	<p class="danger_txt"><%=session.getAttribute("verify404")%></p>
	<%session.removeAttribute("verify404");} %>
	<%if(session.getAttribute("pin_mismatch")!=null){ %>	
	<p class="danger_txt"><%=session.getAttribute("pin_mismatch")%></p>
	<%session.removeAttribute("pin_mismatch");} %>
	<%if(session.getAttribute("failed_change_pass")!=null){ %>	
	<p class="danger_txt"><%=session.getAttribute("failed_change_pass")%></p>
	<%session.removeAttribute("failed_change_pass");} %>
	<%if(session.getAttribute("success_change_pass")!=null){ %>	
	<p class="success_txt"><%=session.getAttribute("success_change_pass")%></p>
	<%session.removeAttribute("success_change_pass");} %>
	<%if(session.getAttribute("pass_mismatch")!=null){ %>	
	<p class="success_txt"><%=session.getAttribute("pass_mismatch")%></p>
	<%session.removeAttribute("pass_mismatch");} %>
	<%if(session.getAttribute("invalid_pin")!=null){ %>	
	<p class="success_txt"><%=session.getAttribute("invalid_pin")%></p>
	<%session.removeAttribute("invalid_pin");} %>
		<div>
			<label for='email_id'>Code</label> <br /> <input
				name='code' type='text' required />
		</div>
		<div>
			<label for='email_id'>Re-Type Email</label> <br /> <input
				name='email' type='email' required />
		</div>
		<div>
			<label for='email_id'>New Password</label> <br /> <input
				name='password' type='text' required />
		</div>
		<div>
			<label for='email_id'>Re-Type New Password</label> <br /> <input
				name='re_password' type='text' required />
		</div>
		<div style="text-align:center">
			<input type='submit' value='Change Password' />
		</div>
	</form>
</body>
</html>