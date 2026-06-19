<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.makanmate.model.User" %>
<%
    List<User> customers = (List<User>) request.getAttribute("customers");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Customers - Admin</title>
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
        <h1>Customer Information Management</h1>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/customers?action=new">+ Add Customer</a>
    </div>

    <% if (request.getParameter("added") != null) { %><div class="alert alert-success">Customer added successfully.</div><% } %>
    <% if (request.getParameter("updated") != null) { %><div class="alert alert-success">Customer updated successfully.</div><% } %>
    <% if (request.getParameter("deleted") != null) { %><div class="alert alert-success">Customer deleted successfully.</div><% } %>

    <div class="table-wrap">
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Address</th>
                <th>Action</th>
            </tr>
            <% if (customers != null && !customers.isEmpty()) { %>
                <% for (User customer : customers) { %>
                    <tr>
                        <td><%= customer.getId() %></td>
                        <td><strong><%= customer.getName() %></strong></td>
                        <td><%= customer.getEmail() %></td>
                        <td><%= customer.getPhone() %></td>
                        <td><%= customer.getAddress() %></td>
                        <td>
                            <a class="btn btn-small" href="${pageContext.request.contextPath}/admin/customers?action=edit&id=<%= customer.getId() %>">Edit</a>
                            <a class="btn btn-danger btn-small" onclick="return confirm('Delete this customer? Related orders will also be removed.')" href="${pageContext.request.contextPath}/admin/customers?action=delete&id=<%= customer.getId() %>">Delete</a>
                        </td>
                    </tr>
                <% } %>
            <% } else { %>
                <tr><td colspan="6">No customer found.</td></tr>
            <% } %>
        </table>
    </div>
</div>
<div class="footer">MakanMate Admin Panel</div>
</body>
</html>
