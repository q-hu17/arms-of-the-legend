<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="css/listprod_style.css">
	<link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/listprod_style.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Charm:wght@700&display=swap" rel="stylesheet">
</head>
<body style="background-image: linear-gradient(rgba(255,255,255,0.75), rgba(255,255,255,0.75)),url(img/showcart_background.jpg); background-size:cover; background-repeat: no-repeat; background-attachment: fixed;">

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

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


<%
	String un = (String) session.getAttribute("authenticatedUser");
%>

<%

// Print Customer information
String sql = "select customerId, profession, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password FROM customer WHERE userid = ?";

try 
{	
	out.println("<h3 style:\"text-align: center; font-family: 'Charm', cursive;\">Customer Profile</h3>");
	
	getConnection();
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, un);	
	ResultSet rst = pstmt.executeQuery();
	
	if (rst.next())
	{
		out.println("<table class=\"table\" border=\"1\">");
		out.println("<tr><th>Id</th><td>"+rst.getString(1)+"</td></tr>");
		out.println("<tr><th>Profession</th><td>"+rst.getString(2)+"</td></tr>");
		out.println("<tr><th>First Name</th><td>"+rst.getString(3) +"</td></tr>");
		out.println("<tr><th>Last Name</th><td>"+rst.getString(4)+"</td></tr>");
		out.println("<tr><th>Email</th><td>"+rst.getString(5)+"</td></tr>");
		out.println("<tr><th>Phone</th><td>"+rst.getString(6)+"</td></tr>");
		out.println("<tr><th>Address</th><td>"+rst.getString(7)+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\" editAccount.jsp?id=" + rst.getString(1) + "&address=" + rst.getString(7) + "\">Edit</a>" + "</td></tr>");
		out.println("<tr><th>City</th><td>"+rst.getString(8)+  "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\" editAccount.jsp?id=" + rst.getString(1) + "&city=" + rst.getString(8) + "\">Edit</a>" + "</td></tr>");
		out.println("<tr><th>State</th><td>"+rst.getString(9)+  "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\" editAccount.jsp?id=" + rst.getString(1) + "&state=" + rst.getString(9) + "\">Edit</a>" + "</td></tr>");
		out.println("<tr><th>Postal Code</th><td>"+rst.getString(10)+  "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\" editAccount.jsp?id=" + rst.getString(1) + "&postalCode=" + rst.getString(10) + "\">Edit</a>" + "</td></tr>");
		out.println("<tr><th>Country</th><td>"+rst.getString(11)+  "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\" editAccount.jsp?id=" + rst.getString(1) + "&userid=" + rst.getString(11) + "\">Edit</a>" + "</td></tr>");
		out.println("<tr><th>User id</th><td>"+rst.getString(12)+"</td></tr>");		
		out.println("</table>");

		out.println("<h4><a href=\" editAccount.jsp?id=" + rst.getString(1) + "&password=" + rst.getString(13) + "\">Reset Password</a></h4>");

	}
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally
{	
	closeConnection();	
}
%>

</body>
</html>

