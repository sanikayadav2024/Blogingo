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

    // Check if form is submitted (POST)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String updatedTitle = request.getParameter("title");
        String updatedContent = request.getParameter("content");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bloggingo", "root", "");

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
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bloggingo", "root", "");

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

<!DOCTYPE html>
<html>
<head>
    <title>Edit Blog - BloginGo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2>Edit Blog</h2>

    <form method="post">
        <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" name="title" class="form-control" value="<%= title %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Content</label>
            <textarea name="content" class="form-control" rows="6" required><%= content %></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Update Blog</button>
        <a href="index.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</body>
</html>
