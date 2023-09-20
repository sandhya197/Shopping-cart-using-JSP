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

<%
String uname=request.getParameter("usr");
String pword=request.getParameter("pwd");
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/shopdetails", "root", "root");
PreparedStatement ps=con.prepareStatement("select * from accdetails where accname=? and password=?");
ps.setString(1,uname);
ps.setString(2,pword);
ResultSet rs=ps.executeQuery();
if(rs.next()){
	out.println("Welcome "+uname);
	%>
	<a href="cart.jsp">go to the database</a>
<% 	
}
else{
	out.println("Invalid username try again!!!");
}


%>


</body>
</html>