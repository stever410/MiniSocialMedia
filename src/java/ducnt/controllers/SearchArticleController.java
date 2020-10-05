/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.controllers;

import ducnt.daos.ArticleDAO;
import ducnt.dtos.ArticleDTO;
import ducnt.utils.PropertiesUtil;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ngota
 */
public class SearchArticleController extends HttpServlet {

    private static final String SEARCH_PAGE = "search_page";
    private static final int MAX_PAGE_ITEM = 20;

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
        String url = prop.getDispatcherValue(SEARCH_PAGE);
        try {
            String search = request.getParameter("txtSearch");
            int currentPage = Integer.parseInt(request.getParameter("txtCurrentPage"));
            int offset = (currentPage - 1) * MAX_PAGE_ITEM;
            ArticleDAO dao = new ArticleDAO();
            int totalRecords = dao.getSearchByLikeContentTotal(search);
            double totalPage = Math.ceil((double) totalRecords / MAX_PAGE_ITEM);
            List<ArticleDTO> result = dao.searchByLikeContent(search, offset, MAX_PAGE_ITEM);
            request.setAttribute("SEARCH_RESULT", result);
            request.setAttribute("TOTAL_PAGE", totalPage);
            request.setAttribute("CURRENT_PAGE", currentPage);
        } catch (Exception e) {
            log("Error at SearchArticleController " + e.getMessage());
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
