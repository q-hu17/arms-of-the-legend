<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
<title>Reset Password</title>
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
String userid = request.getParameter("userid");
String email = request.getParameter("email");

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
    sql = "SELECT * FROM customer WHERE userid = ? AND email = ?";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, userid);
    pstmt.setString(2, email);
    ResultSet rst = pstmt.executeQuery();
    if (rst.next())
    {
        out.println("<h4>Your requested has received! An email has been sent to your email address!</h4>");
        out.println("<h4><a href=login.jsp>Log In</a></h4>");

    }
    else
    {
        out.println("<h4>Your user ID/ email address is not entered correctly, try again. </h4>");
        out.println("<h4><a href=login.jsp>Log In</a></h4>");

    }
    out.println("<h4 ><a href=login.jsp></a></h4>");
    con.close();

}
catch (SQLException ex) 
{   out.println(ex); 
    
}
%>

</html>



   