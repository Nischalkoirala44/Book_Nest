package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("LoginServlet: Processing POST request"); // Debugging

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate inputs
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            System.out.println("LoginServlet: Invalid input parameters"); // Debugging
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
            return;
        }

        User loginAttempt = new User();
        loginAttempt.setEmail(email);
        loginAttempt.setPassword(password); // In production, hash password

        try {
            User authenticatedUser = UserDAO.loginUser(loginAttempt);
            if (authenticatedUser != null) {
                System.out.println("LoginServlet: Login successful for user: " + email + ", role: " + authenticatedUser.getRole()); // Debugging
                // Store user in session
                HttpSession session = request.getSession();
                session.setAttribute("user", authenticatedUser);
                // Redirect based on role
                String redirectUrl;
                if (authenticatedUser.getRole() == User.Role.admin) {
                    redirectUrl = request.getContextPath() + "/view/adminPanel.jsp";
                } else {
                    redirectUrl = request.getContextPath() + "/view/home.jsp";
                }
                System.out.println("LoginServlet: Redirect URL: " + redirectUrl); // Debugging
                response.sendRedirect(redirectUrl);
            } else {
                System.out.println("LoginServlet: Login failed for user: " + email); // Debugging
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("view/login.jsp").forward(request, response);
            }
        } catch (RuntimeException e) {
            System.err.println("LoginServlet: Exception during login: " + e.getMessage()); // Debugging
            e.printStackTrace();
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("LoginServlet: Processing GET request, forwarding to login.jsp"); // Debugging
        request.getRequestDispatcher("view/login.jsp").forward(request, response);
    }
}