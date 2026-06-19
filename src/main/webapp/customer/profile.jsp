<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.makanmate.model.User" %>
<%
    User profile = (User) request.getAttribute("profile");
    if (profile == null) profile = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Profile - MakanMate</title>
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
    <div class="page-title"><h1>My Profile</h1></div>
    <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success"><%= request.getAttribute("success") %></div>
    <% } %>
    <div class="card form-card">
        <form method="post" action="${pageContext.request.contextPath}/profile">
            <div class="form-group">
                <label>Name</label>
                <input type="text" name="name" value="<%= profile.getName() %>" required>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" value="<%= profile.getEmail() %>" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="text" name="password" value="<%= profile.getPassword() %>" required>
            </div>
            <div class="form-group">
                <label>Phone</label>
                <input type="text" name="phone" value="<%= profile.getPhone() == null ? "" : profile.getPhone() %>" required>
            </div>
            <div class="form-group">
                <label>Address</label>
                <textarea name="address" required><%= profile.getAddress() == null ? "" : profile.getAddress() %></textarea>
            </div>
            <button class="btn btn-primary" type="submit">Update Profile</button>
        </form>
    </div>
</div>
<div class="footer">MakanMate Online Food Ordering System</div>
</body>
</html>
