/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.daos;

import ducnt.db.DBConnection;
import ducnt.dtos.EmotionDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author ngota
 */
public class EmotionDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    public boolean addEmotionToArticle(EmotionDTO dto) throws Exception {
        boolean check = false;
        try {
            String sql = "IF EXISTS(select emotion from dbo.tblEmotion where article_id=? AND user_email=?)\n"
                    + "   update dbo.tblEmotion SET emotion=? WHERE article_id=? AND user_email=?\n"
                    + "ELSE\n"
                    + "   insert into dbo.tblEmotion(article_id, user_email, emotion)\n"
                    + "   VALUES(?,?,?)";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, dto.getArticleID());
            preStm.setString(2, dto.getUserEmail());
            preStm.setString(3, dto.getEmotion());
            preStm.setInt(4, dto.getArticleID());
            preStm.setString(5, dto.getUserEmail());
            preStm.setInt(6, dto.getArticleID());
            preStm.setString(7, dto.getUserEmail());
            preStm.setString(8, dto.getEmotion());
            check = preStm.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return check;
    }

    public int getEmotionByType(int articleID, String type) throws Exception {
        int result = -1;
        try {
            String sql = "SELECT COUNT(emotion) AS 'emotion_count'\n"
                    + "FROM dbo.tblEmotion\n"
                    + "WHERE article_id=? AND emotion=?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, articleID);
            preStm.setString(2, type);
            rs = preStm.executeQuery();
            if(rs.next()) {
                result = rs.getInt("emotion_count");
            }
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return result;
    }
    
    public String getEmotionOfUser(int articleID, String email) throws Exception {
        String result = null;
        try {
            String sql = "SELECT emotion\n"
                    + "FROM dbo.tblEmotion\n"
                    + "WHERE article_id=? AND user_email=?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, articleID);
            preStm.setString(2, email);
            rs = preStm.executeQuery();
            if(rs.next()) {
                result = rs.getString("emotion");
            }
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return result;
    }
}
