/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.controllers;

import ducnt.daos.ArticleDAO;
import ducnt.dtos.ArticleDTO;
import ducnt.utils.PropertiesUtil;
import java.io.File;
import java.io.IOException;
import java.util.Hashtable;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author ngota
 */
public class AddArticleController extends HttpServlet {

    private static final String LOGIN_PAGE = "login_page";
    private static final String LOAD_ARTICLE = "load_article";

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
        String email, title, content, image = null;
        List items = null;
        FileItem uploadedImageItem = null;
        String fileName = null;
        try {
            // check xem neu form la multipart
            boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
            if (isMultiPart) {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                items = upload.parseRequest(request);
                Hashtable params = new Hashtable();
                for (Object item : items) {
                    FileItem fileItem = (FileItem) item;
                    if (fileItem.isFormField()) {
                        //get form value
                        params.put(fileItem.getFieldName(), fileItem.getString("UTF-8"));
                    } else {
                        // get file uploaded name
                        uploadedImageItem = (FileItem) item;
                    }
                }
                email = (String) params.get("txtEmail");
                title = (String) params.get("txtTitle");
                content = (String) params.get("txtContent");
                String itemName = uploadedImageItem.getName();
                if (!itemName.isEmpty()) {
                    fileName = itemName.substring(itemName.lastIndexOf("\\") + 1);
                    String imageName = FilenameUtils.getBaseName(fileName);
                    String extension = FilenameUtils.getExtension(fileName);
                    // image name in db
                    image = imageName + "_" + System.currentTimeMillis() + "." + extension;
                    // image store in hard disk
                    String saveLocation = getServletContext().getRealPath("/") + "images\\" + image;
                    File savedImage = new File(saveLocation);
                    uploadedImageItem.write(savedImage);
                }
                ArticleDTO dto = new ArticleDTO(email, title, content, image);
                ArticleDAO dao = new ArticleDAO();
                if (dao.addArticle(dto)) {
                    url = prop.getDispatcherValue(LOAD_ARTICLE);
                    request.setAttribute("SUCCESS", "Post success");
                }
            }
        } catch (Exception e) {
            log("Error at AddArticleController " + e.getMessage());
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
