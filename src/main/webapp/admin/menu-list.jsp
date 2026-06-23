<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.makanmate.model.MenuItem" %>
<%
    List<MenuItem> items = (List<MenuItem>) request.getAttribute("items");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Menu Items - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="navbar">
    <div class="nav-inner">
        <a class="nav-brand"
            href="${pageContext.request.contextPath}/admin/dashboard">
            <img src="${pageContext.request.contextPath}/assets/images/logo_makanmate.png"
                alt="MakanMate Logo" class="nav-logo">
            <span>MakanMate Admin</span>
        </a>

        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/dashboard">
                Dashboard
            </a>

            <a class="active" href="${pageContext.request.contextPath}/admin/menu">
                Menu Items
            </a>

            <a href="${pageContext.request.contextPath}/admin/orders">
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
        <h1>Menu Items Management</h1>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/menu?action=new">+ Add Menu Item</a>
    </div>

    <% if (request.getParameter("added") != null) { %><div class="alert alert-success">Menu item added successfully.</div><% } %>
    <% if (request.getParameter("updated") != null) { %><div class="alert alert-success">Menu item updated successfully.</div><% } %>
    <% if (request.getParameter("deleted") != null) { %><div class="alert alert-success">Menu item deleted successfully.</div><% } %>

    <div class="table-wrap">
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Category</th>
                <th>Price</th>
                <th>Availability</th>
                <th>Description</th>
                <th>Action</th>
            </tr>
            <% if (items != null && !items.isEmpty()) { %>
                <% for (MenuItem item : items) { %>
                    <tr>
                        <td><%= item.getId() %></td>
                        <td><strong><%= item.getItemName() %></strong></td>
                        <td><%= item.getCategory() %></td>
                        <td>RM <%= String.format("%.2f", item.getPrice()) %></td>
                        <td><span class="badge <%= item.isAvailability() ? "badge-green" : "badge-red" %>"><%= item.isAvailability() ? "Available" : "Unavailable" %></span></td>
                        <td><%= item.getDescription() %></td>
                        <td>
                            <a class="btn btn-small" href="${pageContext.request.contextPath}/admin/menu?action=edit&id=<%= item.getId() %>">Edit</a>
                            <a class="btn btn-danger btn-small" onclick="return confirm('Delete this item?')" href="${pageContext.request.contextPath}/admin/menu?action=delete&id=<%= item.getId() %>">Delete</a>
                        </td>
                    </tr>
                <% } %>
            <% } else { %>
                <tr><td colspan="7">No menu item found.</td></tr>
            <% } %>
        </table>
    </div>
</div>
<div class="footer">MakanMate Admin Panel</div>
</body>
</html>
