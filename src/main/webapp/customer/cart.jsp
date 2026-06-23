<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.makanmate.model.CartItem" %>
            <% List<CartItem> cartRows = (List<CartItem>) request.getAttribute("cartRows");
                    double cartTotal = request.getAttribute("cartTotal") == null ? 0.0 : (Double)
                    request.getAttribute("cartTotal");
                    %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <title>My Cart - MakanMate</title>
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

                                    <a class="active" href="${pageContext.request.contextPath}/cart">
                                        My Cart
                                    </a>

                                    <a href="${pageContext.request.contextPath}/orders">
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
                                <h1>My Cart</h1>
                                <a class="btn" href="${pageContext.request.contextPath}/menu">Continue Shopping</a>
                            </div>

                            <% if (cartRows !=null && !cartRows.isEmpty()) { %>
                                <div class="table-wrap">
                                    <table>
                                        <tr>
                                            <th>Food</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Subtotal</th>
                                            <th>Action</th>
                                        </tr>
                                        <% for (CartItem row : cartRows) { %>
                                            <tr>
                                                <td><strong>
                                                        <%= row.getMenuItem().getItemName() %>
                                                    </strong><br><span class="muted">
                                                        <%= row.getMenuItem().getCategory() %>
                                                    </span></td>
                                                <td>RM <%= String.format("%.2f", row.getMenuItem().getPrice()) %>
                                                </td>
                                                <td>
                                                    <form method="post" action="${pageContext.request.contextPath}/cart"
                                                        style="display:flex;gap:8px;align-items:center;">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="itemId"
                                                            value="<%= row.getMenuItem().getId() %>">
                                                        <input type="number" name="quantity"
                                                            value="<%= row.getQuantity() %>" min="0"
                                                            style="width:90px;">
                                                        <button class="btn btn-small" type="submit">Update</button>
                                                    </form>
                                                </td>
                                                <td><strong>RM <%= String.format("%.2f", row.getSubtotal()) %></strong>
                                                </td>
                                                <td>
                                                    <form method="post"
                                                        action="${pageContext.request.contextPath}/cart">
                                                        <input type="hidden" name="action" value="remove">
                                                        <input type="hidden" name="itemId"
                                                            value="<%= row.getMenuItem().getId() %>">
                                                        <input type="hidden" name="quantity" value="0">
                                                        <button class="btn btn-danger btn-small"
                                                            type="submit">Remove</button>
                                                    </form>
                                                </td>
                                            </tr>
                                            <% } %>
                                                <tr>
                                                    <td colspan="3"><strong>Total Amount</strong></td>
                                                    <td colspan="2"><strong class="price">RM <%= String.format("%.2f",
                                                                cartTotal) %></strong></td>
                                                </tr>
                                    </table>
                                </div>
                                <div class="form-actions">
                                    <a class="btn btn-primary"
                                        href="${pageContext.request.contextPath}/orders?action=checkout">Proceed to
                                        Checkout</a>
                                </div>
                                <% } else { %>
                                    <div class="card">Your cart is empty. <a style="color:#ff9800;font-weight:800;"
                                            href="${pageContext.request.contextPath}/menu">Order now</a></div>
                                    <% } %>
                        </div>
                        <div class="footer">MakanMate Online Food Ordering System</div>
                    </body>

                    </html>