
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Daily Chronicle | Modern News Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2c3e50;
            --accent-color: #e74c3c;
            --text-color: #333;
            --light-bg: #f8f9fa;
        }

        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            color: var(--text-color);
            line-height: 1.6;
        }

        .navbar {
            background: var(--primary-color) !important;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .featured-article {
            height: 70vh;
            background-size: cover;
            background-position: center;
            position: relative;
            border-radius: 10px;
            overflow: hidden;
        }

        .featured-content {
            position: absolute;
            bottom: 0;
            background: linear-gradient(transparent, rgba(0,0,0,0.8));
            color: white;
            padding: 2rem;
            width: 100%;
        }

        .article-card {
            transition: transform 0.3s ease;
            border: none;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .article-card:hover {
            transform: translateY(-5px);
        }

        .category-badge {
            background: var(--accent-color);
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.9rem;
        }

        .newsletter-section {
            background: var(--light-bg);
            padding: 4rem 0;
        }

        .author-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin: 1.5rem 0;
        }

        .author-img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
        }

        @media (max-width: 768px) {
            .featured-article {
                height: 50vh;
            }
            
            .article-card {
                margin-bottom: 1.5rem;
            }
        }

        .loading {
            text-align: center;
            padding: 4rem;
            font-size: 1.5rem;
            color: var(--primary-color);
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">The Daily Chronicle</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="#" data-category="general">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#" data-category="business">Business</a></li>
                    <li class="nav-item"><a class="nav-link" href="#" data-category="technology">Tech</a></li>
                    <li class="nav-item"><a class="nav-link" href="#" data-category="entertainment">Entertainment</a></li>
                    <li class="nav-item"><a class="nav-link" href="#" data-category="sports">Sports</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Featured Article -->
    <div class="container mt-4">
        <div class="featured-article">
            <div class="featured-content">
                <span class="category-badge">Featured Story</span>
                <h1 class="mt-2">Loading Top Story...</h1>
                <div class="author-info">
                    <img src="https://source.unsplash.com/random/100x100?face" alt="Author" class="author-img">
                    <div>
                        <h5 class="mb-0">Loading Author...</h5>
                        <small>Staff Writer</small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- News Grid -->
    <div class="container mt-5">
        <div class="row g-4" id="newsGrid">
            <div class="col-12 text-center loading">
                <i class="fas fa-spinner fa-spin"></i> Loading News...
            </div>
        </div>
    </div>

    <!-- Newsletter Section -->
    <section class="newsletter-section mt-5">
        <div class="container text-center">
            <h2>Stay Informed</h2>
            <p class="lead">Subscribe to our daily newsletter for curated news updates</p>
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <form class="input-group">
                        <input type="email" class="form-control" placeholder="Enter your email">
                        <button class="btn btn-primary" type="submit">Subscribe</button>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white mt-5 py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5>The Daily Chronicle</h5>
                    <p>Committed to delivering accurate, timely news</p>
                </div>
                <div class="col-md-3">
                    <h6>Categories</h6>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Politics</a></li>
                        <li><a href="#" class="text-white">Technology</a></li>
                        <li><a href="#" class="text-white">Business</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h6>Connect</h6>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Twitter</a></li>
                        <li><a href="#" class="text-white">Facebook</a></li>
                        <li><a href="#" class="text-white">Instagram</a></li>
                    </ul>
                </div>
            </div>
            <div class="text-center mt-3">
                <small>© 2024 The Daily Chronicle. All rights reserved. | <a href="#" class="text-white">Privacy Policy</a></small>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // News API Configuration
        const API_KEY = '9185d55dbda14e73bfb4c1a08e85b429';
        const BASE_URL = 'https://newsapi.org/v2/top-headlines';
        
        // DOM Elements
        const newsGrid = document.getElementById('newsGrid');
        const navLinks = document.querySelectorAll('.nav-link');
        const featuredArticle = document.querySelector('.featured-article');
        
        // Format date
        const formatDate = (dateString) => {
            const options = { year: 'numeric', month: 'short', day: 'numeric' };
            return new Date(dateString).toLocaleDateString('en-US', options);
        };

        // Create article card
        const createArticleCard = (article, category) => {
            return `
                <div class="col-md-6 col-lg-4">
                    <div class="card article-card">
                        <img src="${article.urlToImage || 'https://source.unsplash.com/random/800x600?news'}" 
                            class="card-img-top" 
                            alt="${article.title}"
                            loading="lazy">
                        <div class="card-body">
                            <span class="category-badge">${category}</span>
                            <h5 class="mt-2">${article.title}</h5>
                            <p class="text-muted">${article.description?.substring(0, 100) || ''}...</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <small>${formatDate(article.publishedAt)}</small>
                                <a href="${article.url}" target="_blank" class="btn btn-sm btn-outline-primary">Read More</a>
                            </div>
                        </div>
                    </div>
                </div>
            `;
        };

        // Update featured article
        const updateFeaturedArticle = (article) => {
            if (!article) return;
            
            featuredArticle.style.backgroundImage = `url('${article.urlToImage || 'https://source.unsplash.com/random/1200x800'}')`;
            featuredArticle.querySelector('h1').textContent = article.title;
            featuredArticle.querySelector('h5').textContent = article.author || 'Staff Writer';
        };

        // Fetch news articles
        const fetchNews = async (category = 'general') => {
            try {
                newsGrid.innerHTML = '<div class="col-12 text-center loading"><i class="fas fa-spinner fa-spin"></i> Loading News...</div>';
                
                const response = await fetch(`${BASE_URL}?country=us&category=${category}&pageSize=15&apiKey=${API_KEY}`);
                const data = await response.json();

                if (!response.ok) throw new Error(data.message || 'Failed to fetch news');
                if (!data.articles?.length) throw new Error('No articles found');

                // Update featured article
                updateFeaturedArticle(data.articles[0]);

                // Generate news cards
                newsGrid.innerHTML = data.articles.slice(1)
                    .filter(article => article.title !== '[Removed]')
                    .map(article => createArticleCard(article, category))
                    .join('');

            } catch (error) {
                console.error('Error:', error);
                newsGrid.innerHTML = `
                    <div class="col-12 text-center py-5">
                        <h3>⚠️ Error Loading Content</h3>
                        <p>${error.message}</p>
                        <button class="btn btn-primary mt-2" onclick="fetchNews()">Retry</button>
                    </div>
                `;
            }
        };

        // Category filter handler
        navLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const category = e.target.dataset.category;
                navLinks.forEach(l => l.classList.remove('active'));
                e.target.classList.add('active');
                fetchNews(category);
            });
        });

        // Initial load
        document.addEventListener('DOMContentLoaded', () => fetchNews());
    </script>
</body>
</html>
