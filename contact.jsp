<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Contact Us - BloginGo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            min-height: 100vh;
            color: white;
            background: url('images/bg.jpg') no-repeat center center fixed;
            background-size: cover;
        }
        .form-container {
            max-width: 500px;
            margin: 130px auto 50px auto;
            background: rgba(0, 0, 0, 0.85);
            padding: 30px;
            border-radius: 15px;
            animation: slideDown 1s ease;
        }
        h1 {
            text-align: center;
            color: #00BFFF;
            margin-bottom: 25px;
        }
        input, textarea {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 5px;
            border: none;
            outline: none;
            transition: transform 0.2s ease;
        }
        input:focus, textarea:focus {
            transform: scale(1.03);
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: #00BFFF;
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }
        button:hover {
            background-color: #009acd;
            transform: scale(1.05);
        }
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @media (max-width: 600px) {
            .form-container {
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

<div class="form-container">
    <h1>Contact Us</h1>
    <form action="contact_process.jsp" method="post">
        <input type="text" name="name" placeholder="Your Name" required>
        <input type="email" name="email" placeholder="Your Email" required>
        <textarea name="message" rows="5" placeholder="Your Message" required></textarea>
        <button type="submit">Send Message</button>
    </form>
</div>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
