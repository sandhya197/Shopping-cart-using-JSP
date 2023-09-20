<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%!String myValue; %>

<%
String uname=request.getParameter("usr");

String pword=request.getParameter("pwd");
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/shopdetails", "root", "root");
PreparedStatement ps=con.prepareStatement("select * from userdetails where cname=? and password=?");
ps.setString(1,uname);
ps.setString(2,pword);
ResultSet rs=ps.executeQuery();
if(rs.next()){
	myValue=rs.getString(1);
	out.println("Welcome "+uname);
	
	%>
	<a href="type.html">go to the shopping cart</a>
	
<% 	
}
else{
	out.println("Invalid username try again!!!");
}
//out.print(myValue);
session.setAttribute("myValue", myValue);			
%>
 


</body>
</html>