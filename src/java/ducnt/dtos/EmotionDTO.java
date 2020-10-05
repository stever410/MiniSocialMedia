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
public class EmotionDTO implements Serializable {

    public static final String LIKE = "Like";
    public static final String DISLIKE = "Dislike";
    
    private int articleID;
    private String userEmail;
    private String emotion;

    public EmotionDTO(int articleID, String userEmail, String emotion) {
        this.articleID = articleID;
        this.userEmail = userEmail;
        this.emotion = emotion;
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

    public String getEmotion() {
        return emotion;
    }

    public void setEmotion(String emotion) {
        this.emotion = emotion;
    }

    @Override
    public String toString() {
        return "EmotionDTO{" + "articleID=" + articleID + ", userEmail=" + userEmail + ", emotion=" + emotion + '}';
    }

}
