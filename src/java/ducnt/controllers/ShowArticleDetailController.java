/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.controllers;

import ducnt.daos.ArticleDAO;
import ducnt.daos.CommentDAO;
import ducnt.daos.EmotionDAO;
import ducnt.dtos.ArticleDTO;
import ducnt.dtos.EmotionDTO;
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
public class ShowArticleDetailController extends HttpServlet {

    private static final String DETAIL_PAGE = "detail_page";

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
        String url = prop.getDispatcherValue(DETAIL_PAGE);
        try {
            int articleID = Integer.parseInt(request.getParameter("txtArticleID"));
            HttpSession session = request.getSession();
            UserDTO userDTO = (UserDTO) session.getAttribute("DTO");
            if (userDTO != null) {
                //Article
                ArticleDAO articleDAO = new ArticleDAO();
                ArticleDTO dto = articleDAO.searchByID(articleID);
                if (dto.getStatus().equals(ArticleDTO.DEFAULT_STATUS)) {
                    request.setAttribute("ARTICLE_DTO", dto);

                    //Article comment
                    CommentDAO commentDAO = new CommentDAO();
                    request.setAttribute("LIST_COMMENT", commentDAO.searchCommentByArticle(articleID));

                    //Emotion
                    EmotionDAO emotionDAO = new EmotionDAO();
                    request.setAttribute("LIKE_COUNT", emotionDAO.getEmotionByType(articleID, EmotionDTO.LIKE));
                    request.setAttribute("DISLIKE_COUNT", emotionDAO.getEmotionByType(articleID, EmotionDTO.DISLIKE));
                    request.setAttribute("USER_EMOTION", emotionDAO.getEmotionOfUser(articleID, userDTO.getEmail()));
                } else {
                    request.setAttribute("NOTIFICATION", "This article has been deleted");
                }
            }
        } catch (Exception e) {
            log("Error at ShowArticleDetailController " + e.getMessage());
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
