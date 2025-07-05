<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ - VehicleRent</title>
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
            align-items: center;
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

        .btn-logout {
            background: #dc3545;
            color: white;
        }

        .btn-logout:hover {
            background: #c82333;
            transform: translateY(-2px);
        }

        .btn-profile {
            background: #28a745;
            color: white;
        }

        .btn-profile:hover {
            background: #218838;
            transform: translateY(-2px);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 0.5rem 1rem;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 25px;
            border: 2px solid #e8e8e8;
        }

        .user-avatar {
            width: 32px;
            height: 32px;
            background: #666;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 0.9rem;
        }

        .user-name {
            font-weight: 500;
            color: #333;
        }

        /* Profile Section */
        .profile-section {
            background: linear-gradient(135deg, rgba(245, 245, 245, 0.9), rgba(232, 232, 232, 0.9));
            min-height: 100vh;
            padding: 120px 2rem 2rem;
        }

        .profile-container {
            max-width: 1000px;
            margin: 0 auto;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .profile-title {
            font-size: 2.5rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 1rem;
        }

        .profile-subtitle {
            color: #666;
            font-size: 1.1rem;
        }

        .profile-grid {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 3rem;
            margin-bottom: 3rem;
        }

        /* Profile Card */
        .profile-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            border: 2px solid #e8e8e8;
            text-align: center;
        }

        .profile-avatar-large {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 2.5rem;
            margin: 0 auto 1.5rem;
            box-shadow: 0 10px 30px rgba(40, 167, 69, 0.3);
        }

        .profile-name {
            font-size: 1.5rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .profile-role {
            color: #666;
            font-size: 1rem;
            margin-bottom: 1.5rem;
            padding: 0.5rem 1rem;
            background: #f8f9fa;
            border-radius: 20px;
            display: inline-block;
        }

        .profile-stats {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-top: 2rem;
        }

        .stat-item {
            text-align: center;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 10px;
        }

        .stat-number {
            font-size: 1.5rem;
            font-weight: bold;
            color: #28a745;
        }

        .stat-label {
            font-size: 0.9rem;
            color: #666;
            margin-top: 0.25rem;
        }

        /* Profile Form */
        .profile-form {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            border: 2px solid #e8e8e8;
        }

        .form-title {
            font-size: 1.5rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 2rem;
            text-align: center;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
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
            border-color: #28a745;
            box-shadow: 0 0 20px rgba(40, 167, 69, 0.2);
        }

        .form-input:disabled {
            background: #f8f9fa;
            color: #666;
            cursor: not-allowed;
        }

        .btn-update {
            width: 100%;
            padding: 1rem;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
        }

        .btn-update:hover {
            background: #218838;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }

        .btn-change-password {
            width: 100%;
            padding: 1rem;
            background: #17a2b8;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
        }

        .btn-change-password:hover {
            background: #138496;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }

        .success-message {
            background: #e8f5e8;
            color: #2e7d32;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            border: 1px solid #a5d6a7;
            text-align: center;
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

        /* Recent Activity */
        .recent-activity {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            border: 2px solid #e8e8e8;
            margin-top: 2rem;
        }

        .activity-title {
            font-size: 1.5rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 1.5rem;
        }

        .activity-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            border-bottom: 1px solid #e8e8e8;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            background: #28a745;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .activity-content {
            flex: 1;
        }

        .activity-text {
            font-weight: 500;
            color: #333;
        }

        .activity-time {
            font-size: 0.9rem;
            color: #666;
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

        .fade-in-up {
            animation: fadeInUp 0.8s ease;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            
            .profile-grid {
                grid-template-columns: 1fr;
                gap: 2rem;
            }
            
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .user-info {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .auth-buttons {
                flex-direction: column;
                gap: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <%
        // Session management
        String userEmail = (String) session.getAttribute("userEmail");
        String userName = (String) session.getAttribute("userName");
        String userRole = (String) session.getAttribute("userRole");
        Long userID = (Long) session.getAttribute("userID");
        
        // Redirect if not logged in
        if (userEmail == null || userEmail.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get user information from database
        dao.UserDAO userDAO = new dao.UserDAO();
        model.User user = userDAO.getUserByEmail(userEmail);
        
        if (user != null) {
            userName = user.getUserName();
            userRole = user.getUserRole();
            userID = user.getUserID();
        }
        
        // Generate user avatar initials
        String userInitials = "";
        if (userName != null && !userName.isEmpty()) {
            String[] nameParts = userName.split("\\s+");
            if (nameParts.length >= 2) {
                userInitials = nameParts[0].substring(0, 1) + nameParts[nameParts.length - 1].substring(0, 1);
            } else {
                userInitials = userName.substring(0, Math.min(2, userName.length()));
            }
        }
    %>

    <!-- Navbar -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="index.jsp" class="logo">🚗 VehicleRent</a>
            <ul class="nav-links">
                <li><a href="index.jsp">Trang chủ</a></li>
                <li><a href="index.jsp#vehicles">Phương tiện</a></li>
                <li><a href="index.jsp#booking">Đặt xe</a></li>
                <li><a href="index.jsp#about">Giới thiệu</a></li>
                <li><a href="index.jsp#contact">Liên hệ</a></li>
            </ul>
            <div class="auth-buttons">
                <div class="user-info">
                    <div class="user-avatar"><%= userInitials.toUpperCase() %></div>
                    <div>
                        <div class="user-name"><%= userName %></div>
                        <small style="color: #666;"><%= userRole %></small>
                    </div>
                </div>
                <a href="profile.jsp" class="btn btn-profile">Hồ sơ</a>
                <a href="logout" class="btn btn-logout">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <!-- Profile Section -->
    <section class="profile-section">
        <div class="profile-container">
            <div class="profile-header fade-in-up">
                <h1 class="profile-title">Hồ sơ cá nhân</h1>
                <p class="profile-subtitle">Quản lý thông tin tài khoản của bạn</p>
            </div>

            <%
                String success = request.getParameter("success");
                String error = request.getParameter("error");
                if (success != null && success.equals("1")) {
            %>
                <div class="success-message fade-in-up">
                    Cập nhật thông tin thành công!
                </div>
            <%
                }
                if (error != null) {
                    String errorMessage = "";
                    switch (error) {
                        case "update_failed":
                            errorMessage = "Có lỗi xảy ra khi cập nhật thông tin!";
                            break;
                        case "password_mismatch":
                            errorMessage = "Mật khẩu xác nhận không khớp!";
                            break;
                        case "invalid_password":
                            errorMessage = "Mật khẩu hiện tại không đúng!";
                            break;
                        default:
                            errorMessage = "Có lỗi xảy ra. Vui lòng thử lại!";
                            break;
                    }
            %>
                <div class="error-message fade-in-up">
                    <%= errorMessage %>
                </div>
            <%
                }
            %>

            <div class="profile-grid">
                <!-- Profile Card -->
                <div class="profile-card fade-in-up">
                    <div class="profile-avatar-large">
                        <%= userInitials.toUpperCase() %>
                    </div>
                    <h2 class="profile-name"><%= userName %></h2>
                    <div class="profile-role"><%= userRole.equals("admin") ? "Quản trị viên" : "Khách hàng" %></div>
                    
                    <div class="profile-stats">
                        <div class="stat-item">
                            <div class="stat-number">5</div>
                            <div class="stat-label">Chuyến đi</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number">4.8</div>
                            <div class="stat-label">Đánh giá</div>
                        </div>
                    </div>
                </div>

                <!-- Profile Form -->
                <div class="profile-form fade-in-up">
                    <h3 class="form-title">Thông tin cá nhân</h3>
                    <form action="updateProfile" method="post">
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="user_name" class="form-label">Họ và tên</label>
                                <input type="text" id="user_name" name="user_name" class="form-input" value="<%= userName %>" required>
                            </div>

                            <div class="form-group">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" id="email" name="email" class="form-input" value="<%= userEmail %>" disabled>
                            </div>

                            <div class="form-group">
                                <label for="phone_number" class="form-label">Số điện thoại</label>
                                <input type="tel" id="phone_number" name="phone_number" class="form-input" value="<%= user != null ? user.getPhoneNumber() : "" %>" placeholder="Nhập số điện thoại">
                            </div>

                            <div class="form-group">
                                <label for="identity_number" class="form-label">CCCD</label>
                                <input type="text" id="identity_number" name="identity_number" class="form-input" value="<%= user != null ? user.getIdentityNumber() : "" %>" placeholder="Nhập CCCD">
                            </div>

                            <div class="form-group full-width">
                                <label for="address" class="form-label">Địa chỉ</label>
                                <input type="text" id="address" name="address" class="form-input" value="<%= user != null ? user.getAddress() : "" %>" placeholder="Nhập địa chỉ">
                            </div>
                        </div>

                        <button type="submit" class="btn-update">Cập nhật thông tin</button>
                    </form>

                    <button type="button" class="btn-change-password" onclick="showPasswordModal()">
                        🔒 Đổi mật khẩu
                    </button>
                </div>
            </div>

            <!-- Recent Activity -->
            <div class="recent-activity fade-in-up">
                <h3 class="activity-title">Hoạt động gần đây</h3>
                <div class="activity-item">
                    <div class="activity-icon">🚗</div>
                    <div class="activity-content">
                        <div class="activity-text">Thuê xe Toyota Vios</div>
                        <div class="activity-time">2 giờ trước</div>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="activity-icon">⭐</div>
                    <div class="activity-content">
                        <div class="activity-text">Đánh giá xe Honda Lead</div>
                        <div class="activity-time">1 ngày trước</div>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="activity-icon">📝</div>
                    <div class="activity-content">
                        <div class="activity-text">Cập nhật thông tin cá nhân</div>
                        <div class="activity-time">3 ngày trước</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Password Change Modal -->
    <div id="passwordModal" class="modal" style="display: none; position: fixed; z-index: 1001; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5);">
        <div class="modal-content" style="background: white; margin: 15% auto; padding: 2rem; border-radius: 20px; width: 90%; max-width: 500px;">
            <h3 style="margin-bottom: 1.5rem; text-align: center;">Đổi mật khẩu</h3>
            <form action="changePassword" method="post">
                <div class="form-group">
                    <label for="current_password" class="form-label">Mật khẩu hiện tại</label>
                    <input type="password" id="current_password" name="current_password" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="new_password" class="form-label">Mật khẩu mới</label>
                    <input type="password" id="new_password" name="new_password" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="confirm_new_password" class="form-label">Xác nhận mật khẩu mới</label>
                    <input type="password" id="confirm_new_password" name="confirm_new_password" class="form-input" required>
                </div>
                <div style="display: flex; gap: 1rem; margin-top: 1.5rem;">
                    <button type="submit" class="btn-update" style="flex: 1;">Đổi mật khẩu</button>
                    <button type="button" class="btn-logout" style="flex: 1;" onclick="hidePasswordModal()">Hủy</button>
                </div>
            </form>
        </div>
    </div>

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

        // Password modal functions
        function showPasswordModal() {
            document.getElementById('passwordModal').style.display = 'block';
        }

        function hidePasswordModal() {
            document.getElementById('passwordModal').style.display = 'none';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('passwordModal');
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }
    </script>
</body>
</html> 