<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.io.PrintStream"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Bid</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		//Get the info
		Statement state = con.createStatement();
		String userN = (String) session.getAttribute("username"); //get current username
		String aid = request.getParameter("aid"); //get vid
		String amount = request.getParameter("amount"); //require
		String increment = request.getParameter("increment"); //optional
		String upperLim = request.getParameter("upperLim"); //optional

		if (amount.isEmpty()) {
			out.print("One or more required fields are empty.\n");
	%>
	<a href="AddBid.jsp"><input
		onclick="this.parentNode.href=AddBid.jsp;" type="button"
		value="Go Back" name="Fail" /></a>
	<%
	} else {
	//Make INSERT vehicles query
	PreparedStatement statement = con
			.prepareStatement("INSERT IGNORE INTO bid (aid, username, amount, increment, upperLim) VALUES (?, ?, ?, ?, ?)");
	statement.setString(1, aid);
	statement.setString(2, userN);
	statement.setString(3, amount);
	statement.setString(4, increment);
	statement.setString(5, upperLim);

	//Run the query against the database.
	int result = statement.executeUpdate();

	//Auto Bid
	Double curBid = Double.parseDouble(amount);
	String winner = userN;
	Double mxBid = curBid;
	PreparedStatement auto = con.prepareStatement(
			"select username, max(amount), upperlim, increment from bid where increment!=0 and aid=? group by username");
	auto.setString(1, aid);
	ResultSet autoList = auto.executeQuery();
	autoList.next();

	while (autoList.next()) {
		String curUser = autoList.getString("username");
		Double lim = Double.parseDouble(autoList.getString("upperLim"));
		Double incr = Double.parseDouble(autoList.getString("increment"));
		if (curUser.equals(winner) == false && lim > curBid + incr) {
			PreparedStatement autoBid = con
			.prepareStatement("insert into bid (aid, username, amount, increment, upperlim) value (?,?,?,?,?)");
			autoBid.setString(1, aid);
			autoBid.setString(2, curUser);
			autoBid.setString(3, Double.toString(curBid + incr));
			autoBid.setString(4, Double.toString(incr));
			autoBid.setString(5, Double.toString(lim));
			System.out.println(autoBid);
			autoBid.executeUpdate();

			if (curBid + incr > mxBid) {
		mxBid = curBid + incr;
		winner = curUser;
			}

		}
	}

	//Update winner and curBid
	PreparedStatement stmt2 = con.prepareStatement("update auction set curBid=? where aid=?");
	stmt2.setString(1, Double.toString(mxBid));
	stmt2.setString(2, aid);
	stmt2.executeUpdate();
	PreparedStatement stmt3 = con.prepareStatement("update auction set winner=? where aid=?");
	stmt3.setString(1, winner);
	stmt3.setString(2, aid);
	stmt3.executeUpdate();

	//get similar items
	Statement stmt = con.createStatement();
	String str = "SELECT * "+
			"FROM auction join vehicles on auction.aid=vehicles.vid "+
			"WHERE auction.available=1 and date_add(current_timestamp, interval -1 month)< auction.endTime "+ 
			"and auction.endTime  < date_add(current_timestamp, interval 1 month)";
	ResultSet rec = stmt.executeQuery(str);
	%>

<body>
	<p>Successfully Bid!.</p>
	<a href="GetVehicle.jsp"><input
		onclick="this.parentNode.href=GetVehicle.jsp;" type="button"
		value="Go Back to listings" name="goback" /></a>

	<p>Similar Items Ending in a month!</p>
	<table border="1">
		<tr>
			<td>AID</td>
			<td>itemName</td>
			<td>endTime</td>
			<td>Current Bid</td>
		</tr>
	<%
	//parse out the results
	while (rec.next()) {
	%>
	<tr>
		<td><%=rec.getString("aid")%></td>
		<td><%=rec.getString("itemName")%></td>
		<td><%=rec.getString("endTime")%></td>
		<td><%=rec.getString("curBid")%></td>
	</tr>
<%
}
}
db.closeConnection(con);
} catch (Exception e) {
out.print(e);
}
%>

</table>
</body>
</html>