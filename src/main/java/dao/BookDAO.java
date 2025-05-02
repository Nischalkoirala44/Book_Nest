package dao;
import model.Book;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class BookDAO {

    private static final String INSERT_BOOK =
            "INSERT INTO book(title, author, totalCopies, category, bookImage) VALUES (?,?,?,?,?)";

    public void insertBook(Book book) throws SQLException {

        try (Connection conn = DBConnection.getDbConnection();
        PreparedStatement ps = conn.prepareStatement(INSERT_BOOK, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setInt(3, book.getTotalCopies());
            ps.setString(4, book.getCategory());
            ps.setBlob(5, book.getBookImage());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException(("Error inserting book: " + e.getMessage()));
        }
    }
}
