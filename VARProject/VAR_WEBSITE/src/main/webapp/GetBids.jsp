<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Get Bids</title>
</head>
<body>
	<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		Statement statement = con.createStatement();
		String curUser = (String) session.getAttribute("username");
		String sqla = "SELECT b.aid, v.itemName, b.username, b.amount, b.increment, b.upperLim FROM bid b, auction a, vehicles v WHERE b.aid = a.aid and a.vid = v.vid and b.username = '"
				+ curUser + "'";
		
		//Run query
		//System.out.println(sqla);
		ResultSet res1 = statement.executeQuery(sqla);
	%>
	<h1>Your Bid History</h1>
	<table border="1">
		<tr>
			<td>aid</td>
			<td>Vehicle Name</td>
			<td>Amount</td>
			<td>Increment</td>
			<td>Upper Limit</td>

		</tr>
		<%
		while (res1.next()) {
		%>
		<tr>
			<td><%=res1.getString("aid")%></td>
			<td><%=res1.getString("itemName")%></td>
			<td><%=res1.getString("amount")%></td>
			<%
			String incr = res1.getString("increment");
			if (incr==null)
				incr = "0";
			String lim = res1.getString("upperLim");
			if (lim == null || lim.equals("0"))
				lim = "one time bid";
			%>
			<td><%=incr%></td>
			<td><%=lim%></td>
		</tr>
		<%
		}
		con.close();
		} catch (Exception e) {
		out.print(e);
		}
		%>
	</table>

	<br>
	<form method="get">
		<a href="input_aid.jsp"><input
			onclick="this.parentNode.href=input_aid.jsp;" type="button"
			value="Check Auction History" name="BackButton" /></a> <a
			href="HomePage.jsp"><input
			onclick="this.parentNode.href=HomePage.jsp;" type="button"
			value="Go Back" name="BackButton" /></a>
	</form>
	<br>

</body>


<a href="userQuestions.jsp"><input
	onclick="this.parentNode.href=userQuestions.jsp;" type="button"
	value="Help" name="help" /></a>


</html>