<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Sign Up Success</title>
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
String fname = request.getParameter("firstName");
String lname = request.getParameter("lastName");
String pro = request.getParameter("profession");
String email = request.getParameter("email");
String pnum = request.getParameter("phonenum");
String address = request.getParameter("address");
String city = request.getParameter("city");
String country = request.getParameter("country");
String state = request.getParameter("state");
String pcode = request.getParameter("postalCode");
String userid = request.getParameter("userid");
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
    sql = "SELECT * FROM customer WHERE userid = ?";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, userid);
    ResultSet rst = pstmt.executeQuery();

    if (rst.next())
    {
        out.println("<h3 style=\"font-size: 40px; position: absolute; top: 50%; left: 40%; z-index: 2; font-family: 'Charm', cursive;\">The user id " + userid + " is already in use!</h3>");
    }
    else
    {
        sql = "INSERT INTO customer (profession, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt1 = con.prepareStatement(sql);
        pstmt1.setString(1, pro);
        pstmt1.setString(2, fname);
        pstmt1.setString(3, lname);
        pstmt1.setString(4, email);
        pstmt1.setString(5, pnum);
        pstmt1.setString(6, address);
        pstmt1.setString(7, city);
        pstmt1.setString(8, state);
        pstmt1.setString(9, pcode);
        pstmt1.setString(10, country);
        pstmt1.setString(11, userid);
        pstmt1.setString(12, password);

        pstmt1.executeUpdate();

        out.println("<p style=\"font-size: 40px; position: absolute; top: 50%; left: 40%; z-index: 2; font-family: 'Charm', cursive;\">Thank you for signing up!</p>");
        
    }

con.close();

}
catch (SQLException ex) 
{   out.println(ex); 

}
%>

</html>