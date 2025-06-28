<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Terms & Conditions - BloginGo</title>
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
    <h1>Terms & Conditions</h1>
    <p>Welcome to BloginGo! By using this website, you agree to comply with the following Terms & Conditions:</p>

    <h3>1. Use of Website</h3>
    <p>You may use BloginGo for lawful purposes only. You must not misuse the platform or attempt unauthorized access.</p>

    <h3>2. User Content</h3>
    <p>You are responsible for the content you post. Do not post harmful, offensive, or illegal material.</p>

    <h3>3. Intellectual Property</h3>
    <p>The website design, branding, and functionality are owned by BloginGo. Content created by users remains their property.</p>

    <h3>4. Account Responsibility</h3>
    <p>Keep your login information secure. You are responsible for activities under your account.</p>

    <h3>5. Termination</h3>
    <p>We reserve the right to suspend or terminate accounts for violations of these terms.</p>

    <h3>6. Changes to Terms</h3>
    <p>We may update these Terms & Conditions at any time. Continued use indicates acceptance of the updated terms.</p>

    <p>For questions, <a href="contact.jsp">Contact Us</a>.</p>
</div>
<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
