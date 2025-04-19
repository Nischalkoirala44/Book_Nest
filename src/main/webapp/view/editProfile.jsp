<%@ page import="model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <style>
        /* Add your styles here or keep your existing ones */
        .profile-image-container {
            width: 128px;
            height: 128px;
            border-radius: 50%;
            overflow: hidden;
            margin-bottom: 10px;
        }
        .profile-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .profile-image-fallback {
            width: 128px;
            height: 128px;
            background-color: #ccc;
            color: white;
            font-size: 48px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 50%;
        }
    </style>
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<h2>Edit Profile</h2>

<% if (request.getAttribute("error") != null) { %>
<p style="color: red;"><%= request.getAttribute("error") %></p>
<% } %>

<form action="<%= request.getContextPath() %>/updateProfile" method="post" enctype="multipart/form-data">
    <div class="profile-image-container">
        <% if (user.getProfilePicture() != null) { %>
        <img src="<%= request.getContextPath() %>/getImage?userId=<%= user.getUserId() %>" alt="Profile Image" class="profile-image">
        <% } else { %>
        <div class="profile-image-fallback">
            <%= user.getName() != null && !user.getName().isEmpty() ? user.getName().charAt(0) : "?" %>
        </div>
        <% } %>
    </div>

    <label>Name:</label><br>
    <input type="text" name="name" value="<%= user.getName() %>" required><br><br>

    <label>Email:</label><br>
    <input type="email" name="email" value="<%= user.getEmail() %>" required><br><br>

    <label>Bio:</label><br>
    <textarea name="bio" rows="4" cols="40"><%= user.getBio() != null ? user.getBio() : "" %></textarea><br><br>

    <label>Address:</label><br>
    <input type="text" name="address" value="<%= user.getAddress() != null ? user.getAddress() : "" %>"><br><br>

    <label>Upload Profile Image:</label><br>
    <input type="file" name="profileImage" accept="image/*"><br><br>

    <input type="submit" value="Update Profile">
</form>
</body>
</html>
