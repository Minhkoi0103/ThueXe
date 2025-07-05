<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - VehicleRent</title>
    <link rel="stylesheet" href="./css/register.css">
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

<!-- Register Section -->
<section class="register-section">
    <div class="register-container">
        <div class="register-header">
            <h1 class="register-title">Đăng ký</h1>
            <p class="register-subtitle">Tạo tài khoản mới để bắt đầu thuê xe</p>
        </div>

        <%
            String error = request.getParameter("error");
            if (error != null) {
                String errorMessage = "";
                switch (error) {
                    case "password_mismatch":
                        errorMessage = "Mật khẩu xác nhận không khớp!";
                        break;
                    case "email_exists":
                        errorMessage = "Email đã tồn tại trong hệ thống!";
                        break;
                    case "insert_failed":
                        errorMessage = "Có lỗi xảy ra khi đăng ký. Vui lòng thử lại!";
                        break;
                    case "empty_username":
                        errorMessage = "Vui lòng nhập họ và tên!";
                        break;
                    case "invalid_username":
                        errorMessage = "Họ và tên không hợp lệ (3-100 ký tự, chỉ chữ cái, số, dấu gạch dưới và khoảng trắng)!";
                        break;
                    case "empty_email":
                        errorMessage = "Vui lòng nhập email!";
                        break;
                    case "invalid_email":
                        errorMessage = "Email không đúng định dạng!";
                        break;
                    case "empty_password":
                        errorMessage = "Vui lòng nhập mật khẩu!";
                        break;
                    case "weak_password":
                        errorMessage = "Mật khẩu phải có ít nhất 6 ký tự!";
                        break;
                    case "empty_phone":
                        errorMessage = "Vui lòng nhập số điện thoại!";
                        break;
                    case "invalid_phone":
                        errorMessage = "Số điện thoại không hợp lệ (10-11 số)!";
                        break;
                    case "empty_address":
                        errorMessage = "Vui lòng nhập địa chỉ!";
                        break;
                    case "invalid_address":
                        errorMessage = "Địa chỉ phải từ 5-200 ký tự!";
                        break;
                    case "empty_identity":
                        errorMessage = "Vui lòng nhập CCCD!";
                        break;
                    case "invalid_identity":
                        errorMessage = "CCCD phải có đúng 12 số!";
                        break;
                    case "system_error":
                        errorMessage = "Lỗi hệ thống. Vui lòng thử lại sau!";
                        break;
                    default:
                        errorMessage = "Có lỗi xảy ra. Vui lòng thử lại!";
                        break;
                }
        %>
        <div class="error-message">
            <%= errorMessage %>
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

        <form action="register" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="user_name" class="form-label">Họ và tên</label>
                <input type="text" id="user_name" name="user_name" class="form-input" required>
            </div>

            <div class="form-group">
                <label for="email" class="form-label">Email</label>
                <input type="email" id="email" name="email" class="form-input" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="phone_number" class="form-label">Số điện thoại</label>
                    <input type="tel" id="phone_number" name="phone_number" class="form-input" required>
                </div>

                <div class="form-group">
                    <label for="identity_number" class="form-label">CCCD</label>
                    <input type="text" id="identity_number" name="identity_number" class="form-input" required>
                </div>
            </div>

            <div class="form-group">
                <label for="address" class="form-label">Địa chỉ</label>
                <input type="text" id="address" name="address" class="form-input" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="user_password" class="form-label">Mật khẩu</label>
                    <input type="password" id="user_password" name="user_password" class="form-input" required>
                </div>

                <div class="form-group">
                    <label for="confirm_password" class="form-label">Xác nhận mật khẩu</label>
                    <input type="password" id="confirm_password" name="confirm_password" class="form-input" required>
                </div>
            </div>

            <button type="submit" class="btn-register-submit">Đăng ký</button>
        </form>

        <div class="register-footer">
            <p>Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a></p>
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

    // Form validation
    function validateForm() {
        const password = document.getElementById('user_password').value;
        const confirmPassword = document.getElementById('confirm_password').value;
        const phone = document.getElementById('phone_number').value;
        const identity = document.getElementById('identity_number').value;

        // Kiểm tra mật khẩu
        if (password !== confirmPassword) {
            alert('Mật khẩu xác nhận không khớp!');
            return false;
        }

        // Kiểm tra độ dài mật khẩu
        if (password.length < 6) {
            alert('Mật khẩu phải có ít nhất 6 ký tự!');
            return false;
        }

        // Kiểm tra số điện thoại
        const phoneRegex = /^[0-9]{10,11}$/;
        if (!phoneRegex.test(phone)) {
            alert('Số điện thoại không hợp lệ!');
            return false;
        }

        // Kiểm tra CCCD
        const identityRegex = /^[0-9]{12}$/;
        if (!identityRegex.test(identity)) {
            alert('CCCD phải có 12 số!');
            return false;
        }

        return true;
    }
</script>
</body>
</html>