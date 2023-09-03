<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<body>




	<h1>All User Auctions</h1>
	<table border="1">
		<tr>
			<td>aid</td>
			<td>Available</td>
			<td>Username</td>
			<td>vid</td>
			<td>endTime</td>
			<td>Winner</td>

		</tr>
		<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection connection = db.getConnection();
			Statement statement = connection.createStatement();
			String sqla = "SELECT * FROM auction";
			ResultSet res1 = statement.executeQuery(sqla);
			int i = 0;
			while (res1.next()) {
		%>
		<tr>
			<td><%=res1.getString("aid")%></td>
			<td><%=res1.getString("available")%></td>
			<td><%=res1.getString("username")%></td>
			<td><%=res1.getString("vid")%></td>
			<td><%=res1.getString("endTime")%></td>
			<td><%=res1.getString("winner")%></td>
			<td><a href="deleteAuction.jsp?aid=<%=res1.getString("aid")%>"><button
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