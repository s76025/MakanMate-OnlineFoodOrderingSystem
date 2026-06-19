package com.makanmate.controller;

import com.makanmate.dao.MenuItemDAO;
import com.makanmate.dao.OrderDAO;
import com.makanmate.model.CartItem;
import com.makanmate.model.MenuItem;
import com.makanmate.model.Order;
import com.makanmate.model.OrderItem;
import com.makanmate.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();
    private final MenuItemDAO menuItemDAO = new MenuItemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = getCurrentCustomer(request, response);
        if (user == null) {
            return;
        }

        String action = request.getParameter("action");
        try {
            if ("checkout".equals(action)) {
                prepareCartData(request);
                request.getRequestDispatcher("/customer/checkout.jsp").forward(request, response);
            } else if ("detail".equals(action)) {
                int orderId = Integer.parseInt(request.getParameter("id"));
                Order order = orderDAO.findById(orderId);
                if (order == null || order.getCustomerId() != user.getId()) {
                    response.sendRedirect(request.getContextPath() + "/orders");
                    return;
                }
                List<OrderItem> items = orderDAO.findItems(orderId);
                request.setAttribute("order", order);
                request.setAttribute("items", items);
                request.getRequestDispatcher("/customer/order-detail.jsp").forward(request, response);
            } else {
                List<Order> orders = orderDAO.findByCustomer(user.getId());
                request.setAttribute("orders", orders);
                request.getRequestDispatcher("/customer/orders.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = getCurrentCustomer(request, response);
        if (user == null) {
            return;
        }

        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = getCart(session);

        if (cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        try {
            int orderId = orderDAO.createOrder(
                    user.getId(),
                    request.getParameter("deliveryName"),
                    request.getParameter("deliveryPhone"),
                    request.getParameter("deliveryAddress"),
                    request.getParameter("paymentMethod"),
                    request.getParameter("notes"),
                    cart
            );
            session.removeAttribute("cart");
            response.sendRedirect(request.getContextPath() + "/orders?action=detail&id=" + orderId);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private User getCurrentCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
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

    @SuppressWarnings("unchecked")
    private Map<Integer, Integer> getCart(HttpSession session) {
        Object object = session.getAttribute("cart");
        if (object instanceof Map) {
            return (Map<Integer, Integer>) object;
        }
        Map<Integer, Integer> cart = new LinkedHashMap<>();
        session.setAttribute("cart", cart);
        return cart;
    }

    private void prepareCartData(HttpServletRequest request) throws Exception {
        Map<Integer, Integer> cart = getCart(request.getSession());
        List<CartItem> cartRows = new ArrayList<>();
        double total = 0.0;

        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            MenuItem item = menuItemDAO.findById(entry.getKey());
            if (item != null) {
                CartItem row = new CartItem(item, entry.getValue());
                cartRows.add(row);
                total += row.getSubtotal();
            }
        }

        request.setAttribute("cartRows", cartRows);
        request.setAttribute("cartTotal", total);
    }
}
