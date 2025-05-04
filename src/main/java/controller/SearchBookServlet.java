package controller;

import dao.BookDAO;
import model.Book;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "SearchBookServlet", value = "/searchBook")
public class SearchBookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        String searchType = request.getParameter("searchType");

        BookDAO bookDAO = new BookDAO();
        List<Book> books;

        try {
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                switch (searchType) {
                    case "title":
                        books = bookDAO.searchByTitle(searchTerm);
                        break;
                    case "author":
                        books = bookDAO.searchByAuthor(searchTerm);
                        break;
                    case "category":
                        books = bookDAO.searchByCategory(searchTerm);
                        break;
                    case "all":
                    default:
                        books = bookDAO.searchAllFields(searchTerm);
                        break;
                }
            } else {
                // If no search term, get all books
                books = bookDAO.getAllBooks();
            }

            request.setAttribute("books", books);
            request.getRequestDispatcher("browse.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error searching books: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}