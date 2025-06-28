<style>
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
    }

    .footer {
        background-color: #333;
        color: white;
        padding: 20px 50px;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        font-size: 14px;
        width: 100%;
        margin-top: auto; /* Ensures footer stays at the bottom */
    }

    .footer-content {
        width: 100%;
        max-width: 1200px;
        text-align: center;
    }

    .footer-links {
        margin-top: 10px;
    }

    .footer-links a {
        color: #bbb;
        margin: 0 10px;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .footer-links a:hover {
        color: white;
    }

    @media (max-width: 600px) {
        .footer {
            padding: 15px 20px;
            font-size: 13px;
        }

        .footer-links a {
            display: block;
            margin: 5px 0;
        }
    }
</style>

<footer class="footer">
    <div class="footer-content">
        <p>&copy; 2025 BloginGo. All rights reserved.</p>
        <div class="footer-links">
            <a href="privacy.jsp">Privacy Policy</a>
            <a href="terms.jsp">Terms</a>
            <a href="contact.jsp">Contact</a>
        </div>
    </div>
</footer>
