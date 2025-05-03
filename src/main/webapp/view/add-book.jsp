<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Book</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }
        input[type="text"], input[type="number"], input[type="file"], select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"], input[type="button"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 48%;
            margin: 1%;
        }
        input[type="button"] {
            background-color: #ccc;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        input[type="button"]:hover {
            background-color: #bbb;
        }
        .error {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Add New Book</h2>
    <% if (request.getAttribute("errorMessage") != null) { %>
    <p class="error"><%= request.getAttribute("errorMessage") %></p>
    <% } %>
    <form action="${pageContext.request.contextPath}/AddBookServlet" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" required>
        </div>
        <div class="form-group">
            <label for="author">Author:</label>
            <input type="text" id="author" name="author" required>
        </div>
        <div class="form-group">
            <label for="totalCopies">Total Copies:</label>
            <input type="number" id="totalCopies" name="totalCopies" min="1" required>
        </div>
        <div class="form-group">
            <label for="category">Category:</label>
            <select id="category" name="category" required>
                <option value="Fiction">Fiction</option>
                <option value="Non-Fiction">Non-Fiction</option>
                <option value="Science">Science</option>
                <option value="History">History</option>
                <option value="Biography">Biography</option>
                <option value="Fantasy">Fantasy</option>
            </select>
        </div>
        <div class="form-group">
            <label for="bookImage">Book Image:</label>
            <input type="file" id="bookImage" name="bookImage" accept="image/*">
        </div>
        <input type="submit" value="Add Book">
        <input type="button" value="Cancel" onclick="window.location.href='${pageContext.request.contextPath}/view/adminPanel.jsp'">
    </form>
</div>
</body>
</html>