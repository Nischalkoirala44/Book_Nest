<%--
  Created by IntelliJ IDEA.
  User: Nischal Koirala
  Date: 4/18/2025
  Time: 5:00 PM
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>BookHive Admin Panel</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 50px;
            background-color: #f4f4f4;
            text-align: center;
        }
        .container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #333;
        }
        p {
            font-size: 1.1em;
            color: #555;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Welcome, <%= ((model.User) session.getAttribute("user")).getName() %>!</h2>
    <p>This is the BookHive Admin Panel. Manage users, books, and more.</p>
    <p><a href="${pageContext.request.contextPath}/logout">Log out</a></p>
</div>
</body>
</html>