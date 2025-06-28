<style>
    .blog-section {
        padding: 40px 50px;
        background-color: #f9f9f9;
        text-align: center;
    }

    .blog-section h2 {
        margin-bottom: 30px;
        color: #333;
    }

    .blog-container {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 20px;
    }

    .blog-card {
        background-color: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        width: calc(33.333% - 20px);
        box-sizing: border-box;
        text-align: left;
    }

    .blog-card h3 {
        color: #444;
        margin-bottom: 10px;
    }

    .blog-card .meta {
        font-size: 12px;
        color: #888;
        margin-bottom: 15px;
    }

    .blog-card .excerpt {
        font-size: 14px;
        margin-bottom: 15px;
    }

    .read-more {
        text-decoration: none;
        color: #007BFF;
        font-weight: bold;
    }

    .read-more:hover {
        text-decoration: underline;
    }

    @media (max-width: 768px) {
        .blog-card {
            width: 100%;
        }
    }
</style>

<section class="blog-section">
    <h2>Latest Blogs</h2>
    <div class="blog-container">
        <div class="blog-card">
            <h3>How to Start Blogging</h3>
            <p class="meta">By Admin | June 24, 2025</p>
            <p class="excerpt">Learn the basics of starting a blog and growing your audience from scratch.</p>
            <a href="#" class="read-more">Read More</a>
        </div>
        <div class="blog-card">
            <h3>Top 5 Writing Tools</h3>
            <p class="meta">By Jane Doe | June 20, 2025</p>
            <p class="excerpt">Explore the best tools to improve your content writing and SEO performance.</p>
            <a href="#" class="read-more">Read More</a>
        </div>
        <div class="blog-card">
            <h3>Monetizing Your Blog</h3>
            <p class="meta">By BloggerX | June 15, 2025</p>
            <p class="excerpt">Discover smart strategies to turn your blog into a source of income.</p>
            <a href="#" class="read-more">Read More</a>
        </div>
    </div>
</section>
