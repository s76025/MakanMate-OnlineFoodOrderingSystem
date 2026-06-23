<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>MakanMate | Login</title>
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

                <% if (request.getAttribute("error") !=null) { %>
                    <div class="alert alert-error">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>
                        <% if (request.getParameter("registered") !=null) { %>
                            <div class="alert alert-success">Registration successful. Please login.</div>
                            <% } %>

                                <form method="post" action="${pageContext.request.contextPath}/login"
                                    onsubmit="return validateLogin()">
                                    <div class="form-group">
                                        <label>Email</label>
                                        <input type="email" name="email" id="email" placeholder="Enter your email"
                                            required>
                                    </div>
                                    <div class="form-group">
                                        <label>Password</label>
                                        <input type="password" name="password" id="password" placeholder="Enter you password"
                                            required>
                                    </div>
                                    <button class="btn btn-primary" style="width:100%;" type="submit">Login</button>
                                </form>

                                <p class="muted" style="margin-top:16px;">
                                    New Customer? <a href="${pageContext.request.contextPath}/register"
                                        style="color:#ff9800;font-weight:800;">Register here</a>
                                </p>

                                <div class="motorcycle-logo">
                                    <img src="${pageContext.request.contextPath}/assets/images/login_motor.png"
                                        alt="Delivery Motorcycle">
                                </div>

                                <div class="demo-toggle">
                                    <button type="button" class="btn btn-small btn-primary"
                                        onclick="toggleDemo()">Show/Hide Demo Account</button>
                                    <div id="demoCard" class="card demo-card" style="display:none;">
                                        <strong>Demo account</strong><br>
                                        Admin: admin@makanmate.com / admin123<br>
                                        Customer: customer@makanmate.com / customer123
                                    </div>
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
        <script>
            function toggleDemo() {
                const demo = document.getElementById("demoCard");
                demo.style.display = (demo.style.display === "none") ? "block" : "none";
            }
        </script>

    </body>

    </html>