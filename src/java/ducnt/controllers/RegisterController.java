/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.controllers;

import ducnt.daos.UserDAO;
import ducnt.dtos.UserDTO;
import ducnt.utils.EncryptionUtil;
import ducnt.utils.PropertiesUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ngota
 */
public class RegisterController extends HttpServlet {

    private static final String REGISTER_PAGE = "register_page";
    private static final String LOGIN_PAGE = "login_page";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PropertiesUtil prop = new PropertiesUtil(getServletContext());
        String url = prop.getDispatcherValue(REGISTER_PAGE);
        String email = request.getParameter("txtEmail");
        UserDTO dto = null;
        try {
            //1: Get user parameter
            String name = request.getParameter("txtName");
            String password = request.getParameter("txtPassword");
            //2. Create user obj with SHA256 encrypted password
            dto = new UserDTO(email, name);
            dto.setPassword(EncryptionUtil.encrypt(password));
            //3. Call DAO to add user to db
            UserDAO dao = new UserDAO();
            if (dao.addUser(dto)) {
                url = prop.getDispatcherValue(LOGIN_PAGE);
                request.setAttribute("SUCCESS", "Registration success");
            }
        } catch (Exception e) {
            if (e.getMessage().contains("Cannot insert duplicate key")) {
                request.setAttribute("INVALID", email + " already existed");
            }
            request.setAttribute("DTO", dto);
            log("Error at RegisterController " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
