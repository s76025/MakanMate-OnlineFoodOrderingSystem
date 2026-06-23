<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.makanmate.model.Order" %>
            <%@ page import="com.makanmate.model.OrderItem" %>
                <% Order order=(Order) request.getAttribute("order"); List<OrderItem> items = (List<OrderItem>)
                        request.getAttribute("items");
                        %>
                        <!DOCTYPE html>
                        <html>

                        <head>
                            <title>Order Details - MakanMate</title>
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
                                    <h1>Order Details</h1>
                                    <a class="btn" href="${pageContext.request.contextPath}/orders">Back</a>
                                </div>

                                <% if (order !=null) { %>
                                    <div class="order-summary">
                                        <div class="card">
                                            <h2>ORD<%= String.format("%04d", order.getId()) %>
                                            </h2>
                                            <p><strong>Date:</strong>
                                                <%= order.getOrderDate() %>
                                            </p>
                                            <p><strong>Status:</strong> <span class="badge badge-yellow">
                                                    <%= order.getStatus() %>
                                                </span></p>
                                            <p><strong>Payment:</strong>
                                                <%= order.getPaymentMethod() %>
                                            </p>
                                            <p><strong>Delivery:</strong><br>
                                                <%= order.getDeliveryName() %><br>
                                                    <%= order.getDeliveryPhone() %><br>
                                                        <%= order.getDeliveryAddress() %>
                                            </p>
                                            <p><strong>Notes:</strong>
                                                <%= order.getNotes()==null ? "-" : order.getNotes() %>
                                            </p>
                                        </div>
                                        <div class="card">
                                            <h2>Items</h2>
                                            <% if (items !=null) { %>
                                                <% for (OrderItem item : items) { %>
                                                    <p><strong>
                                                            <%= item.getItemName() %>
                                                        </strong> x <%= item.getQuantity() %><br>
                                                            <span class="muted">RM <%= String.format("%.2f",
                                                                    item.getSubtotal()) %></span></p>
                                                    <% } %>
                                                        <% } %>
                                                            <hr>
                                                            <h2>Total: RM <%= String.format("%.2f",
                                                                    order.getTotalAmount()) %>
                                                            </h2>
                                        </div>
                                    </div>
                                    <% } %>
                            </div>
                            <div class="footer">MakanMate Online Food Ordering System</div>
                        </body>

                        </html>