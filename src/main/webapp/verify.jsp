<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
if (session.getAttribute("verify_user_id") == null)
	response.sendRedirect("login.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Account Verification!</title>
<style>
#register_form {
	display: flex;
	flex-direction: column;
	gap: 10px;
	align-items: center;
	height: 100vh;
	justify-content: center
}

@
keyframes spiner-1 { 0%{
	transform: rotate(0deg);
}

25




%
{
transform




:rotate




(




90deg




)




;
}
50




%
{
transform




:rotate




(




180deg




)




;
}
75




%
{
transform




:rotate




(




270deg




)




;
}
100




%
{
transform




:rotate




(




260deg




)




;
}
}
#spiner {
	width: 50px;
	background: transparent;
	border-left: 3px solid #01b8ff;
	border-top: 3px solid #f706ff;
	height: 50px;
	border-radius: 100%;
	animation: spiner-1 1s ease-in 0s infinite alternate;
}
</style>
</head>
<body>
	<form id="register_form">
		<h2>-Verify Account-</h2>
		<div style="text-align: center">
			<label for="fname">Insert 6 Characters Code from Your Email </label><br />
			<input required name="code" id="code" type="text" />
		</div>
		<div>
			<input name="btn" id="btn" type="submit" value="Verify" />
		</div>
		<p>
			<a href="#" id='resentCode'>Request For New Code</a>
		</p>
		<div id="spiner"></div>
	</form>
</body>
<script>
	let spiner = document.getElementById('spiner');
	spiner.style.display='none';
document.getElementById("register_form").addEventListener("submit",(e)=>{
	spiner.style.display='block';
	e.preventDefault();
	let code=e.target.code.value;
	const ajx = new XMLHttpRequest();

	ajx.onreadystatechange=function(){
		if(this.readyState===4){
			spiner.style.display='none';
			if(this.status===200){
				if(this.responseText=='valid'){
					alert('Successfully Verified!')
					//window.location='login.jsp'
				}else if(this.responseText=='invalid'){
					alert("Invalid Pin Code!")
				}else if(this.responseText=='expire'){
					alert('Expired Pin Code!')
				}else if(this.responseText=='mismatch'){
					alert("Code is not Matched!")
				}else if(this.responseText=='request_new_pin'){
					alert("Request for a new code!")
				}
			}else{
				alert('Server Error!')
			}
		}
	}
	
	ajx.open('post','VerifyCodeServlet',true);
	ajx.setRequestHeader('content-type','application/x-www-form-urlencoded');
	ajx.send("code="+code);
});

document.getElementById("resentCode").addEventListener("click",()=>{
	spiner.style.display='block';
	const ajx = new XMLHttpRequest();

	ajx.onreadystatechange=function(){
		if(this.readyState===4){
			spiner.style.display='none';
			if(this.status===200){
				if(this.responseText=='sent'){
					alert('Check Your Email!')
				}else if(this.responseText=='not_sent'){
					alert("Your old pin_code is not expire yet!")
			}else if(this.responseText=='user_not_exist'){
					alert("Invalid Account!")
			}else if(this.responseText=='login_redirect'){
					window.location='login.jsp';
			}else{
				alert('Server Error!')
			}
		}
	}
	}
	
	ajx.open('post','ResentCodeServlet',true);
	ajx.setRequestHeader('content-type','application/x-www-form-urlencoded');
	ajx.send("c=c");
});
</script>
</html>