/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.controllers;

import ducnt.daos.EmotionDAO;
import ducnt.daos.NotificationDAO;
import ducnt.dtos.EmotionDTO;
import ducnt.dtos.NotificationDTO;
import ducnt.dtos.UserDTO;
import ducnt.utils.PropertiesUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ngota
 */
public class AddEmotionController extends HttpServlet {

    private static final String LOGIN_PAGE = "login_page";
    private static final String SEARCH_DETAIL = "search_detail_article";

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
            int articleID = Integer.parseInt(request.getParameter("txtArticleID"));
            String articleUserEmail = request.getParameter("txtEmail");
            String type = request.getParameter("txtType");
            HttpSession session = request.getSession();
            UserDTO userDTO = (UserDTO) session.getAttribute("DTO");
            if (userDTO != null) {
                String currentUserEmail = userDTO.getEmail();
                EmotionDTO dto = new EmotionDTO(articleID, currentUserEmail, type);
                EmotionDAO dao = new EmotionDAO();
                if (dao.addEmotionToArticle(dto)) {
                    if (!currentUserEmail.equals(articleUserEmail)) {
                        String description = currentUserEmail + " has " + type.toLowerCase() + "d your post";
                        NotificationDTO notificationDTO = new NotificationDTO(description, articleUserEmail, currentUserEmail, articleID);
                        NotificationDAO notificationDAO = new NotificationDAO();
                        notificationDAO.addNotification(notificationDTO);
                    }
                    url = prop.getDispatcherValue(SEARCH_DETAIL);
                }
            }
        } catch (Exception e) {
            log("Error at AddEmotionController " + e.getMessage());
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
