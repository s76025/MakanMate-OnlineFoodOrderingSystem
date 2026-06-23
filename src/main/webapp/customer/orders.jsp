<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.makanmate.model.Order" %>
            <% List<Order> orders = (List<Order>) request.getAttribute("orders");
                    %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <title>My Orders - MakanMate</title>
                        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
                    </head>

                    <body>
                        <div class="navbar">
                            <div class="nav-inner">
                                <a class="nav-brand" href="${pageContext.request.contextPath}/menu">
                                    <img src="${pageContext.request.contextPath}/assets/images/logo_makanmate.png"
                                        alt="MakanMate Logo" class="nav-logo">
                                    <span>MakanMate</span>
                                </a>

                                <div class="nav-links">
                                    <a href="${pageContext.request.contextPath}/menu">
                                        Menu
                                    </a>

                                    <a href="${pageContext.request.contextPath}/cart">
                                        My Cart
                                    </a>

                                    <a class="active" href="${pageContext.request.contextPath}/orders">
                                        My Orders
                                    </a>

                                    <a href="${pageContext.request.contextPath}/profile">
                                        Profile
                                    </a>

                                    <a href="${pageContext.request.contextPath}/logout"
                                        onclick="return confirm('Confirm logout from MakanMate?');">
                                        Logout
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div class="container">
                            <div class="page-title">
                                <h1>My Orders</h1>
                                <a class="btn btn-primary" href="${pageContext.request.contextPath}/menu">Order More</a>
                            </div>

                            <div class="table-wrap">
                                <table>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Date</th>
                                        <th>Total Amount</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    <% if (orders !=null && !orders.isEmpty()) { %>
                                        <% for (Order order : orders) { %>
                                            <tr>
                                                <td>ORD<%= String.format("%04d", order.getId()) %>
                                                </td>
                                                <td>
                                                    <%= order.getOrderDate() %>
                                                </td>
                                                <td>RM <%= String.format("%.2f", order.getTotalAmount()) %>
                                                </td>
                                                <td>
                                                    <span class="badge <%= " Completed".equals(order.getStatus())
                                                        ? "badge-green" : ("Cancelled".equals(order.getStatus())
                                                        ? "badge-red" : "badge-yellow" ) %>"><%= order.getStatus() %>
                                                            </span>
                                                </td>
                                                <td><a class="btn btn-small"
                                                        href="${pageContext.request.contextPath}/orders?action=detail&id=<%= order.getId() %>">View
                                                        Details</a></td>
                                            </tr>
                                            <% } %>
                                                <% } else { %>
                                                    <tr>
                                                        <td colspan="5">No orders yet.</td>
                                                    </tr>
                                                    <% } %>
                                </table>
                            </div>
                        </div>
                        <div class="footer">MakanMate Online Food Ordering System</div>
                    </body>

                    </html>