<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Arms of the Legends - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for    

String productId = request.getParameter("id");
NumberFormat cf = NumberFormat.getCurrencyInstance(Locale.CANADA);

int pi = Integer.parseInt(productId);

String pn = request.getParameter("name");

String productPrice = request.getParameter("price");
double price = Double.parseDouble(productPrice);
String pri = cf.format(price);

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
        Statement stmt = con.createStatement();) 
{   

    
    sql = "SELECT productPrice, productImageURL, productDesc FROM product WHERE productName = ?";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, pn);

    ResultSet rst = pstmt.executeQuery();

	if (!rst.next())
	{
		out.println("Invalid product");
	}
	else{
		String desc = rst.getString(3);
		out.println("<h2>" + pn + "</h2>");
		out.println("<table><tr><th>Id</th>" + "<td>" + pi + "</td>");
		out.println("<tr><th>Price</th>" + "<td>" + pri+ "</td></tr>");
		out.println("<tr><th>Description</th>" + "<td>" + desc+ "</td></tr>");
		String imageURL = rst.getString("productImageURL");
		if (imageURL!=null){
		out.println("<img src=\""+imageURL+"\" width=\"400\" height=\"300\">");
		}
		out.println("<tr><th>Customer Reviews</th></tr>");

		sql = "SELECT * from review WHERE productName = ?";
		PreparedStatement pstmt1 = con.prepareStatement(sql);
		pstmt1.setString(1,pn);
		ResultSet rst1 = pstmt1.executeQuery();
		
		if(rst1.next())
		{
			do
			{
				int cid = rst1.getInt("customerId");
				String comment = rst1.getString("reviewComment");
				int rating = rst1.getInt("reviewRating");
				int ri = rst1.getInt("reviewId");
					out.println("<tr><th cospan = \"1\"></th><th>Review No.: </th>" + "<td>" + ri + "</td></tr>");
					out.println("<tr><th cospan = \"1\"></th><th>Customer ID: </th>" + "<td>" + cid + "</td></tr>");
					out.println("<tr><th cospan = \"1\"></th><th>Rating: </th>" + "<td>" + rating + "</td></tr>");
					out.println("<tr><th cospan = \"1\"></th><th>Comment: </th>" + "<td>"  + comment + "</td></tr>");
					out.println("");


			}	while (rst1.next());
		}
		else{
			out.println("<tr><td>No comments yet</td></tr>");

		}
    	out.println("</table>");
	}

out.println("<h3><a href=\"reviewRed.jsp?id=" + pi + "&name=" + pn + "&price=" + productPrice + "\">Add a review</a></h3>");
out.println("<h3><a href=\"addcart.jsp?id=" + pi + "&name=" + pn + "&price=" + productPrice + "\">Add to Cart</a></h3>");
out.println("<h3><a href=index.jsp>Continue shopping</a></h3>");

con.close();

}
catch (SQLException ex) 
{   out.println(ex); 
    
}
%>

</body>
</html>

