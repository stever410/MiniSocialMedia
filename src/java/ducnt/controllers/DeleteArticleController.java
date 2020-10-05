/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.controllers;

import ducnt.daos.ArticleDAO;
import ducnt.daos.NotificationDAO;
import ducnt.dtos.NotificationDTO;
import ducnt.dtos.UserDTO;
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
public class DeleteArticleController extends HttpServlet {

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
        String url = prop.getDispatcherValue("login_page");
        try {
            int id = Integer.parseInt(request.getParameter("txtArticleID"));
            String articleUserEmail = request.getParameter("txtArticleUserEmail");
            HttpSession session = request.getSession();
            UserDTO dto = (UserDTO) session.getAttribute("DTO");
            if (dto != null) {
                if (dto.getEmail().equals(articleUserEmail) || dto.getRole().equals(UserDTO.ADMIN)) {
                    ArticleDAO dao = new ArticleDAO();
                    if (dao.delete(id)) {
                        if (dto.getRole().equals(UserDTO.ADMIN)) {
                            String description = dto.getEmail() + " has deleted your post";
                            NotificationDAO notificationDAO = new NotificationDAO();
                            NotificationDTO notificationDTO = new NotificationDTO(description, articleUserEmail, dto.getEmail(), id);
                            notificationDAO.addNotification(notificationDTO);
                        }
                        url = prop.getDispatcherValue("load_article");
                    }
                }
            }
        } catch (Exception e) {
            log("Error at DeleteArticleController: " + e.getMessage());
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
