<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Inserting Data in MySql</title>
</head>
<%
String CurUsername = request.getParameter("username");
%>
<BODY>
	<FORM method="post">

		<TABLE>
			<tr>
				<td>New Username :</td>
				<td><input name="username" size=15 type="text" /></td>
			</tr>
			<tr>
				<td>New Password :</td>
				<td><input name="pswd" size=15 type="text" /></td>
			</tr>
			<tr>
				<td>isAdmin :</td>
				<td><input name="isAdmin" size=15 type="text" /></td>
			</tr>
			<tr>
				<td>customerRep :</td>
				<td><input name="customerRep" size=15 type="text" /></td>
			</tr>
			<tr>
				<td width="50%"><INPUT TYPE="submit" VALUE="submit"></td>
			</tr>
		</table>
		<%
		String username = request.getParameter("username");
		String password = request.getParameter("pswd");
		String isAdmin = request.getParameter("isAdmin");
		String customerRep = request.getParameter("customerRep");

		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection connection = db.getConnection();
		PreparedStatement pstatement = null;

		int updateQuery = 0;
		if (username != null && password != null && isAdmin != null && customerRep != null) {
			if (username != "" && password != "" && isAdmin != "" && customerRep != "") {
				try {

			String queryString = "UPDATE users SET username=?, pswd=?, isAdmin=?, customerRep=? WHERE username='"
					+ CurUsername + "'";
			pstatement = connection.prepareStatement(queryString);
			pstatement.setString(1, username);
			pstatement.setString(2, password);
			pstatement.setString(3, isAdmin);
			pstatement.setString(4, customerRep);
			updateQuery = pstatement.executeUpdate();
			if (updateQuery != 0) {
		%>
		<br>
		<TABLE style="background-color: #E3E4FA;" WIDTH="30%" border="1">
			<tr>
				<th>Data is updated successfully in database.</th>
			</tr>
		</table>
		<%
		}
		} catch (Exception ex) {
		out.println("Unable to connect to database.");

		} finally {
		// close all the connections.
		pstatement.close();
		connection.close();
		}
		}
		}
		%>
	</FORM>
	
	<a href="DeleteAccount.jsp"><input onclick="this.parentNode.href=DeleteAccount.jsp;" type="button" value="Go Back" name="goback"/></a>
	
</body>
</html>
