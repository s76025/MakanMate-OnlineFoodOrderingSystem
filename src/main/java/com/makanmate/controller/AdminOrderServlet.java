package com.makanmate.controller;

import com.makanmate.dao.OrderDAO;
import com.makanmate.model.Order;
import com.makanmate.model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("detail".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Order order = orderDAO.findById(id);
                List<OrderItem> items = orderDAO.findItems(id);
                request.setAttribute("order", order);
                request.setAttribute("items", items);
                request.getRequestDispatcher("/admin/order-detail.jsp").forward(request, response);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                orderDAO.delete(id);
                response.sendRedirect(request.getContextPath() + "/admin/orders?deleted=1");
            } else {
                String status = request.getParameter("status");
                request.setAttribute("orders", orderDAO.findAll(status));
                request.setAttribute("selectedStatus", status);
                request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            String notes = request.getParameter("notes");
            orderDAO.updateStatus(id, status, notes);
            response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + id + "&updated=1");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
