<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to BloginGo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            min-height: 100vh;
            background: url('./bg3.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
            position: relative;
            animation: gradientMove 15s ease infinite alternate;
        }

        @keyframes gradientMove {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .welcome-container {
            flex: 1;
            max-width: 800px;
            margin: 80px auto;
            background: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
            text-align: center;
            animation: fadeIn 1s ease;
        }

        .welcome-container h1 {
            font-size: 2.8rem;
            color: #0d6efd;
            margin-bottom: 20px;
        }

        .welcome-container p {
            font-size: 1.2rem;
            color: #333;
        }

        .action-buttons {
            margin-top: 30px;
        }

        .action-buttons a {
            margin: 10px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>

<body>
    
    <%@ include file="navbar.jsp" %>
<% if(user == null){ %>
    <div class="welcome-container">
        <h1>Welcome to BloginGo!</h1>
        <p>Your space to share ideas, connect with readers, and explore inspiring blogs from creators worldwide.</p>

        <div class="action-buttons">
            <a href="homepage.jsp" class="btn btn-primary btn-lg">
                <i class="bi bi-house-door"></i> Go to Homepage
            </a>
            <a href="dashboard.jsp" class="btn btn-success btn-lg">
                <i class="bi bi-pencil-square"></i> Write a Blog
            </a>
            <a href="logout.jsp" class="btn btn-outline-danger btn-lg">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
        </div>
    </div>
  <% } %>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
 <% if(user != null){ %>
            <a href=".jsp" class="btn btn-outline-danger btn-lg">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
            <% } %>