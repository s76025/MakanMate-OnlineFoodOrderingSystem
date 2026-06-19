<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.makanmate.model.User" %>
<%
    User customer = (User) request.getAttribute("customer");
    boolean editMode = customer != null && customer.getId() > 0;
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= editMode ? "Edit" : "Add" %> Customer - Admin</title>
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
        <h1><%= editMode ? "Update Customer" : "Add New Customer" %></h1>
        <a class="btn" href="${pageContext.request.contextPath}/admin/customers">Back</a>
    </div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error"><%= request.getAttribute("error") %></div>
    <% } %>

    <div class="card form-card">
        <form method="post" action="${pageContext.request.contextPath}/admin/customers">
            <input type="hidden" name="action" value="<%= editMode ? "update" : "insert" %>">
            <% if (editMode) { %><input type="hidden" name="id" value="<%= customer.getId() %>"><% } %>

            <div class="form-group">
                <label>Name</label>
                <input type="text" name="name" value="<%= editMode ? customer.getName() : "" %>" required>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" value="<%= editMode ? customer.getEmail() : "" %>" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="text" name="password" value="<%= editMode ? customer.getPassword() : "" %>" required>
            </div>
            <div class="form-group">
                <label>Phone</label>
                <input type="text" name="phone" value="<%= editMode && customer.getPhone() != null ? customer.getPhone() : "" %>" required>
            </div>
            <div class="form-group">
                <label>Address</label>
                <textarea name="address" required><%= editMode && customer.getAddress() != null ? customer.getAddress() : "" %></textarea>
            </div>
            <button class="btn btn-primary" type="submit"><%= editMode ? "Update Customer" : "Save Customer" %></button>
        </form>
    </div>
</div>
<div class="footer">MakanMate Admin Panel</div>
</body>
</html>
