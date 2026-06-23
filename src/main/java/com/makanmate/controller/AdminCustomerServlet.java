package com.makanmate.controller;

import com.makanmate.dao.UserDAO;
import com.makanmate.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/customers")
public class AdminCustomerServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("edit".equals(action) || "view".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));

                User customer = userDAO.findById(id);

                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/admin/customer-form.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));

                userDAO.delete(id);

                response.sendRedirect(request.getContextPath() + "/admin/customers?deleted=1");

            } else {
                request.setAttribute("customers", userDAO.findCustomers());
                request.getRequestDispatcher("/admin/customers.jsp").forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }
}