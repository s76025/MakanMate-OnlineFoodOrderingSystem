<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.makanmate.model.MenuItem" %>
<%@ page import="com.makanmate.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    List<MenuItem> items = (List<MenuItem>) request.getAttribute("items");
    String selectedCategory = request.getAttribute("category") == null ? "All" : String.valueOf(request.getAttribute("category"));
    String keyword = request.getAttribute("keyword") == null ? "" : String.valueOf(request.getAttribute("keyword"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>Menu - MakanMate</title>
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
        <div>
            <h1>Food Menu</h1>
            <p class="muted">Hi <%= currentUser.getName() %>, choose your food and add it to cart.</p>
        </div>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/cart">View Cart</a>
    </div>

    <form class="search-bar" method="get" action="${pageContext.request.contextPath}/menu">
        <input type="text" name="keyword" placeholder="Search food..." value="<%= keyword %>">
        <select name="category">
            <option value="All" <%= "All".equals(selectedCategory) ? "selected" : "" %>>All</option>
            <option value="Rice" <%= "Rice".equals(selectedCategory) ? "selected" : "" %>>Rice</option>
            <option value="Noodles" <%= "Noodles".equals(selectedCategory) ? "selected" : "" %>>Noodles</option>
            <option value="Western" <%= "Western".equals(selectedCategory) ? "selected" : "" %>>Western</option>
            <option value="Drinks" <%= "Drinks".equals(selectedCategory) ? "selected" : "" %>>Drinks</option>
        </select>
        <button class="btn btn-primary" type="submit">Search</button>
    </form>

    <div class="grid">
        <% if (items != null && !items.isEmpty()) { %>
            <% for (MenuItem item : items) { %>
                <div class="card menu-card">
                    <div class="menu-image">
                        <% if (item.getImageUrl() != null && !item.getImageUrl().trim().isEmpty()) { %>
                            <img src="<%= item.getImageUrl() %>" alt="<%= item.getItemName() %>" style="width:100%;height:100%;object-fit:cover;">
                        <% } else { %>
                            🍽️
                        <% } %>
                    </div>
                    <div class="menu-card-content">
                        <span class="badge badge-blue"><%= item.getCategory() %></span>
                        <h3><%= item.getItemName() %></h3>
                        <p class="muted"><%= item.getDescription() %></p>
                        <p class="price">RM <%= String.format("%.2f", item.getPrice()) %></p>
                        <form method="post" action="${pageContext.request.contextPath}/cart">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="itemId" value="<%= item.getId() %>">
                            <div class="form-group">
                                <label>Quantity</label>
                                <input type="number" name="quantity" value="1" min="1" required>
                            </div>
                            <button class="btn btn-primary" type="submit">Add to Cart</button>
                        </form>
                    </div>
                </div>
            <% } %>
        <% } else { %>
            <div class="card">No menu item found.</div>
        <% } %>
    </div>
</div>
<div class="footer">MakanMate Online Food Ordering System</div>
</body>
</html>
