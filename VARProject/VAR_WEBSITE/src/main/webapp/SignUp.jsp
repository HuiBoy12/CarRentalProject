<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.io.PrintStream"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Sign Up</title>
	</head>
	<body>
	
		Sign Up <!-- the usual HTML way -->
		
		<form method="get" action="AddUser.jsp">
			<table>
				<tr>    
					<td>Create a Username</td><td><input type="text" name="new_username"></td>
				</tr>
				<tr>
					<td>Create a Password</td><td><input type="text" name="new_password"></td>
				</tr>
			</table>
			
			<br>
				<input type="submit" value="Sign Up">
				<a href="HelloWorld.jsp"><input onclick="this.parentNode.href=HelloWorld.jsp;" type="button" value="Go Back" name="goBack"/></a>
			<br>
		</form>
	
	</body>
</html>