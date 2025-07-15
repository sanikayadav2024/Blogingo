<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login - BloginGo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .login-wrapper {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .login-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
            width: 320px;
            text-align: center;
            animation: fadeIn 0.8s ease;
        }

        .login-container h2 {
            margin-bottom: 20px;
        }

        .login-container input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .login-container button {
            padding: 10px 20px;
            background-color: #343a40;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        .login-container button:hover {
            background-color: #495057;
            transform: scale(1.05);
        }

        .login-container a {
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

<div class="login-wrapper">
    <div class="login-container">
        <h2>User Login</h2>
        <form method="post">
            <input type="text" name="username" placeholder="Username" required><br>
            <input type="password" name="password" placeholder="Password" required><br>
            <button type="submit">Login</button>
        </form>

        <a href="register.jsp">Don't have an account? Register</a>

        <%
            if (request.getMethod().equalsIgnoreCase("post")) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                Connection conn = null;
                PreparedStatement pst = null;
                ResultSet rs = null;

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
                        pst = conn.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?");
                        pst.setString(1, username);
                        pst.setString(2, password);
                        rs = pst.executeQuery();

                        if (rs.next()) {
                            session.setAttribute("username", username);
                            session.setAttribute("userId", rs.getInt("id"));
        %>
                            <p style="color:green; margin-top:15px;">Login Successful! Redirecting...</p>
                            <script>
                                setTimeout(() => { window.location.href = 'index.jsp'; }, 1500);
                            </script>
        <%
                        } else {
        %>
                            <p style="color:red; margin-top:15px;">Invalid username or password.</p>
        <%
                        }
                    }
                } catch (Exception e) {
        %>
                    <p style="color:red;">Error: <%= e.getMessage() %></p>
        <%
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception ignore) {}
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
