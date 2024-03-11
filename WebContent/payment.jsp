<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Information</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="css/listprod_style.css">
	<link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/listprod_style.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Charm:wght@700&display=swap" rel="stylesheet">
</head>
<body style="background-image: linear-gradient(rgba(255,255,255,0.75), rgba(255,255,255,0.75)),url(img/login_background.jpg); background-size:cover; background-repeat: no-repeat; background-attachment: fixed;">

    

<form method="get" action=paymentSuc.jsp>
    <table class="ShippingTable">
    <h3 style="font-size: 40px; position: absolute; top: 10%; left: 38%; z-index: 2; font-family: 'Charm', cursive;">Shipping Address</h3>

    <tr><td>Customer Id</td><td><input type="text" name="customerId" size="20"></td></tr>

    <tr><td>First Name</td><td><input type="text" name="fname" size="20"></td></tr>

    <tr><td>Last Name</td><td><input type="text" name="lname" size="20"></td></tr>

    <tr><td>E-Mail</td><td><input type="email" name="email" size="20"></td></tr>

    <tr><td>Address</td><td><input type="text" name="address" size="20"></td></tr>

    <tr><td>City</td><td><input type="text" name="city" size="20"></td></tr>

    <tr><td>State</td><td><input type="text" name="state" size="20"></td></tr>
 
    <tr><td>Country</td><td><input type="text" name="country" size="20"></td></tr>

    <tr><td>Postal Code</td><td><input type="text" name="pcode" size="20"></td></tr>

</table>

<table class="paymentTable">
    <h3 style="font-size: 40px; position: absolute; top: 10%; left: 58%; z-index: 2; font-family: 'Charm', cursive;">Payment<h3>
            <th><tr style="font-size: 18px; position: absolute; left: 49.9%;"><b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Payment Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></tr></th>
        <select size="1" name="type">
            <option>Visa</option>
            <option>American Express</option>
            <option>Mastercard</option>
        </select>

    <tr><td>Name on card</td><td><input type="text" name="name" size="20"></td></tr>
    
    <tr><td>Credit card number</td><td><input type="text" name="cnumber" size="20"></td></tr>

    <tr><td>Expiry month</td><td><input type="text" name="month" size="20"></td></tr>

<tr><td>Expiry Year</td><td><input type="text" name="year" size="20"></td></tr>

<tr><td>CVV</td><td><input type="text" name="CVV" size="20"></td></tr>
</table>
<input type="submit" value="Continue to Checkout" style="background-color: rgba(255, 169, 40, 0.986); padding: 16px 32px; margin: 4px 2px; border-radius:10px; height:50px;position: absolute; left: 58%; top: 49.9%; font-family: 'Charm', cursive; font-size: 20px;">

</form>

</body>
</html>


