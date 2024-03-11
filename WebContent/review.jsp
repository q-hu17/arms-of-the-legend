<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>

<html>
<%
out.println("<h2>Say something about the product, "+un+"!</h2>");
%>

<body>

<form method="get" action=reviewSuc.jsp>

    <tr><td>Customer ID:</td><td><input type="text" name="customerId" size="20"></td></tr>

    <table>
    <p align="left">
		<select size="1" name="productName">
		<option>Product Name</option>
        <option>axe</option>
        <option>dagger</option>
        <option>spear</option>
        <option>sword</option>
        <option>armour</option>
        <option>beartrap</option>
        <option>belt</option>
        <option>bow and arrow</option>
        <option>crossbow</option>
        <option>hand cannon</option>
        <option>helmet</option>
        <option>knuckles</option>
        <option>necklace</option>
        <option>ring</option>
        <option>staff</option>
        <option>talisman</option>
        <option>wand</option>
    
    </select>

    <p align="left">
		<select size="1" name="stars">
		<option>Rating</option>
    <option>1</option>
    <option>2</option>
    <option>3</option>
    <option>4</option>
    <option>5</option>
    </select>

        Comment: 
        <br>
         <textarea rows = "5" cols = "60" name = "productReview">
         </textarea><br>
        
         <tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>

        </table>

        </form>



<%

String custId = request.getParameter("customerId");

String password = request.getParameter("password");

String pn = request.getParameter("productName");

String preview = request.getParameter("productReview");

String sql = "";

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

if(custId==null || custId.equals(""))
	{
		out.println("<h1>"+ "Invalid customer id. Go back to the previous page and try again." + "</h1>");
	}
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


//    String star = request.getParameter("stars");
//   int rating = Integer.parseInt(star);

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

    out.println("<h3><a href=shop.html>Continue shopping</a></h3>");
    out.println("<h3><a href=showcart.jsp>View cart</a></h3>");

    con.close();

}
catch (SQLException ex) 
{   out.println(ex); 
    
}
%>

</body>
</html>