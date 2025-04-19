<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: Nischal Koirala
  Date: 4/19/2025
  Time: 8:31 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        :root {
            --primary-color: #ff7a65;
            --secondary-color: #f8f8f8;
            --text-color: #333;
            --light-text: #888;
            --border-color: #ddd;
        }

        body {
            background-color: var(--secondary-color);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Navigation Bar */
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
        }

        .user-name {
            font-weight: 500;
        }

        .dropdown-menu {
            position: absolute;
            top: 50px;
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
        /* Modal */
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

        .modal-footer button a{
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-left: 10px;
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

        /* Profile Modal */
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

        .book-details-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .book-details-description h4 {
            margin-bottom: 10px;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .profile-details {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="nav-container">
        <div class="logo">
            <h1><span>Book</span> Hive</h1>
        </div>

        <ul class="nav-links">
            <li><a href="#" class="active">Home</a></li>
            <li><a href="#">Browse</a></li>
            <li><a href="#">My Books</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Contact</a></li>
        </ul>

        <div class="user-actions">
            <div class="user-profile" id="userProfileToggle">
                <div class="user-avatar"><%= ((model.User) session.getAttribute("user")).getName().charAt(0) %></div>
                <div class="user-name"><%= ((model.User) session.getAttribute("user")).getName() %></div>

                <div class="dropdown-menu" id="userDropdown">
                    <ul>
                        <li><a href="#" id="viewProfileBtn">View Profile</a></li>
                        <li><a href="#">My Books</a></li>
                        <li class="logout"><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>
<div class="container">
    <h2>Welcome, <%= ((model.User) session.getAttribute("user")).getName() %>!</h2>
    <p>This is the BookHive Landing page.</p>
    <p><a href="${pageContext.request.contextPath}/logout">Log out</a></p>
</div>

<!-- Profile Modal -->
<div class="modal" id="profileModal">
    <div class="modal-content">
        <div class="modal-header">
            <div class="modal-title">My Profile</div>
            <button class="modal-close">&times;</button>
        </div>
        <div class="modal-body">
            <div class="profile-details">
                <div class="profile-avatar">
                </div>
                <div class="profile-info">
                    <div class="profile-info-item">
                        <div class="profile-info-label">Name</div>
                        <div class="profile-info-value"><%= ((model.User) session.getAttribute("user")).getName() %></div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-info-label">Email</div>
                        <div class="profile-info-value"><%= ((model.User) session.getAttribute("user")).getEmail() %></div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-info-label">Bio</div>
                        <div class="profile-info-value"><%= ((model.User) session.getAttribute("user")).getBio() %></div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-info-label">Address</div>
                        <div class="profile-info-value"><%= ((model.User) session.getAttribute("user")).getAddress() %></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn-secondary modal-close-btn">Close</button>
            <button class="btn-primary"><a href="editProfile.jsp">Edit Profile</a></button>
        </div>
    </div>
</div>

<script>
    // User Profile Dropdown Toggle
    const userProfileToggle = document.getElementById('userProfileToggle');
    const userDropdown = document.getElementById('userDropdown');

    userProfileToggle.addEventListener('click', function() {
        userDropdown.classList.toggle('active');
    });

    // Close dropdown when clicking outside
    document.addEventListener('click', function(event) {
        if (!userProfileToggle.contains(event.target)) {
            userDropdown.classList.remove('active');
        }
    });

    // Tab Switching
    const tabs = document.querySelectorAll('.tab');
    const tabContents = document.querySelectorAll('.tab-content');

    tabs.forEach(tab => {
        tab.addEventListener('click', function() {
            const tabId = this.getAttribute('data-tab');

            // Remove active class from all tabs and contents
            tabs.forEach(t => t.classList.remove('active'));
            tabContents.forEach(c => c.classList.remove('active'));

            // Add active class to current tab and content
            this.classList.add('active');
            document.getElementById(tabId).classList.add('active');
        });
    });

    // Modal Functionality
    const modals = document.querySelectorAll('.modal');
    const modalCloseBtns = document.querySelectorAll('.modal-close, .modal-close-btn');
    const viewProfileBtn = document.getElementById('viewProfileBtn');
    const profileModal = document.getElementById('profileModal');
    const bookDetailsModal = document.getElementById('bookDetailsModal');
    const borrowButtons = document.querySelectorAll('.book-action');

    // Open profile modal
    viewProfileBtn.addEventListener('click', function(e) {
        e.preventDefault();
        profileModal.classList.add('active');
        userDropdown.classList.remove('active');
    });

    // Open book details modal when borrow button is clicked
    borrowButtons.forEach(button => {
        if (!button.disabled) {
            button.addEventListener('click', function() {
                bookDetailsModal.classList.add('active');
            });
        }
    });

    // Close modals
    modalCloseBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            modals.forEach(modal => {
                modal.classList.remove('active');
            });
        });
    });

    // Close modal when clicking outside
    modals.forEach(modal => {
        modal.addEventListener('click', function(e) {
            if (e.target === this) {
                this.classList.remove('active');
            }
        });
    });
</script>

</body>
</html>
