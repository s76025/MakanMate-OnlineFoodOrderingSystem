package com.makanmate.controller;

import com.makanmate.dao.MenuItemDAO;
import com.makanmate.model.CartItem;
import com.makanmate.model.MenuItem;

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

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private final MenuItemDAO menuItemDAO = new MenuItemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            prepareCartData(request);
            request.getRequestDispatcher("/customer/cart.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = getCart(session);

        try {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            if ("add".equals(action)) {
                cart.put(itemId, cart.getOrDefault(itemId, 0) + Math.max(1, quantity));
            } else if ("update".equals(action)) {
                if (quantity <= 0) {
                    cart.remove(itemId);
                } else {
                    cart.put(itemId, quantity);
                }
            } else if ("remove".equals(action)) {
                cart.remove(itemId);
            }
            session.setAttribute("cart", cart);
            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (Exception e) {
            throw new ServletException(e);
        }
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
