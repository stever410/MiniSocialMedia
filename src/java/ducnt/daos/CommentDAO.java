/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.daos;

import ducnt.db.DBConnection;
import ducnt.dtos.CommentDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ngota
 */
public class CommentDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    public boolean addCommentToArticle(CommentDTO dto) throws Exception {
        boolean check = false;
        try {
            String sql = "INSERT dbo.tblComment(article_id, user_email , comment_content, status)\n"
                    + "VALUES(?,?,?,?)";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, dto.getArticleID());
            preStm.setString(2, dto.getUserEmail());
            preStm.setNString(3, dto.getContent());
            preStm.setString(4, dto.getStatus());
            check = preStm.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return check;
    }

    public List<CommentDTO> searchCommentByArticle(int articleID) throws Exception {
        List<CommentDTO> result = null;
        String email, content;
        int id;
        CommentDTO dto;
        try {
            String sql = "SELECT comment_id, comment_content, user_email \n"
                    + "FROM dbo.tblComment\n"
                    + "WHERE article_id=? and status='Active'";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, articleID);
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            while(rs.next()) {
                id = rs.getInt("comment_id");
                content = rs.getNString("comment_content");
                email = rs.getString("user_email");
                dto = new CommentDTO(id, articleID, email, content, CommentDTO.DEFAULT_STATUS);
                result.add(dto);
            }
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return result;
    }
    
    public boolean delete(int id) throws Exception {
        boolean check = false;
        try {
            String sql = "UPDATE dbo.tblComment SET status=? WHERE comment_id=?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, CommentDTO.DELETE_STATUS);
            preStm.setInt(2, id);
            check = preStm.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return check;
    }
}
