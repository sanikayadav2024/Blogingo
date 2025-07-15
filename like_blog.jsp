<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    String blogId = request.getParameter("id");
    String username = (String) session.getAttribute("username");

    if (blogId != null && username != null) {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Fetch environment variables
            String dbUrl = System.getenv("DB_URL");
            String dbUser = System.getenv("DB_USER");
            String dbPass = System.getenv("DB_PASS");

            if (dbUrl == null || dbUser == null || dbPass == null) {
                out.println("Error: Database environment variables not configured.");
            } else {
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

                // Check existing record
                PreparedStatement checkPs = conn.prepareStatement(
                    "SELECT * FROM blog_likes WHERE blog_id=? AND username=?"
                );
                checkPs.setString(1, blogId);
                checkPs.setString(2, username);
                ResultSet rs = checkPs.executeQuery();

                if (rs.next()) {
                    boolean currentLiked = rs.getBoolean("liked");

                    if (!currentLiked) {
                        // Update unlike to like
                        PreparedStatement updateLike = conn.prepareStatement(
                            "UPDATE blog_likes SET liked=TRUE WHERE blog_id=? AND username=?"
                        );
                        updateLike.setString(1, blogId);
                        updateLike.setString(2, username);
                        updateLike.executeUpdate();

                        // Adjust blog counts safely
                        PreparedStatement updateBlog = conn.prepareStatement(
                            "UPDATE blogs SET likes = likes + 1, unlikes = CASE WHEN unlikes > 0 THEN unlikes - 1 ELSE 0 END WHERE id=?"
                        );
                        updateBlog.setString(1, blogId);
                        updateBlog.executeUpdate();
                    }
                } else {
                    // First time like
                    PreparedStatement insertPs = conn.prepareStatement(
                        "INSERT INTO blog_likes (blog_id, username, liked) VALUES (?, ?, TRUE)"
                    );
                    insertPs.setString(1, blogId);
                    insertPs.setString(2, username);
                    insertPs.executeUpdate();

                    PreparedStatement updateBlog = conn.prepareStatement(
                        "UPDATE blogs SET likes = likes + 1 WHERE id=?"
                    );
                    updateBlog.setString(1, blogId);
                    updateBlog.executeUpdate();
                }
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception ignore) {}
        }
    }

    response.sendRedirect("blog.jsp?id=" + blogId);
%>
