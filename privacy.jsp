<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Privacy Policy - BloginGo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            color: white;
            min-height: 100vh;
            background: url('images/bg.jpg') no-repeat center center fixed;
            background-size: cover;
        }
        .content-container {
            max-width: 800px;
            margin: 130px auto 50px auto;
            background: rgba(0, 0, 0, 0.8);
            padding: 30px;
            border-radius: 15px;
            animation: fadeIn 1s ease;
            color: white;
        }
        h1, h3 {
            color: #00BFFF;
            margin-bottom: 15px;
        }
        p, li {
            line-height: 1.7;
            margin-bottom: 10px;
        }
        a {
            color: #00BFFF;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        a:hover {
            color: #FFD700;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @media (max-width: 600px) {
            .content-container {
                margin: 100px 20px 30px 20px;
                padding: 20px;
            }
            h1 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="content-container">
    <h1>Privacy Policy</h1>
    <p>Your privacy is important to us. BloginGo is committed to protecting your personal information.</p>

    <h3>Information We Collect</h3>
    <ul>
        <li>Your name and email when you register.</li>
        <li>Usage data like your IP address and browser type.</li>
    </ul>

    <h3>How We Use Information</h3>
    <ul>
        <li>To personalize your experience.</li>
        <li>To maintain security and service quality.</li>
    </ul>

    <h3>Contact</h3>
    <p>If you have questions, <a href="contact.jsp">Contact Us</a>.</p>
</div>

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
