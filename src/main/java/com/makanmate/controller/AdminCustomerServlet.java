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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("new".equals(action)) {
                request.getRequestDispatcher("/admin/customer-form.jsp").forward(request, response);
            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("customer", userDAO.findById(id));
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            User user = new User();
            user.setName(request.getParameter("name"));
            user.setEmail(request.getParameter("email"));
            user.setPassword(request.getParameter("password"));
            user.setPhone(request.getParameter("phone"));
            user.setAddress(request.getParameter("address"));
            user.setRole("CUSTOMER");

            if ("update".equals(action)) {
                user.setId(Integer.parseInt(request.getParameter("id")));
                userDAO.update(user);
                response.sendRedirect(request.getContextPath() + "/admin/customers?updated=1");
            } else {
                if (userDAO.emailExists(user.getEmail())) {
                    request.setAttribute("error", "Email already exists.");
                    request.setAttribute("customer", user);
                    request.getRequestDispatcher("/admin/customer-form.jsp").forward(request, response);
                    return;
                }
                userDAO.insert(user);
                response.sendRedirect(request.getContextPath() + "/admin/customers?added=1");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
