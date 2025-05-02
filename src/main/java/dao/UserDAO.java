package dao;

import model.User;
import util.DBConnection;
import util.PasswordUtil;

import java.sql.*;

public class UserDAO {

    private static final String INSERT_USER =
            "INSERT INTO users(name, email, password, role, profile_picture, bio, address) VALUES(?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_USER_BY_EMAIL =
            "SELECT userId, name, email, password, role, profile_picture, bio, address FROM users WHERE email = ?";
    private static final String SELECT_USER_BY_ID =
            "SELECT userId, name, email, password, role, profile_picture, bio, address FROM users WHERE userId = ?";
    private static final String UPDATE_USER =
            "UPDATE users SET name=?, email=?, password=?, profile_picture=?, bio=?, address=? WHERE userId=?";

    public static int registerUser(User user) {
        try (Connection connection = DBConnection.getDbConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_USER, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            String hashedPassword = PasswordUtil.hashPassword(user.getPassword());
            ps.setString(3, hashedPassword);
            ps.setString(4, user.getRole().name());
            ps.setBytes(5, user.getProfilePicture());
            ps.setString(6, user.getBio());
            ps.setString(7,user.getAddress());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException("Database error during registration", e);
        } catch (Exception e) {
            throw new RuntimeException("Encryption error", e);
        }
        return -1;
    }

    public static User loginUser(User loginAttempt) {
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_USER_BY_EMAIL)) {

            stmt.setString(1, loginAttempt.getEmail());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userId"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(User.Role.valueOf(rs.getString("role")));
                user.setProfilePicture(rs.getBytes("profile_picture"));
                // Decrypt bio and address
                user.setBio(rs.getString("bio"));
                user.setAddress(rs.getString("address"));

                if (PasswordUtil.verifyPassword(loginAttempt.getPassword(), user.getPassword())) {
                    return user;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error during login", e);
        } catch (Exception e) {
            throw new RuntimeException("Error during login",e);
        }
        return null;
    }

    public static User getUserById(int userId) {
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_USER_BY_ID)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userId"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(User.Role.valueOf(rs.getString("role")));
                user.setProfilePicture(rs.getBytes("profile_picture"));
                user.setBio(rs.getString("bio"));
                user.setAddress(rs.getString("address"));
                return user;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error fetching user", e);
        }
        return null;
    }

    public static void storeRememberMeToken(int userId, String token) {
        String sql = "INSERT INTO remember_me_tokens(userId, token, expiry) VALUES(?, ?, ?)";
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setString(2, token);
            stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis() + 7 * 24 * 60 * 60 * 1000)); // 7 days
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error storing remember me token", e);
        }
    }

    public static User validateRememberMeToken(String token) {
        String sql = "SELECT u.* FROM users u JOIN remember_me_tokens t ON u.userId = t.userId " +
                "WHERE t.token = ? AND t.expiry > NOW()";
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userId"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(User.Role.valueOf(rs.getString("role")));
                user.setProfilePicture(rs.getBytes("test-profile_picture"));
                // Decrypt bio and address
                user.setBio(rs.getString("bio"));
                user.setAddress(rs.getString("address"));
                return user;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error validating remember me token", e);
        } catch (Exception e) {
            throw new RuntimeException("Decryption error", e);
        }
        return null;
    }

    public static boolean updateUser(User user) {
        try (Connection connection = DBConnection.getDbConnection();
             PreparedStatement ps = connection.prepareStatement(UPDATE_USER)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            // Hash password if updated
            String hashedPassword = user.getPassword().startsWith("$") ?
                    user.getPassword() : PasswordUtil.hashPassword(user.getPassword());
            ps.setString(3, hashedPassword);
            ps.setBytes(4, user.getProfilePicture() != null ? user.getProfilePicture() : null);
            ps.setString(5, user.getBio());
            ps.setString(6, user.getAddress());
            ps.setInt(7, user.getUserId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Database update failed: " + e.getMessage(), e);
        } catch (Exception e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}