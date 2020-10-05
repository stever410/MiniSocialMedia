/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.dtos;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author ngota
 */
public class ArticleDTO implements Serializable {

    public static final String DEFAULT_STATUS = "Active";
    public static final String DELETE_STATUS = "Delete";

    private int id;
    private String userEmail;
    private String title;
    private String content;
    private String image;
    private Date createdDate;
    private String status;

    public ArticleDTO(String userEmail, String title, String content, String image) {
        this.userEmail = userEmail;
        this.title = title;
        this.content = content;
        this.image = image;
        this.status = DEFAULT_STATUS;
    }

    public ArticleDTO(int id, String userEmail, String title, String content, String image, Date createdDate, String status) {
        this.id = id;
        this.userEmail = userEmail;
        this.title = title;
        this.content = content;
        this.image = image;
        this.createdDate = createdDate;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "ArticleDTO{" + "id=" + id + ", userEmail=" + userEmail + ", title=" + title + ", content=" + content + ", image=" + image + ", createdDate=" + createdDate + ", status=" + status + '}';
    }

}
