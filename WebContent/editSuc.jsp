<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
<title>Add a new product</title>
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
String cid = request.getParameter("userid");
String address = request.getParameter("newAddress");
    String city = request.getParameter("newCity");
    String country = request.getParameter("newCountry");
    String state = request.getParameter("newState");
    String pcode = request.getParameter("newPcode");
    String password = request.getParameter("newPassword");

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

    if (address!=null)
    {
   
            sql = "UPDATE customer SET address = ? WHERE customerId = ?";
            PreparedStatement pstmt1 = con.prepareStatement(sql);
            pstmt1.setString(1, address);
            pstmt1.setString(2, cid);
            pstmt1.executeUpdate();
            out.println("<h4 style=\"font-size: 40px; position: absolute; top: 50%; left: 40%; z-index: 2; font-family: 'Charm', cursive;\">Your address is updated successfully!</h4>");

    }
    else if (city!=null)
    {

        sql = "UPDATE customer SET address = ? WHERE customerId = ?";
            PreparedStatement pstmt1 = con.prepareStatement(sql);
            pstmt1.setString(1, city);
            pstmt1.setString(2, cid);
            pstmt1.executeUpdate();
            out.println("<h4 style=\"font-size: 40px; position: absolute; top: 50%; left: 40%; z-index: 2; font-family: 'Charm', cursive;\">Your city is updated successfully!</h4>");
    }
    else if (country!=null)
    {

        sql = "UPDATE customer SET address = ? WHERE customerId = ?";
            PreparedStatement pstmt1 = con.prepareStatement(sql);
            pstmt1.setString(1, country);
            pstmt1.setString(2, cid);
            pstmt1.executeUpdate();
            out.println("<h4 style=\"font-size: 40px; position: absolute; top: 50%; left: 40%; z-index: 2; font-family: 'Charm', cursive;\">Your country is updated successfully!</h4>");
    }
    else if (state!=null)
    {

        sql = "UPDATE customer SET address = ? WHERE customerId = ?";
            PreparedStatement pstmt1 = con.prepareStatement(sql);
            pstmt1.setString(1, state);
            pstmt1.setString(2, cid);
            pstmt1.executeUpdate();
            out.println("<h4 style=\"font-size: 40px; position: absolute; top: 50%; left: 40%; z-index: 2; font-family: 'Charm', cursive;\">Your state is updated successfully!</h4>");
    }
    else if (pcode!=null)
    {

        sql = "UPDATE customer SET address = ? WHERE customerId = ?";
            PreparedStatement pstmt1 = con.prepareStatement(sql);
            pstmt1.setString(1, pcode);
            pstmt1.setString(2, cid);
            pstmt1.executeUpdate();
            out.println("<h4 style=\"font-size: 40px; position: absolute; top: 50%; left: 40%; z-index: 2; font-family: 'Charm', cursive;\">Your postal code is updated successfully!</h4>");
    }
    else if (password!=null)
    {

        sql = "UPDATE customer SET address = ? WHERE customerId = ?";
            PreparedStatement pstmt1 = con.prepareStatement(sql);
            pstmt1.setString(1, password);
            pstmt1.setString(2, cid);
            pstmt1.executeUpdate();
            out.println("<h4 style=\"font-size: 40px; position: absolute; top: 50%; left: 40%; z-index: 2; font-family: 'Charm', cursive;\">Your password is updated successfully!</h4>");
    }
/* 
    out.println("<h3><a href=customer.jsp>Go back</a></h3>");
    out.println("<h3><a href=index.jsp>Continue shopping</a></h3>");
    out.println("<h3><a href=showcart.jsp>View cart</a></h3>"); */

    con.close();

}
catch (SQLException ex) 
{   out.println(ex); 
    
}
%>

</html>



   