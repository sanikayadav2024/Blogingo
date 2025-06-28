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

                if (!currentLiked) {
                    // Update unlike to like
                    PreparedStatement updateLike = conn.prepareStatement("UPDATE blog_likes SET liked=TRUE WHERE blog_id=? AND username=?");
                    updateLike.setString(1, blogId);
                    updateLike.setString(2, username);
                    updateLike.executeUpdate();

                    // Adjust blog counts
                    conn.prepareStatement("UPDATE blogs SET likes = likes + 1, unlikes = CASE WHEN unlikes > 0 THEN unlikes - 1 ELSE 0 END WHERE id=" + blogId).executeUpdate();
                }
            } else {
                // First time like
                PreparedStatement insertPs = conn.prepareStatement("INSERT INTO blog_likes (blog_id, username, liked) VALUES (?, ?, TRUE)");
                insertPs.setString(1, blogId);
                insertPs.setString(2, username);
                insertPs.executeUpdate();

                conn.prepareStatement("UPDATE blogs SET likes = likes + 1 WHERE id=" + blogId).executeUpdate();
            }

            conn.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
    response.sendRedirect("blog.jsp?id=" + blogId);
%>
