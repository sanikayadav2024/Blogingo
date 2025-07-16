<%@ page import="java.sql.*" %>
<%@ include file="navbar.jsp" %>
<%
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String id = request.getParameter("id");
    String title = "";
    String content = "";
    String author = "";

    if (id == null || id.trim().equals("")) {
        out.println("<p class='text-danger'>Invalid Blog ID.</p>");
        return;
    }

    // Get env vars for Railway
    String dbUrl = System.getenv("DB_URL");
    String dbUser = System.getenv("DB_USER");
    String dbPass = System.getenv("DB_PASS");

    // Convert Railway-style plain DB_URL to JDBC if needed
    if (dbUrl != null && !dbUrl.startsWith("jdbc:")) {
        dbUrl = "jdbc:mysql://" + dbUrl + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    }

    if (dbUrl == null || dbUser == null || dbPass == null) {
        out.println("<p class='text-danger'>Error: Database environment variables not configured.</p>");
        return;
    }

    // Check if form is submitted (POST)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String updatedTitle = request.getParameter("title");
        String updatedContent = request.getParameter("content");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            String updateSql = "UPDATE blogs SET title=?, content=? WHERE id=? AND author=?";
            PreparedStatement psUpdate = conn.prepareStatement(updateSql);
            psUpdate.setString(1, updatedTitle);
            psUpdate.setString(2, updatedContent);
            psUpdate.setString(3, id);
            psUpdate.setString(4, user); // Ensure only owner can update

            int rowsUpdated = psUpdate.executeUpdate();
            conn.close();

            if (rowsUpdated > 0) {
                response.sendRedirect("index.jsp");
            } else {
                out.println("<p class='text-danger'>Update failed. Are you the blog owner?</p>");
            }
            return;
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error updating blog: " + e.getMessage() + "</p>");
        }
    } else {
        // GET Request - fetch blog details
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            String sql = "SELECT * FROM blogs WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                title = rs.getString("title");
                content = rs.getString("content");
                author = rs.getString("author");

                if (!user.equals(author) && !user.equals("Admin")) {
                    out.println("<p class='text-danger'>Unauthorized: You cannot edit this blog.</p>");
                    conn.close();
                    return;
                }
            } else {
                out.println("<p class='text-danger'>Blog not found.</p>");
                conn.close();
                return;
            }

            conn.close();
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error fetching blog: " + e.getMessage() + "</p>");
            return;
        }
    }
%>

<!-- Blog Edit Form -->
<div class="container mt-4">
    <h2>Edit Blog</h2>
    <form method="post">
        <div class="mb-3">
            <label for="title" class="form-label">Blog Title</label>
            <input type="text" class="form-control" id="title" name="title" value="<%= title %>" required>
        </div>
        <div class="mb-3">
            <label for="content" class="form-label">Content</label>
            <textarea class="form-control" id="content" name="content" rows="10" required><%= content %></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Update Blog</button>
        <a href="index.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
