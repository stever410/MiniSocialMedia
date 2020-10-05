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
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ngota
 */
public class LoginController extends HttpServlet {

    private static final String LOGIN_PAGE = "login_page";
    private static final String LOAD_ARTICLE = "load_article";
    private static final String SEND_VERIFICATION = "send_verification";

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
        String url = prop.getDispatcherValue(LOGIN_PAGE);
        try {
            //1. Get login parameter
            String email = request.getParameter("txtEmail");
            String password = request.getParameter("txtPassword");
            //2. Call DAO
            UserDAO dao = new UserDAO();
            UserDTO dto = dao.checkLogin(email, EncryptionUtil.encrypt(password));
            if (dto != null) {
                HttpSession session = request.getSession();
                if (dto.getRole().equals("member") || dto.getRole().equals("admin")) {
                    if (dto.getStatus().equals(UserDTO.DEFAULT_STATUS)) {
                        url = prop.getDispatcherValue(SEND_VERIFICATION);
                    } else if (dto.getStatus().equals(UserDTO.ACTIVE_STATUS)) {
                        url = prop.getDispatcherValue(LOAD_ARTICLE);
                    }
                    session.setAttribute("DTO", dto);
                } else {
                    request.setAttribute("INVALID", "Invalid role");
                    request.setAttribute("EMAIL", email);
                }
            } else {
                request.setAttribute("INVALID", "Invalid username or password");
                request.setAttribute("EMAIL", email);
            }
        } catch (Exception e) {
            log("Error at LoginController " + e.getMessage());
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
