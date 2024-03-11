<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Arms of the Legends Order Processing</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="css/listprod_style.css">
	<link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/listprod_style.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Charm:wght@700&display=swap" rel="stylesheet">
</head>
<body>

	
        
<%@ include file="header.jsp" %>

<%
// Get customer id
String custId = request.getParameter("customerId");
// Get password
String password = request.getParameter("password");
// Get shopping cart
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
                
	if(custId==null || custId.equals(""))
	{
		out.println("<h1>"+ "Invalid customer id. Go back to the previous page and try again." + "</h1>");
	}
	
	// Determine if there are products in the shopping cart

	else if (productList.size()==0){
		out.println("<h1>"+ "Your shopping cart is empty. Go back to the previous page and try again." + "</h1>");
	}
	
	// Determine if custId is an Integer

	else{
		int number;
		try{
			number = Integer.parseInt(custId);
		}	
		catch (Exception ex){
			out.println("<h1>"+ "Invalid customer id. Go back to the previous page and try again." + "</h1>");
			return;
		} 
		
	}

try
{   // Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

// Make connection
try ( Connection con = DriverManager.getConnection(url,uid,pw);)
	{

	String id_sql = "SELECT customerId, CONCAT(firstName,' ',lastName) FROM Customer WHERE customerId = ?";
	PreparedStatement pstmt_id = con.prepareStatement(id_sql);
	int id = Integer.parseInt(custId);
	pstmt_id.setInt(1, id);
	ResultSet rst_id = pstmt_id.executeQuery();
	
	if (!rst_id.next()){
		out.println("<h1>"+ "Invalid customer id. Go back to the previous page and try again." + "</h1>");
	}

	else{

		String cust_name = rst_id.getString(2);

		NumberFormat cf = NumberFormat.getCurrencyInstance(Locale.CANADA);

/*
// Use retrieval of auto-generated keys.
PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);           
ResultSet keys = pstmt.getGeneratedKeys();
keys.next();
int order_id = keys.getInt(1);
*/

		String insert_sql = "INSERT INTO ordersummary (customerId, totalAmount, orderDate) VALUES(?, 0, ?);";
	
	//auto-generated orderId
		PreparedStatement insert_pstmt = con.prepareStatement(insert_sql, Statement.RETURN_GENERATED_KEYS);           
		insert_pstmt.setInt(1,id);
		java.sql.Timestamp ts = new java.sql.Timestamp(new java.util.Date().getTime());
		insert_pstmt.setTimestamp(2,ts);
		insert_pstmt.executeUpdate();
		ResultSet keys = insert_pstmt.getGeneratedKeys();
		keys.next();
		
		int order_id = keys.getInt(1);
	
		out.println("<h1>Your Order Summary</h1>");
		out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");


// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-price, 3-quantity

/*
Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
while (iterator.hasNext())
{ 
	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
	ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
	String productId = (String) product.get(0);
	String price = (String) product.get(2);
	double pr = Double.parseDouble(price);
	int qty = ( (Integer)product.get(3)).intValue();
		...
}
*/
		double subtotal=0;

		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
		while (iterator.hasNext())
		{ 
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String product_id = (String) product.get(0);
				out.print("<tr><td>"+product_id+"</td>" + "<td>"+product.get(1)+"</td>" + "<td>"+product.get(3)+"</td>");

				int qty = ((Integer)product.get(3)).intValue();

				if(product.get(2) == null){
					double pr = 0.0;
					out.print("<td>"+cf.format(pr)+"</td>" + "<td>"+cf.format(pr*qty)+"</td></tr>");
					out.println("</tr>");
					subtotal += pr*qty;
				}

				else{
					String price = (String)(product.get(2));
					double pr = Double.parseDouble(price);
					out.print("<td>"+cf.format(pr)+"</td>" + "<td>"+cf.format(pr*qty)+"</td></tr>");
					out.println("</tr>");
					subtotal += pr*qty;
				}
				
			
		// Insert into orderproduct
			String prod_sql = "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES(?, ?, ?, ?)";
			PreparedStatement prod_pstmt = con.prepareStatement(prod_sql);
			prod_pstmt.setInt(1, order_id);
			prod_pstmt.setInt(2, Integer.parseInt(product_id));
			prod_pstmt.setInt(3, ((Integer)product.get(3)).intValue());
			if(product.get(2) == null){
				prod_pstmt.setString(4, "0.00");
			}
			else{
			prod_pstmt.setString(4, (String)(product.get(2)));
			}
			prod_pstmt.executeUpdate();				
		}
		out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
					   +"<td>"+cf.format(subtotal)+"</td></tr>");
		out.println("</table>");

		String summary_sql = "UPDATE ordersummary SET totalAmount=? WHERE orderId=?";
		PreparedStatement summary_pstmt = con.prepareStatement(summary_sql);
		summary_pstmt.setDouble(1, subtotal);
		summary_pstmt.setInt(2, order_id);			
		summary_pstmt.executeUpdate();						

		out.println("<h1>Order completed.  Will be shipped soon...</h1>");
		out.println("<h1>Your order reference number is: " + order_id + "</h1>");
		out.println("<h1>Shipping to customer: " + custId + " Name: " + cust_name + "</h1>");

		out.println("<h2><a href=\"index.jsp\">Return to shopping</a></h2>");
					
// Clear cart if order placed successfully
	session.setAttribute("productList", null);	
}

con.close();
	}
catch (SQLException ex) 
{   out.println(ex); 
		
}
%>
</BODY>
</HTML>


