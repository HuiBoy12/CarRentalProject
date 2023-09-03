<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.io.PrintStream"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Sales Report</title>
	</head>
	
	<body>
	<h1>Sales Report</h1>
	
	<%! Integer itemEarnings;
	    Integer userEarnings;
		
		// total earnings for each type
		Integer car;
		Integer motorbike;
		Integer truck;
	%> 
	
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			
			//Get the total earnings 
			Statement stmt = con.createStatement();
			String item = request.getParameter("itemName");
			String type = request.getParameter("typeName");
			String username = request.getParameter("usernameInput");
			
			if (item.isBlank() && type.isBlank() && username.isBlank()) { out.print("All fields are empty."); };
			
			// Make sure only one field is entered
			if (!item.isBlank() && type.isBlank() && username.isBlank()) { 
				
				// Item name is entered -> check if the item name exists
				String checkItem = "SELECT * FROM vehicles WHERE itemName='" + item + "'";
				ResultSet result = stmt.executeQuery(checkItem);
				if (result.next() == false) {
					out.print("This item doesn't exist.");
				}
				
				String ItemStmt = "select SUM(tmp.mx) from auction left join (select aid, username, max(amount) as mx from bid group by aid) as tmp on tmp.aid=auction.aid join vehicles on auction.vid=vehicles.vid where available=0 and vehicles.itemName='" + item + "'";
				ResultSet ItemStmtResult = stmt.executeQuery(ItemStmt);
				if (ItemStmtResult.next()) { // just in case
					itemEarnings = ItemStmtResult.getInt(1); // indexes are one-based
					out.println(itemEarnings);
				}
	
			} else if (item.isBlank() && !type.isBlank() && username.isBlank()) {
				if (!type.equalsIgnoreCase("car") && !type.equalsIgnoreCase("truck") && !type.equalsIgnoreCase("motorbike")) {
					out.print("This item type doesn't exist.");
				} else {
			
					if (type.equalsIgnoreCase("car")) {
						String checkType = "SELECT * from vehicles where power IS NULL AND container IS NULL"; 
						ResultSet carResult = stmt.executeQuery(checkType);
						if (carResult.next() == false) {
							out.print("No car sales exist.");
						}
						
						// SUM for car sales
						String carSum = "select SUM(tmp.mx) from auction left join (select aid, max(amount) as mx from bid group by aid) as tmp on tmp.aid=auction.aid join vehicles on auction.vid=vehicles.vid where available=0 and vehicles.power IS NULL and vehicles.container IS NULL";
						ResultSet carSumResult = stmt.executeQuery(carSum);
						if (carSumResult.next()) { // just in case
						    car = carSumResult.getInt(1); // indexes are one-based
						    out.print(car);
						}
								
					} else if (type.equalsIgnoreCase("motorbike")) {
						
						String checkType = "SELECT * from vehicles where power IS NOT NULL and container IS NULL"; 
						ResultSet motorbikeResult = stmt.executeQuery(checkType);
						
						if (motorbikeResult.next() == false) {
							out.print("No motorbike sales exist.");
						}
						
						// SUM for motorbike sales
						String motorbikeSum = "select SUM(tmp.mx) from auction left join (select aid, max(amount) as mx from bid group by aid) as tmp on tmp.aid=auction.aid join vehicles on auction.vid=vehicles.vid where available=0 and vehicles.power IS NOT NULL and vehicles.container IS NULL";
						ResultSet motorbikeSumResult = stmt.executeQuery(motorbikeSum);
						if (motorbikeSumResult.next()) { // just in case
						    motorbike = motorbikeSumResult.getInt(1); // indexes are one-based
						    out.print(motorbike);
						}
								
					} else if (type.equalsIgnoreCase("truck")) { 
						String checkType = "SELECT * from vehicles where power IS NULL and container IS NOT NULL"; 
						ResultSet truckResult = stmt.executeQuery(checkType);
						
						if (truckResult.next() == false) {
							out.print("No truck sales exist.");
						}
						
						// SUM for truck sales
						String truckSum = "select SUM(tmp.mx) from auction left join (select aid, max(amount) as mx from bid group by aid) as tmp on tmp.aid=auction.aid join vehicles on auction.vid=vehicles.vid where available=0 and vehicles.power IS NULL and vehicles.container IS NOT NULL";
						ResultSet truckSumResult = stmt.executeQuery(truckSum);
						if (truckSumResult.next()) { // just in case
						    truck = truckSumResult.getInt(1); // indexes are one-based
						    out.print(truck);
						}
					}
				}
				
			} else if (item.isBlank() && type.isBlank() && !username.isBlank()) {
			
				String checkUser = "SELECT * FROM users WHERE username='" + username + "'";
				ResultSet userResult = stmt.executeQuery(checkUser);
				if (userResult.next() == false) {
					out.print("This user doesn't exist.");
				}
				
				String userStmt = "select SUM(tmp.mx) from auction left join (select aid, username, max(amount) as mx from bid group by aid) as tmp on tmp.aid=auction.aid join vehicles on auction.vid=vehicles.vid where available=0 and auction.username='" + username + "'";
				ResultSet userStmtResult = stmt.executeQuery(userStmt);
				if (userStmtResult.next()) { // just in case
					userEarnings = userStmtResult.getInt(1); // indexes are one-based
					out.println(userEarnings);
				}
				
			}
			
			
		} catch (Exception e) {
			out.print(e);
		}
	%>


		
		<br>
			<a href="salesReport.jsp"><input onclick="this.parentNode.href=salesReport.jsp;" type="button" value="Go Back" name="gobackHome"/></a>
		<br>
	

</body>
</html>