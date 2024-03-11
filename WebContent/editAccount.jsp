<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>


<!DOCTYPE html>
<html>
<head>
<title>Edit Account Info</title>
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

    <%
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String country = request.getParameter("country");
    String state = request.getParameter("state");
    String pcode = request.getParameter("postalCode");
    String password = request.getParameter("password");

    String sql = "";
    
    String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";
    
    
    try
    {   // Load driver class
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    }
    catch (java.lang.ClassNotFoundException e)
    {
        out.println("ClassNotFoundException: " +e);
    }
    
    try ( Connection con = DriverManager.getConnection(url, uid, pw);
    Statement st = con.createStatement();) 
    {
        out.println("<form method=\"get\" action=editSuc.jsp>" +"<tr><td>Enter your user id:</td><td><input type=\"text\" name=\"userid\" size=\"20\"></td></tr>");

        if (address!=null)
        {
            out.println("<form method=\"get\" action=editSuc.jsp>" +"<tr><td>New Address:</td><td><input type=\"text\" name=\"newAddress\" size=\"20\"></td></tr>");
        }
        else if (city!=null)
        {
            out.println("<form method=\"get\" action=editSuc.jsp>" +"<tr><td>New City:</td><td><input type=\"text\" name=\"newCity\" size=\"20\"></td></tr>");
        }
        else if (country!=null)
        {
            out.println("<form method=\"get\" action=editSuc.jsp>" +"<tr><td>New Country:</td><td><input type=\"text\" name=\"newCountry\" size=\"20\"></td></tr>");
        }
        else if (state!=null)
        {
            out.println("<form method=\"get\" action=editSuc.jsp>" +"<tr><td>New State:</td><td><input type=\"text\" name=\"newState\" size=\"20\"></td></tr>");
        }
        else if (pcode!=null)
        {
            out.println("<form method=\"get\" action=editSuc.jsp>" +"<tr><td>New Postal Code:</td><td><input type=\"text\" name=\"newPcode\" size=\"20\"></td></tr>");
        }
        else if (password!=null)
        {
            out.println("<form method=\"get\" action=editSuc.jsp>" +"<tr><td>New Password:</td><td><input type=\"password\" name=\"newPassword\" size=\"20\"></td></tr>");
        }
        out.println("<tr><td><input type=\"submit\" value=\"Submit\" style=\"background-color: rgba(255, 169, 40, 0.986); border: none; color: white; padding: 16px 32px; text-decoration: none; margin: 4px 2px; border-radius: 10px; height: 50px;\"></td><td><input type=\"reset\" value=\"Reset\"></td></tr></form>");


        /* out.println("<h3><a href=index.jsp>Continue shopping</a></h3>");
        out.println("<h3><a href=showcart.jsp>View cart</a></h3>"); */
    
        con.close();
    
    }
    catch (SQLException ex) 
    {   out.println(ex); 
        
    }
    %>
    
    </html>
    
    
    
          