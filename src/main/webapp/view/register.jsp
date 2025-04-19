<%--
  Created by IntelliJ IDEA.
  User: Nischal Koirala
  Date: 4/18/2025
  Time: 2:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 50px;
        }
        form {
            max-width: 400px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        input, select, button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
        }
        .error {
            color: red;
        }
        .success {
            color: green;
        }
    </style>
</head>
<body>
<h2 style="text-align:center;">Register New User</h2>

<form method="post" action="${pageContext.request.contextPath}/register" enctype="multipart/form-data">
    <input type="text" name="name" placeholder="Full Name" required />
    <input type="email" name="email" placeholder="Email" required />
    <input type="password" name="password" placeholder="Password" required />
    <select name="role">
        <option value="user">Student</option>
        <option value="admin">Admin</option>
    </select>
    <input type="file" name="profilePicture" accept="image/*" />
    <button type="submit">Register</button>

    <p class="error">${error}</p>
    <p class="success">
        <% if (request.getParameter("registerSuccess") != null) { %>
        Registration successful! You can now <a href="login.jsp">login</a>.
        <% } %>
    </p>
    <p style="text-align: center;">
        Already have an account? <a href="${pageContext.request.contextPath}/view/login.jsp">Login here</a>.
    </p>
</form>
</body>
</html>