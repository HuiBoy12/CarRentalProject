<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.io.PrintStream"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Add Users</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			
			//Get the user's question
			Statement stmt = con.createStatement();
			String userQuestion = request.getParameter("questionArea");
			String qid = null;
			String Ans = null;
			
			if (userQuestion.isEmpty()) {
				out.print("Cannot submit an empty question."); 
				%>
					<a href="userQuestions.jsp"><input onclick="this.parentNode.href=userQuestions.jsp;" type="button" value="Go Back" name="askQuestionFail"/></a>
				<%
			}
			
			//Make INSERT query
			PreparedStatement statement = con.prepareStatement("INSERT IGNORE INTO QA (qid, ques, ans) VALUES ( ?, ?, ?)");
			statement.setString(1, qid);
			statement.setString(2, userQuestion);
			statement.setString(3, Ans);
			//String addUser = "INSERT INTO users (username, pswd, isAdmin) VALUES ('" + new_user + "', '" + new_pswd + "', " + "false)";
			
			//Run the query against the database.
			int result = statement.executeUpdate();
		%>
		
		<body>
		<% if (result != 1) { // User already exists %>
				
			<p> Question already exists. You can view the existing questions here.</p>
			<a href="showQA.jsp"><input onclick="this.parentNode.href=showQA.jsp;" type="button" value="View Existing Q&A" name="viewQ&A"/></a>
			<a href="userQuestions.jsp"><input onclick="this.parentNode.href=userQuestions.jsp;" type="button" value="Go Back" name="askQuestionFail"/></a>
				
			
		<% } else { %>
			
			<p> Thank you for your feedback! Your question is submitted. The Customer Representatives will get back to you shortly.</p>
			<a href="userQuestions.jsp"><input onclick="this.parentNode.href=userQuestions.jsp;" type="button" value="Go Back" name="submitQuestionSuccess"/></a>
				
		<% } %>
		
		</body>
			
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>