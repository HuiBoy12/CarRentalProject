<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.io.PrintStream"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Add Customer Rep</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			
			//Get the username and password
			Statement stmt = con.createStatement();
			String cusRep_username = request.getParameter("cusRepUsername");
			String cusRep_pswd = request.getParameter("cusRepPassword");
			
			if (cusRep_username.isEmpty() || cusRep_pswd.isEmpty()) {
				out.print("Username or password is empty.\n"); 
				%>
					<a href="SignUp.jsp"><input onclick="this.parentNode.href=SignUp.jsp;" type="button" value="Go Back" name="signupFail"/></a>
				<%
			}
			//Make INSERT query
			PreparedStatement statement = con.prepareStatement("INSERT IGNORE INTO users (username, pswd, isAdmin, customerRep) VALUES ( ?, ?, ?, ?)");
			statement.setString(1, cusRep_username);
			statement.setString(2, cusRep_pswd);
			statement.setInt(3, 0);
			statement.setInt(4, 1); // Todo : update Cus Rep count value
			
			//Run the query against the database.
			int result = statement.executeUpdate();
		%>
		
		<body>
		<% if (result != 1) { // User already exists %>
				
			<p>Customer Representative already exists. Please enter a different user name.</p>
			<a href="Admin.jsp"><input onclick="this.parentNode.href=Admin.jsp;" type="button" value="Go Back" name="gobackAdmin"/></a>
				
			
		<% } else { %>
			
			<p>Customer Representative created.</p>
			<a href="Admin.jsp"><input onclick="this.parentNode.href=Admin.jsp;" type="button" value="Go Back to Admin" name="addRepSuccess"/></a>
				
		<% } %>
		
		</body>
			
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>