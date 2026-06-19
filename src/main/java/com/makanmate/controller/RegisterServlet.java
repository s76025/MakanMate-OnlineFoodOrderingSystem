package com.makanmate.controller;

import com.makanmate.dao.UserDAO;
import com.makanmate.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            if (userDAO.emailExists(email)) {
                request.setAttribute("error", "Email already exists. Please use another email.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            User user = new User();
            user.setName(request.getParameter("name"));
            user.setEmail(email);
            user.setPassword(request.getParameter("password"));
            user.setPhone(request.getParameter("phone"));
            user.setAddress(request.getParameter("address"));
            user.setRole("CUSTOMER");
            userDAO.insert(user);

            response.sendRedirect(request.getContextPath() + "/login?registered=1");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
