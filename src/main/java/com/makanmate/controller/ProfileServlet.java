package com.makanmate.controller;

import com.makanmate.dao.UserDAO;
import com.makanmate.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = getCurrentUser(request, response);
        if (user == null) return;
        request.setAttribute("profile", user);
        request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User current = getCurrentUser(request, response);
        if (current == null) return;

        try {
            User updated = new User();
            updated.setId(current.getId());
            updated.setName(request.getParameter("name"));
            updated.setEmail(request.getParameter("email"));
            updated.setPassword(request.getParameter("password"));
            updated.setPhone(request.getParameter("phone"));
            updated.setAddress(request.getParameter("address"));
            updated.setRole(current.getRole());
            userDAO.update(updated);

            request.getSession().setAttribute("user", updated);
            request.setAttribute("success", "Profile updated successfully.");
            request.setAttribute("profile", updated);
            request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private User getCurrentUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Object obj = request.getSession().getAttribute("user");
        if (!(obj instanceof User)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return null;
        }
        User user = (User) obj;
        if (!"CUSTOMER".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return null;
        }
        return user;
    }
}
