<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Arms of the Legends</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/listprod_style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@1,400;1,700&display=swap" rel="stylesheet">
</head>
<body style="background-image: linear-gradient(rgba(255,255,255,0.75), rgba(255,255,255,0.75)),url(img/listprod_background.jpg); background-size:cover; background-repeat: no-repeat; background-attachment: fixed;">

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
<br>
<br>
<form method="get" action="listprod.jsp">
	<p id="search">
		<select size="1" name="categoryName" style = >
		<option>All</option>
		
<%
String name = request.getParameter("productName");
String category = request.getParameter("categoryName");
String sql = "";
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

try ( Connection con = DriverManager.getConnection(url,uid,pw);
Statement st = con.createStatement(); )
{
	sql = "SELECT DISTINCT categoryName FROM product";
	Statement stmt = con.createStatement();
	ResultSet crst = stmt.executeQuery(sql);
	while (crst.next()){
		out.println("<option>"+crst.getString(1)+"</option>");
	}
}
catch (SQLException ex)
{       out.println(ex);
}
%>
<option>Weapons</option>
<option>Equipment</option>
<option>Accessories</option>
</select>
<div id="search">
	<input type="text" placeholder="Search for the products you are looking for..." name="productName">
	<input type="submit" value="Submit">
</div>
</p>
</form>

<% // Get product name to search for

NumberFormat cf = NumberFormat.getCurrencyInstance(Locale.CANADA);

//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}


// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection


try ( Connection con = DriverManager.getConnection(url,uid,pw);
Statement st = con.createStatement(); )
    
    {
		
// Print out the ResultSet

// name is not null 
if (name != null && !name.equals(""))
{
	out.println("<h3>Products containing '"+name+"'</h3>");
	name = "%" + name + "%";
	sql = "SELECT productId, productName, productPrice, categoryName, productImageURL,productDesc FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE ?";
}
// category is not null
else if (category != null && !category.equals("") && !category.equals("All"))
{
	out.println("<h3>Products in category: '"+category+"'</h3>");
	sql = "SELECT productId, productName, productPrice, categoryName, productImageURL,productDesc FROM product JOIN category ON product.categoryId = category.categoryId WHERE categoryName = ?";
}
// name & category are not null
else if ((name != null && !name.equals("")) && (category != null && !category.equals("") && !category.equals("All")))
{
	out.println("<h3>Products containing '"+name+"' in category: '"+category+"'</h3>");
	name = "%" + name + "%";
	sql = "SELECT productId, productName, productPrice, categoryName, productImageURL,productDesc FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE ? AND categoryName = ?";
}
// nothing entered
else
{
	out.println("<h3>All products</h3>");
	sql = "SELECT productId, productName, productPrice, categoryName, productImageURL,productDesc FROM product JOIN category ON product.categoryId = category.categoryId";
}
PreparedStatement pstmt = con.prepareStatement(sql);
if (name != null && !name.equals(""))
{
	pstmt.setString(1, name);
	if (category != null && !category.equals("") && !category.equals("All"))
	{
		pstmt.setString(2,category);
	}
}
else if (category != null && !category.equals("") && !category.equals("All"))
{
	pstmt.setString(1, category);
}
ResultSet rst = pstmt.executeQuery();
out.println("<table style=\"margin-left: 10%;\">");
out.print("<tr><th></th><th class=\"col-md-1\"></th><th class=\"col-md-1\">Item</th><th class=\"col-md-1\">Category</th><th class=\"col-md-1\">Price</th></tr>");
while (rst.next())
{
	int pid = rst.getInt("productId");
	String pname = rst.getString("productName");
	double pri = rst.getDouble("productPrice");
	String purl = "addcart.jsp?id=" + pid + "&name=" + pname + "&price=" + pri;
	

	String imageURL = rst.getString("productImageURL");

	if (imageURL!=null)
	{
		out.println("<tr><td class=\"col-md-1\"><button><a href="+purl+" style=\"text-decoration: none; color: black;\">Add to Cart</a></button></td>" + "<td><img src=\""+imageURL+"\" width=\"250\" height=\"250\" style=\"padding: 40px;\"></td>" +
		"<td  class=\"col-md-1\"><a style=\"font-size: 18px; font-family: 'Noto Serif', serif; color: #757575;\" href= \" product.jsp?id=" + pid + "&name=" + pname + "&price=" + rst.getDouble(3) + "\" >" +
			rst.getString(2)+"</a></td><td style=\"font-size: 18px; font-family: 'Noto Serif', serif; \" class=\"col-md-1\">"+rst.getString(4)+"</td><td style=\"font-size: 18px; font-family: 'Noto Serif', serif;\" class=\"col-md-1\">" + 
				cf.format(rst.getDouble(3))+"</td></tr>");
	}
	else
	{
		out.println("<td class=\"col-md-1\"><a href="+purl+">Add to Cart</a></td>" + "<td class=\"col-md-1\"></td>" +
		"<td  class=\"col-md-1\"><a href= \" product.jsp?id=" + pid + "&name=" + pname + "&price=" + rst.getDouble(3) + "\" >" +
			rst.getString(2)+"</a></td><td class=\"col-md-1\">"+rst.getString(4)+"</td><td class=\"col-md-1\">" + 
				cf.format(rst.getDouble(3))+"</td></tr>");
			}
	}

out.println("</table>");
con.close();
}
catch (SQLException ex) 
{   out.println(ex); 
    
}

%>

</body>
</html>