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
public class NotificationDTO implements Serializable {

    private int id;
    private String description;
    private String userEmail;
    private String interactorEmail;
    private int articleID;
    private Date createdDate;

    public NotificationDTO(String description, String userEmail, String interactorEmail, int articleID) {
        this.description = description;
        this.userEmail = userEmail;
        this.interactorEmail = interactorEmail;
        this.articleID = articleID;
    }

    public NotificationDTO(int id, String description, String userEmail, String interactorEmail, int articleID, Date createdDate) {
        this.id = id;
        this.description = description;
        this.userEmail = userEmail;
        this.interactorEmail = interactorEmail;
        this.articleID = articleID;
        this.createdDate = createdDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getInteractorEmail() {
        return interactorEmail;
    }

    public void setInteractorEmail(String interactorEmail) {
        this.interactorEmail = interactorEmail;
    }

    public int getArticleID() {
        return articleID;
    }

    public void setArticleID(int articleID) {
        this.articleID = articleID;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public String toString() {
        return "NotificationDTO{" + "id=" + id + ", description=" + description + ", userEmail=" + userEmail + ", interactorEmail=" + interactorEmail + ", articleID=" + articleID + ", createdDate=" + createdDate + '}';
    }

}
