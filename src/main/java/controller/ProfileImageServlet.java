package controller; // replace with your actual servlet package

import util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;

@WebServlet("/profile-image")
public class ProfileImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId;
        try {
            userId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
            return;
        }

        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT profile_picture FROM users WHERE id = ?")) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                byte[] imageData = rs.getBytes("profile_picture");
                if (imageData != null && imageData.length > 0) {
                    response.setContentType("image/jpeg"); // or image/png
                    OutputStream os = response.getOutputStream();
                    os.write(imageData);
                    os.flush();
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}
