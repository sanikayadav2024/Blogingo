<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");

    if (id != null) {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String dbUrl = System.getenv("DB_URL");
            String dbUser = System.getenv("DB_USER");
            String dbPass = System.getenv("DB_PASS");

            if (dbUrl == null || dbUser == null || dbPass == null) {
                out.println("<p class='text-danger'>Error: One or more DB environment variables are missing.</p>");
            } else {
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                String sql = "DELETE FROM blogs WHERE id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, id);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception ignore) {}
        }
    }

    response.sendRedirect("index.jsp");
%>
