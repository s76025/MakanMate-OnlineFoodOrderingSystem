package com.makanmate.dao;

import com.makanmate.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class DashboardDAO {

    public Map<String, Object> getSummary() throws SQLException {
        Map<String, Object> summary = new HashMap<>();
        summary.put("totalCustomers", count("SELECT COUNT(*) FROM users WHERE role = 'CUSTOMER'"));
        summary.put("totalMenus", count("SELECT COUNT(*) FROM menu_items"));
        summary.put("totalOrders", count("SELECT COUNT(*) FROM orders"));
        summary.put("totalRevenue", sum("SELECT COALESCE(SUM(total_amount), 0) FROM orders WHERE status IN ('Completed', 'Preparing', 'Pending')"));
        return summary;
    }

    private int count(String sql) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        }
    }

    private double sum(String sql) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getDouble(1);
        }
    }
}
