/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.dtos;

import java.io.Serializable;

/**
 *
 * @author ngota
 */
public class CommentDTO implements Serializable {

    public static final String DEFAULT_STATUS = "Active";
    public static final String DELETE_STATUS = "Delete";

    private int commentID;
    private int articleID;
    private String userEmail;
    private String content;
    private String status;

    public CommentDTO(int articleID, String userEmail, String content) {
        this.articleID = articleID;
        this.userEmail = userEmail;
        this.content = content;
        this.status = DEFAULT_STATUS;
    }

    public CommentDTO(int commentID, int articleID, String userEmail, String content, String status) {
        this.commentID = commentID;
        this.articleID = articleID;
        this.userEmail = userEmail;
        this.content = content;
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    public int getArticleID() {
        return articleID;
    }

    public void setArticleID(int articleID) {
        this.articleID = articleID;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "CommentDTO{" + "commentID=" + commentID + ", articleID=" + articleID + ", userEmail=" + userEmail + ", content=" + content + '}';
    }

}
