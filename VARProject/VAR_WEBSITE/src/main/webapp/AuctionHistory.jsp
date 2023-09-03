<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<h1>Auction History</h1>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement statement = con.createStatement();
		String curAid = request.getParameter("aid");
		String sqla = "SELECT a.aid, v.itemName, a.available, b.username, b.amount, a.endTime, a.winner FROM bid b, auction a, vehicles v WHERE a.aid = b.aid and a.vid = v.vid and b.aid = '"
		+ curAid + "'";
		ResultSet res1 = statement.executeQuery(sqla);
	%>
	
	<table border="1">
		<tr>
			<td>Bidder Name</td>
			<td>Amount</td>
		</tr>

		<%
		while (res1.next()) {
		%>

		<tr>
			<td><%=res1.getString("username")%></td>
			<td><%=res1.getString("amount")%></td>
		</tr>
		<%
		}
		con.close();
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>

	</table>

<br>
<form method="get">
	<a href="input_aid.jsp"><input
		onclick="this.parentNode.href=input_aid.jsp;" type="button"
		value="Go Back" name="BackButton" /></a>
</form>
<br>

</body>

<body>
</html>