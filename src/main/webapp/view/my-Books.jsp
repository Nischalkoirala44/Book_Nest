<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.BookDAO,model.Book,model.User,java.util.List,java.util.Objects" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Books - Book Hive</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        :root {
            --primary-color: #ff7a65;
            --primary-hover: #e66b58;
            --secondary-color: #f8f8f8;
            --text-color: #333;
            --light-text: #888;
            --border-color: #ddd;
            --status-available-bg: hsl(8, 100%, 95%);
            --status-available-text: hsl(8, 80%, 40%);
            --status-borrowed-bg: hsl(8, 20%, 95%);
            --status-borrowed-text: hsl(8, 80%, 50%);
        }

        body {
            background-color: var(--secondary-color);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            display: flex;
            align-items: center;
        }

        .logo h1 {
            font-size: 24px;
            color: var(--text-color);
        }

        .logo span {
            color: var(--primary-color);
        }

        .nav-links {
            display: flex;
            list-style: none;
            align-items: center;
        }

        .nav-links li {
            margin-left: 30px;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--text-color);
            font-weight: 500;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: var(--primary-color);
        }

        .nav-links .active {
            color: var(--primary-color);
        }

        .user-actions {
            display: flex;
            align-items: center;
        }

        .user-profile {
            display: flex;
            align-items: center;
            cursor: pointer;
            position: relative;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-right: 10px;
            overflow: hidden;
        }

        .user-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .user-name {
            font-weight: 500;
        }

        .dropdown-menu {
            position: absolute;
            top: 100%;
            right: 0;
            background-color: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 200px;
            display: none;
            z-index: 101;
        }

        .dropdown-menu.active {
            display: block;
        }

        .dropdown-menu ul {
            list-style: none;
            padding: 10px 0;
        }

        .dropdown-menu li {
            padding: 10px 20px;
        }

        .dropdown-menu a {
            text-decoration: none;
            color: var(--text-color);
            display: block;
        }

        .dropdown-menu a:hover {
            color: var(--primary-color);
        }

        .dropdown-menu .logout {
            border-top: 1px solid var(--border-color);
            margin-top: 5px;
        }

        .hamburger {
            display: none;
            font-size: 24px;
            background: none;
            border: none;
            color: var(--text-color);
            cursor: pointer;
        }

        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s, visibility 0.3s;
        }

        .modal.active {
            opacity: 1;
            visibility: visible;
        }

        .modal-content {
            background-color: white;
            border-radius: 8px;
            width: 90%;
            max-width: 500px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .modal-header {
            padding: 15px 20px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-title {
            font-size: 20px;
            font-weight: bold;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: var(--light-text);
        }

        .modal-body {
            padding: 20px;
        }

        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid var(--border-color);
            display: flex;
            justify-content: flex-end;
        }

        .modal-footer button {
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-left: 10px;
        }

        .modal-footer button a {
            text-decoration: none;
            color: white;
        }

        .btn-secondary {
            background-color: #f0f0f0;
            color: var(--text-color);
            border: 1px solid var(--border-color);
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
            border: none;
        }

        .profile-details {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 15px;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: var(--primary-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            font-weight: bold;
            margin: 0 auto;
            overflow: hidden;
        }

        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .profile-info {
            margin-top: 20px;
        }

        .profile-info-item {
            margin-bottom: 15px;
        }

        .profile-info-label {
            font-weight: bold;
            margin-bottom: 5px;
            color: var(--light-text);
            font-size: 14px;
        }

        .profile-info-value {
            font-size: 16px;
        }

        .main-content {
            padding: 40px 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .page-title {
            margin-bottom: 30px;
        }

        .page-title h1 {
            font-size: 32px;
            color: var(--primary-color);
        }

        .page-title p {
            color: var(--light-text);
        }

        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 25px;
        }

        .book-card {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .book-card:hover {
            transform: translateY(-10px);
        }

        .book-cover {
            height: 280px;
            background-color: #f0f0f0;
            overflow: hidden;
        }

        .book-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .book-info {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .book-info h3 {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .book-info p {
            font-size: 14px;
            color: var(--light-text);
            margin-bottom: 15px;
        }

        .book-info .author {
            font-size: 14px;
            color: var(--light-text);
            margin-bottom: 15px;
            display: block;
        }

        .book-info .category {
            display: inline-block;
            background-color: var(--secondary-color);
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            color: var(--light-text);
            margin-bottom: 15px;
        }

        .book-actions {
            margin-top: auto;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .due-date, .borrow-date {
            background-color: var(--secondary-color);
            padding: 10px;
            border-radius: 5px;
            font-size: 14px;
            color: var(--light-text);
            display: flex;
            justify-content: space-between;
        }

        .overdue {
            color: var(--status-borrowed-text);
            font-weight: 500;
        }

        .return-btn {
            background-color: var(--primary-color);
            color: white;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .return-btn:hover {
            background-color: var(--primary-hover);
        }

        .extend-btn {
            background-color: #4cc9f0;
            color: white;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .extend-btn:hover {
            background-color: #3ba8c9;
        }

        .empty-state {
            text-align: center;
            padding: 50px 20px;
        }

        .empty-state-icon {
            font-size: 60px;
            color: var(--border-color);
            margin-bottom: 20px;
        }

        .empty-state h2 {
            font-size: 24px;
            color: var(--light-text);
            margin-bottom: 15px;
        }

        .empty-state p {
            color: var(--light-text);
            margin-bottom: 25px;
        }

        .browse-btn {
            display: inline-block;
            background-color: var(--primary-color);
            color: white;
            padding: 12px 25px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .browse-btn:hover {
            background-color: var(--primary-hover);
        }

        .footer {
            background-color: white;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px 0;
            margin-top: auto;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
        }

        .footer-section h3 {
            font-size: 18px;
            margin-bottom: 15px;
            position: relative;
            padding-bottom: 10px;
        }

        .footer-section h3::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 30px;
            height: 2px;
            background-color: var(--primary-color);
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 10px;
        }

        .footer-links a {
            text-decoration: none;
            color: var(--text-color);
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: var(--primary-color);
        }

        .footer-bottom {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
            color: var(--light-text);
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
                flex-direction: column;
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                background-color: white;
                padding: 20px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .nav-links.active {
                display: flex;
            }

            .nav-links li {
                margin: 10px 0;
            }

            .hamburger {
                display: block;
            }

            .profile-details {
                grid-template-columns: 1fr;
            }

            .dropdown-menu {
                width: 150px;
            }

            .books-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            }

            .book-cover {
                height: 200px;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar">
    <div class="nav-container">
        <div class="logo">
            <h1><span>Book</span> Nest</h1>
        </div>
        <button class="hamburger" aria-label="Toggle navigation" aria-expanded="false">☰</button>
        <ul class="nav-links">
            <li><a href="home.jsp">Home</a></li>
            <li><a href="browse.jsp">Browse</a></li>
            <li><a href="my-Books.jsp" class="active">My Books</a></li>
        </ul>
        <div class="user-actions">
            <div class="user-profile" id="userProfileToggle" aria-haspopup="true" aria-expanded="false">
                <% User user = (User) session.getAttribute("user"); %>
                <div class="user-avatar">
                    <% if (user != null && user.getProfilePicture() != null && user.getProfilePicture().length > 0) { %>
                    <img src='${pageContext.request.contextPath}/ProfileImageServlet?userId=<%= user.getUserId() %>' alt='Profile Image' />
                    <% } else if (user != null) { %>
                    <%= user.getName().charAt(0) %>
                    <% } else { %>
                    G
                    <% } %>
                </div>
                <div class="user-name"><%= user != null && user.getName() != null ? user.getName() : "Guest" %></div>
                <div class="dropdown-menu" id="userDropdown">
                    <ul>
                        <li><a href="#" id="viewProfileBtn">View Profile</a></li>
                        <li><a href="my-Books.jsp">My Books</a></li>
                        <li class="logout"><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="main-content">
    <div class="container">
        <div class="page-title">
            <h1>My Borrowed Books</h1>
            <p>Manage your borrowed books and due dates</p>
        </div>

        <!-- Books Grid -->
        <div class="books-grid" id="myBooksGrid">
            <!-- Books will be loaded here -->
        </div>

        <!-- Empty State -->
        <div class="empty-state" id="emptyState" style="display: none;">
            <div class="empty-state-icon">📚</div>
            <h2>No Books Borrowed Yet</h2>
            <p>You haven't borrowed any books from our library. Start reading today!</p>
            <a href="browse.jsp" class="browse-btn">Browse Books</a>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-content">
            <div class="footer-section">
                <h3>About Us</h3>
                <ul class="footer-links">
                    <li><a href="#">Our Story</a></li>
                    <li><a href="#">Team</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Press</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Resources</h3>
                <ul class="footer-links">
                    <li><a href="#">Help Center</a></li>
                    <li><a href="#">FAQs</a></li>
                    <li><a href="#">Community Guidelines</a></li>
                    <li><a href="#">Tutorials</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Legal</h3>
                <ul class="footer-links">
                    <li><a href="#">Terms of Service</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Cookie Policy</a></li>
                    <li><a href="#">Copyright</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Contact</h3>
                <ul class="footer-links">
                    <li><a href="#">Email Us</a></li>
                    <li><a href="#">Support</a></li>
                    <li><a href="#">Feedback</a></li>
                    <li><a href="#">Report an Issue</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2025 My Book Shelf. All rights reserved.</p>
        </div>
    </div>
</footer>

<!-- Profile Modal -->
<div class="modal" id="profileModal" role="dialog" aria-modal="true">
    <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title">Profile</h2>
            <button class="modal-close" aria-label="Close profile modal">×</button>
        </div>
        <div class="modal-body">
            <div class="profile-details">
                <% if (user != null) { %>
                <div class="profile-avatar">
                    <% if (user != null && user.getProfilePicture() != null && user.getProfilePicture().length > 0) { %>
                    <img src='${pageContext.request.contextPath}/ProfileImageServlet?userId=<%= user.getUserId() %>' alt='Profile Image' />
                    <% } else if (user != null) { %>
                    <%= user.getName().charAt(0) %>
                    <% } else { %>
                    G
                    <% } %>
                </div>
                <div class="profile-info">
                    <div class="profile-info-item">
                        <div class="profile-info-label">Name</div>
                        <div class="profile-info-value"><%= user.getName() != null ? user.getName().replaceAll("[<>\"&]", "") : "N/A" %></div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-info-label">Email</div>
                        <div class="profile-info-value"><%= user.getEmail() != null ? user.getEmail().replaceAll("[<>\"&]", "") : "N/A" %></div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-info-label">Bio</div>
                        <div class="profile-info-value"><%= user.getBio() != null ? user.getBio().replaceAll("[<>\"&]", "") : "No bio provided" %></div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-info-label">Address</div>
                        <div class="profile-info-value"><%= user.getAddress() != null ? user.getAddress().replaceAll("[<>\"&]", "") : "No address provided" %></div>
                    </div>
                </div>
                <% } else { %>
                <div class="profile-info">
                    <div class="profile-info-item">
                        <div class="profile-info-value">Please log in to view profile details.</div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn-secondary modal-close-btn">Close</button>
            <% if (user != null) { %>
            <button class="btn-primary"><a href="editProfile.jsp">Edit Profile</a></button>
            <% } %>
        </div>
    </div>
</div>

<script>
    // User Profile Dropdown Toggle
    const userProfileToggle = document.getElementById('userProfileToggle');
    const userDropdown = document.getElementById('userDropdown');
    if (userProfileToggle && userDropdown) {
        userProfileToggle.addEventListener('click', function(event) {
            event.stopPropagation();
            const isActive = userDropdown.classList.toggle('active');
            userProfileToggle.setAttribute('aria-expanded', isActive);
        });
    }

    document.addEventListener('click', function(event) {
        if (userDropdown && !userProfileToggle.contains(event.target) && !userDropdown.contains(event.target)) {
            userDropdown.classList.remove('active');
            userProfileToggle.setAttribute('aria-expanded', 'false');
        }
    });

    const hamburger = document.querySelector('.hamburger');
    const navLinks = document.querySelector('.nav-links');
    if (hamburger && navLinks) {
        hamburger.addEventListener('click', function() {
            const isActive = navLinks.classList.toggle('active');
            hamburger.setAttribute('aria-expanded', isActive);
            hamburger.textContent = isActive ? '×' : '☰';
        });
    }

    document.addEventListener('click', function(event) {
        if (navLinks && hamburger && !navLinks.contains(event.target) && !hamburger.contains(event.target)) {
            navLinks.classList.remove('active');
            hamburger.setAttribute('aria-expanded', 'false');
            hamburger.textContent = '☰';
        }
    });

    const profileModal = document.getElementById('profileModal');
    const viewProfileBtn = document.getElementById('viewProfileBtn');
    const modalCloseBtns = document.querySelectorAll('.modal-close, .modal-close-btn');

    if (viewProfileBtn) {
        viewProfileBtn.addEventListener('click', function(e) {
            e.preventDefault();
            profileModal.classList.add('active');
            userDropdown.classList.remove('active');
        });
    }

    modalCloseBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            profileModal.classList.remove('active');
        });
    });

    profileModal.addEventListener('click', function(e) {
        if (e.target === this) {
            this.classList.remove('active');
        }
    });

    // Mock user's borrowed books data
    const borrowedBooks = [
        {
            id: 3,
            title: "Ancient Civilizations",
            author: "Robert Johnson",
            category: "history",
            coverImage: "../assets/ancientCivilization.jpg",
            borrowDate: "2025-04-01",
            dueDate: "2025-04-29",
            isOverdue: false
        },
        {
            id: 6,
            title: "Stars Beyond Reach",
            author: "Sarah Miller",
            category: "science-fiction",
            coverImage: "../assets/beyondreach.jpeg",
            borrowDate: "2025-03-25",
            dueDate: "2025-04-15",
            isOverdue: true
        },
        {
            id: 9,
            title: "Love in Paris",
            author: "Sophie Martin",
            category: "romance",
            coverImage: "../assets/paris.jpg",
            borrowDate: "2025-04-10",
            dueDate: "2025-05-08",
            isOverdue: false
        }
    ];

    function displayBorrowedBooks() {
        const myBooksGrid = document.getElementById('myBooksGrid');
        const emptyState = document.getElementById('emptyState');

        // Clear previous content
        while (myBooksGrid.firstChild) {
            myBooksGrid.removeChild(myBooksGrid.firstChild);
        }

        if (borrowedBooks.length === 0) {
            emptyState.style.display = 'block';
            return;
        } else {
            emptyState.style.display = 'none';
        }

        borrowedBooks.forEach(book => {
            console.log("Book Object:", book);
            console.log("Book Author:", book.author);
            console.log("Book Title:", book.title);

            // Create book card
            const bookCard = document.createElement('div');
            bookCard.className = 'book-card';

            // Book cover
            const bookCover = document.createElement('div');
            bookCover.className = 'book-cover';
            const coverImg = document.createElement('img');
            coverImg.src = book.coverImage;
            coverImg.alt = `${book.title} Cover`;
            bookCover.appendChild(coverImg);

            // Book info
            const bookInfo = document.createElement('div');
            bookInfo.className = 'book-info';

            // Category
            const category = document.createElement('span');
            category.className = 'category';
            category.textContent = book.category.charAt(0).toUpperCase() + book.category.slice(1);
            bookInfo.appendChild(category);

            // Title
            const title = document.createElement('h3');
            title.textContent = book.title;
            bookInfo.appendChild(title);

            // Author
            const author = document.createElement('p');
            author.className = 'author';
            author.textContent = `Author: ${book.author || "Unknown Author"}`;
            bookInfo.appendChild(author);

            // Borrow Date
            const borrowDateDiv = document.createElement('div');
            borrowDateDiv.className = 'borrow-date';
            const borrowLabel = document.createElement('span');
            borrowLabel.textContent = 'Borrowed On:';
            const borrowValue = document.createElement('span');
            borrowValue.textContent = book.borrowDate;
            borrowDateDiv.appendChild(borrowLabel);
            borrowDateDiv.appendChild(borrowValue);
            bookInfo.appendChild(borrowDateDiv);

            // Book Actions
            const bookActions = document.createElement('div');
            bookActions.className = 'book-actions';

            // Due Date
            const dueDateDiv = document.createElement('div');
            dueDateDiv.className = 'due-date';
            const dueLabel = document.createElement('span');
            dueLabel.textContent = 'Due Date:';
            const dueValue = document.createElement('span');
            dueValue.className = book.isOverdue ? 'overdue' : '';
            dueValue.textContent = book.dueDate;
            dueDateDiv.appendChild(dueLabel);
            dueDateDiv.appendChild(dueValue);
            bookActions.appendChild(dueDateDiv);

            // Return Button
            const returnBtn = document.createElement('a');
            returnBtn.href = '#';
            returnBtn.className = 'return-btn';
            returnBtn.dataset.id = book.id;
            returnBtn.textContent = 'Return Book';
            bookActions.appendChild(returnBtn);

            // Extend Button
            const extendBtn = document.createElement('a');
            extendBtn.href = '#';
            extendBtn.className = 'extend-btn';
            extendBtn.dataset.id = book.id;
            extendBtn.textContent = 'Extend Due Date';
            bookActions.appendChild(extendBtn);

            // Assemble the book card
            bookInfo.appendChild(bookActions);
            bookCard.appendChild(bookCover);
            bookCard.appendChild(bookInfo);
            myBooksGrid.appendChild(bookCard);
        });

        // Add event listeners
        document.querySelectorAll('.return-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                const bookId = this.dataset.id;
                returnBook(bookId);
            });
        });

        document.querySelectorAll('.extend-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                const bookId = this.dataset.id;
                extendDueDate(bookId);
            });
        });
    }

    function returnBook(bookId) {
        const index = borrowedBooks.findIndex(book => book.id == bookId);

        if (index !== -1) {
            const bookTitle = borrowedBooks[index].title;
            borrowedBooks.splice(index, 1);
            displayBorrowedBooks();
            alert(`You have successfully returned "${bookTitle}".`);
        }
    }

    function extendDueDate(bookId) {
        const book = borrowedBooks.find(book => book.id == bookId);

        if (book) {
            const dueDate = new Date(book.dueDate);
            dueDate.setDate(dueDate.getDate() + 14);

            const newDueDate = dueDate.toISOString().split('T')[0];
            book.dueDate = newDueDate;
            book.isOverdue = false;

            displayBorrowedBooks();
            alert(`Due date for "${book.title}" has been extended to ${newDueDate}.`);
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        displayBorrowedBooks();
    });
</script>
</body>
</html>