<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Books - BookHive</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            display: flex;
            height: 100vh;
            background: linear-gradient(to right, #eef2f3, #e6f0ff);
        }

        .sidebar {
            width: 220px;
            background: linear-gradient(to bottom, #4e54c8, #8f94fb);
            color: white;
            padding: 20px;
            display: flex;
            flex-direction: column;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }

        .sidebar h2 {
            margin-bottom: 30px;
            text-align: center;
        }

        .sidebar a {
            color: white;
            text-decoration: none;
            margin: 10px 0;
            padding: 10px;
            border-radius: 8px;
            transition: background 0.3s;
        }

        .sidebar a:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .main {
            flex: 1;
            padding: 30px;
            background-color: #f2f6ff;
            overflow-y: auto;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        .book-form {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 40px;
            justify-content: space-between;
        }

        .book-form input, .book-form select {
            flex: 1;
            padding: 12px 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            outline: none;
            transition: border 0.3s;
        }

        .book-form input:focus {
            border-color: #4e54c8;
        }

        .book-form button {
            padding: 12px 20px;
            background: linear-gradient(to right, #4e54c8, #8f94fb);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
        }

        .book-form button:hover {
            background: linear-gradient(to right, #8f94fb, #4e54c8);
            transform: scale(1.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        th, td {
            padding: 14px 18px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }

        th {
            background-color: #4e54c8;
            color: white;
        }

        tr:hover {
            background-color: #f7f9ff;
        }

        .actions button {
            margin-right: 8px;
            padding: 6px 10px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            color: white;
            transition: all 0.3s;
        }

        .edit-btn {
            background-color: #36d1dc;
        }

        .edit-btn:hover {
            background-color: #2bb6c4;
        }

        .delete-btn {
            background-color: #ff6a6a;
        }

        .delete-btn:hover {
            background-color: #e65c5c;
        }

        .sidebar .active {
            background-color: rgba(255, 255, 255, 0.2);
        }
    </style>
</head>
<body>
<div class="sidebar">
    <h2>📚 BookNest</h2>
    <a href="${pageContext.request.contextPath}/view/adminPanel.jsp">Dashboard</a>
    <a href="${pageContext.request.contextPath}/view/books.jsp" class="active">Books</a>
    <a href="${pageContext.request.contextPath}/view/users.jsp">Users</a>
    <a href="${pageContext.request.contextPath}/view/issued.jsp">Issued</a>
    <a href="${pageContext.request.contextPath}/view/register.jsp">Logout</a>
</div>

<div class="main">
    <h1>📚 Manage Books</h1>

    <form class="book-form">
        <input type="text" placeholder="Book Title" required>
        <input type="text" placeholder="Author" required>
        <input type="text" placeholder="Category" required>
        <input type="date" required>
        <button type="submit">Add Book</button>
    </form>

    <table>
        <tr>
            <th>Title</th>
            <th>Author</th>
            <th>Category</th>
            <th>Date Added</th>
            <th>Actions</th>
        </tr>
        <tr>
            <td>Java for Beginners</td>
            <td>Sunil Thapa</td>
            <td>Programming</td>
            <td>April 10, 2025</td>
            <td class="actions">
                <button class="edit-btn">Edit</button>
                <button class="delete-btn">Delete</button>
            </td>
        </tr>
        <tr>
            <td>Web Design Basics</td>
            <td>Asha Gurung</td>
            <td>Design</td>
            <td>April 5, 2025</td>
            <td class="actions">
                <button class="edit-btn">Edit</button>
                <button class="delete-btn">Delete</button>
            </td>
        </tr>
    </table>
</div>
</body>
</html>