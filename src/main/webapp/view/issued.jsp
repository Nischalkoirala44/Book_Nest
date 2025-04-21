<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Issued Books - BookHive</title>
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

        .status-returned {
            color: green;
            font-weight: bold;
        }

        .status-pending {
            color: red;
            font-weight: bold;
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
    <a href="${pageContext.request.contextPath}/view/books.jsp">Books</a>
    <a href="${pageContext.request.contextPath}/view/users.jsp">Users</a>
    <a href="${pageContext.request.contextPath}/view/issued.jsp" class="active" >Issued</a>
    <a href="${pageContext.request.contextPath}/view/register.jsp">Logout</a>
</div>

<div class="main">
    <h1>📖 Issued Books</h1>

    <table>
        <tr>
            <th>User Name</th>
            <th>Book Title</th>
            <th>Issued Date</th>
            <th>Issued Time</th>
            <th>Deadline</th>
            <th>Status</th>
        </tr>
        <tr>
            <td>Ram Bahadur</td>
            <td>Java Programming</td>
            <td>April 10, 2025</td>
            <td>10:30 AM</td>
            <td>April 25, 2025</td>
            <td class="status-pending">Not Returned</td>
        </tr>
        <tr>
            <td>Sita Kumari</td>
            <td>Data Structures</td>
            <td>April 5, 2025</td>
            <td>2:00 PM</td>
            <td>April 20, 2025</td>
            <td class="status-returned">Returned</td>
        </tr>
        <tr>
            <td>Hari Shrestha</td>
            <td>Web Development Basics</td>
            <td>April 12, 2025</td>
            <td>9:45 AM</td>
            <td>April 27, 2025</td>
            <td class="status-pending">Not Returned</td>
        </tr>
    </table>
</div>
</body>
</html>