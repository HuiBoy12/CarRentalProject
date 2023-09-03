<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
String getAid = request.getParameter("aid");
try {

	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection conn = db.getConnection();
	Statement st = conn.createStatement();
	int i = st.executeUpdate("DELETE FROM auction WHERE aid = '" + getAid + "'");
	out.println("Data Deleted Successfully!");
} catch (Exception e) {
	out.print(e);
	e.printStackTrace();
}
%>