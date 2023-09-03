<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.io.PrintStream"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Answers</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			PreparedStatement stmt = con.prepareStatement("update QA set ans=? where qid=?");
			//Get the qid and answer
			String qid = request.getParameter("qid");
			String ans = request.getParameter("answ");
			
			//Make update query
			stmt.setString(1, ans);
			stmt.setString(2, qid);
		
			//Run the query against the database.
			int result = stmt.executeUpdate();
		%>
		
		<body>
			<p>Answer Updated!</p>
			<a href="CusRep.jsp"><input onclick="this.parentNode.href=CusRep.jsp;" type="button" value="Go Back" name="goback"/></a>
		</body>
			

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>