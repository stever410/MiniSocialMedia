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
public class UserDTO implements Serializable {

    public static final String ADMIN = "admin";
    public static final String DEFAULT_ROLE = "member";
    public static final String DEFAULT_STATUS = "New";
    public static final String ACTIVE_STATUS = "Active";
    
    private String email;
    private String name;
    private String password;
    private String role;
    private String status;

    public UserDTO(String email, String name, String role, String status) {
        this.email = email;
        this.name = name;
        this.role = role;
        this.status = status;
    }

    public UserDTO(String email, String name) {
        this.email = email;
        this.name = name;
        this.role = DEFAULT_ROLE;
        this.status = DEFAULT_STATUS;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "UserDTO{" + "email=" + email + ", name=" + name + ", password=" + password + ", role=" + role + ", status=" + status + '}';
    }

}
