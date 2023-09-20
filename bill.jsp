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
    footer{
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
<div class="main" align="center">
<h1>Payment successful!!!..</h1>
<p>please visit us again!!...</p>
<footer>Thank You..Have a great day!!!</footer>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%!ResultSet resultset;%>
<%!PreparedStatement pst;%>
<%!Connection con;%>
<%!int sta; %>

<%


String id=(String)session.getAttribute("myValue");
//out.println(id);
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/shopdetails", "root", "root");
pst=con.prepareStatement("select * from cart join userdetails on cart.cid=userdetails.cid;");


//create table billing(billno int primary key auto_increment,cid int,cname varchar(30),pid int,pname varchar(30),category varchar(30),quantity int, sprice double,total double)
resultset=pst.executeQuery();
while (resultset.next()) {
    // Retrieve data from the result set
    String customerId = resultset.getString("cid");
    String customerName = resultset.getString("cname");
    String orderId = resultset.getString("pid");
    String orderDate = resultset.getString("pname");
    String cat=resultset.getString("category");
    int quantity=resultset.getInt("quantity");
    Double price=resultset.getDouble("price");
    Double total=resultset.getDouble("total");


    // Step 4: Insert data into the third table
    PreparedStatement pstmt = con.prepareStatement("INSERT INTO billing (cid,cname ,pid ,pname,category,quantity,sprice,total ) VALUES (?, ?, ?, ?,?,?,?,?)");
    pstmt.setString(1,customerId );
    pstmt.setString(2,customerName );
    pstmt.setString(3,orderId );
    pstmt.setString(4,orderDate );
    pstmt.setString(5,cat );
    pstmt.setInt(6,quantity );
    pstmt.setDouble(7, price);
    pstmt.setDouble(8,total);
    int stat=pstmt.executeUpdate();
    sta=stat;
    pst=con.prepareStatement("select * from stock where pid=?");
    pst.setString(1,orderId);
    ResultSet rs = pst.executeQuery();
    int currentInstock = 0;
    if (rs.next()) {
       currentInstock = rs.getInt("instock");
    }
    
    // Step 3: Calculate the new instock value
    int quantitySold = quantity; // Provide the quantity of the item sold
    int newInstock = currentInstock - quantitySold;
    
    // Step 4: Update the instock value
    PreparedStatement pstmtUpdate = con.prepareStatement("UPDATE stock SET instock = ? WHERE pid = ?");
    pstmtUpdate.setInt(1, newInstock);
    pstmtUpdate.setString(2, orderId);
    pstmtUpdate.executeUpdate();


 }
out.println(sta);

if(sta>0){
	String sql = "DELETE FROM cart WHERE cid = ?";

	pst = con.prepareStatement(sql);

	pst.setString(1, id);
	int status=pst.executeUpdate();
	
	
	
}

%>
</div>
</body>
</html>