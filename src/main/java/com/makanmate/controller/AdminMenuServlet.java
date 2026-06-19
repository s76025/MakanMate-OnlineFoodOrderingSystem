package com.makanmate.controller;

import com.makanmate.dao.MenuItemDAO;
import com.makanmate.model.MenuItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/menu")
public class AdminMenuServlet extends HttpServlet {
    private final MenuItemDAO menuItemDAO = new MenuItemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            MenuItem item = new MenuItem();
            item.setItemName(request.getParameter("itemName"));
            item.setDescription(request.getParameter("description"));
            item.setCategory(request.getParameter("category"));
            item.setPrice(Double.parseDouble(request.getParameter("price")));
            item.setImageUrl(request.getParameter("imageUrl"));
            item.setAvailability(request.getParameter("availability") != null);

            if ("update".equals(action)) {
                item.setId(Integer.parseInt(request.getParameter("id")));
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
}
