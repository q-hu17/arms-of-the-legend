<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Currency" %>
<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>

<html>

<%

String custId = request.getParameter("customerId");

int cid = Integer.parseInt(custId);

String pn = request.getParameter("productName");

String preview = request.getParameter("productReview");

String star = request.getParameter("stars");

int rating = Integer.parseInt(star);

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

    
                sql = "SELECT productName FROM review WHERE customerId = ? ";
                PreparedStatement pstmt4 = con.prepareStatement(sql);
                pstmt4.setInt(1, cid);
                ResultSet rst4 = pstmt4.executeQuery(); 
                java.sql.Timestamp ts = new java.sql.Timestamp(new java.util.Date().getTime());
                if (rst4.next()) 
                {
                    if (rst4.getString(1).equals(pn)) //user left a comment on this product before
                    {
                        out.println("<h3>You have already added a comment on this product before!</h3>");
                    }
                    else 
                    {
                        sql = "INSERT INTO review(reviewRating, reviewDate, customerId, productName, reviewComment) VALUES (?,?,?,?,?)";

                        PreparedStatement pstmt2 = con.prepareStatement(sql);
                        pstmt2.setInt(1, rating);
                        pstmt2.setTimestamp(2, ts);
                        pstmt2.setInt(3, cid);
                        pstmt2.setString(4, pn);
                        pstmt2.setString(5, preview);
                        pstmt2.executeUpdate();

                        out.println("<h3>You have successfully added a comment!</h3>");
                    }
                }
                else 
                {
                    sql = "INSERT INTO review(reviewRating, reviewDate, customerId, productName, reviewComment) VALUES (?,?,?,?,?)";

                    PreparedStatement pstmt2 = con.prepareStatement(sql);
                    pstmt2.setInt(1, rating);
                    pstmt2.setTimestamp(2, ts);
                    pstmt2.setInt(3, cid);
                    pstmt2.setString(4, pn);
                    pstmt2.setString(5, preview);
                    pstmt2.executeUpdate();

                    out.println("<h3>You have successfully added a comment!</h3>");
                }
            
        
    

        
        
        out.println("<h3><a href=listprod.jsp>Back to main page</a></h3>");
    out.println("<h3><a href=listprod.jsp>Continue shopping</a></h3>");
    out.println("<h3><a href=showcart.jsp>View cart</a></h3>");


    con.close();

}
catch (SQLException ex) 
{   out.println(ex); 
    
}
%>

</html>
