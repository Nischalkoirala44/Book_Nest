package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("LogoutServlet: Processing logout request"); // Debugging

        // Invalidate the session
        HttpSession session = request.getSession(false); // Don't create new session
        if (session != null) {
            session.invalidate();
            System.out.println("LogoutServlet: Session invalidated"); // Debugging
        }

        // Redirect to login page
        String redirectUrl = request.getContextPath() + "/index.jsp";
        System.out.println("LogoutServlet: Redirect URL: " + redirectUrl); // Debugging
        response.sendRedirect(redirectUrl);
    }
}