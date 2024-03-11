<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
<title>Add a new product</title>
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
String ci = request.getParameter("categoryId");
int cn = Integer.parseInt(ci);
String pn = request.getParameter("productName");
String pri = request.getParameter("productPrice");
String desc = request.getParameter("productDesc");

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
    sql = "SELECT productName from product where productName = ?";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, pn);
    ResultSet rst = pstmt.executeQuery();
    if (rst.next())
    {
        out.println("<h3 style=\"font-size: 40px; position: absolute; top: 50%; left: 40%; z-index: 2; font-family: 'Charm', cursive;\">The product " + pn + " already exists!</h3>");
    }
    else
    {
        // find category id

        sql = "INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES (?,?,?,?)";
        PreparedStatement pstmt2 = con.prepareStatement(sql);
        pstmt2.setString(1, pn);
        pstmt2.setInt(2, cn);
        pstmt2.setString(3, desc);
        double price = Double.parseDouble(pri);
        pstmt2.setDouble(4, price);

        pstmt2.executeUpdate();

        out.println("<h3 style=\"font-size: 40px; position: absolute; top: 50%; left: 40%; z-index: 2; font-family: 'Charm', cursive;\"> The product " + pn + " is successfully added !</h3>");

    }
/*     out.println("<h3><a href=index.jsp>Continue shopping</a></h3>");
    out.println("<h3><a href=showcart.jsp>View cart</a></h3>"); */

    con.close();

}
catch (SQLException ex) 
{   out.println(ex); 
    
}
%>

</html>



   