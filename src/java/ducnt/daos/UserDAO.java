/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.daos;

import ducnt.db.DBConnection;
import ducnt.dtos.UserDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author ngota
 */
public class UserDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    public UserDAO() {
    }

    public UserDTO checkLogin(String email, String password) throws Exception {
        UserDTO dto = null;
        String name, status, role;
        try {
            String sql = "SELECT name, role, status\n"
                    + "FROM dbo.tblUser\n"
                    + "WHERE email=? AND password=?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            preStm.setString(2, password);
            rs = preStm.executeQuery();
            if(rs.next()) {
                name = rs.getNString("name");
                status = rs.getString("status");
                role = rs.getString("role");
                dto = new UserDTO(email, name, role, status);
            }
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return dto;
    }

    public boolean updateUserStatus(String email, String status) throws Exception {
        boolean check = false;
        try {
            String sql = "UPDATE dbo.tblUser SET status=? WHERE email=?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, status);
            preStm.setString(2, email);
            check = preStm.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return check;
    }
    
    public boolean addUser(UserDTO dto) throws Exception {
        boolean check = false;
        try {
            String sql = "INSERT dbo.tblUser(email, name, password, role, status)\n"
                    + "VALUES(?,?,?,?,?)";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, dto.getEmail());
            preStm.setNString(2, dto.getName());
            preStm.setString(3, dto.getPassword());
            preStm.setString(4, dto.getRole());
            preStm.setString(5, dto.getStatus());
            check = preStm.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn, preStm, rs);
        }
        return check;
    }
}
