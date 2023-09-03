<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>HomePage</title>
	</head>
	
	<body>

			HomePage <!-- the usual HTML way -->
				
		<br>
			<form method="get">
				<a href="SellVehicle.jsp"><input onclick="this.parentNode.href=SellVehicle.jsp;" type="button" value="Sell" name="sellButton"/></a>
				<a href="GetVehicle.jsp"><input onclick="this.parentNode.href=GetVehicle.jsp;" type="button" value="Buy" name="buyButton"/></a>
				<a href="GetBids.jsp"><input onclick="this.parentNode.href=GetBids.jsp;" type="button" value="Your Bids" name="YourBidButton"/></a>
				<a href="userQuestions.jsp"><input onclick="this.parentNode.href=userQuestions.jsp;" type="button" value="Help" name="help"/></a>
				<a href="ShowUserQA.jsp"><input onclick="this.parentNode.href=HelloWorld.jsp;" type="button" value="FAQs" name="QAButton"/></a>
				<a href="HelloWorld.jsp"><input onclick="this.parentNode.href=HelloWorld.jsp;" type="button" value="Logout" name="logout"/></a>
			</form>
		<br>
	

	</body>
</html>