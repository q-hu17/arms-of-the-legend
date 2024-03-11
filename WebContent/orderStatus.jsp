<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>


<!DOCTYPE html>
<html>
<head>
<title>Check Order Status</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="css/listprod_style.css">
	<link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/listprod_style.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Charm:wght@700&display=swap" rel="stylesheet">
</head>
<body style="background-image: linear-gradient(rgba(255,255,255,0.75), rgba(255,255,255,0.75)),url(img/showcart_background.jpg); background-size:cover; background-repeat: no-repeat; background-attachment: fixed;">

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

<form method="get" action=checkOrderStatus.jsp>
    <table style="border-collapse: separate; border-spacing: 1 1em; position: absolute; top: 35%; left: 42%; font-size: 16px;">
    <tr><td>Enter order ID:</td><td><input type="text" name="orderId" size="20"></td></tr>
<tr><td><input type="submit" value="Submit" style="background-color: rgba(255, 169, 40, 0.986); border: none; color: white; padding: 16px 32px; text-decoration: none; margin: 4px 2px; border-radius: 10px; height: 50px;"></td><td><input type="reset" value="Reset" style="background-color: rgba(255, 169, 40, 0.986); border: none; color: white; padding: 16px 32px; text-decoration: none; margin: 4px 2px; border-radius: 10px; height: 50px;"></td></tr>
