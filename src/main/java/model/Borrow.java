package model;

import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class Borrow {
    private int borrowId;
    private int userId;
    private int bookId;
    private java.sql.Date borrowDate;
    private java.sql.Date dueDate;
    private java.sql.Date returnDate;
    private double penalty;
    private Book book; // Reference to the associated Book

    private static final int DUE_DAYS = 10;
    private static final int GRACE_DAYS = 15;
    private static final double PENALTY_AMOUNT = 100.0;

    // Default constructor
    public Borrow() {
        LocalDate currentDate = LocalDate.now();
        this.borrowDate = Date.valueOf(currentDate);
        this.dueDate = Date.valueOf(currentDate.plusDays(DUE_DAYS));
        this.penalty = 0.0;
    }

    // Constructor with essential fields
    public Borrow(int borrowId, int userId, int bookId) {
        this();
        this.borrowId = borrowId;
        this.userId = userId;
        this.bookId = bookId;
    }

    // Full constructor
    public Borrow(int borrowId, int userId, int bookId, java.sql.Date borrowDate,
                  java.sql.Date dueDate, java.sql.Date returnDate, double penalty) {
        this.borrowId = borrowId;
        this.userId = userId;
        this.bookId = bookId;
        this.borrowDate = borrowDate;
        this.dueDate = dueDate;
        this.returnDate = returnDate;
        this.penalty = penalty;
    }

    // Getter and Setter methods
    public int getBorrowId() {
        return borrowId;
    }

    public void setBorrowId(int borrowId) {
        this.borrowId = borrowId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public java.sql.Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(java.sql.Date borrowDate) {
        this.borrowDate = borrowDate;
        if (borrowDate != null) {
            this.dueDate = Date.valueOf(borrowDate.toLocalDate().plusDays(DUE_DAYS));
        } else {
            this.dueDate = null;
        }
    }

    public java.sql.Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(java.sql.Date dueDate) {
        this.dueDate = dueDate;
    }

    public java.sql.Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(java.sql.Date returnDate) {
        this.returnDate = returnDate;
        if (returnDate != null) {
            calculatePenalty();
        }
    }

    public double getPenalty() {
        return penalty;
    }

    public void setPenalty(double penalty) {
        this.penalty = penalty;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    // Calculate penalty based on return date
    private void calculatePenalty() {
        if (returnDate != null) {
            LocalDate returnLocalDate = returnDate.toLocalDate();
            LocalDate dueLocalDate = dueDate.toLocalDate();

            long daysLate = ChronoUnit.DAYS.between(dueLocalDate, returnLocalDate);

            if (daysLate > GRACE_DAYS) {
                this.penalty = PENALTY_AMOUNT;
            } else {
                this.penalty = 0.0;
            }
        }
    }

    // Utility methods
    public boolean isOverdue() {
        if (returnDate != null) {
            return false;
        }
        LocalDate currentDate = LocalDate.now();
        return currentDate.isAfter(dueDate.toLocalDate());
    }

    public boolean hasPenalty() {
        return penalty > 0;
    }

    public long getRemainingDays() {
        if (returnDate != null) {
            return 0;
        }
        LocalDate currentDate = LocalDate.now();
        return ChronoUnit.DAYS.between(currentDate, dueDate.toLocalDate());
    }

    public long getDaysOverdue() {
        if (returnDate != null) {
            return ChronoUnit.DAYS.between(dueDate.toLocalDate(), returnDate.toLocalDate());
        }
        if (isOverdue()) {
            LocalDate currentDate = LocalDate.now();
            return ChronoUnit.DAYS.between(dueDate.toLocalDate(), currentDate);
        }
        return 0;
    }
}