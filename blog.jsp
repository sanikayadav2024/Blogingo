<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, javax.servlet.*, javax.servlet.http.*" session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>BloginGo - Blog Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #f0f4f8, #dbe5ed);
            min-height: 100vh;
            padding-top: 80px;
        }

        .blog-container {
            max-width: 800px;
            margin: 20px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            animation: fadeIn 0.8s ease;
            position: relative;
        }

        h2 {
            color: #0d6efd;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .blog-meta {
            font-size: 14px;
            color: #6c757d;
            margin-bottom: 20px;
        }

        .blog-content {
            font-size: 16px;
            line-height: 1.6;
            color: #333;
            margin-bottom: 30px;
        }

        .likes-count {
            font-size: 16px;
            margin-top: 15px;
            color: #198754;
        }

        .btn-like, .btn-unlike {
            min-width: 150px;
            margin-right: 10px;
            margin-top: 10px;
            transition: transform 0.2s;
        }

        .btn-like:hover, .btn-unlike:hover {
            transform: scale(1.05);
        }

        .back-home {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="blog-container">
<%
    String blogId = request.getParameter("id");
    String username = (String) session.getAttribute("username");

    if (blogId == null || blogId.trim().equals("")) {
        out.println("<p class='text-danger'>Invalid blog ID provided.</p>");
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bloggingo", "root", "");

            // Fetch Blog
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM blogs WHERE id=?");
            ps.setString(1, blogId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
%>
        <h2><%= rs.getString("title") %></h2>
        <p class="blog-meta">By <%= rs.getString("author") %> | Posted on: <%= rs.getString("created_at") %></p>
        <hr>
        <div class="blog-content"><%= rs.getString("content") %></div>

        <p class="likes-count">
            <i class="bi bi-hand-thumbs-up-fill"></i> <strong><%= rs.getInt("likes") %></strong> Likes &nbsp;
            <i class="bi bi-hand-thumbs-down-fill text-danger"></i> <strong><%= rs.getInt("unlikes") %></strong> Unlikes
        </p>

<%
                // Check user's reaction
                PreparedStatement checkReaction = conn.prepareStatement("SELECT liked FROM blog_likes WHERE blog_id=? AND username=?");
                checkReaction.setString(1, blogId);
                checkReaction.setString(2, username);
                ResultSet reactionRs = checkReaction.executeQuery();

                if (reactionRs.next()) {
                    boolean liked = reactionRs.getBoolean("liked");

                    if (liked) {
%>
        <!-- Show Unlike Button -->
        <form action="unlike_blog.jsp" method="post" style="display:inline;">
            <input type="hidden" name="id" value="<%= rs.getString("id") %>">
            <button type="submit" class="btn btn-outline-danger btn-unlike">
                <i class="bi bi-hand-thumbs-down"></i> Unlike
            </button>
        </form>
<%
                    } else {
%>
        <!-- Show Like Button -->
        <form action="like_blog.jsp" method="post" style="display:inline;">
            <input type="hidden" name="id" value="<%= rs.getString("id") %>">
            <button type="submit" class="btn btn-success btn-like">
                <i class="bi bi-hand-thumbs-up"></i> Like
            </button>
        </form>
<%
                    }
                } else {
%>
        <!-- First time - Show Like Button -->
        <form action="like_blog.jsp" method="post" style="display:inline;">
            <input type="hidden" name="id" value="<%= rs.getString("id") %>">
            <button type="submit" class="btn btn-success btn-like">
                <i class="bi bi-hand-thumbs-up"></i> Like
            </button>
        </form>
<%
                }
            } else {
                out.println("<p class='text-danger'>Blog not found.</p>");
            }
            conn.close();
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
        }
    }
%>
</div>

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
