<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="css/index_style.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Charm:wght@700&display=swap" rel="stylesheet">

    <title>Arms of the Legends Main Page</title>
</head>
<body style="background-image: url(img/index_background.jpg); background-size: cover;">
	<!-- <div id="navi_bar">
		<ul>
			<li><a class="home" href="index.jsp">Home</a></li>
			<li><a href="listprod.jsp">Begin Shopping</a></li>
			<li><a href="listorder.jsp">List All Orders</a></li>
			<li><a href="customer.jsp">Customer Info</a></li>
			<li><a href="admin.jsp">Administrators</a></li>
			<li><a href="login.jsp">Login</a></li>
			<li><a href="signUp.jsp">Sign Up</a></li>
			<li><a href="logout.jsp">Log out</a></li>
			<li><a href="showcart.jsp"><img src="http://www.clker.com/cliparts/U/D/n/G/6/h/white-shopping-cart-md.png" alt="Cart" style="width:15px;height:15px; background-position: -65px 0px;"></a></li>
		</ul>
	</div> -->

	<div>
		<button  id="enter_store"> <a href="listprod.jsp" style="text-decoration: none; color: black;">Enter Store</a></button>
	</div>

	<div>
		<h2 id="sub_heading">Welcome to</h2>
		<h1 id="heading">ARMS OF THE LEGENDS</h1>
	</div>

<%
	String un = (String) session.getAttribute("authenticatedUser");
	if (un != null)
		out.println("<h3 align=\"center\" style=\"font-family: 'Charm', cursive; color: black; font-size: 20px;\">Welcome, "+un+"</h3>");
%>
</body>
</head>


