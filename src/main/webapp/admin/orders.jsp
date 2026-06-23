<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.makanmate.model.Order" %>
            <% List<Order> orders = (List<Order>) request.getAttribute("orders");
                    String selectedStatus = request.getAttribute("selectedStatus") == null ? "All" :
                    String.valueOf(request.getAttribute("selectedStatus"));
                    %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <title>Orders - Admin</title>
                        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
                    </head>

                    <body>
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

                        <div class="container">
                            <div class="page-title">
                                <h1>Order Transactions Management</h1>
                            </div>

                            <% if (request.getParameter("deleted") !=null) { %>
                                <div class="alert alert-success">Order deleted successfully.</div>
                                <% } %>

                                    <form class="search-bar" method="get"
                                        action="${pageContext.request.contextPath}/admin/orders">
                                        <select name="status">
                                            <option value="All" <%="All" .equals(selectedStatus) ? "selected" : "" %>
                                                >All Status</option>
                                            <option value="Pending" <%="Pending" .equals(selectedStatus) ? "selected"
                                                : "" %>>Pending</option>
                                            <option value="Preparing" <%="Preparing" .equals(selectedStatus)
                                                ? "selected" : "" %>>Preparing</option>
                                            <option value="Completed" <%="Completed" .equals(selectedStatus)
                                                ? "selected" : "" %>>Completed</option>
                                            <option value="Cancelled" <%="Cancelled" .equals(selectedStatus)
                                                ? "selected" : "" %>>Cancelled</option>
                                        </select>
                                        <button class="btn btn-primary" type="submit">Filter</button>
                                    </form>

                                    <div class="table-wrap">
                                        <table>
                                            <tr>
                                                <th>Order ID</th>
                                                <th>Customer</th>
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
                                                            <%= order.getCustomerName() %>
                                                        </td>
                                                        <td>
                                                            <%= order.getOrderDate() %>
                                                        </td>
                                                        <td>RM <%= String.format("%.2f", order.getTotalAmount()) %>
                                                        </td>
                                                        <td><span class="badge badge-yellow">
                                                                <%= order.getStatus() %>
                                                            </span></td>
                                                        <td>
                                                            <a class="btn btn-small"
                                                                href="${pageContext.request.contextPath}/admin/orders?action=detail&id=<%= order.getId() %>">View
                                                                / Update</a>
                                                            <a class="btn btn-danger btn-small"
                                                                onclick="return confirm('Delete this order?')"
                                                                href="${pageContext.request.contextPath}/admin/orders?action=delete&id=<%= order.getId() %>">Delete</a>
                                                        </td>
                                                    </tr>
                                                    <% } %>
                                                        <% } else { %>
                                                            <tr>
                                                                <td colspan="6">No order found.</td>
                                                            </tr>
                                                            <% } %>
                                        </table>
                                    </div>
                        </div>
                        <div class="footer">MakanMate Admin Panel</div>
                    </body>

                    </html>