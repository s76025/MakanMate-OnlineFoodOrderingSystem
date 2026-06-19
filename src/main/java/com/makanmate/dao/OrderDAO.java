package com.makanmate.dao;

import com.makanmate.model.MenuItem;
import com.makanmate.model.Order;
import com.makanmate.model.OrderItem;
import com.makanmate.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class OrderDAO {

    public int createOrder(int customerId, String deliveryName, String deliveryPhone, String deliveryAddress,
                           String paymentMethod, String notes, Map<Integer, Integer> cart) throws SQLException {
        String orderSql = "INSERT INTO orders (customer_id, total_amount, status, delivery_name, delivery_phone, delivery_address, payment_method, notes) VALUES (?, ?, 'Pending', ?, ?, ?, ?, ?)";
        String itemSql = "INSERT INTO order_items (order_id, item_id, item_name, quantity, price, subtotal) VALUES (?, ?, ?, ?, ?, ?)";
        String menuSql = "SELECT * FROM menu_items WHERE id = ? AND availability = TRUE";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                double total = 0.0;
                List<MenuItem> menuItems = new ArrayList<>();
                List<Integer> quantities = new ArrayList<>();

                try (PreparedStatement menuPs = conn.prepareStatement(menuSql)) {
                    for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                        menuPs.setInt(1, entry.getKey());
                        try (ResultSet rs = menuPs.executeQuery()) {
                            if (rs.next()) {
                                MenuItem item = new MenuItem(
                                        rs.getInt("id"),
                                        rs.getString("item_name"),
                                        rs.getString("description"),
                                        rs.getString("category"),
                                        rs.getDouble("price"),
                                        rs.getString("image_url"),
                                        rs.getBoolean("availability")
                                );
                                int quantity = Math.max(1, entry.getValue());
                                menuItems.add(item);
                                quantities.add(quantity);
                                total += item.getPrice() * quantity;
                            }
                        }
                    }
                }

                if (menuItems.isEmpty()) {
                    throw new SQLException("Cart is empty or items are unavailable.");
                }

                int orderId;
                try (PreparedStatement orderPs = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                    orderPs.setInt(1, customerId);
                    orderPs.setDouble(2, total);
                    orderPs.setString(3, deliveryName);
                    orderPs.setString(4, deliveryPhone);
                    orderPs.setString(5, deliveryAddress);
                    orderPs.setString(6, paymentMethod);
                    orderPs.setString(7, notes);
                    orderPs.executeUpdate();

                    try (ResultSet keys = orderPs.getGeneratedKeys()) {
                        if (!keys.next()) {
                            throw new SQLException("Failed to create order.");
                        }
                        orderId = keys.getInt(1);
                    }
                }

                try (PreparedStatement itemPs = conn.prepareStatement(itemSql)) {
                    for (int i = 0; i < menuItems.size(); i++) {
                        MenuItem item = menuItems.get(i);
                        int quantity = quantities.get(i);
                        double subtotal = item.getPrice() * quantity;

                        itemPs.setInt(1, orderId);
                        itemPs.setInt(2, item.getId());
                        itemPs.setString(3, item.getItemName());
                        itemPs.setInt(4, quantity);
                        itemPs.setDouble(5, item.getPrice());
                        itemPs.setDouble(6, subtotal);
                        itemPs.addBatch();
                    }
                    itemPs.executeBatch();
                }

                conn.commit();
                return orderId;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public List<Order> findByCustomer(int customerId) throws SQLException {
        String sql = "SELECT o.*, u.name AS customer_name FROM orders o JOIN users u ON o.customer_id = u.id WHERE o.customer_id = ? ORDER BY o.id DESC";
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    orders.add(mapOrder(rs));
                }
            }
        }
        return orders;
    }

    public List<Order> findAll(String statusKeyword) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT o.*, u.name AS customer_name FROM orders o JOIN users u ON o.customer_id = u.id WHERE 1=1");
        if (statusKeyword != null && !statusKeyword.trim().isEmpty() && !"All".equalsIgnoreCase(statusKeyword)) {
            sql.append(" AND o.status = ?");
        }
        sql.append(" ORDER BY o.id DESC");

        List<Order> orders = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            if (statusKeyword != null && !statusKeyword.trim().isEmpty() && !"All".equalsIgnoreCase(statusKeyword)) {
                ps.setString(1, statusKeyword);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    orders.add(mapOrder(rs));
                }
            }
        }
        return orders;
    }

    public Order findById(int orderId) throws SQLException {
        String sql = "SELECT o.*, u.name AS customer_name FROM orders o JOIN users u ON o.customer_id = u.id WHERE o.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapOrder(rs);
                }
            }
        }
        return null;
    }

    public List<OrderItem> findItems(int orderId) throws SQLException {
        String sql = "SELECT * FROM order_items WHERE order_id = ? ORDER BY id";
        List<OrderItem> items = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(rs.getInt("id"));
                    item.setOrderId(rs.getInt("order_id"));
                    item.setItemId(rs.getInt("item_id"));
                    item.setItemName(rs.getString("item_name"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getDouble("price"));
                    item.setSubtotal(rs.getDouble("subtotal"));
                    items.add(item);
                }
            }
        }
        return items;
    }

    public void updateStatus(int orderId, String status, String notes) throws SQLException {
        String sql = "UPDATE orders SET status = ?, notes = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, notes);
            ps.setInt(3, orderId);
            ps.executeUpdate();
        }
    }

    public void delete(int orderId) throws SQLException {
        String sql = "DELETE FROM orders WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.executeUpdate();
        }
    }

    private Order mapOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setCustomerId(rs.getInt("customer_id"));
        order.setCustomerName(rs.getString("customer_name"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setTotalAmount(rs.getDouble("total_amount"));
        order.setStatus(rs.getString("status"));
        order.setDeliveryName(rs.getString("delivery_name"));
        order.setDeliveryPhone(rs.getString("delivery_phone"));
        order.setDeliveryAddress(rs.getString("delivery_address"));
        order.setPaymentMethod(rs.getString("payment_method"));
        order.setNotes(rs.getString("notes"));
        return order;
    }
}
