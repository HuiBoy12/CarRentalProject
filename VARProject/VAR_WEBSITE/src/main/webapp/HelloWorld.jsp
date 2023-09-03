<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>

<body>

	Login
	<!-- the usual HTML way -->

	<br>
	<form method="get" action="showLoginResult.jsp">
		<table>
			<tr>
				<td>User</td>
				<td><input type="text" name="username"></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="text" name="password"></td>
			</tr>
		</table>

		<br> <input type="submit" value="Login">
		<p>OR</p>
		<a href="SignUp.jsp"><input
			onclick="this.parentNode.href=SignUp.jsp;" type="button"
			value="Sign Up" name="signUp" /></a> <br>
	</form>

	<br>
</body>
</html>