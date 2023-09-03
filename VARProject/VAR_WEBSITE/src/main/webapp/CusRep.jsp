<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Rep</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Make a SELECT query from QA
		String str = "SELECT * FROM QA ";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		
		
		
	%>

	<!--  Make an HTML table to show the results in: -->

	Search for a question:
	<br>
	<form method="get" action="showQA.jsp">
		<table>
			<tr>
				<td>Key Word:</td>
				<td><input type="text" name="kywd"></td>
			</tr>
		</table>
		<input type="submit" value="Search">
	</form>
	
	<br> Answer a question:
	<br>
	<form method="get" action="AddAnswer.jsp">
		<table>
			<tr>
				<td>QID:</td>
				<td><input type="text" name="qid"></td>
			</tr>
			<tr>
				<td>Answer</td>
				<td><input type="text" name="answ"></td>
			</tr>
		</table>
		<input type="submit" value="Answer">
	</form>

	<br> All Questions
	<br>
	<table>
		<tr>
			<td>QID</td>
			<td>Question</td>
			<td>Answer</td>
		</tr>
		<%
		//parse out the results
		while (result.next()) {
		%>
		<tr>
			<td><%=result.getString("qid")%></td>
			<td><%=result.getString("ques")%></td>
			<%
			String ans = result.getString("ans");
			if (ans==null)
				ans = "Not answered!";
			%>
			<td><%=ans%></td>
		</tr>


		<%
		}
		//close the connection.
		db.closeConnection(con);
		%>
	</table>


	<%
	} catch (Exception e) {
	out.print(e);
	}
	%>
			
			
			<form method="get">
				<a href="DeleteAccount.jsp"><input onclick="this.parentNode.href=DeleteAccount.jsp;" type="button" value="View Accounts" name="deleteButton"/></a>
				<a href="RemoveBid.jsp"><input onclick="this.parentNode.href=RemoveBid.jsp;" type="button" value="Remove Bid" name="removeBidButton"/></a>
				<a href="RemoveAuction.jsp"><input onclick="this.parentNode.href=Remove Auction.jsp;" type="button" value="Remove Auction" name="removeAuctionButton"/></a>
				<a href="HelloWorld.jsp"><input onclick="this.parentNode.href=HelloWorld.jsp;" type="button" value="Logout" name="logout"/></a>
			</form>
			
			
			
</body>
</html>