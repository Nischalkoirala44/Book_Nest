package model;

public class Book {

    private int bookId;
    private String title;
    private String author;
    private int totalCopies;
    private String category;
    private String borrowDate;
    private String returnDate;
    private byte[] bookImage;

    public Book() {

    }

    public Book(int bookId, String title, String author, int totalCopies, String category, String borrowDate, String returnDate, byte[] bookImage) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.totalCopies = totalCopies;
        this.category = category;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.bookImage = bookImage;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public int getTotalCopies() {
        return totalCopies;
    }

    public void setTotalCopies(int totalCopies) {
        this.totalCopies = totalCopies;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(String borrowDate) {
        this.borrowDate = borrowDate;
    }

    public String getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(String returnDate) {
        this.returnDate = returnDate;
    }

    public byte[] getBookImage() {
        return bookImage;
    }

    public void setBookImage(byte[] bookImage) {
        this.bookImage = bookImage;
    }
}
