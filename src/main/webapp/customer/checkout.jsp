<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.makanmate.model.CartItem" %>
<%@ page import="com.makanmate.model.User" %>
<%
    List<CartItem> cartRows = (List<CartItem>) request.getAttribute("cartRows");
    double cartTotal = request.getAttribute("cartTotal") == null ? 0.0 : (Double) request.getAttribute("cartTotal");
    User currentUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout - MakanMate</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="navbar">
    <div class="nav-inner">
        <a class="nav-brand" href="${pageContext.request.contextPath}/menu">🍱 MakanMate</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/menu">Menu</a>
            <a href="${pageContext.request.contextPath}/cart">My Cart</a>
            <a href="${pageContext.request.contextPath}/orders">My Orders</a>
            <a href="${pageContext.request.contextPath}/profile">Profile</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
</div>

<div class="container">
    <div class="page-title">
        <h1>Place Order</h1>
        <a class="btn" href="${pageContext.request.contextPath}/cart">Back to Cart</a>
    </div>

    <% if (cartRows == null || cartRows.isEmpty()) { %>
        <div class="card">Cart is empty.</div>
    <% } else { %>
        <div class="order-summary">
            <div class="card">
                <h2>Order Summary</h2>
                <% for (CartItem row : cartRows) { %>
                    <p><strong><%= row.getMenuItem().getItemName() %></strong> x <%= row.getQuantity() %><br>
                    <span class="muted">RM <%= String.format("%.2f", row.getSubtotal()) %></span></p>
                <% } %>
                <hr>
                <h2>Total: RM <%= String.format("%.2f", cartTotal) %></h2>
            </div>

            <div class="card">
                <h2>Delivery Information</h2>
                <form method="post" action="${pageContext.request.contextPath}/orders">
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" name="deliveryName" value="<%= currentUser.getName() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" name="deliveryPhone" value="<%= currentUser.getPhone() == null ? "" : currentUser.getPhone() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Delivery Address</label>
                        <textarea name="deliveryAddress" required><%= currentUser.getAddress() == null ? "" : currentUser.getAddress() %></textarea>
                    </div>
                    <div class="form-group">
                        <label>Payment Method</label>
                        <select name="paymentMethod" required>
                            <option value="Cash on Delivery">Cash on Delivery</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Notes (optional)</label>
                        <textarea name="notes" placeholder="Example: less spicy, pickup at cafe counter"></textarea>
                    </div>
                    <button class="btn btn-primary" type="submit">Place Order</button>
                </form>
            </div>
        </div>
    <% } %>
</div>
<div class="footer">MakanMate Online Food Ordering System</div>
</body>
</html>
