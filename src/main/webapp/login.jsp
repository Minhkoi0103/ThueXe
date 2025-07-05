<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - VehicleRent</title>
    <link rel="stylesheet" href="./css/login.css">

</head>
<body>
<!-- Navbar -->
<nav class="navbar">
    <div class="nav-container">
        <a href="index.jsp" class="logo">VehicleRent</a>
        <ul class="nav-links">
            <li><a href="index.jsp">Trang chủ</a></li>
            <li><a href="#vehicles">Xe</a></li>
            <li><a href="#about">Giới thiệu</a></li>
            <li><a href="#contact">Liên hệ</a></li>
        </ul>
        <div class="auth-buttons">
            <a href="login.jsp" class="btn btn-login">Đăng nhập</a>
            <a href="register.jsp" class="btn btn-register">Đăng ký</a>
        </div>
    </div>
</nav>

<!-- Login Section -->
<section class="login-section">
    <div class="login-container">
        <div class="login-header">
            <h1 class="login-title">Đăng nhập</h1>
            <p class="login-subtitle">Chào mừng bạn quay trở lại!</p>
        </div>

        <%
            if (request.getParameter("error") != null) {
        %>
        <div class="error-message">
            Sai email hoặc mật khẩu!
        </div>
        <%
            }

            // Hiển thị thông báo thành công nếu có
            String success = request.getParameter("success");
            if (success != null && success.equals("1")) {
        %>
        <div class="success-message">
            Đăng ký thành công! Vui lòng đăng nhập.
        </div>
        <%
            }
        %>

        <form action="login" method="post">
            <div class="form-group">
                <label for="email" class="form-label">Email</label>
                <input type="email" id="email" name="email" class="form-input" required>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">Mật khẩu</label>
                <input type="password" id="password" name="password" class="form-input" required>
            </div>

            <button type="submit" class="btn-login-submit">Đăng nhập</button>
        </form>

        <div class="login-footer">
            <p>Chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a></p>
        </div>
    </div>
</section>

<script>
    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
</script>
</body>
</html>