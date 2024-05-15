<%@page import="helper.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
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
:
rotate(
90deg
);
}
50
%
{
transform
:
rotate(
180deg
);
}
75
%
{
transform
:
rotate(
270deg
);
}
100
%
{
transform
:
rotate(
260deg
);
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
	<form id="register_form" action="RegisterServlet">
		<h2>-Register-</h2>
		<div>
			<label for="fname">First Name</label><br /> <input required
				name="fname" id="fname" type="text" />
		</div>
		<div>
			<label for="lname">Last Name</label><br /> <input required
				name="lname" id="lname" type="text" />
		</div>
		<div>
			<label for="email">Email</label><br /> <input required name="email"
				id="email" type="email" />
		</div>
		<div>
			<label for="password">Password</label><br /> <input required
				name="password" id="password" type="password" />
		</div>
		<div>
			<label for="id">ID</label><br /> <input required name="id" id="id"
				type="number" />
		</div>

		<!-- ONLY FOR STUDENTS -->
		<div id="onlyForStudent">
		
		<div>
			<label for="id">Batch/Class</label><br /> <select name="batch" id="batch">
				<option value="volvo">Volvo</option>
				<option value="saab">Saab</option>
				<option value="vw">VW</option>
				<option value="audi" selected>Audi</option>
			</select>
		</div>
		<div >
			<label for="id">Section</label><br /> <select name="section" id="section">
				<option value="volvo">Volvo</option>
				<option value="saab">Saab</option>
				<option value="vw">VW</option>
				<option value="audi" selected>Audi</option>
			</select>
		</div>
		</div>
		<!-- ONLY FOR STUDENTS -->


		<div id='roles'>
			<input name="role" id="role" type="radio" value="0" checked="true">Student</input>
			<input name="role" id="role" type="radio" value="1">Teacher</input>
		</div>
		<div>
			<input name="btn" id="btn" type="submit" value="Register" /> <input
				name="btn2" id="btn2" type="reset" value="Reset" />
		</div>
		<p>
			<a href="login.jsp">Already have an account?</a>
		</p>
		<div id="spiner"></div>
	</form>
</body>
<script>
document.getElementById('roles').addEventListener('click',(e)=>{
	if(document.getElementById('roles').firstElementChild.checked===true)document.getElementById('onlyForStudent').style.display='block';
	else document.getElementById('onlyForStudent').style.display='none';
	
})
	let spiner = document.getElementById('spiner');
	spiner.style.display='none';
document.getElementById("register_form").addEventListener("submit",(e)=>{
	spiner.style.display='block';
	e.preventDefault();
	let fname=e.target.fname.value;
	let lname=e.target.lname.value;
	let id=e.target.id.value;
	let password=e.target.password.value;
	let role=e.target.role.value;
	let email=e.target.email.value;
	let section=e.target.section.value;
	let batch=e.target.batch.value;
	const ajx = new XMLHttpRequest();

	ajx.onreadystatechange=function(){
		if(this.readyState===4){
			spiner.style.display='none';
			if(this.status===200){
				if(this.responseText==0){
					alert('Successfully Registered!')
					//window.location='login.jsp'
				}else if(this.responseText==1062){
					alert("ID or Email already Registered!")
				}else{
					alert('Something Went Wrong!')
				}
			}else{
				alert('Server Error!')
			}
		}
	}
	
	ajx.open('post','RegisterServlet',true);
	ajx.setRequestHeader('content-type','application/x-www-form-urlencoded');
	ajx.send("fname="+fname+"&lname="+lname+"&id="+id+"&email="+email+"&role="+role+"&password="+password+"&batch="+batch+"&section="+section);
});
</script>
</html>