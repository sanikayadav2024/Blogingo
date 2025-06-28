<div class="navbar navbar-expand-lg custom-navbar">
    <div class="container">
        <a class="navbar-brand logo" href="index.jsp">BloginGo</a>
        <button class="navbar-toggler bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav ms-auto">
                <% String user = (String) session.getAttribute("username"); %>
                <% if (user != null) { %>
                    <li class="nav-item"><a class="nav-link menu-item" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link menu-item" href="logout.jsp">Logout</a></li>
                <% } else { %>
                    <li class="nav-item"><a class="nav-link menu-item" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link menu-item" href="login.jsp">Login</a></li>
                    <li class="nav-item"><a class="nav-link menu-item" href="register.jsp">Register</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</div>

<style>
    .custom-navbar {
        background: linear-gradient(90deg, #343a40, #212529);
        padding: 15px 0;
        animation: slide 0.7s ease;
    }

    .navbar-brand.logo {
        color: #fff !important;
        font-weight: bold;
        font-size: 24px;
        transition: color 0.3s ease, transform 0.3s ease;
    }

    .navbar-brand.logo:hover {
        color: #ffc107 !important;
        transform: scale(1.05);
    }

    .nav-link.menu-item {
        color: #fff !important;
        margin-left: 15px;
        transition: color 0.3s ease, transform 0.3s ease;
    }

    .nav-link.menu-item:hover {
        color: #ffc107 !important;
        transform: scale(1.1);
    }

    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-50px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
</style>
