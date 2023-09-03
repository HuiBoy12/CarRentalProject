<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View User Accounts</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection connection = db.getConnection();

		//Create a SQL statement
		Statement statement = connection.createStatement();
		String sqla = "SELECT * FROM users";
		ResultSet res1 = statement.executeQuery(sqla);
		int i = 0;
	%>
	<h1>All User Accounts</h1>
	<table border="1">
		<tr>
			<td>Username</td>
			<td>Password</td>
			<td>isAdmin</td>
			<td>CustomerRep</td>

		</tr>
		<%
		while (res1.next()) {
		%>
		<tr>
			<td><%=res1.getString("username")%></td>
			<td><%=res1.getString("pswd")%></td>
			<td><%=res1.getString("isAdmin")%></td>
			<td><%=res1.getString("customerRep")%></td>
			<td><a
				href="delete.jsp?username=<%=res1.getString("username")%>"><button
						type="button" class="delete">Delete</button></a></td>
			<td><a
				href="UpdateAccount.jsp?username=<%=res1.getString("username")%>"><button
						type="button" class="delete">Edit</button></a></td>
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