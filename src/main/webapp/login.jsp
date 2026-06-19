<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>MakanMate Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="auth-page">
    <div class="auth-card">
        <div class="logo">🍱 MakanMate</div>
        <p class="muted">Online Food Ordering System</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getParameter("registered") != null) { %>
            <div class="alert alert-success">Registration successful. Please login.</div>
        <% } %>

        <form method="post" action="${pageContext.request.contextPath}/login" onsubmit="return validateLogin()">
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" id="email" placeholder="admin@makanmate.com" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" id="password" placeholder="admin123" required>
            </div>
            <button class="btn btn-primary" style="width:100%;" type="submit">Login</button>
        </form>

        <p class="muted" style="margin-top:16px;">
            Customer baru? <a href="${pageContext.request.contextPath}/register" style="color:#ff9800;font-weight:800;">Register here</a>
        </p>

        <div class="card" style="margin-top:18px;background:#fff7e8;box-shadow:none;">
            <strong>Demo account</strong><br>
            Admin: admin@makanmate.com / admin123<br>
            Customer: customer@makanmate.com / customer123
        </div>
    </div>
</div>
<script>
function validateLogin() {
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    if (!email.includes('@')) {
        alert('Please enter a valid email address.');
        return false;
    }
    if (password.length < 3) {
        alert('Password is too short.');
        return false;
    }
    return true;
}
</script>
</body>
</html>
