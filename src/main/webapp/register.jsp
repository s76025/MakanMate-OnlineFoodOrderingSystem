<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>MakanMate | Register</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logo_makanmate.png">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>

    <body>
        <div class="auth-page">
            <div class="auth-card">
                <div class="login-header">
                    <img src="${pageContext.request.contextPath}/assets/images/logo_makanmate.png" alt="MakanMate Logo"
                        class="login-logo-large">

                    <p class="login-subtitle">Online Food Ordering</p>
                </div>
                <!-- <p class="muted">Create a customer account.</p> -->

                <% if (request.getAttribute("error") !=null) { %>
                    <div class="alert alert-error">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>

                        <form method="post" action="${pageContext.request.contextPath}/register"
                            onsubmit="return validateRegister()">
                            <div class="form-group">
                                <label>Full Name</label>
                                <input type="text" name="name" required>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" name="email" id="email" required>
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" name="password" id="password" required>
                            </div>
                            <div class="form-group">
                                <label>Phone Number</label>
                                <input type="text" name="phone" required>
                            </div>
                            <div class="form-group">
                                <label>Address</label>
                                <textarea name="address" required></textarea>
                            </div>
                            <button class="btn btn-primary" style="width:100%;" type="submit">Create Account</button>
                        </form>

                        <p class="muted" style="margin-top:16px;">
                            Already have account? <a href="${pageContext.request.contextPath}/login"
                                style="color:#ff9800;font-weight:800;">Login</a>
                        </p>
            </div>
        </div>
        <script>
            function validateRegister() {
                const email = document.getElementById('email').value;
                const password = document.getElementById('password').value;
                if (!email.includes('@')) {
                    alert('Please enter a valid email address.');
                    return false;
                }
                if (password.length < 6) {
                    alert('Password must be at least 6 characters.');
                    return false;
                }
                return true;
            }
        </script>
    </body>

    </html>