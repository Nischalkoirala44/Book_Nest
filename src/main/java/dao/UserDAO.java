package dao;

import model.User;
import util.DBConnection;

import java.sql.*;

public class UserDAO {

    private static final String INSERT_USER =
            "INSERT INTO users(name, email, password, role, profile_picture) VALUES(?, ?, ?, ?, ?)";

    private static final String SELECT_USER_BY_EMAIL_PASSWORD =
            "SELECT * FROM users WHERE email = ? AND password = ?";

    private static final String SELECT_USER_BY_ID =
            "SELECT * FROM users WHERE id = ?";

    private static final String UPDATE_USER =
            "UPDATE users SET name=?, email=?, password=?,profile_picture=?, " + "bio=?, address=?, WHERE id=?";

    public static int registerUser(User user) {
        try (Connection connection = DBConnection.getDbConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_USER, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword()); // In production, hash this
            ps.setString(4, user.getRole().name());
            ps.setBytes(5, user.getProfilePicture());

            int rows = ps.executeUpdate();
            System.out.println("Rows affected: " + rows); // Debugging

            if (rows > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int userId = generatedKeys.getInt(1);
                    System.out.println("Registered user ID: " + userId); // Debugging
                    return userId;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error registering user: " + e.getMessage());
            e.printStackTrace(); // Detailed stack trace for debugging
            throw new RuntimeException("Database error during registration", e);
        }

        System.err.println("No rows affected or no keys generated");
        return -1;
    }

    public static User loginUser(User user) {
        try (Connection connection = DBConnection.getDbConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_USER_BY_EMAIL_PASSWORD)) {

            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User userFromDB = new User();
                userFromDB.setUserId(rs.getInt("id"));
                userFromDB.setName(rs.getString("name"));
                userFromDB.setEmail(rs.getString("email"));
                userFromDB.setPassword(rs.getString("password"));
                userFromDB.setRole(User.Role.valueOf(rs.getString("role")));
                userFromDB.setProfilePicture(rs.getBytes("profile_picture"));
                return userFromDB;
            }

        } catch (SQLException e) {
            System.err.println("Error authenticating user: " + e.getMessage());
            throw new RuntimeException("Database error during login", e);
        }

        return null;
    }

    public static User getUserById(int id) {
        try (Connection connection = DBConnection.getDbConnection();
             PreparedStatement ps =
                     connection.prepareStatement(SELECT_USER_BY_ID)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User userFromDB = new User();
                userFromDB.setUserId(rs.getInt("id"));
                userFromDB.setName(rs.getString("name"));
                userFromDB.setEmail(rs.getString("email"));
                userFromDB.setPassword(rs.getString("password"));

                userFromDB.setRole(User.Role.valueOf(rs.getString("role")));
                userFromDB.setProfilePicture(rs.getBytes("profile_picture"));

                // Add these fields if they exist in your database
                userFromDB.setBio(rs.getString("bio"));


                userFromDB.setAddress(rs.getString("address"));
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving user by ID: " +
                    e.getMessage());
            throw new RuntimeException("Database error retrieving user",
                    e);
        }

        return null;
    }

    // Add the updateUser method
    public static boolean updateUser(User user) {
        try (Connection connection = DBConnection.getDbConnection();
             PreparedStatement ps = connection.prepareStatement(UPDATE_USER)) {

            // Set parameters with null checks
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());

            if (user.getProfilePicture() != null) {
                ps.setBytes(4, user.getProfilePicture());
            } else {
                ps.setNull(4, Types.BLOB);
            }

            ps.setString(5, user.getBio());
            ps.setString(7, user.getAddress());

            ps.setInt(9, user.getUserId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.err.println("Update error [SQLState:" + e.getSQLState()
                    + "]");
            throw new RuntimeException("Database update failed: " +
                    e.getMessage(), e);
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Invalid date format. Use yyyy-mm-dd", e);
        }
    }
}