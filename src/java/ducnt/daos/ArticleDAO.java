/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.daos;

import ducnt.db.DBConnection;
import ducnt.dtos.ArticleDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author ngota
 */
public class ArticleDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    public boolean addArticle(ArticleDTO dto) throws Exception {
        boolean check = true;
        try {
            String sql = "INSERT dbo.tblArticle(user_email, article_title, article_content, img, created_date, status)\n"
                    + "VALUES(?,?,?,?,GETDATE(), ?)";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, dto.getUserEmail());
            preStm.setNString(2, dto.getTitle());
            preStm.setNString(3, dto.getContent());
            preStm.setNString(4, dto.getImage());
            preStm.setString(5, dto.getStatus());
            check = preStm.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return check;
    }

    public List<ArticleDTO> searchByLikeContent(String search, int offset, int limit) throws Exception {
        List<ArticleDTO> list;
        int id;
        String title, content, image, status, email;
        Date createdDate;
        ArticleDTO dto;
        try {
            String sql = "SELECT article_id, article_title, article_content, img, created_date, user_email\n"
                    + "FROM dbo.tblArticle\n"
                    + "WHERE article_content LIKE ? AND status='Active'\n"
                    + "ORDER BY created_date DESC\n"
                    + "OFFSET ? ROWS\n"
                    + "FETCH NEXT ? ROWS ONLY";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setNString(1, "%" + search + "%");
            preStm.setInt(2, offset);
            preStm.setInt(3, limit);
            rs = preStm.executeQuery();
            list = new ArrayList();
            while (rs.next()) {
                id = rs.getInt("article_id");
                title = rs.getNString("article_title");
                content = rs.getNString("article_content");
                image = rs.getNString("img");
                createdDate = rs.getTimestamp("created_date");
                email = rs.getString("user_email");
                dto = new ArticleDTO(id, email, title, content, image, createdDate, "Active");
                list.add(dto);
            }
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return list;
    }

    public int getSearchByLikeContentTotal(String search) throws Exception {
        int total = -1;
        try {
            String sql = "SELECT COUNT(article_id) AS 'total'\n"
                    + "FROM dbo.tblArticle\n"
                    + "WHERE article_content LIKE ? AND status='Active'\n";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setNString(1, "%" + search + "%");
            rs = preStm.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return total;
    }

    public List<ArticleDTO> getAllArticle() throws Exception {
        List<ArticleDTO> list;
        int id;
        String title, content, image, email;
        Date createdDate;
        ArticleDTO dto;
        try {
            String sql = "SELECT article_id, article_title, article_content, img, created_date, user_email\n"
                    + "FROM dbo.tblArticle\n"
                    + "WHERE status='Active'\n"
                    + "ORDER BY created_date DESC";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            list = new ArrayList();
            while (rs.next()) {
                id = rs.getInt("article_id");
                title = rs.getNString("article_title");
                content = rs.getNString("article_content");
                image = rs.getNString("img");
                createdDate = rs.getTimestamp("created_date");
                email = rs.getString("user_email");
                dto = new ArticleDTO(id, email, title, content, image, createdDate, "Active");
                list.add(dto);
            }
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return list;
    }

    public ArticleDTO searchByID(int id) throws Exception {
        String title, content, image, email, status;
        Date createdDate;
        ArticleDTO dto = null;
        try {
            String sql = "SELECT article_title, article_content, img, created_date, user_email, status\n"
                    + "FROM dbo.tblArticle\n"
                    + "WHERE article_id = ?\n";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, id);
            rs = preStm.executeQuery();
            if (rs.next()) {
                title = rs.getNString("article_title");
                content = rs.getNString("article_content");
                image = rs.getNString("img");
                createdDate = rs.getTimestamp("created_date");
                email = rs.getString("user_email");
                status = rs.getString("status");
                dto = new ArticleDTO(id, email, title, content, image, createdDate, status);
            }
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return dto;
    }

    public boolean delete(int id) throws Exception {
        boolean check = false;
        try {
            String sql = "UPDATE dbo.tblArticle SET status=? WHERE article_id=?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, ArticleDTO.DELETE_STATUS);
            preStm.setInt(2, id);
            check = preStm.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return check;
    }
}
