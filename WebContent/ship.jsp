<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Arms of the Legends Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id

	String orderId = request.getParameter("orderId");
	int oi = Integer.parseInt(orderId);
          
	// TODO: Check if valid order id
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";

	String sql = "";

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
	// TODO: Start a transaction (turn-off auto-commit)

	con.setAutoCommit(false);

	// TODO: Retrieve all items in order with given id

	String t1 = "SELECT orderproduct.productId, orderproduct.quantity, productinventory.quantity, warehouseId" +
				" FROM orderproduct JOIN productinventory ON orderproduct.productId = productinventory.productId" +
				" WHERE orderproduct.orderId = ?";
	PreparedStatement pstmt = con.prepareStatement(t1);
	pstmt.setInt(1,oi);
	ResultSet rst = pstmt.executeQuery();
	
	if(!rst.next()){
		out.println("<h1>The order id: " + oi + " is not valid</h1>");
		con.rollback();
	}
	else{
		do {
			int previous = rst.getInt(3);
			int current = rst.getInt(3) - rst.getInt(2);

			if (current >= 0){
		
				// Insert shipment records

				String t2 = " INSERT shipment(shipmentDate, warehouseId) VALUES (?,1)";
				PreparedStatement pstmt1 = con.prepareStatement(t2);
				
				java.sql.Timestamp ts = new java.sql.Timestamp(new java.util.Date().getTime());
				pstmt1.setTimestamp(1,ts);
				
				pstmt1.executeUpdate();
		
		
				// Update inventory
				String t3 = " UPDATE productinventory SET quantity = ?";
				PreparedStatement pstmt2 = con.prepareStatement(t3);
				pstmt2.setInt(1, current);
				pstmt2.executeUpdate();

				// Update shipment status
				String t4 = "UPDATE shipment SET shipmentDesc = ? ";
				String status = "shipped";
				PreparedStatement pstmt3 = con.prepareStatement(t4);
				pstmt3.setString(1,status);
				pstmt3.executeUpdate();

				// Update order status
				String t5 = "UPDATE orderproduct SET orderDesc = ? WHERE orderproduct.orderId = ?";
				String status1 = "shipped";
				PreparedStatement pstmt4 = con.prepareStatement(t5);
				pstmt4.setString(1,status1);
				pstmt4.setInt(2,oi);

				pstmt4.executeUpdate();

		
				out.print("<h2>Ordered product: " + rst.getInt(1));
				out.print(" Qty: " + rst.getInt(2));
				out.print(" New inventory: " + current );
				out.print(" Order status: " + status + "</h2>");
				out.println("\n");
				out.println("\n");

				con.commit();

		
			} 
			else {

				out.println("<h1>Shipment not done. Insufficient inventory for product id: " + rst.getInt(1) + "</h1>");
				con.rollback();
			}
		}while (rst.next());
	}
	
	
	

	
	// TODO: Create a new shipment record.
	 
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
	con.setAutoCommit(true);

	con.close();
}
	catch (SQLException ex) 
{   out.println(ex);     
	

}

%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>



</body>
</html>
