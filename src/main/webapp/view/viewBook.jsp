<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.BookDAO,model.Book,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Books</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        img {
            max-width: 100px;
            height: auto;
        }
        h2 {
            text-align: center;
        }
    </style>
</head>
<body>
<h2>Book List</h2>
<table>
    <tr>
        <th>Book ID</th>
        <th>Title</th>
        <th>Author</th>
        <th>Total Copies</th>
        <th>Category</th>
        <th>Image</th>
    </tr>
    <%
        BookDAO bookDAO = new BookDAO();
        try {
            List<Book> books = bookDAO.getAllBooks();
            for (Book book : books) {
    %>
    <tr>
        <td><%= book.getBookId() %></td>
        <td><%= book.getTitle() %></td>
        <td><%= book.getAuthor() %></td>
        <td><%= book.getTotalCopies() %></td>
        <td><%= book.getCategory() %></td>
        <td>
            <img src="BookImageServlet?bookId=<%= book.getBookId() %>" alt="Book Image" />
        </td>
    </tr>
    <%
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    %>
</table>
</body>
</html>