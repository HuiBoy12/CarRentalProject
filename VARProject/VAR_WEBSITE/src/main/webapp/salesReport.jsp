<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Sales Report</title>
	</head>
	
	<body>
	<h1>Sales Report</h1>
	
	<%! Integer total; 
		String bestItem;
		String bestBuyer;
	%> 
	
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			
			//Get the total earnings 
			Statement stmt = con.createStatement();
			
			//Make SUM query
			String totalStmt = "select SUM(tmp.mx) from auction left join (select aid, max(amount) as mx from bid group by aid) as tmp on tmp.aid=auction.aid join vehicles on auction.vid=vehicles.vid where available=0 and tmp.mx > vehicles.minPrice";

			//Run the query against the database.
			ResultSet totalResult =  stmt.executeQuery(totalStmt);
			if (totalResult.next()) { 
			    total = totalResult.getInt(1); // indexes are one-based
			}
			
			//Best Item
			String bestItemStmt = "select vehicles.itemName from auction left join (select aid, max(amount) as mx from bid group by aid) as tmp on tmp.aid=auction.aid join vehicles on auction.vid=vehicles.vid where available=0 and tmp.mx > vehicles.minPrice";

			//Run the query against the database.
			ResultSet bestItemResult =  stmt.executeQuery(bestItemStmt);
			if (bestItemResult.next()) { 
				bestItem = bestItemResult.getString(1); // indexes are one-based
			}
			
			
			//Best Buyer
			String bestBuyerStmt = "select tmp.username from auction left join (select aid, username, max(amount) as mx from bid group by aid) as tmp on tmp.aid=auction.aid join vehicles on auction.vid=vehicles.vid where available=0 and tmp.mx > vehicles.minPrice";

			//Run the query against the database.
			ResultSet bestBuyerResult =  stmt.executeQuery(bestBuyerStmt);
			if (bestBuyerResult.next()) { 
				bestBuyer = bestBuyerResult.getString(1); // indexes are one-based
			}
			
			
		} catch (Exception e) {
			out.print(e);
		}
	%>

		<br>
		<p> Total Earnings : <%= total%> </p>
		
		<br>
  
  
		<br>
		<form method="post" action="specificTotalEarnings.jsp">
			<table>
				<tr>
				<td>Enter the name of the item : </td><td><input type="text" name="itemName"></td>
				</tr>
				<tr>
				<td>Enter the type of the item : </td><td><input type="text" name="typeName"></td>
				</tr>
				<tr>
				<td>Enter the username : </td><td><input type="text" name="usernameInput"></td>
				</tr>
			</table>
			<input type="submit" value="Generate">
		</form>
		
		<br>
		<p>Best Selling Item : <%= bestItem%> </p> 
		
		<p>Best Buyer : <%= bestBuyer%> </p> 
		
		<br>
			<a href="Admin.jsp"><input onclick="this.parentNode.href=AdminPage.jsp;" type="button" value="Go Back" name="gobackHome"/></a>
		<br>
	

</body>
</html>