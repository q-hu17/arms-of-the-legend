<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Arms of the Legends Order List</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="css/listprod_style.css">
	<link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/listprod_style.css">
    <link rel="stylesheet" href="css/listorder_style.css">
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

<h1 style="font-size: 40px; position: absolute; top: 8%; left: 46%; z-index: 2; font-family: 'Charm', cursive;">Order List</h1>

<%

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

NumberFormat cf = NumberFormat.getCurrencyInstance(Locale.CANADA);

  
        // Stores the values
try
{   // Load driver class
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
    out.println("ClassNotFoundException: " +e);
}

try ( Connection con = DriverManager.getConnection(url, uid, pw);
        Statement stmt = con.createStatement();) 
{   
    String sql = "SELECT ordersummary.orderId, orderDate, ordersummary.customerId, CONCAT (firstName, ' ', lastName) AS name, totalAmount" +
                    " FROM ordersummary JOIN customer ON ordersummary.customerId = customer.customerId";            
    ResultSet rst = stmt.executeQuery(sql);     
    out.print("<table style=\"position: absolute; left: 20%; top: 20%; margin-left: 0%;font-family: 'Charm', cursive; font-size: 20px; border-collapse: separate; border-spacing: 100px 0;\"><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
    
    String sql1 = "SELECT productId, quantity, price FROM orderproduct WHERE orderId=?";
    PreparedStatement pstmt = con.prepareStatement(sql1);
    
    while (rst.next())
    {   int id = rst.getInt(1);

        out.println("<tr><td>"+id+"</td><td>"+rst.getString(2)+"</td><td>"+rst.getInt(3)+"</td><td>"+rst.getString(4)+"</td><td>"+cf.format(rst.getDouble(5))+"</td></tr>");

        pstmt.setInt(1, id);               
        ResultSet rst1 = pstmt.executeQuery();
        
        out.println("<tr align=\"right\"><td colspan=\"5\"><table>");
        out.println("<th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");
        while (rst1.next())
        {
            out.print("<tr><td>"+rst1.getInt(1)+"</td>" + "<td>"+rst1.getInt(2)+"</td>" + "<td>"+cf.format(rst1.getDouble(3))+"</td></tr>");
            
        }
        out.println("</table></td></tr>");
        rst1.close();
    }
    out.println("</table>");
    rst.close();
    con.close();
}
catch (SQLException ex) 
{   out.println(ex); 
}
%>

</body>
</html>


