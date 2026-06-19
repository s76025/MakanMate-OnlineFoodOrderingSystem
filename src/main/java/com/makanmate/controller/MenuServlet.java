package com.makanmate.controller;

import com.makanmate.dao.MenuItemDAO;
import com.makanmate.model.MenuItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {
    private final MenuItemDAO menuItemDAO = new MenuItemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String keyword = request.getParameter("keyword");
            String category = request.getParameter("category");
            List<MenuItem> items = menuItemDAO.findAvailable(keyword, category);
            request.setAttribute("items", items);
            request.setAttribute("keyword", keyword);
            request.setAttribute("category", category);
            request.getRequestDispatcher("/customer/menu.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
