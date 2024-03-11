<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
<title>Validate Payment</title>
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
String type = request.getParameter("type");
String name = request.getParameter("name");
String cnum = request.getParameter("cnumber");
String cmonth = request.getParameter("month");
int month = Integer.parseInt(cmonth);
String cyear = request.getParameter("year");
int year = Integer.parseInt(cyear);
String CCVV = request.getParameter("CVV");
int CVV = Integer.parseInt(CCVV);
String custId = request.getParameter("customerId");
int cid = Integer.parseInt(custId);

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
    sql = "SELECT * FROM paymentmethod WHERE paymentNumber = ?";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, cnum);
    ResultSet rst = pstmt.executeQuery();
    if (rst.next())
    {
        if (rst.getString("paymentType").equals(type) && rst.getInt("paymentExpiryMonth") == month && rst.getInt("paymentExpiryYear") == year && rst.getInt("CVV") == CVV)
        {
            out.println("<h3 style=\"font-size: 40px; position: absolute; top: 40%; left: 36%; z-index: 2; font-family: 'Charm', cursive;\">You have successfully placed an order!</h3>");

            out.println("<h4 style=\"font-size: 40px; position: absolute; top: 51%; left: 43.5%; z-index: 2; font-family: 'Charm', cursive; text-decoration: none;\"><a href=\"order.jsp?customerId=" + cid + "\">Order Details</a></h4>");
        }
        else
        {
            out.println("<h3 style=\"font-size: 60px; position: absolute; top: 10%; left: 50%; z-index: 2; font-family: 'Charm', cursive;\">Something went wrong with your payment information, plese try again</h3>");
            out.println("<h4 style=\"font-size: 40px; position: absolute; top: 10%; left: 50%; z-index: 2; font-family: 'Charm', cursive;\"><a href=payment.jsp>Go back</a></h4>");
        }
        
    }
    else
    {
        out.println("<h3 style=\"font-size: 32px; font-family: 'Charm', cursive; text-align: center; vertical-align: middle;\">Something went wrong with your payment information, please try again</h3>");
        /* out.println("<h4><a href=payment.jsp>Go back</a></h4>"); */
    }


    /* out.println("<h3><a href=index.jsp>Continue shopping</a></h3>");
    out.println("<h3><a href=showcart.jsp>View cart</a></h3>"); */

    con.close();

}
catch (SQLException ex) 
{   out.println(ex); 
    
}
%>

</html>



   