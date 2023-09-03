<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Administration</title>
</head>
<body>
	
	Administration <!-- the usual HTML way -->
	
	<p>Create a Customer Representative :</p><br>

		<form method="get" action="AddCusRep.jsp">
			<table>
				<tr>    
					<td>Customer Representative Username</td><td><input type="text" name="cusRepUsername"></td>
				</tr>
				<tr>
					<td>Customer Representative Password</td><td><input type="text" name="cusRepPassword"></td>
				</tr>
			</table>
			
			<br>
				<input type="submit" value="Create">
			<br>
			<p>OR</p><br>
			<a href="salesReport.jsp"><input onclick="this.parentNode.href=salesReport.jsp;" type="button" value="Sales Report" name="salesRepButton"/></a>
			<br>
			<a href="HelloWorld.jsp"><input onclick="this.parentNode.href=HelloWorld.jsp;" type="button" value="Logout" name="logout"/></a>
		</form>
		
	<br>
	
</body>
</html>