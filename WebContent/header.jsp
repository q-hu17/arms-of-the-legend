<%
	String un = (String) session.getAttribute("authenticatedUser");
	if (un != null) {
		out.print("<h4 align=\"right\">Welcome, "+un+"!" + "<td>&nbsp;&nbsp;&nbsp;</td>" + "<td><button><a href=\"logout.jsp\" style=\"text-decoration: none; color: black;\">Log out</a></td></button></td></h4>");
    }
%>