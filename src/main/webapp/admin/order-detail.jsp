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
                            <title>Order Details - Admin</title>
                            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
                        </head>

                        <body>
                            <div class="navbar">
                                <div class="nav-inner">
                                    <a class="nav-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                                        <img src="${pageContext.request.contextPath}/assets/images/logo_makanmate.png"
                                            alt="MakanMate Logo" class="nav-logo">
                                        <span>MakanMate Admin</span>
                                    </a>

                                    <div class="nav-links">
                                        <a href="${pageContext.request.contextPath}/admin/dashboard">
                                            Dashboard
                                        </a>

                                        <a href="${pageContext.request.contextPath}/admin/menu">
                                            Menu Items
                                        </a>

                                        <a class="active" href="${pageContext.request.contextPath}/admin/orders">
                                            Orders
                                        </a>

                                        <a href="${pageContext.request.contextPath}/admin/customers">
                                            Customers
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
                                    <h1>Update Order Status</h1>
                                    <a class="btn" href="${pageContext.request.contextPath}/admin/orders">Back</a>
                                </div>

                                <% if (request.getParameter("updated") !=null) { %>
                                    <div class="alert alert-success">Order status updated successfully.</div>
                                    <% } %>

                                        <% if (order !=null) { %>
                                            <div class="order-summary">
                                                <div class="card">
                                                    <h2>ORD<%= String.format("%04d", order.getId()) %>
                                                    </h2>
                                                    <p><strong>Customer:</strong>
                                                        <%= order.getCustomerName() %>
                                                    </p>
                                                    <p><strong>Date:</strong>
                                                        <%= order.getOrderDate() %>
                                                    </p>
                                                    <p><strong>Total Amount:</strong> RM <%= String.format("%.2f",
                                                            order.getTotalAmount()) %>
                                                    </p>
                                                    <p><strong>Current Status:</strong> <span
                                                            class="badge badge-yellow">
                                                            <%= order.getStatus() %>
                                                        </span></p>
                                                    <p><strong>Delivery:</strong><br>
                                                        <%= order.getDeliveryName() %><br>
                                                            <%= order.getDeliveryPhone() %><br>
                                                                <%= order.getDeliveryAddress() %>
                                                    </p>
                                                    <p><strong>Payment Method:</strong>
                                                        <%= order.getPaymentMethod() %>
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
                                                                    <form method="post"
                                                                        action="${pageContext.request.contextPath}/admin/orders">
                                                                        <input type="hidden" name="id"
                                                                            value="<%= order.getId() %>">
                                                                        <div class="form-group">
                                                                            <label>New Status</label>
                                                                            <select name="status" required>
                                                                                <option value="Pending" <%="Pending"
                                                                                    .equals(order.getStatus())
                                                                                    ? "selected" : "" %>>Pending
                                                                                </option>
                                                                                <option value="Preparing" <%="Preparing"
                                                                                    .equals(order.getStatus())
                                                                                    ? "selected" : "" %>>Preparing
                                                                                </option>
                                                                                <option value="Completed" <%="Completed"
                                                                                    .equals(order.getStatus())
                                                                                    ? "selected" : "" %>>Completed
                                                                                </option>
                                                                                <option value="Cancelled" <%="Cancelled"
                                                                                    .equals(order.getStatus())
                                                                                    ? "selected" : "" %>>Cancelled
                                                                                </option>
                                                                            </select>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label>Notes</label>
                                                                            <textarea
                                                                                name="notes"><%= order.getNotes() == null ? "" : order.getNotes() %></textarea>
                                                                        </div>
                                                                        <button class="btn btn-primary"
                                                                            type="submit">Update Status</button>
                                                                    </form>
                                                </div>
                                            </div>
                                            <% } else { %>
                                                <div class="card">Order not found.</div>
                                                <% } %>
                            </div>
                            <div class="footer">MakanMate Admin Panel</div>
                        </body>

                        </html>