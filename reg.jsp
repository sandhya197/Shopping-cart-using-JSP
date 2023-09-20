<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@page import="java.sql.*,javax.sql.*" %>
<%! PreparedStatement ps; %>
<%
String uname=request.getParameter("user");
String pword=request.getParameter("pwd");
String cpword=request.getParameter("cpwd");
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/shopdetails", "root", "root");
if(pword.equals(cpword)){
ps=con.prepareStatement("insert into userdetails(cname,password) values(?,?);");

ps.setString(1,uname);
ps.setString(2,pword);
int status=ps.executeUpdate();
out.print("Registered");
%>
<a href="user.html">Go to login page</a>
<% 
}
else{
	out.print("please fill the confirm password correctly");
}

%>


</body>
</html>