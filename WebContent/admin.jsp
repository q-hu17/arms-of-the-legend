<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="css/listprod_style.css">
	<link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/listprod_style.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Charm:wght@700&display=swap" rel="stylesheet">
</head>
<body style="background-image: linear-gradient(rgba(255,255,255,0.75), rgba(255,255,255,0.75)),url(img/login_background.jpg); background-size:cover; background-repeat: no-repeat; background-attachment: fixed;">

	<div class="topnav">
        <a class="active" href="index.jsp">Home</a>
        <a href="listprod.jsp">Shop</a>
        <a href="listorder.jsp">List All Orders</a>
        <a href="customer.jsp">Customer Info</a>
        <a href="admin.jsp">Administrators</a>
        <a href="orderStatus.jsp">Order Status</a>

        <div class="topnav-right">
            <a href="login.jsp">Login</a>
            <a href="signUp.jsp">Sign Up</a>
            <a href="showcart.jsp"><img src="http://www.clker.com/cliparts/U/D/n/G/6/h/white-shopping-cart-md.png" alt="Cart" style="width:15px;height:15px; background-position: -65px 0px;"></a>
        </div>

    </div>

<%@ include file="../auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>


<%

// Print out total order amount by day
String sql = "select year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM OrderSummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";

NumberFormat cf = NumberFormat.getCurrencyInstance(Locale.CANADA);

try 
{	
	out.println("<h3>Administrator Sales Report by Day</h3>");
	
	getConnection();
	ResultSet rst = con.createStatement().executeQuery(sql);		
	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>Order Date</th><th>Total Order Amount</th>");	

	while (rst.next())
	{
		out.println("<tr><td>"+rst.getString(1)+"-"+rst.getString(2)+"-"+rst.getString(3)+"</td><td>"+cf.format(rst.getDouble(4))+"</td></tr>");
	}
	out.println("</table>");
	
	
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally
{	
	closeConnection();	
}
%>

<form action=addProduct.jsp>
	<input type="submit" value="Add" style="background-color: rgba(255, 169, 40, 0.986); border: none; color: black; padding: 16px 32px; text-decoration: none; margin: 4px 2px; border-radius: 10px; height: 50px;"/>
</form>

<form action=deleteProduct.jsp>
	<input type="submit" value="Delete" style="background-color: rgba(255, 169, 40, 0.986); border: none; color: black; padding: 16px 32px; text-decoration: none; margin: 4px 2px; border-radius: 10px; height: 50px;"/>
</form>

<form action=updateProduct.jsp>
	<input type="submit" value="Update" style="background-color: rgba(255, 169, 40, 0.986); border: none; color: black; padding: 16px 32px; text-decoration: none; margin: 4px 2px; border-radius: 10px; height: 50px;"/>
</form>

<form action=updateOrder.jsp>
	<input type="submit" value="Change Order Status" style="background-color: rgba(255, 169, 40, 0.986); border: none; color: black; padding: 16px 32px; text-decoration: none; margin: 4px 2px; border-radius: 10px; height: 50px;"/>
</form>

</body>
</html>

