package com.makanmate.controller;

import com.makanmate.dao.MenuItemDAO;
import com.makanmate.model.MenuItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/admin/menu")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class AdminMenuServlet extends HttpServlet {

    private final MenuItemDAO menuItemDAO = new MenuItemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("new".equals(action)) {
                request.getRequestDispatcher("/admin/menu-form.jsp").forward(request, response);

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("item", menuItemDAO.findById(id));
                request.getRequestDispatcher("/admin/menu-form.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                menuItemDAO.delete(id);
                response.sendRedirect(request.getContextPath() + "/admin/menu?deleted=1");

            } else {
                request.setAttribute("items", menuItemDAO.findAll());
                request.getRequestDispatcher("/admin/menu-list.jsp").forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("action");

            String itemName = request.getParameter("itemName");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String priceParam = request.getParameter("price");
            String currentImageUrl = request.getParameter("currentImageUrl");

            if (itemName == null || itemName.trim().isEmpty()) {
                throw new ServletException("Food name is missing. Please check name='itemName' in menu-form.jsp.");
            }

            if (category == null || category.trim().isEmpty()) {
                throw new ServletException("Category is missing. Please check name='category' in menu-form.jsp.");
            }

            if (priceParam == null || priceParam.trim().isEmpty()) {
                throw new ServletException("Price is missing. Please check name='price' in menu-form.jsp and @MultipartConfig in AdminMenuServlet.");
            }

            double price = Double.parseDouble(priceParam);

            Part imagePart = request.getPart("imageFile");
            String uploadedImageUrl = saveUploadedImage(imagePart);

            String finalImageUrl;
            if (uploadedImageUrl != null) {
                finalImageUrl = uploadedImageUrl;
            } else {
                finalImageUrl = currentImageUrl;
            }

            boolean availability = request.getParameter("availability") != null;

            MenuItem item = new MenuItem();
            item.setItemName(itemName);
            item.setDescription(description);
            item.setCategory(category);
            item.setPrice(price);
            item.setImageUrl(finalImageUrl);
            item.setAvailability(availability);

            if ("update".equals(action)) {
                String idParam = request.getParameter("id");

                if (idParam == null || idParam.trim().isEmpty()) {
                    throw new ServletException("Menu item ID is missing for update.");
                }

                int id = Integer.parseInt(idParam);
                item.setId(id);

                menuItemDAO.update(item);
                response.sendRedirect(request.getContextPath() + "/admin/menu?updated=1");

            } else {
                menuItemDAO.insert(item);
                response.sendRedirect(request.getContextPath() + "/admin/menu?added=1");
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private String saveUploadedImage(Part imagePart) throws IOException {

        if (imagePart == null || imagePart.getSize() == 0) {
            return null;
        }

        String submittedFileName = imagePart.getSubmittedFileName();

        if (submittedFileName == null || submittedFileName.trim().isEmpty()) {
            return null;
        }

        String originalFileName = Paths.get(submittedFileName).getFileName().toString();

        String fileExtension = "";
        int dotIndex = originalFileName.lastIndexOf(".");
        if (dotIndex > 0) {
            fileExtension = originalFileName.substring(dotIndex).toLowerCase();
        }

        if (!fileExtension.equals(".jpg") && !fileExtension.equals(".jpeg")
                && !fileExtension.equals(".png") && !fileExtension.equals(".gif")
                && !fileExtension.equals(".webp")) {
            throw new IOException("Only image files are allowed. Please upload jpg, jpeg, png, gif, or webp.");
        }

        String newFileName = "menu_" + System.currentTimeMillis() + fileExtension;

        String uploadPath = getServletContext().getRealPath("/assets/images/menu");

        if (uploadPath == null) {
            throw new IOException("Upload path is not available. Please deploy the project as an exploded WAR.");
        }

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        imagePart.write(uploadPath + File.separator + newFileName);

        return "assets/images/menu/" + newFileName;
    }
}