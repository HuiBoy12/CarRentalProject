<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.io.PrintStream"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Message</title>
	</head>
	<body>
		<% try {
			String message=(String)session.getAttribute("message");
			//String mssage2=(String)session.getAttribute("message2");
			String curUser =(String)session.getAttribute("username");
			String nextJSP = (String)session.getAttribute("nextJSP");
		%>
		
		
		<body>
			<%!
				String myMethod(String input) {
	    			return "Message: " + input;
				}
			%>
			<%= myMethod(message) %>
			<% 
				session.setAttribute("username", curUser);
				//response.sendRedirect(nextJSP);
			%>
			<form method="get">
				<a href=HomePage.jsp><input onclick="this.parentNode.href=HomePage.jsp;" type="button" value="OK" name="OK"/></a>
			</form>
		</body>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>