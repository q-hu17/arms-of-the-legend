<!DOCTYPE html>
<html>
	<head>
	<title>Login</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="css/listprod_style.css">
	<link rel="stylesheet" href="css/login.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Charm:wght@700&display=swap" rel="stylesheet">
	</head>
	<body style="background-image: linear-gradient(rgba(255,255,255,0.75), rgba(255,255,255,0.75)),url(img/login_background.jpg); background-size:cover; background-repeat: no-repeat; background-attachment: fixed;">

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

		<%
		// Print prior error login message if present
		if (session.getAttribute("loginMessage") != null)
			out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
		%>

			<br>
			<p style="font-size: 40px; position: absolute; top: 40%; left: 48.1%; z-index: 2; font-family: 'Charm', cursive;">Login</p>

			<div class="container">
				<form name="MyForm" method=post action="validateLogin.jsp" id="interface">
				<table style="display:inline">
				<tr>
					<td><div><font face="Arial, Helvetica, sans-serif" size="3">Username:&nbsp;</font></div></td>
					<td><input type="text" name="username"  size=10 maxlength=10 class="input"></td>
				</tr>
				<tr>
					<td><div><font face="Arial, Helvetica, sans-serif" size="3">Password:&nbsp;</font></div></td>
					<td><input type="password" name="password" size=10 maxlength="10" class="input"></td>
				</tr>
				</table>
				<br/>
				<br>
				<input class="submit" type="submit" name="Submit2" value="Log In">
				
				<br><br><br><br><br>
				<h6><a href=forgetPassword.jsp>Forget Password</a><h4></h4>
				</form>
			</div>
		</div>

	</body>
</html>

