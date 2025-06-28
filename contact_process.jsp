<%@ page import="java.io.*, javax.mail.*, javax.mail.internet.*, java.util.*" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

    // Simulate storing or sending email (You can replace this with email logic)
%>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Submitted - BloginGo</title>
</head>
<body>
    <h1>Thank You!</h1>
    <p>Thank you, <b><%= name %></b>, for reaching out. We have received your message and will get back to you at <b><%= email %></b>.</p>
</body>
</html>
