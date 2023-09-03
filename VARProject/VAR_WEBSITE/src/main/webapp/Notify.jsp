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
			//String userN = request.getParameter("username");
			//String pswd = request.getParameter("password");
			
			String curUser=(String)session.getAttribute("username");
			//Make SELECT query
			//String getUser = "SELECT * FROM users WHERE username='" + userN + "' and pswd='" + pswd+"'";
			String getVidForUser = "select a.vid, b.amount from auction a, bid b where a.available = 1 and a.aid = b.aid and b.username = '" + curUser + "'limit 1";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(getVidForUser);
			
			//Run query to see if curUser is winner of his/her bid
			Statement stmtWinner = con.createStatement();
			String winnerResult = "select a.vid from auction a where a.available = 0 and a.winner = '" + curUser + "'";
			ResultSet resultWinner = stmtWinner.executeQuery(winnerResult);
			
		%>
		
		<body>
		<% 
			int vidWinner = -1;
			int vid = -1;
			boolean res1 = false;
			boolean res2 = false;
			double amount = 0;
			String notify = null;
			if (result.next() != false) {
				// no result. go to HomePage
				vid = result.getInt("vid");
				amount = result.getDouble("amount");
				
				Statement stmt2 = con.createStatement();
				String getOutBid = "select b.username, b.amount from bid b, auction a where b.username != '" + curUser + "' and a.aid = b.aid and a.vid = '" + vid + "' and b.amount  > " + amount;
				ResultSet result2 = stmt2.executeQuery(getOutBid);
				
				if(result2.next() != false)
				{
					String user2 = result2.getString("username");
					notify = "There are other bids higher than you bid for vid = " + vid +"\n";	
					res1 = true;
				}
			}
			if(resultWinner.next() != false)
			{
				vidWinner = resultWinner.getInt("vid");
				if(res1)
					notify = notify + "\nCongratulations, you are the bid winner for vid = " + vidWinner;
				else
					notify = "Congratulations, you are the bid winner for vid = " + vidWinner;
						
				res2 = true;
			}
			
			if(res1 || res2)
			{
				session.setAttribute("message", notify);
				//session.setAttribute("message2", notify2);
				session.setAttribute("username", curUser);
				//session.setAttribute("nextJSP", "HomePage.jsp");
				response.sendRedirect("Message.jsp");
			}
			else
			{
				session.setAttribute("username", curUser);
				response.sendRedirect("HomePage.jsp");
			}
		%>
		</body>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>