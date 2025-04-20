<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookNest - Library Management System</title>
    <style>
        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        }

        body {
            background-color: #f9fafb;
            color: #1f2937;
            line-height: 1.5;
        }

        .container {
            width: 100%;
            max-width: 1280px;
            margin: 0 auto;
            padding: 0 16px;
        }

        /* Header */
        header {
            background-color: #ffffff;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
        }

        .logo {
            font-size: 18px;
            font-weight: 700;
            color: #4f46e5;
            text-decoration: none;
            letter-spacing: -0.5px;
        }

        .logo span {
            color: #10b981;
        }

        .nav-links {
            display: flex;
            list-style: none;
            align-items: center;
        }

        .nav-links li {
            margin: 0 8px;
        }

        .nav-links a {
            text-decoration: none;
            color: #4b5563;
            font-size: 13px;
            font-weight: 500;
            transition: color 0.2s;
        }

        .nav-links a:hover {
            color: #4f46e5;
        }

        .auth-buttons a {
            margin-left: 8px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
        }

        .login-btn {
            color: #4f46e5;
            padding: 6px 12px;
            border-radius: 6px;
            transition: background-color 0.2s;
        }

        .login-btn:hover {
            background-color: #f3e8ff;
        }

        .register-btn {
            background-color: #4f46e5;
            color: white;
            padding: 6px 12px;
            border-radius: 6px;
            transition: background-color 0.2s;
        }

        .register-btn:hover {
            background-color: #4338ca;
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, #f5f7ff 0%, #e0f2fe 100%);
            padding: 60px 0;
            margin-bottom: 48px;
        }

        .hero-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 32px;
            align-items: center;
        }

        .hero-text h1 {
            font-size: 32px;
            font-weight: 800;
            color: #1f2937;
            margin-bottom: 12px;
            line-height: 1.2;
        }

        .hero-text p {
            font-size: 14px;
            color: #6b7280;
            margin-bottom: 20px;
            max-width: 450px;
        }

        .cta-btn {
            display: inline-flex;
            background-color: #10b981;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 13px;
            transition: background-color 0.2s, transform 0.2s;
        }

        .cta-btn:hover {
            background-color: #059669;
            transform: translateY(-2px);
        }

        .hero-image img {
            max-width: 100%;
            height: auto;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        /* Features Section */
        .features {
            padding: 60px 0;
        }

        .section-title {
            text-align: center;
            margin-bottom: 40px;
        }

        .section-title h2 {
            font-size: 28px;
            font-weight: 800;
            color: #1f2937;
            margin-bottom: 8px;
        }

        .section-title p {
            font-size: 14px;
            color: #6b7280;
            max-width: 550px;
            margin: 0 auto;
        }

        .feature-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 20px;
        }

        .feature-card {
            background-color: #ffffff;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        .feature-icon {
            font-size: 36px;
            color: #4f46e5;
            margin-bottom: 12px;
        }

        .feature-card h3 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #1f2937;
        }

        .feature-card p {
            font-size: 13px;
            color: #6b7280;
        }

        /* Popular Books Section */
        .popular-books {
            padding: 60px 0;
            background-color: #f9fafb;
        }

        .books-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }

        .book-card {
            background-color: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .book-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        .book-cover {
            height: 220px;
            overflow: hidden;
        }

        .book-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }

        .book-card:hover .book-cover img {
            transform: scale(1.05);
        }

        .book-info {
            padding: 12px;
        }

        .book-info .category {
            display: inline-block;
            background-color: #f3f4f6;
            padding: 3px 10px;
            border-radius: 999px;
            font-size: 11px;
            color: #4b5563;
            margin-bottom: 10px;
        }

        .book-info h3 {
            font-size: 15px;
            font-weight: 600;
            margin-bottom: 6px;
            color: #1f2937;
        }

        .book-info p {
            font-size: 12px;
            color: #6b7280;
            margin-bottom: 10px;
        }

        .borrow-btn {
            display: inline-flex;
            background-color: #4f46e5;
            color: white;
            padding: 6px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 500;
            transition: background-color 0.2s, transform 0.2s;
        }

        .borrow-btn:hover {
            background-color: #4338ca;
            transform: translateY(-2px);
        }

        .borrow-btn.disabled {
            background-color: #9ca3af;
            cursor: not-allowed;
            transform: none;
        }

        .borrow-btn.disabled:hover {
            background-color: #9ca3af;
            transform: none;
        }

        /* Footer */
        footer {
            background-color: #1f2937;
            color: #f9fafb;
            padding: 48px 0 24px;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 24px;
            margin-bottom: 32px;
        }

        .footer-column h3 {
            font-size: 15px;
            font-weight: 600;
            margin-bottom: 12px;
            color: #10b981;
        }

        .footer-column ul {
            list-style: none;
        }

        .footer-column ul li {
            margin-bottom: 6px;
        }

        .footer-column ul li a {
            text-decoration: none;
            color: #d1d5db;
            font-size: 13px;
            transition: color 0.2s;
        }

        .footer-column ul li a:hover {
            color: #10b981;
        }

        .footer-bottom {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #374151;
        }

        .footer-bottom p {
            font-size: 12px;
            color: #9ca3af;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .hero-content {
                grid-template-columns: 1fr;
                text-align: center;
            }

            .hero-text {
                margin-bottom: 24px;
            }

            .hero-text h1 {
                font-size: 28px;
            }

            .hero-text p {
                font-size: 13px;
            }
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 12px;
            }

            .nav-links {
                margin: 12px 0;
                flex-wrap: wrap;
                justify-content: center;
                gap: 8px;
            }

            .nav-links li {
                margin: 4px 6px;
            }

            .feature-cards,
            .books-container {
                grid-template-columns: 1fr;
            }

            .hero {
                padding: 40px 0;
            }

            .section-title h2 {
                font-size: 24px;
            }

            .footer-content {
                grid-template-columns: 1fr;
                text-align: center;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 0 12px;
            }

            .logo {
                font-size: 16px;
            }

            .auth-buttons a {
                padding: 5px 10px;
                font-size: 12px;
            }

            .hero-text h1 {
                font-size: 24px;
            }

            .cta-btn {
                padding: 8px 16px;
                font-size: 12px;
            }

            .book-card {
                max-width: 280px;
                margin: 0 auto;
            }
        }
    </style>
</head>
<body>
<!-- Header -->
<header>
    <div class="container">
        <nav class="navbar">
            <a href="index.jsp" class="logo">Book<span>Nest</span></a>
            <ul class="nav-links">
                <li><a href="#">Home</a></li>
                <li><a href="books.jsp">Books</a></li>
                <% if (session.getAttribute("user") != null) { %>
                <li><a href="mybooks.jsp">My Books</a></li>
                <li><a href="profile.jsp">Profile</a></li>
                <% } %>
            </ul>
            <div class="auth-buttons">
                <% if (session.getAttribute("user") == null) { %>
                <a href="view/login.jsp" class="login-btn">Login</a>
                <a href="view/register.jsp" class="register-btn">Register</a>
                <% } else { %>
                <% } %>
            </div>
        </nav>
    </div>
</header>

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <div class="hero-content">
            <div class="hero-text">
                <h1>Find Your Next Great Read</h1>
                <p>Explore thousands of books across all genres.
                    <% if (session.getAttribute("user") == null) { %>
                    Sign in to borrow books!
                    <% } %>
                </p>
                <a href="books.jsp" class="cta-btn">Browse Books</a>
            </div>
            <div class="hero-image">
                <img src="https://via.placeholder.com/500x400" alt="Library with books">
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="features">
    <div class="container">
        <div class="section-title">
            <h2>Why Choose BookNest</h2>
            <p>Discover the features that make your reading experience seamless</p>
        </div>
        <div class="feature-cards">
            <div class="feature-card">
                <div class="feature-icon">📚</div>
                <h3>Extensive Library</h3>
                <p>Browse thousands of books across all genres in one place.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🔍</div>
                <h3>Smart Search</h3>
                <p>Quickly find books with our powerful search and filters.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📱</div>
                <h3>Your Account</h3>
                <p>Track borrowed books and manage your reading history.</p>
            </div>
        </div>
    </div>
</section>

<!-- Popular Books Section -->
<section class="popular-books">
    <div class="container">
        <div class="section-title">
            <h2>Trending Books</h2>
            <p>Explore the most popular books this month</p>
        </div>
        <div class="books-container">
            <div class="book-card">
                <div class="book-cover">
                    <img src="https://via.placeholder.com/250x350" alt="Book Cover">
                </div>
                <div class="book-info">
                    <span class="category">Fiction</span>
                    <h3>The Silent Echo</h3>
                    <p>Author: Jane Doe</p>
                    <% if (session.getAttribute("user") != null) { %>
                    <a href="borrow.jsp?bookId=1" class="borrow-btn">Borrow Now</a>
                    <% } else { %>
                    <a href="login.jsp" class="borrow-btn disabled" onclick="alert('Please login to borrow books!')">Borrow Now</a>
                    <% } %>
                </div>
            </div>
            <div class="book-card">
                <div class="book-cover">
                    <img src="https://via.placeholder.com/250x350" alt="Book Cover">
                </div>
                <div class="book-info">
                    <span class="category">Science</span>
                    <h3>Cosmic Horizons</h3>
                    <p>Author: John Smith</p>
                    <% if (session.getAttribute("user") != null) { %>
                    <a href="borrow.jsp?bookId=2" class="borrow-btn">Borrow Now</a>
                    <% } else { %>
                    <a href="login.jsp" class="borrow-btn disabled" onclick="alert('Please login to borrow books!')">Borrow Now</a>
                    <% } %>
                </div>
            </div>
            <div class="book-card">
                <div class="book-cover">
                    <img src="https://via.placeholder.com/250x350" alt="Book Cover">
                </div>
                <div class="book-info">
                    <span class="category">History</span>
                    <h3>Ancient Civilizations</h3>
                    <p>Author: Robert Johnson</p>
                    <% if (session.getAttribute("user") != null) { %>
                    <a href="borrow.jsp?bookId=3" class="borrow-btn">Borrow Now</a>
                    <% } else { %>
                    <a href="login.jsp" class="borrow-btn disabled" onclick="alert('Please login to borrow books!')">Borrow Now</a>
                    <% } %>
                </div>
            </div>
            <div class="book-card">
                <div class="book-cover">
                    <img src="https://via.placeholder.com/250x350" alt="Book Cover">
                </div>
                <div class="book-info">
                    <span class="category">Self-Help</span>
                    <h3>The Power of Habits</h3>
                    <p>Author: Emily Wilson</p>
                    <% if (session.getAttribute("user") != null) { %>
                    <a href="borrow.jsp?bookId=4" class="borrow-btn">Borrow Now</a>
                    <% } else { %>
                    <a href="login.jsp" class="borrow-btn disabled" onclick="alert('Please login to borrow books!')">Borrow Now</a>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="footer-content">
            <div class="footer-column">
                <h3>BookNest</h3>
                <ul>
                    <li><a href="about.jsp">About Us</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                    <li><a href="privacy.jsp">Privacy Policy</a></li>
                    <li><a href="terms.jsp">Terms of Service</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Explore</h3>
                <ul>
                    <li><a href="books.jsp">All Books</a></li>
                    <li><a href="books.jsp?category=fiction">Fiction</a></li>
                    <li><a href="books.jsp?category=non-fiction">Non-Fiction</a></li>
                    <li><a href="books.jsp?category=academic">Academic</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Support</h3>
                <ul>
                    <li><a href="faq.jsp">FAQ</a></li>
                    <li><a href="help.jsp">Help Center</a></li>
                    <li><a href="report.jsp">Report an Issue</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Connect</h3>
                <ul>
                    <li><a href="#">Facebook</a></li>
                    <li><a href="#">Twitter</a></li>
                    <li><a href="#">Instagram</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2025 BookNest Library Management System. All rights reserved.</p>
        </div>
    </div>
</footer>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Library Management System initialized');
    });
</script>
</body>
</html>