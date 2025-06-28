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
    background: linear-gradient(135deg, #e6e5b3, #e8cd89);
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
            background: rgba(255, 255, 255, 0.92);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.25);
            text-align: center;
            animation: fadeIn 1s ease;
            position: relative;
            z-index: 2;
        }

        .welcome-container h1 {
            font-size: 2.8rem;
            color: #0d6efd;
            margin-bottom: 20px;
        }

        .welcome-container p {
            font-size: 1.2rem;
            color: #333;
            margin-bottom: 15px;
        }

        .highlight-text {
            font-weight: 500;
            color: #0d6efd;
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

        /* Floating icons background */
        .floating-icons i {
            position: absolute;
            color: rgba(255, 255, 255, 0.3);
            font-size: 60px;
            animation: floatAnim 20s linear infinite;
        }

        @keyframes floatAnim {
            from { transform: translateY(0); }
            to { transform: translateY(-100vh); }
        }

        .floating-icons i:nth-child(1) { left: 10%; animation-delay: 0s; }
        .floating-icons i:nth-child(2) { left: 25%; animation-delay: 5s; }
        .floating-icons i:nth-child(3) { left: 40%; animation-delay: 10s; }
        .floating-icons i:nth-child(4) { left: 60%; animation-delay: 2s; }
        .floating-icons i:nth-child(5) { left: 75%; animation-delay: 8s; }
        .floating-icons i:nth-child(6) { left: 90%; animation-delay: 4s; }
    </style>
</head>

<body>

    <%@ include file="navbar.jsp" %>

    

<% if (user == null) { %>
    <div class="welcome-container">
        <h1>Welcome to <span class="highlight-text">BloginGo!</span></h1>
        <p>Your creative space to <span class="highlight-text">write</span>, <span class="highlight-text">explore</span>, and <span class="highlight-text">inspire</span> readers worldwide.</p>
        
        <p><i class="bi bi-journal-text text-primary"></i> Publish your thoughts with ease.</p>
        <p><i class="bi bi-globe text-primary"></i> Connect with a global community of bloggers.</p>
        <p><i class="bi bi-lightbulb text-primary"></i> Discover new ideas and trending topics.</p>

        <div class="action-buttons">
            <a href="index.jsp" class="btn btn-primary btn-lg">
                <i class="bi bi-house-door"></i> Go to Homepage
            </a>
            <a href="dashboard.jsp" class="btn btn-success btn-lg">
                <i class="bi bi-pencil-square"></i> Write a Blog
            </a>
             <% if(user != null){ %>
            <a href=".jsp" class="btn btn-outline-danger btn-lg">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
            <% } else {%>
            <a href="register.jsp" class="btn btn-outline-dark btn-lg">
                <i class="bi bi-person-plus"></i> Join Now
            </a>
            <% }%>
        </div>
    </div>
<% } %>
<div class="floating-icons">
        <i class="bi bi-pencil-fill"></i>
        <i class="bi bi-journal-text"></i>
        <i class="bi bi-chat-left-dots"></i>
        <i class="bi bi-globe"></i>
        <i class="bi bi-lightbulb"></i>
        <i class="bi bi-cloud-upload"></i>
    </div>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
