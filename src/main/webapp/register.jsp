<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - VehicleRent</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            color: #333;
            overflow-x: hidden;
        }

        /* Navbar */
        .navbar {
            background: linear-gradient(135deg, #f5f5f5 0%, #e8e8e8 100%);
            padding: 1rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 2rem;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: #333;
            text-decoration: none;
            transition: transform 0.3s ease;
        }

        .logo:hover {
            transform: scale(1.05);
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 2rem;
        }

        .nav-links a {
            color: #333;
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
        }

        .nav-links a:hover {
            color: #666;
            transform: translateY(-2px);
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 2px;
            background: #666;
            transition: width 0.3s ease;
        }

        .nav-links a:hover::after {
            width: 100%;
        }

        .auth-buttons {
            display: flex;
            gap: 1rem;
        }

        .btn {
            padding: 0.5rem 1.5rem;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .btn-login {
            background: transparent;
            color: #333;
            border: 2px solid #333;
        }

        .btn-login:hover {
            background: #333;
            color: white;
            transform: translateY(-2px);
        }

        .btn-register {
            background: #666;
            color: white;
        }

        .btn-register:hover {
            background: #555;
            transform: translateY(-2px);
        }

        /* Register Section */
        .register-section {
            background: linear-gradient(135deg, rgba(245, 245, 245, 0.9), rgba(232, 232, 232, 0.9)),
            url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 800"><rect fill="%23f5f5f5" width="1200" height="800"/><g fill="%23e8e8e8"><circle cx="200" cy="200" r="100" opacity="0.3"/><circle cx="1000" cy="600" r="150" opacity="0.2"/><circle cx="600" cy="100" r="80" opacity="0.4"/></g></svg>');
            background-size: cover;
            background-position: center;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .register-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 3rem;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
            border: 2px solid #e8e8e8;
            animation: fadeInUp 0.8s ease;
        }

        .register-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .register-title {
            font-size: 2rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .register-subtitle {
            color: #666;
            font-size: 1rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            color: #333;
            font-weight: 500;
        }

        .form-input {
            width: 100%;
            padding: 1rem;
            border: 2px solid #e8e8e8;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }

        .form-input:focus {
            outline: none;
            border-color: #666;
            box-shadow: 0 0 20px rgba(102, 102, 102, 0.2);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        .btn-register-submit {
            width: 100%;
            padding: 1rem;
            background: #666;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
        }

        .btn-register-submit:hover {
            background: #555;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }

        .error-message {
            background: #ffebee;
            color: #c62828;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            border: 1px solid #ffcdd2;
            text-align: center;
        }

        .success-message {
            background: #e8f5e8;
            color: #2e7d32;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            border: 1px solid #c8e6c9;
            text-align: center;
        }

        .register-footer {
            text-align: center;
            margin-top: 2rem;
            color: #666;
        }

        .register-footer a {
            color: #666;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .register-footer a:hover {
            color: #333;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            
            .register-container {
                padding: 2rem;
                margin: 1rem;
            }

            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
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
