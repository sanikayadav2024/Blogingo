<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>BloginGo Homepage</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        /* Your CSS styles are unchanged */
        body {
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #e9e7e3, #ece8e3);
            background-size: 400% 400%;
            overflow-x: hidden;
            animation: gradientMove 15s ease infinite alternate;
        }
        @keyframes gradientMove {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        .floating-icons i {
            position: absolute;
            color: rgba(198, 198, 198, 0.3);
            font-size: 60px;
            animation: floatAnim 15s linear infinite;
        }
        @keyframes floatAnim {
            from { transform: translateY(0); }
            to { transform: translateY(-120vh); }
        }
        .main-content {
            max-width: 1000px;
            margin: 30px auto;
            position: relative;
            z-index: 2;
        }
        .intro-section, .steps-section {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            margin-bottom: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .steps-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }
        .step-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            border: 1px solid #dee2e6;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s;
        }
        .step-card:hover { transform: translateY(-5px); }
        .step-card i {
            font-size: 40px;
            color: #0d6efd;
            margin-bottom: 15px;
        }
        .blog-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }
        .blog {
            background: white;
            border: 1px solid #dee2e6;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            animation: slideUp 0.6s forwards;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 320px;
        }
        .blog p {
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 4;
            -webkit-box-orient: vertical;
            text-overflow: ellipsis;
            margin-bottom: 10px;
            color: #333;
        }
        .blog:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .read-more {
            color: #0d6efd;
            text-decoration: none;
            font-weight: 500;
        }
        .read-more:hover {
            color: #0056b3;
            text-decoration: underline;
        }
        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
    </style>
</head>

<body>
<%@ include file="navbar.jsp" %>


<div class="main-content container">

    <!-- Intro -->
    <div class="intro-section">
        <h1 class="text-center mb-3">Welcome to <span style="color:#0d6efd;">BloginGo</span></h1>
        <p class="lead text-center">Your space to share ideas, inspire others, and build your writing journey.</p>
    </div>

    <!-- Steps -->
    <div class="steps-section">
        <h3 class="text-center mb-4">Get Started in 3 Simple Steps</h3>
        <div class="steps-cards">
            <div class="step-card"><i class="bi bi-lightbulb"></i><h5>Choose Your Topic</h5><p>Pick a topic you're passionate about.</p></div>
            <div class="step-card"><i class="bi bi-pencil-square"></i><h5>Write Your Blog</h5><p>Create engaging content easily.</p></div>
            <div class="step-card"><i class="bi bi-cloud-upload"></i><h5>Upload & Share</h5><p>Share your blog with the world!</p></div>
        </div>
    </div>

    <% if (user == null) { %>
        <h2 class="mb-4">Public Blogs</h2>
        <div class="blog-grid">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String dbUrl = System.getenv("DB_URL");
                String dbUser = System.getenv("DB_USER");
                String dbPass = System.getenv("DB_PASS");

                if (dbUrl != null && dbUser != null && dbPass != null) {
                    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                    PreparedStatement ps = conn.prepareStatement("SELECT * FROM public_blogs ORDER BY created_at DESC");
                    ResultSet rs = ps.executeQuery();
                    boolean found = false;

                    while (rs.next()) {
                        found = true;
        %>
            <div class="blog">
                <h4><%= rs.getString("title") %></h4>
                <p><%= rs.getString("content") %></p>
                <small class="text-muted">Author: <%= rs.getString("author") %> | Posted: <%= rs.getString("created_at") %></small>
                <br><a href="welcome.jsp" class="read-more">Read More</a>
            </div>
        <%
                    }
                    if (!found) {
                        out.println("<p>No public blogs available at the moment.</p>");
                    }
                    rs.close(); ps.close(); conn.close();
                } else {
                    out.println("<p class='text-danger'>DB environment variables not set.</p>");
                }
            } catch (Exception e) {
                out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
            }
        %>
        </div>
    <% } else { %>

        <p class="text-end">Welcome, <strong><%= user %></strong></p>

        <div class="text-center">
            <a href="dashboard.jsp" class="btn btn-dark mt-4"><i class="bi bi-upload"></i> Upload Your Blog</a>
        </div>

        <h2 class="mt-5 mb-4">All Blogs</h2>
        <div class="blog-grid">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String dbUrl = System.getenv("DB_URL");
                String dbUser = System.getenv("DB_USER");
                String dbPass = System.getenv("DB_PASS");

                if (dbUrl != null && dbUser != null && dbPass != null) {
                    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                    PreparedStatement ps = conn.prepareStatement("SELECT * FROM blogs ORDER BY created_at DESC");
                    ResultSet rs = ps.executeQuery();
                    boolean found = false;

                    while (rs.next()) {
                        found = true;
        %>
            <div class="blog">
                <h4><%= rs.getString("title") %></h4>
                <p><%= rs.getString("content") %></p>
                <small class="text-muted">Author: <%= rs.getString("author") %> | Posted: <%= rs.getString("created_at") %></small>
                <br><a href="blog.jsp?id=<%= rs.getString("id") %>" class="read-more">Read More</a>
            </div>
        <%
                    }
                    if (!found) {
                        out.println("<p>No blogs posted yet.</p>");
                    }
                    rs.close(); ps.close(); conn.close();
                } else {
                    out.println("<p class='text-danger'>DB environment variables not set.</p>");
                }
            } catch (Exception e) {
                out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
            }
        %>
        </div>
    <% } %>
</div>

<!-- Floating Icons -->
<div class="floating-icons">
    <i class="bi bi-pencil-fill" style="left:5%; animation-delay:0s;"></i>
    <i class="bi bi-journal-text" style="left:15%; animation-delay:4s;"></i>
    <i class="bi bi-lightbulb" style="left:30%; animation-delay:6s;"></i>
    <i class="bi bi-globe" style="left:45%; animation-delay:2s;"></i>
    <i class="bi bi-cloud-upload" style="left:60%; animation-delay:8s;"></i>
    <i class="bi bi-chat-dots" style="left:70%; animation-delay:3s;"></i>
    <i class="bi bi-star" style="left:80%; animation-delay:5s;"></i>
    <i class="bi bi-bookmark" style="left:90%; animation-delay:7s;"></i>
</div>

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
