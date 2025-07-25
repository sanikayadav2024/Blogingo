<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register - BloginGo</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .register-wrapper {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .register-container {
            background-color: white;
            padding: 30px 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
            animation: fadeIn 0.8s ease;
        }

        .register-container h2 {
            margin-bottom: 20px;
        }

        .register-container input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .register-container button {
            width: 100%;
            padding: 10px;
            background-color: #343a40;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        .register-container button:hover {
            background-color: #495057;
            transform: scale(1.02);
        }

        .register-container a {
            display: block;
            margin-top: 15px;
            text-decoration: none;
            color: #007BFF;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="register-wrapper">
    <div class="register-container">
        <h2>Create Account</h2>
        <form method="post">
            <input type="text" name="username" placeholder="Username" required><br>
            <input type="email" name="email" placeholder="Email" required><br>
            <input type="password" name="password" placeholder="Password" required><br>
            <button type="submit">Register</button>
        </form>

        <a href="login.jsp">Already have an account? Login</a>

<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pst = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String dbUrl = System.getenv("DB_URL");
            String dbUser = System.getenv("DB_USER");
            String dbPass = System.getenv("DB_PASS");

            if (dbUrl == null || dbUser == null || dbPass == null) {
%>
                <p style="color:red;">Error: One or more DB environment variables are missing.</p>
<%
            } else {
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                pst = conn.prepareStatement("INSERT INTO users(username, email, password) VALUES (?, ?, ?)");
                pst.setString(1, username);
                pst.setString(2, email);
                pst.setString(3, password);

                int rows = pst.executeUpdate();
                if (rows > 0) {
%>
                    <p style="color:green; margin-top:15px;">Registration Successful! <a href="login.jsp">Login Now</a></p>
<%
                } else {
%>
                    <p style="color:red; margin-top:15px;">Registration Failed. Please try again.</p>
<%
                }
            }
        } catch (Exception e) {
%>
            <p style="color:red;">Error: <%= e.getMessage() %></p>
<%
        } finally {
            try { if (pst != null) pst.close(); } catch (Exception ignore) {}
            try { if (conn != null) conn.close(); } catch (Exception ignore) {}
        }
    }
%>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
