<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, javax.servlet.*, javax.servlet.http.*" session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>BloginGo - Blog Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- Mobile Scaling -->
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
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            animation: fadeIn 0.8s ease;
        }

        h2 {
            color: #0d6efd;
            font-weight: 600;
            margin-bottom: 15px;
            font-size: 1.6rem;
        }

        .blog-meta {
            font-size: 0.9rem;
            color: #6c757d;
            margin-bottom: 15px;
        }

        .blog-content {
            font-size: 1rem;
            line-height: 1.7;
            color: #333;
            margin-bottom: 30px;
            word-wrap: break-word;
        }

        .likes-count {
            font-size: 1rem;
            margin-top: 10px;
            color: #198754;
        }

        .btn-like, .btn-unlike {
            width: 100%;
            margin-bottom: 10px;
            transition: transform 0.2s;
        }

        .btn-like:hover, .btn-unlike:hover {
            transform: scale(1.03);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (min-width: 576px) {
            .btn-like, .btn-unlike {
                width: auto;
                margin-right: 10px;
            }
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="blog-container">
    <%
        String blogId = request.getParameter("id");
        String username = (String) session.getAttribute("username");

        if (blogId == null || blogId.trim().equals("")) {
            out.println("<p class='text-danger'>Invalid blog ID provided.</p>");
        } else {
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

                String dbUrl = System.getenv("DB_URL");
                String dbUser = System.getenv("DB_USER");
                String dbPass = System.getenv("DB_PASS");

                if (dbUrl == null || dbUser == null || dbPass == null) {
                    out.println("<p class='text-danger'>Error: One or more DB environment variables are missing.</p>");
                } else {
                    conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

                    ps = conn.prepareStatement("SELECT * FROM blogs WHERE id=?");
                    ps.setString(1, blogId);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        String title = rs.getString("title");
                        String content = rs.getString("content");
                        String author = rs.getString("author");
                        String createdAt = rs.getString("created_at");
                        int likes = rs.getInt("likes");
                        int unlikes = rs.getInt("unlikes");
    %>
        <h2><%= title %></h2>
        <p class="blog-meta">By <%= author %> | <%= createdAt %></p>
        <hr>
        <div class="blog-content"><%= content %></div>

        <p class="likes-count">
            <i class="bi bi-hand-thumbs-up-fill"></i> <strong><%= likes %></strong> Likes &nbsp;
            <i class="bi bi-hand-thumbs-down-fill text-danger"></i> <strong><%= unlikes %></strong> Unlikes
        </p>

    <%
                        if (username != null) {
                            PreparedStatement checkReaction = conn.prepareStatement("SELECT liked FROM blog_likes WHERE blog_id=? AND username=?");
                            checkReaction.setString(1, blogId);
                            checkReaction.setString(2, username);
                            ResultSet reactionRs = checkReaction.executeQuery();

                            if (reactionRs.next()) {
                                boolean liked = reactionRs.getBoolean("liked");

                                if (liked) {
    %>
        <!-- Unlike Button -->
        <form action="unlike_blog.jsp" method="post">
            <input type="hidden" name="id" value="<%= blogId %>">
            <button type="submit" class="btn btn-outline-danger btn-unlike">
                <i class="bi bi-hand-thumbs-down"></i> Unlike
            </button>
        </form>
    <%
                                } else {
    %>
        <!-- Like Button -->
        <form action="like_blog.jsp" method="post">
            <input type="hidden" name="id" value="<%= blogId %>">
            <button type="submit" class="btn btn-success btn-like">
                <i class="bi bi-hand-thumbs-up"></i> Like
            </button>
        </form>
    <%
                                }
                            } else {
    %>
        <!-- First Time Like -->
        <form action="like_blog.jsp" method="post">
            <input type="hidden" name="id" value="<%= blogId %>">
            <button type="submit" class="btn btn-success btn-like">
                <i class="bi bi-hand-thumbs-up"></i> Like
            </button>
        </form>
    <%
                            }
                            reactionRs.close();
                            checkReaction.close();
                        } else {
                            out.println("<p class='text-muted mt-3'>Login to like or unlike this blog.</p>");
                        }
                    } else {
                        out.println("<p class='text-danger'>Blog not found.</p>");
                    }
                }
            } catch (Exception e) {
                out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ignore) {}
                try { if (ps != null) ps.close(); } catch (Exception ignore) {}
                try { if (conn != null) conn.close(); } catch (Exception ignore) {}
            }
        }
    %>
    </div>
</div>

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
