<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Sell</title>
	</head>
	
	<body>

		Sell an item <!-- the usual HTML way -->
		<br>
		Enter the details of your selling item: 
	
		<br>
		<form method="post" action="seller.jsp">
			<table>
				<tr>    
				<td>Item Name</td><td><input type="text" name="item name"></td>
				</tr>
				<tr>
				<td>Category</td><td><input type="text" name="category"></td>
				</tr>
				<tr>
				<td>Starting Price</td><td><input type="text" name="starting price"></td>
				</tr>
				<td>Closing Time</td><td><input type="text" name="closing time"></td>
				</tr>
				<td>Reserve</td><td><input type="text" name="reserve"></td>
			</table>
			<input type="submit" value="Sell">
		</form>
	<br>
	
		<br>

			<a href="HomePage.jsp"><input onclick="this.parentNode.href=HomePage.jsp;" type="button" value="Go Back" name="gobackHome"/></a>

		<br>
	

</body>
</html>