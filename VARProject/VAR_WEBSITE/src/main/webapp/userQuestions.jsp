<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.io.PrintStream"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>User Questions </title>
	</head>
	<body>
		
		Ask a Question : <!-- the usual HTML way -->
	

		<form method="get" action="submitQuestions.jsp">
			<textarea name="questionArea"></textarea>
			<input type="submit" value="Submit">
		</form>
		
		<br>
		
		<a href="HelloWorld.jsp"><input onclick="this.parentNode.href=HelloWorld.jsp;" type="button" value="Logout" name="logout"/></a>
		
	<br>
	
	<form method="get">
				<a href="HomePage.jsp"><input onclick="this.parentNode.href=HomePage.jsp;" type="button" value="Go Back" name="BackButton"/></a>
			</form>

	</body>
</html>