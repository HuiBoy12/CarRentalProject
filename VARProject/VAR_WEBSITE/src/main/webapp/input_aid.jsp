<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Input</title>
</head>
<body>
	<form method=post action=AuctionHistory.jsp>

		<table>

			<tr>
				<td>Input aid</td>
				<td><input type="text" name="aid"></td>

			</tr>

		</table>

		<input type="submit" value="Search">
	</form>

	<form method="get">
		<a href="GetBids.jsp"><input
			onclick="this.parentNode.href=GetBids.jsp;" type="button"
			value="Go Back" name="BackButton" /></a>
	</form>

</body>
</html>