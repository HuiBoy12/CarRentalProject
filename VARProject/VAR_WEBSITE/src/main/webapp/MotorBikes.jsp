<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Motor Bikes</title>
</head>
<body>
<!-- the usual HTML way -->
		<br>
		Enter the details of your Motor Bike: 
	
		<br>
		<form method="post" action="AddMotorBikeAuction.jsp">
			<table>

				<tr>    
				<td>MotorBike ID</td><td><input type="text" name="vid"></td>
				</tr>
				<tr>    
				<td>MotorBike Name</td><td><input type="text" name="itemName"></td>
				</tr>
				<tr>    
				<td>Country</td><td><input type="text" name="country"></td>
				</tr>
				<tr>    
				<td>Power</td><td><input type="text" name="power"></td>
				</tr>
				<tr>
				<td>Closing Date (YYYY-MM-DD)</td><td><input type="text" name="endTime"></td>
				</tr>
				<tr>
				<td>Reserve</td><td><input type="text" name="minPrice"></td>
				</tr>
			</table>
			<input type="submit" value="Sell">
		</form>
	<br>
	
		<br>

			<a href="SellVehicle.jsp"><input onclick="this.parentNode.href=SellVehicle.jsp;" type="button" value="Go Back" name="goback"/></a>

		<br>
</body>
</html>