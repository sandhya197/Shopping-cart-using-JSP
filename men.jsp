<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" >
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" rel="stylesheet">
    <style>
    body{
    background-color:black;
    }
    p{
    color:white;
    }
    h1{
    color:white;
    }
    h2{
    color:white;
    }
    .sidebar {
  height: 100%;
  width: 160px;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #f28482;
  overflow-x: hidden;
  padding-top: 16px;
}

.sidebar a {
  padding: 9px 8px 9px 16px;
  text-decoration: none;
  font-size: 20px;
  color: #111;
  display: block;
}

.sidebar a:hover {
  color: #f1f1f1;
}

.main {
  margin-left: 160px; /* Same as the width of the sidenav */
  padding: 0px 10px;
}

@media screen and (max-height: 450px) {
  .sidebar {padding-top: 19px;}
  .sidebar a {font-size: 18px;}
}
.table-style {
    border-collapse: collapse;
  }
  .table-style th, .table-style td {
    border: 1px solid black;
    padding: 8px;
  }
  .table-style th {
    background-color: #ffc07f;
  }
  .table-style tr:nth-child(even) {
    background-color: #ffc07f;
  }

    </style>
</head>
<body>
<div class="sidebar">
  <a href="type.html"><i class="fa fa-fw fa-home"></i> Home</a>
  <a href="view.html"><i class="fa fa-fw fa-user"></i>Women T-shirts</a>
  <a href="men.html"><i class="fa fa-fw fa-user"></i>Men T-shirts</a>
  <a href="kid.html"><i class="fa fa-fw fa-user"></i>Kids T-shirts</a>
  <a href="user.html"><i class="fa fa-fw fa-envelope"></i>Logout</a>
</div>
<div class="main">

<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%!ResultSet resultset;%>
<%!PreparedStatement pst;%>
<%!Connection con;%>
<%! String pname; %>
<h2 align="center"><font><strong>Cart</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="5" border="2" class="table-style">
<tr bgcolor="yellow">
<td><b>Product id</b></td>
<td><b>Product name</b></td>
<td><b>Category</b></td>
<td><b>Price</b></td>
<td><b>Quantity</b></td>
<td><b>Total Amount</b></td>

</tr>

<%
    double price = Double.parseDouble(request.getParameter("price"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    String ad=request.getParameter("obt");
    String id=(String)session.getAttribute("myValue");
    if(ad.equals("no")){
    	pname="NYC Blue T-Shirt";
    	%>
    	<div align="center">
    	<img src="https://images.pexels.com/photos/10857809/pexels-photo-10857809.jpeg?auto=compress&cs=tinysrgb&w=600"  alt="..." width="300px" height="300px">
    	</div><br><br>    	<% 
    }
    else if(ad.equals("ob")){
    	pname="black T-Shirt";
    	%>
    	<div align="center">
    	<img src="https://images.pexels.com/photos/3290886/pexels-photo-3290886.jpeg?auto=compress&cs=tinysrgb&w=600"  alt="..." width="300px" height="300px">
    	</div><br><br>    	<% 
    }
    else if(ad.equals("rst")){
    	pname="Flower T-Shirt";
    	%>
    	<div align="center">
    	<img src="https://images.pexels.com/photos/837443/pexels-photo-837443.jpeg?auto=compress&cs=tinysrgb&w=600"  alt="..." width="300px" height="300px">
    	</div><br><br>    	<% 
    	
    }
 else if(ad.equals("bwt")){
	 pname="Pacman White T-Shirt";
	 %>
 	<div align="center">
 	<img src="https://images.pexels.com/photos/2560894/pexels-photo-2560894.jpeg?auto=compress&cs=tinysrgb&w=600"  alt="..." width="300px" height="300px">
 	</div><br><br>    	<% 
    }
 else if(ad.equals("qt")){
	 pname="Printed T-Shirt";
 }
 else if(ad.equals("bbt")){
	 pname="Manly Black T-Shirt";
	 %>
 	<div align="center">
 	<img src="https://images.pexels.com/photos/1566412/pexels-photo-1566412.jpeg?auto=compress&cs=tinysrgb&w=600"  alt="..." width="300px" height="300px">
 	</div><br><br>    	<% 
 }

    double billingAmount = price * quantity;

    // Formatting the billing amount with two decimal places
    NumberFormat nf = NumberFormat.getCurrencyInstance(Locale.US);
    DecimalFormat df = (DecimalFormat) nf;
    df.applyPattern("0.00");
    String formattedBillingAmount = df.format(billingAmount);
    Class.forName("com.mysql.cj.jdbc.Driver");
    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/shopdetails", "root", "root");
    pst=con.prepareStatement("select pid,pname,category,sprice from pricing where pname=?;");
    pst.setString(1,pname);
    resultset=pst.executeQuery();

    



if(resultset.next()){
%>
<tr bgcolor="pink">
<td><%=resultset.getString(1) %></td>
<td><%=resultset.getString(2) %></td>
<td><%=resultset.getString(3) %></td>
<td><%=resultset.getString(4) %></td>
<td><%=quantity %></td>
<td><%= formattedBillingAmount%></td>

</tr>

<%
}
pst=con.prepareStatement("insert into cart(cid,pid,pname,category,price,quantity,total)values(?,?,?,?,?,?,?);");
pst.setString(1,id);
pst.setString(2,resultset.getString(1));
pst.setString(3,resultset.getString(2));
pst.setString(4,resultset.getString(3));
pst.setString(5,resultset.getString(4));
pst.setInt(6,quantity);
pst.setString(7,formattedBillingAmount );


int status=pst.executeUpdate();

%>
</table>
<div align="center">
<h1>Billing Amount</h1>
<p>Quantity: <%= quantity %></p>

    <p>Billing Amount: <%= formattedBillingAmount %></p>
    </div>
<h2 align="center"><font><strong>Total Cart</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1" class="table-style">
<tr bgcolor="yellow">
<td><b>Action</b></td>

<td><b>Product id</b></td>
<td><b>Product name</b></td>
<td><b>Category</b></td>
<td><b>Price</b></td>
<td><b>Quantity</b></td>
<td><b>Total Amount</b></td>

</tr>
           

<%

pst=con.prepareStatement("select * from cart where cid=?;");
pst.setString(1,id);


resultset=pst.executeQuery();

while(resultset.next()){
	 
%>
<tr bgcolor="cyan">
<td>

                    <form action="delete.jsp" method="post">

                        <input type="hidden" name="id" value="<%= resultset.getInt(1) %>">

                        <button class="btn btn-danger" type="submit">Delete</button>

                    </form>

                </td>

<td><%=resultset.getString(2) %></td>
<td><%=resultset.getString(3) %></td>
<td><%=resultset.getString(4) %></td>
<td><%=resultset.getString(5) %></td>
<td><%=resultset.getString(6) %></td>
<td><%=resultset.getString(7) %></td>


</tr>
<%
}

%>

</table><br><br>
<div align="center">
    <form action="bill.jsp" method="post">
    <button  class="btn btn-primary" name="out" value="check" >Check out</button><br><br>
    
    </form><br>
    
</div><br>
</div>
</body>
</html>