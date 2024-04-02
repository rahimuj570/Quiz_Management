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
			<label for="id">ID</label><br /> <input required
				name="id" id="id" type="number" />
		</div>
		<div>
			<input name="role" id="role" type="radio" value="0" checked="true">Student</input>
			<input name="role" id="role" type="radio" value="1">Teacher</input>
		</div>
		<div>
			<input name="btn" id="btn" type="submit" value="Register" /> <input
				name="btn2" id="btn2" type="reset" value="Reset" />
		</div>

	</form>
</body>
</html>