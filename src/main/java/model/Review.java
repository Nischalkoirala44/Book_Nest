package model;

public class Review {

    private int reviewId;
    private int rating;
    private String comment;
    private String reviewDate;
    private boolean isBorrowed;

    public Review() {

    }

    public Review(int reviewId, int rating, String comment, String reviewDate) {
        this.reviewId = reviewId;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
    }

    public int getReviewId() {
        return reviewId;
    }
    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getRating() {
        return rating;
    }
    public void setRating(int rating) {
        this.rating = rating;
    }
    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getReviewDate() {
        return reviewDate;
    }

    public boolean setIsBorrowed() {
        return isBorrowed;
    }
    public void setIsBorrowed(boolean isBorrowed) {
        this.isBorrowed = isBorrowed;
    }
    public void setReviewDate(String reviewDate) {
        this.reviewDate = reviewDate;
    }
}
