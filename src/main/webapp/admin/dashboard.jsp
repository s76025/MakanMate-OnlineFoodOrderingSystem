<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.makanmate.model.Order" %>
<%
    Map<String, Object> summary = (Map<String, Object>) request.getAttribute("summary");
    List<Order> recentOrders = (List<Order>) request.getAttribute("recentOrders");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - MakanMate</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="navbar">
    <div class="nav-inner">
        <a class="nav-brand" href="${pageContext.request.contextPath}/admin/dashboard">🍱 MakanMate Admin</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/menu">Menu Items</a>
            <a href="${pageContext.request.contextPath}/admin/orders">Orders</a>
            <a href="${pageContext.request.contextPath}/admin/customers">Customers</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
</div>

<div class="container">
    <div class="page-title">
        <h1>Dashboard</h1>
    </div>

    <div class="grid">
        <div class="card stat-card"><h2><%= summary.get("totalCustomers") %></h2><p>Total Customers</p></div>
        <div class="card stat-card"><h2><%= summary.get("totalMenus") %></h2><p>Total Menu Items</p></div>
        <div class="card stat-card"><h2><%= summary.get("totalOrders") %></h2><p>Total Orders</p></div>
        <div class="card stat-card"><h2>RM <%= String.format("%.2f", (Double) summary.get("totalRevenue")) %></h2><p>Total Revenue</p></div>
    </div>

    <h2 style="margin-top:28px;">Recent Orders</h2>
    <div class="table-wrap">
        <table>
            <tr>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Date</th>
                <th>Total</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <% if (recentOrders != null && !recentOrders.isEmpty()) { %>
                <% int count = 0; for (Order order : recentOrders) { if (count++ >= 5) break; %>
                    <tr>
                        <td>ORD<%= String.format("%04d", order.getId()) %></td>
                        <td><%= order.getCustomerName() %></td>
                        <td><%= order.getOrderDate() %></td>
                        <td>RM <%= String.format("%.2f", order.getTotalAmount()) %></td>
                        <td><span class="badge badge-yellow"><%= order.getStatus() %></span></td>
                        <td><a class="btn btn-small" href="${pageContext.request.contextPath}/admin/orders?action=detail&id=<%= order.getId() %>">View</a></td>
                    </tr>
                <% } %>
            <% } else { %>
                <tr><td colspan="6">No orders yet.</td></tr>
            <% } %>
        </table>
    </div>
</div>
<div class="footer">MakanMate Admin Panel</div>
</body>
</html>
