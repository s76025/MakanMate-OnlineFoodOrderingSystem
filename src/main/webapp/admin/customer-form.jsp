<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.makanmate.model.User" %>

<%
    User customer = (User) request.getAttribute("customer");
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Customer - Admin</title>
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

                <a href="${pageContext.request.contextPath}/admin/orders">
                    Orders
                </a>

                <a class="active" href="${pageContext.request.contextPath}/admin/customers">
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
            <h1>View Customer Details</h1>
            <a class="btn" href="${pageContext.request.contextPath}/admin/customers">Back</a>
        </div>

        <% if (customer != null) { %>
            <div class="card form-card">

                <div class="form-group">
                    <label>Customer ID</label>
                    <input type="text" value="<%= customer.getId() %>" readonly>
                </div>

                <div class="form-group">
                    <label>Name</label>
                    <input type="text" value="<%= customer.getName() %>" readonly>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" value="<%= customer.getEmail() %>" readonly>
                </div>

                <div class="form-group">
                    <label>Phone</label>
                    <input type="text"
                           value="<%= customer.getPhone() != null ? customer.getPhone() : "-" %>"
                           readonly>
                </div>

                <div class="form-group">
                    <label>Address</label>
                    <textarea readonly><%= customer.getAddress() != null ? customer.getAddress() : "-" %></textarea>
                </div>

            </div>
        <% } else { %>
            <div class="alert alert-error">
                Customer not found.
            </div>
        <% } %>
    </div>

    <div class="footer">MakanMate Admin Panel</div>
</body>
</html>