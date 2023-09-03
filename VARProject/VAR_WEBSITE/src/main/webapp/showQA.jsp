<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Show QnA</title>
</head>
<body>
	<%

	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Get the key word
		String kywd = request.getParameter("kywd");
		//Make a SELECT query
		String str = "SELECT * FROM qa WHERE ques LIKE '%" + kywd + "%'";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
	%>
	<!--Make an HTML table to show the results in:-->

	Answer a question:
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
	<br> Result
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

</body>
</html>