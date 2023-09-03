<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<body>




	<h1>All User Bids</h1>
	<table border="1">
		<tr>
			<td>aid</td>
			<td>Username</td>
			<td>Amount</td>
			<td>Increment</td>
			<td>upperLim</td>

		</tr>
		<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
			Statement statement = connection.createStatement();
			String sqla = "SELECT * FROM bid";
			ResultSet res1 = statement.executeQuery(sqla);
			int i = 0;
			while (res1.next()) {
		%>
		<tr>
			<td><%=res1.getString("aid")%></td>
			<td><%=res1.getString("username")%></td>
			<td><%=res1.getString("amount")%></td>
			<td><%=res1.getString("increment")%></td>
			<td><%=res1.getString("upperLim")%></td>
			<td><a href="deleteBid.jsp?aid=<%=res1.getString("aid")%>&amount=<%=res1.getString("amount")%>"><button
						type="button" class="delete">Delete</button></a></td>
		</tr>
		<%
		i++;
		}
		connection.close();
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>
	</table>

<a href="CusRep.jsp"><input
		onclick="this.parentNode.href=CusRep.jsp;" type="button"
		value="Go Back" name="goback" /></a>
</body>
</html>