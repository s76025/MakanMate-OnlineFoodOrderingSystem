<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.makanmate.model.MenuItem" %>

        <% MenuItem item=(MenuItem) request.getAttribute("item"); boolean editMode=item !=null && item.getId()> 0;
            %>

            <!DOCTYPE html>
            <html>

            <head>
                <title>
                    <%= editMode ? "Edit" : "Add" %> Menu Item - Admin
                </title>
                <link rel="icon" type="image/png"
                    href="${pageContext.request.contextPath}/assets/images/logo_makanmate.png">
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
                        <h1>
                            <%= editMode ? "Update Menu Item" : "Add New Menu Item" %>
                        </h1>
                        <a class="btn" href="${pageContext.request.contextPath}/admin/menu">Back</a>
                    </div>

                    <div class="card form-card">
                        <form method="post" action="${pageContext.request.contextPath}/admin/menu"
                            enctype="multipart/form-data">

                            <% if (editMode) { %>
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="<%= item.getId() %>">
                                <% } else { %>
                                    <input type="hidden" name="action" value="insert">
                                    <% } %>

                                        <div class="form-group">
                                            <label>Food Name</label>
                                            <input type="text" name="itemName"
                                                value="<%= editMode && item.getItemName() != null ? item.getItemName() : "" %>"
                                                required>
                                        </div>

                                        <div class="form-group">
                                            <label>Description</label>
                                            <textarea name="description"
                                                required><%= editMode && item.getDescription() != null ? item.getDescription() : "" %></textarea>
                                        </div>

                                        <div class="form-group">
                                            <label>Category</label>
                                            <select name="category" required>
                                                <option value="Rice" <%=editMode && "Rice" .equals(item.getCategory())
                                                    ? "selected" : "" %>>Rice</option>
                                                <option value="Noodles" <%=editMode && "Noodles"
                                                    .equals(item.getCategory()) ? "selected" : "" %>>Noodles</option>
                                                <option value="Western" <%=editMode && "Western"
                                                    .equals(item.getCategory()) ? "selected" : "" %>>Western</option>
                                                <option value="Drinks" <%=editMode && "Drinks"
                                                    .equals(item.getCategory()) ? "selected" : "" %>>Drinks</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label>Price (RM)</label>
                                            <input type="number" step="0.01" min="0.01" name="price"
                                                value="<%= editMode ? item.getPrice() : "" %>" required>
                                        </div>

                                        <div class="form-group">
                                            <label>Menu Image</label>

                                            <% if (editMode && item.getImageUrl() !=null &&
                                                !item.getImageUrl().trim().isEmpty()) { %>
                                                <div style="margin-bottom:10px;">
                                                    <img src="${pageContext.request.contextPath}/<%= item.getImageUrl() %>"
                                                        alt="Current Image"
                                                        style="width:160px;height:120px;object-fit:cover;border-radius:12px;border:1px solid #ddd;">
                                                </div>
                                                <small>Current image will remain if no new image is uploaded.</small>
                                                <% } else { %>
                                                    <small>No image uploaded yet.</small>
                                                    <% } %>

                                                        <input type="file" name="imageFile" accept="image/*">

                                                        <input type="hidden" name="currentImageUrl"
                                                            value="<%= editMode && item.getImageUrl() != null ? item.getImageUrl() : "" %>">
                                        </div>

                                        <div class="form-group">
                                            <label>
                                                <input type="checkbox" name="availability" <%=!editMode ||
                                                    item.isAvailability() ? "checked" : "" %>
                                                style="width:auto;">
                                                Available
                                            </label>
                                        </div>

                                        <button class="btn btn-primary" type="submit">
                                            <%= editMode ? "Update Item" : "Save Item" %>
                                        </button>
                        </form>
                    </div>
                </div>

                <div class="footer">MakanMate Admin Panel</div>
            </body>

            </html>