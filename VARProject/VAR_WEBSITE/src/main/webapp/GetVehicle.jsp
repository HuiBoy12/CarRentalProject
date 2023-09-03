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
		String sql = ("select  auction.aid, vehicles.itemName, vehicles.country, vehicles.power, vehicles.container, auction.curBid "
		+ "from auction "
		+ "join vehicles on auction.vid=vehicles.vid " + "where auction.available=1");
		
		//If request Search
		try{
			String searchby = request.getParameter("searchby");
			String kywd = request.getParameter("kywd");
			if (searchby!=null && kywd!=null) sql += (" and "+ searchby + " like '%" + kywd + "%'");
		}catch (Exception e){
			// not requested
		}
		
		//If request Sort
		try{
			String sortby = request.getParameter("sortby");
			sql+= " order by " + sortby;
		}catch (Exception e){
			// not requested
		}
		
		//System.out.println(sql);
		ResultSet resultSet = statement.executeQuery(sql);
		
		
	%>

	<h1>Buying</h1>

	<form method="get">
		<a href="Bidding.jsp"><input onclick="this.parentNode.href=Bidding.jsp;" type="button" value="Bid Now!" name="BidButton" /></a>
		<a href="HomePage.jsp"><input onclick="this.parentNode.href=GetVehicle.jsp;" type="button" value="Go Back" name="BackButton" /></a>
	</form>
	
	<br>
	Sort item list:
	<br>
		<form method="get" action="GetVehicle.jsp">
			<select name="sortby" size=1>
				<option value="curBid">By Current Bid</option>
				<option value="country">By Country</option>
				<option value="power, container">By Type</option>
			</select>&nbsp;<br> <input type="submit" value="Sort">
		</form>
	<br>
	
	Search item:
	<br>
		<form method="get" action="GetVehicle.jsp">
			<select name="searchby" size=1>
				<option value="vehicles.itemName">Item name</option>
				<option value="auction.aid">Auction ID</option>
			</select>&nbsp;
			<input type="text" name="kywd" class="form-control" placeholder="Keyword">
			<br> 
			<input type="submit" value="Search">
		</form>

	<br>

	<table border="1">
		<tr>
			<td>Aid</td>
			<td>Vehicle Name</td>
			<td>Current Bid</td>
			<td>Type</td>
			<td>Country</td>
		</tr>
		<%
		while (resultSet.next()) {
		%>
		<tr>
			<td><%=resultSet.getString("aid")%></td>
			<td><%=resultSet.getString("itemName")%></td>
			
			<%
				String price = resultSet.getString("curBid");
				if (resultSet.getString("curBid") == null) price = "0";
			%>
			<td><%=price%></td>
			
			<%
				String type = "car";
				if (resultSet.getString("power") != null) type = "motor bike";
				if (resultSet.getString("container") != null) type = "truck";
			%>
			<td><%=type%></td>
			
			<%
				String country = resultSet.getString("country");
				if (resultSet.getString("country") == null) country = " ";
			%>
			<td><%=country%></td>
		</tr>
		<%
		}
		con.close();
		} catch (Exception e) {
		out.print(e);
		}
		%>
	</table>
</html>