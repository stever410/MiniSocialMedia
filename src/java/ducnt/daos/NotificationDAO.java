/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.daos;

import ducnt.db.DBConnection;
import ducnt.dtos.NotificationDTO;
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
public class NotificationDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    public boolean addNotification(NotificationDTO dto) throws Exception {
        boolean check = false;
        try {
            String sql = "INSERT dbo.tblNotification(description, user_email, interactor_email, article_id, created_date)\n"
                    + "VALUES  (?,?,?,?,GETDATE())";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setNString(1, dto.getDescription());
            preStm.setString(2, dto.getUserEmail());
            preStm.setString(3, dto.getInteractorEmail());
            preStm.setInt(4, dto.getArticleID());
            check = preStm.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return check;
    }

    public List<NotificationDTO> getTop20Notification(String userEmail) throws Exception {
        List<NotificationDTO> result;
        NotificationDTO dto;
        int id, articleID;
        String description, interactorEmail;
        Date createdDate;
        try {
            String sql = "SELECT TOP 20 notification_id, description, interactor_email, article_id, created_date\n"
                    + "FROM dbo.tblNotification\n"
                    + "WHERE user_email=?\n"
                    + "ORDER BY created_date DESC";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, userEmail);
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                id = rs.getInt("notification_id");
                description = rs.getNString("description");
                interactorEmail = rs.getString("interactor_email");
                articleID = rs.getInt("article_id");
                createdDate = rs.getTimestamp("created_date");
                dto = new NotificationDTO(id, description, userEmail, interactorEmail, articleID, createdDate);
                result.add(dto);
            }
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return result;
    }

    public List<NotificationDTO> getTop20Notification() throws Exception {
        List<NotificationDTO> result;
        NotificationDTO dto;
        int id, articleID;
        String description, interactorEmail, userEmail;
        Date createdDate;
        try {
            String sql = "SELECT TOP 20 notification_id, description, user_email, interactor_email, article_id, created_date\n"
                    + "FROM dbo.tblNotification\n"
                    + "ORDER BY created_date DESC";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                id = rs.getInt("notification_id");
                description = rs.getNString("description");
                userEmail = rs.getString("user_email");
                interactorEmail = rs.getString("interactor_email");
                articleID = rs.getInt("article_id");
                createdDate = rs.getTimestamp("created_date");
                dto = new NotificationDTO(id, description, userEmail, interactorEmail, articleID, createdDate);
                result.add(dto);
            }
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return result;
    }
}
