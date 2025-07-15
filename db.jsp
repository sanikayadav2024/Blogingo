<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        String dbUrl = System.getenv("DB_URL");
        String dbUser = System.getenv("DB_USER");
        String dbPass = System.getenv("DB_PASS");

        if (dbUrl != null && dbUser != null && dbPass != null) {
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        } else {
            out.println("Error: One or more DB environment variables (DB_URL, DB_USER, DB_PASS) are not set.");
        }

    } catch (Exception e) {
        out.println("Database connection error: " + e.getMessage());
    }
%>
