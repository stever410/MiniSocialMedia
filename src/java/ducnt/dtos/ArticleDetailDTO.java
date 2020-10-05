/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.dtos;

import java.io.Serializable;
import java.util.List;

/**
 *
 * @author ngota
 */
public class ArticleDetailDTO implements Serializable {

    private int articleID;
    private List<CommentDTO> listComment;
    private int likeCount;
    private int dislikeCount;

    public ArticleDetailDTO(int article, List<CommentDTO> listComment, int likeCount, int dislikeCount) {
        this.articleID = article;
        this.listComment = listComment;
        this.likeCount = likeCount;
        this.dislikeCount = dislikeCount;
    }

    public int getArticleID() {
        return articleID;
    }

    public void setArticleID(int articleID) {
        this.articleID = articleID;
    }

    public List<CommentDTO> getListComment() {
        return listComment;
    }

    public void setListComment(List<CommentDTO> listComment) {
        this.listComment = listComment;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public int getDislikeCount() {
        return dislikeCount;
    }

    public void setDislikeCount(int dislikeCount) {
        this.dislikeCount = dislikeCount;
    }

    @Override
    public String toString() {
        return "ArticleDetailDTO{" + "article=" + articleID + ", listComment=" + listComment + ", likeCount=" + likeCount + ", dislikeCount=" + dislikeCount + '}';
    }

}
