<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BloginGo Homepage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #e9e7e3, #ece8e3);
            background-size: 400% 400%;
            overflow-x: hidden;
            position: relative;
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

        .floating-icons i:nth-child(1) { left: 5%; animation-delay: 0s; }
        .floating-icons i:nth-child(2) { left: 15%; animation-delay: 5s; }
        .floating-icons i:nth-child(3) { left: 30%; animation-delay: 10s; }
        .floating-icons i:nth-child(4) { left: 50%; animation-delay: 2s; }
        .floating-icons i:nth-child(5) { left: 65%; animation-delay: 7s; }
        .floating-icons i:nth-child(6) { left: 80%; animation-delay: 3s; }
        .floating-icons i:nth-child(7) { left: 90%; animation-delay: 6s; }
        .floating-icons i:nth-child(8) { left: 25%; animation-delay: 12s; }
        .floating-icons i:nth-child(9) { left: 75%; animation-delay: 9s; }

        .main-content {
            flex: 1;
            max-width: 1000px;
            margin: 30px auto;
            animation: fadeIn 1s ease;
            width: 100%;
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
            margin-top: 20px;
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

        .step-card:hover {
            transform: translateY(-5px);
        }

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
            opacity: 0;
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
            display: inline-block;
            margin-top: 10px;
            color: #0d6efd;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        .read-more:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
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
        <div class="intro-section">
            <h1 class="text-center mb-3">Welcome to <span style="color:#0d6efd;">BloginGo</span></h1>
            <p class="lead text-center">Your space to share ideas, inspire others, and build your writing journey.</p>
        </div>

        <div class="steps-section">
            <h3 class="text-center mb-4">Get Started in 3 Simple Steps</h3>
            <div class="steps-cards">
                <div class="step-card">
                    <i class="bi bi-lightbulb"></i>
                    <h5>Choose Your Topic</h5>
                    <p>Pick a topic you're passionate about—technology, travel, lifestyle, anything!</p>
                </div>
                <div class="step-card">
                    <i class="bi bi-pencil-square"></i>
                    <h5>Write Your Blog</h5>
                    <p>Express your thoughts, add images, and create engaging content easily.</p>
                </div>
                <div class="step-card">
                    <i class="bi bi-cloud-upload"></i>
                    <h5>Upload & Share</h5>
                    <p>Post your blog and share your knowledge with the world. It's that simple!</p>
                </div>
            </div>
        </div>

        <% if (user != null) { %>
            <p class="text-end">Welcome, <strong><%= user %></strong></p>
        <% } %>

        <% if (user == null) { %>
            <h2 class="mb-4">Public Blogs</h2>
            <div class="blog-grid">
             <%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    String dbUrl = System.getenv("DB_URL");
    String dbUser = System.getenv("DB_USER");
    String dbPass = System.getenv("DB_PASS");

    if (dbUrl == null || dbUser == null || dbPass == null) {
        out.println("<p class='text-danger'>Error: One or more DB environment variables are missing.</p>");
        out.println("<p>DB_URL = " + dbUrl + "</p>");
        out.println("<p>DB_USER = " + dbUser + "</p>");
        out.println("<p>DB_PASS = " + (dbPass != null ? "****" : "null") + "</p>");
    } else {
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        // ... Your code to run the SQL query ...
 while (rs.next()) { hasPublicBlogs = true; %>
                        <div class="blog">
                            <h4><%= rs.getString("title") %></h4>
                            <p><%= rs.getString("content") %></p>
                            <small class="text-muted">Author: <%= rs.getString("author") %> | Posted on: <%= rs.getString("created_at") %></small>
                            <br><a href="welcome.jsp" class="read-more">Read More</a>
                        </div>
    }
} catch (Exception e) {
    out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
}
%>

            </div>
        <% } %>

        <% if (user != null) { %>
    <div class="text-center">
        <a href="dashboard.jsp" class="btn btn-dark mt-4"><i class="bi bi-upload"></i> Upload Your Blog</a>
    </div>

    <h2 class="mt-5 mb-4">All Blogs</h2>
    <div class="blog-grid">
        <% 
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Fetch database credentials from environment variables
                String dbUrl = System.getenv("DB_URL");
                String dbUser = System.getenv("DB_USER");
                String dbPass = System.getenv("DB_PASS");

                if (dbUrl == null || dbUser == null || dbPass == null) {
                    out.println("<p class='text-danger'>Database environment variables are not set.</p>");
                } else {
                    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                    String sql = "SELECT * FROM blogs ORDER BY created_at DESC";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();
                    boolean hasBlogs = false;

                    while (rs.next()) {
                        hasBlogs = true;
        %>
                        <div class="blog">
                            <h4><%= rs.getString("title") %></h4>
                            <p><%= rs.getString("content") %></p>
                            <small class="text-muted">
                                Author: <%= rs.getString("author") %> | Posted on: <%= rs.getString("created_at") %>
                            </small>
                            <br>
                            <a href="blog.jsp?id=<%= rs.getString("id") %>" class="read-more">Read More</a>
                        </div>
        <%
                    }
                    if (!hasBlogs) {
                        out.println("<p>No blogs posted yet.</p>");
                    }
                    conn.close();
                }
            } catch (Exception e) {
                out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
            }
        %>
    </div>
<% } else { %>
    <p class="text-center mt-4">Please <a href="login.jsp">login</a> to view all blogs and upload your own.</p>
<% } %>
</div>
    <div class="floating-icons">
        <i class="bi bi-pencil-fill"></i>
        <i class="bi bi-journal-text"></i>
        <i class="bi bi-lightbulb"></i>
        <i class="bi bi-globe"></i>
        <i class="bi bi-cloud-upload"></i>
        <i class="bi bi-chat-dots"></i>
        <i class="bi bi-star"></i>
        <i class="bi bi-bookmark"></i>
        <i class="bi bi-rocket"></i>
    </div>

    <%@ include file="footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
