<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bidding</title>
</head>
<body>
<!-- the usual HTML way -->
		<br>
		Enter the details: 
	
		<br>
		<form method="post" action="AddBid.jsp">	
			<table>
<tr>    
				<td>AID</td><td><input type="text" name="aid"></td>
				</tr>
				<tr>    
				<td>Amount</td><td><input type="text" name="amount"></td>
				</tr>
				<tr>    
				<td>Increment</td><td><input type="text" name="increment"></td>
				</tr>
				<tr>
				<td>Upper Limit</td><td><input type="text" name="upperLim"></td>
				</tr>
			</table>
			<input type="submit" value="Bid">
		</form>
	<br>
	
		<br>

			<a href="GetVehicle.jsp"><input onclick="this.parentNode.href=GetVehicle.jsp;" type="button" value="Go Back" name="goback"/></a>

		<br>
</body>
</html>