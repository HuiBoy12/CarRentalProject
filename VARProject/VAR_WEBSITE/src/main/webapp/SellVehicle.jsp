<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sell Vehicle</title>
</head>
<body>


Choose a vehicle. <!-- the usual HTML way -->
				
		<br>
			<form method="get">
				<a href="Car.jsp"><input onclick="this.parentNode.href=Car.jsp;" type="button" value="Car" name="carButton"/></a>
				<a href="Truck.jsp"><input onclick="this.parentNode.href=Truck.jsp;" type="button" value="Truck" name="truckButton"/></a>
				<a href="MotorBikes.jsp"><input onclick="this.parentNode.href=MotorBikes.jsp;" type="button" value="MotorBikes" name="motorbikeButton"/></a>
				<a href="HomePage.jsp"><input onclick="this.parentNode.href=GetVehicle.jsp;" type="button" value="Go Back" name="BackButton"/></a>
				<a href="HelloWorld.jsp"><input onclick="this.parentNode.href=HelloWorld.jsp;" type="button" value="Logout" name="logout"/></a>
			</form>
		<br>


</body>
</html>