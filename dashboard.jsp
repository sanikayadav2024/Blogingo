<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>BloginGo - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        /* same styles as before */
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="container">
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Read DB connection variables from environment
    String dbUrl = System.getenv("DB_URL");
    String dbUser = System.getenv("DB_USER");
    String dbPass = System.getenv("DB_PASS");

    if (dbUrl == null || dbUser == null || dbPass == null) {
        out.println("<p class='text-danger'>Error: Database environment variables not set.</p>");
    } else {
%>

    <h2 class="mb-4">Welcome, <%= username %>!</h2>

    <h4 class="mb-3">Post a New Blog</h4>
    <form method="post">
        <input type="text" name="title" placeholder="Blog Title" required>
        <textarea name="content" rows="4" placeholder="Your blog content..." required></textarea>
        <button type="submit" class="btn btn-dark">Post Blog</button>
    </form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
            PreparedStatement ps = conn.prepareStatement("INSERT INTO blogs(title, content, author) VALUES (?, ?, ?)");
            ps.setString(1, title);
            ps.setString(2, content);
            ps.setString(3, username);
            ps.executeUpdate();
            out.println("<p class='success'>Blog posted successfully!</p>");
            conn.close();
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    }
%>

    <hr class="my-4">
    <h4 class="mb-3">Your Blogs</h4>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM blogs WHERE author=? ORDER BY created_at DESC");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        boolean hasBlogs = false;

        while (rs.next()) {
            hasBlogs = true;
%>
        <div class="blog">
            <h5><%= rs.getString("title") %></h5>
            <p><%= rs.getString("content") %></p>
            <small class="text-muted">Posted on: <%= rs.getString("created_at") %></small>

            <div class="action-buttons">
                <a href="edit_blog.jsp?id=<%= rs.getString("id") %>" class="btn btn-sm btn-outline-primary me-2">
                    <i class="bi bi-pencil-square"></i> Edit
                </a>
                <a href="delete_blog.jsp?id=<%= rs.getString("id") %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this blog?');">
                    <i class="bi bi-trash"></i> Delete
                </a>
            </div>
        </div>
<%
        }
        if (!hasBlogs) {
            out.println("<p>You haven't posted any blogs yet.</p>");
        }
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>

<%
    } // Close DB env check
%>
</div>

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
