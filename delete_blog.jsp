<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    if (id != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bloggingo", "root", "");
            String sql = "DELETE FROM blogs WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.executeUpdate();
            conn.close();
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
        }
    }
    response.sendRedirect("index.jsp");
%>
