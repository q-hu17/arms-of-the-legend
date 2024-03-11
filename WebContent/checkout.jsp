<html>
<head>
    <title>Checkout</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="css/listprod_style.css">
	<link rel="stylesheet" href="css/login.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Charm:wght@700&display=swap" rel="stylesheet">
</head>
<body style="background-image: linear-gradient(rgba(255,255,255,0.75), rgba(255,255,255,0.75)),url(img/showcart_background.jpg); background-size:cover; background-repeat: no-repeat; background-attachment: fixed;">

    <div>

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

<h1 style="font-size: 40px; position: absolute; top: 13%; left: 28%; z-index: 2; font-family: 'Charm', cursive;">Enter your customer id and password to complete the transaction:</h1>
<div class="container">
    <form method="get" action="payment.jsp">
        <table style="position: absolute; top: 30%;">
            <tr><td>Customer ID:</td><td><input type="text" name="customerId" size="20" class="cusID"></td></tr>
            <tr><td>Password:</td><td><input type="password" name="password" size="20" class="cusID"></td></tr>
            <tr><td><input id="search" type="submit" value="Submit"><input type="reset" value="Reset"></td></tr>
        </table>
    </form>
</div>
</body>
</html>

