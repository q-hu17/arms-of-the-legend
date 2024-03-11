<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
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

    <%@ include file="header.jsp" %>

    <p style="font-size: 40px; position: absolute; top: 8%; left: 30%; z-index: 2; font-family: 'Charm', cursive;">Hello, please take a moment to fill in your information</p>

<form method="get" action=signupSuc.jsp>
    <table class="signupTable">
    <tr><td>First Name:</td><td><input type="text" name="firstName" size="20"></td></tr>

    <tr><td>Last Name:</td><td><input type="text" name="lastName" size="20"></td></tr>
 
    <tr><td>Profession:</td><td><input type="text" name="profession" size="20"></td></tr>

    <tr><td>Email:</td><td><input type="email" name="email" size="20"></td></tr>

    <tr><td>Phone Number:</td><td><input type="tel" name="phonenum" size="20"></td></tr>

    <tr><td>Address:</td><td><input type="text" name="address" size="20"></td></tr>

    <tr><td>City:</td><td><input type="text" name="city" size="20"></td></tr>

    <tr><td>Country:</td><td><input type="text" name="country" size="20"></td></tr>

    <tr><td>State:</td><td><input type="text" name="state" size="20"></td></tr>

    <tr><td>Postal Code:</td><td><input type="text" name="postalCode" size="20"></td></tr>

    <tr><td>User id:</td><td><input type="text" name="userid" size="20"></td></tr>

    <tr><td>Password:</td><td><input type="password" name="password" size="20"></td></tr>

    <tr><td></td><td><input type="submit" value="Submit" ><input type="reset" value="Reset"></td></tr>

</table>
</form>

</body>
</html>






