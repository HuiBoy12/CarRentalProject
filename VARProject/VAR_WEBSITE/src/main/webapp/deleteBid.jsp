<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
String getAid = request.getParameter("aid");
String amount = request.getParameter("amount");
try {

	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection connection = db.getConnection();
	Statement st = connection.createStatement();
	int i = st.executeUpdate("DELETE FROM bid WHERE aid = '" + getAid + "' and amount= '"+amount+"'");
	out.println("Data Deleted Successfully!");
} catch (Exception e) {
	out.print(e);
	e.printStackTrace();
}
%>