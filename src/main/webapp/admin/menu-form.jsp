<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.makanmate.model.MenuItem" %>
<%
    MenuItem item = (MenuItem) request.getAttribute("item");
    boolean editMode = item != null && item.getId() > 0;
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= editMode ? "Edit" : "Add" %> Menu Item - Admin</title>
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
        <h1><%= editMode ? "Update Menu Item" : "Add New Menu Item" %></h1>
        <a class="btn" href="${pageContext.request.contextPath}/admin/menu">Back</a>
    </div>

    <div class="card form-card">
        <form method="post" action="${pageContext.request.contextPath}/admin/menu">
            <input type="hidden" name="action" value="<%= editMode ? "update" : "insert" %>">
            <% if (editMode) { %><input type="hidden" name="id" value="<%= item.getId() %>"><% } %>

            <div class="form-group">
                <label>Food Name</label>
                <input type="text" name="itemName" value="<%= editMode ? item.getItemName() : "" %>" required>
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" required><%= editMode ? item.getDescription() : "" %></textarea>
            </div>
            <div class="form-group">
                <label>Category</label>
                <select name="category" required>
                    <option value="Rice" <%= editMode && "Rice".equals(item.getCategory()) ? "selected" : "" %>>Rice</option>
                    <option value="Noodles" <%= editMode && "Noodles".equals(item.getCategory()) ? "selected" : "" %>>Noodles</option>
                    <option value="Western" <%= editMode && "Western".equals(item.getCategory()) ? "selected" : "" %>>Western</option>
                    <option value="Drinks" <%= editMode && "Drinks".equals(item.getCategory()) ? "selected" : "" %>>Drinks</option>
                </select>
            </div>
            <div class="form-group">
                <label>Price (RM)</label>
                <input type="number" step="0.01" min="0.01" name="price" value="<%= editMode ? item.getPrice() : "" %>" required>
            </div>
            <div class="form-group">
                <label>Image URL (optional)</label>
                <input type="text" name="imageUrl" value="<%= editMode && item.getImageUrl() != null ? item.getImageUrl() : "" %>">
            </div>
            <div class="form-group">
                <label>
                    <input type="checkbox" name="availability" <%= !editMode || item.isAvailability() ? "checked" : "" %> style="width:auto;">
                    Available
                </label>
            </div>
            <button class="btn btn-primary" type="submit"><%= editMode ? "Update Item" : "Save Item" %></button>
        </form>
    </div>
</div>
<div class="footer">MakanMate Admin Panel</div>
</body>
</html>
