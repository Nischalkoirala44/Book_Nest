package dao;

import model.Book;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    private static final String INSERT_BOOK =
            "INSERT INTO book(title, author, totalcopies, category, bookImage) VALUES (?,?,?,?,?)";

    private static final String SELECT_BOOK =
            "SELECT bookid, title, author, totalcopies, category FROM book";

    private static final String SELECT_BOOK_IMAGE =
            "SELECT bookImage FROM book WHERE bookid = ?";

    public void insertBook(Book book) throws SQLException {
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_BOOK, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setInt(3, book.getTotalCopies());
            ps.setString(4, book.getCategory());
            ps.setBlob(5, book.getBookImage());
            ps.executeUpdate();
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    book.setBookId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Error inserting book: " + e.getMessage(), e);
        }
    }



    public List<Book> getAllBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        try (Connection conn = DBConnection.getDbConnection();

             PreparedStatement ps = conn.prepareStatement(SELECT_BOOK);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("bookid"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setTotalCopies(rs.getInt("totalcopies"));
                book.setCategory(rs.getString("category"));
                books.add(book);
            }
        } catch (SQLException e) {
            throw new SQLException("Error fetching books: " + e.getMessage(), e);
        }
        return books;
    }


    public byte[] getBookImage(int bookId) throws SQLException {
        try (Connection conn = DBConnection.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_BOOK_IMAGE)) {
            ps.setInt(1, bookId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    java.sql.Blob blob = rs.getBlob("bookImage");
                    if (blob != null) {
                        return blob.getBytes(1, (int) blob.length());
                    }
                }
                return null;
            }
        } catch (SQLException e) {
            throw new SQLException("Error fetching book image: " + e.getMessage(), e);
        }
    }
}