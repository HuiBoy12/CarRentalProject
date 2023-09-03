<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.io.PrintStream"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the username and password
			String userN = request.getParameter("username");
			String pswd = request.getParameter("password");
			
			//Make SELECT query
			String getUser = "SELECT * FROM users WHERE username='" + userN + "' and pswd='" + pswd+"'";
		
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(getUser);
			
			//Update avaliablity and winners of auctions
			Statement stmt2 = con.createStatement();
			String update = "update auction set available=0 where endTime < (SELECT CURRENT_TIMESTAMP)";
			stmt2.executeUpdate(update);
			
			Statement stmt3 = con.createStatement();
			String update2 = "update auction "+
					"join bid on auction.aid=bid.aid and bid.aid=2 "+
					"join vehicles on vehicles.vid=auction.aid "+
					"set auction.winner = bid.username "+
					"where auction.curBid=bid.amount and auction.curBid >= minPrice";
			stmt3.executeUpdate(update2);
		%>
		
		<body>
		<% if (result.next() == false || userN.isEmpty() || pswd.isEmpty()) {
				// no result, login fail
				out.print("Login Fail. Please check if your username or password is empty or incorrect.");
				%>
					<br>
					<br>
					<a href="HelloWorld.jsp"><input onclick="this.parentNode.href=HelloWorld.jsp;" type="button" value="Go Back" name="loginFail"/></a>
				<%
			} else {
				//login success

				if (result.getString("isAdmin").equals("1") ) {
					response.sendRedirect("Admin.jsp");
				} else if (result.getString("customerRep").equals("1")) {
					response.sendRedirect("CusRep.jsp");
				}
				else {
					session.setAttribute("username", userN);
					//response.sendRedirect("HomePage.jsp");
					response.sendRedirect("Notify.jsp");
				}
			}
		%>
		</body>
			

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>