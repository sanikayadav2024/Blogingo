<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    String blogId = request.getParameter("id");
    String username = (String) session.getAttribute("username");

    if (blogId != null && username != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bloggingo", "root", "");

            // Check existing record
            PreparedStatement checkPs = conn.prepareStatement("SELECT * FROM blog_likes WHERE blog_id=? AND username=?");
            checkPs.setString(1, blogId);
            checkPs.setString(2, username);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                boolean currentLiked = rs.getBoolean("liked");

                if (currentLiked) {
                    // Update like to unlike
                    PreparedStatement updateUnlike = conn.prepareStatement("UPDATE blog_likes SET liked=FALSE WHERE blog_id=? AND username=?");
                    updateUnlike.setString(1, blogId);
                    updateUnlike.setString(2, username);
                    updateUnlike.executeUpdate();

                    // Adjust blog counts
                    conn.prepareStatement("UPDATE blogs SET unlikes = unlikes + 1, likes = CASE WHEN likes > 0 THEN likes - 1 ELSE 0 END WHERE id=" + blogId).executeUpdate();
                }
            } else {
                // First time unlike
                PreparedStatement insertPs = conn.prepareStatement("INSERT INTO blog_likes (blog_id, username, liked) VALUES (?, ?, FALSE)");
                insertPs.setString(1, blogId);
                insertPs.setString(2, username);
                insertPs.executeUpdate();

                conn.prepareStatement("UPDATE blogs SET unlikes = unlikes + 1 WHERE id=" + blogId).executeUpdate();
            }

            conn.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
    response.sendRedirect("blog.jsp?id=" + blogId);
%>
