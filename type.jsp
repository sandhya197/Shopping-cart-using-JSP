<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <h1>Reading Checkbox Data</h1>
 <p>Gender: ${param.maths}</p>
      <%
      String id=request.getParameter("custId");
      String g=request.getParameter("maths");
      if(g.equals("w")){
    	  response.sendRedirect("view.html");
      }
      else if(g.equals("m")){
    	  response.sendRedirect("men.html");
      }
      else{
    	  response.sendRedirect("kid.html");
      }
      %>
</body>
</html>