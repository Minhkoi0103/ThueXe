<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ - VehicleRent</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/profile.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
        
        // Get user statistics from database
        dao.UserStatsDAO userStatsDAO = new dao.UserStatsDAO();
        model.UserStats userStats = userStatsDAO.getUserStats(userID.intValue());
        
        // Get recent activities from database
        dao.UserActivityDAO userActivityDAO = new dao.UserActivityDAO();
        java.util.List<model.UserActivity> recentActivities = userActivityDAO.getRecentActivities(userID.intValue(), 5);
        
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

    <!-- Main Content -->
    <main class="profile-main">
        <!-- Hero Section -->
        <section class="hero-section">
            <div class="hero-background"></div>
            <div class="hero-content">
                <div class="hero-avatar">
                    <div class="avatar-circle">
                        <span class="avatar-text"><%= userInitials.toUpperCase() %></span>
                    </div>
                </div>
                <div class="hero-info">
                    <h1 class="hero-name"><%= userName %></h1>
                    <p class="hero-role"><%= userRole.equals("admin") ? "Quản trị viên" : "Khách hàng" %></p>
                    <p class="hero-email"><i class="fas fa-envelope"></i> <%= userEmail %></p>
                </div>
            </div>
        </section>

        <!-- Messages Section -->
        <section class="messages-section">
            <div class="container">
                <%
                    String success = request.getParameter("success");
                    String error = request.getParameter("error");
                    if (success != null && success.equals("1")) {
                %>
                    <div class="message success-message" role="alert" aria-live="polite">
                        <i class="fas fa-check-circle"></i>
                        <span>Cập nhật thông tin thành công!</span>
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
                    <div class="message error-message" role="alert" aria-live="polite">
                        <i class="fas fa-exclamation-circle"></i>
                        <span><%= errorMessage %></span>
                    </div>
                <%
                    }
                %>
            </div>
        </section>

        <!-- Content Grid -->
        <section class="content-section">
            <div class="container">
                <div class="content-grid">
                    <!-- Left Column -->
                    <div class="left-column">
                        <!-- Stats Cards -->
                        <div class="stats-section">
                            <h2 class="section-title">
                                <i class="fas fa-chart-bar"></i>
                                Thống kê cá nhân
                            </h2>
                            <div class="stats-grid">
                                <div class="stat-card">
                                    <div class="stat-icon">
                                        <i class="fas fa-car"></i>
                                    </div>
                                    <div class="stat-content">
                                        <div class="stat-number"><%= userStats.getTotalRentals() %></div>
                                        <div class="stat-label">Chuyến đi</div>
                                    </div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-icon">
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <div class="stat-content">
                                        <div class="stat-number"><%= String.format("%.1f", userStats.getAverageRating()) %></div>
                                        <div class="stat-label">Đánh giá TB</div>
                                    </div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-icon">
                                        <i class="fas fa-comment"></i>
                                    </div>
                                    <div class="stat-content">
                                        <div class="stat-number"><%= userStats.getTotalReviews() %></div>
                                        <div class="stat-label">Đánh giá</div>
                                    </div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-icon">
                                        <i class="fas fa-wallet"></i>
                                    </div>
                                    <div class="stat-content">
                                        <div class="stat-number"><%= String.format("%.0f", userStats.getTotalSpent() / 1000000) %>M</div>
                                        <div class="stat-label">Đã chi</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Profile Form -->
                        <div class="profile-form-section">
                            <h2 class="section-title">
                                <i class="fas fa-user-edit"></i>
                                Thông tin cá nhân
                            </h2>
                            <form action="updateProfile" method="post" class="profile-form">
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="user_name" class="form-label">
                                            <i class="fas fa-user"></i>
                                            Họ và tên
                                        </label>
                                        <input type="text" id="user_name" name="user_name" class="form-input" value="<%= userName %>" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="email" class="form-label">
                                            <i class="fas fa-envelope"></i>
                                            Email
                                        </label>
                                        <input type="email" id="email" name="email" class="form-input" value="<%= userEmail %>" disabled>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="phone_number" class="form-label">
                                            <i class="fas fa-phone"></i>
                                            Số điện thoại
                                        </label>
                                        <input type="tel" id="phone_number" name="phone_number" class="form-input" value="<%= user != null ? user.getPhoneNumber() : "" %>" placeholder="Nhập số điện thoại">
                                    </div>
                                    <div class="form-group">
                                        <label for="identity_number" class="form-label">
                                            <i class="fas fa-id-card"></i>
                                            CCCD
                                        </label>
                                        <input type="text" id="identity_number" name="identity_number" class="form-input" value="<%= user != null ? user.getIdentityNumber() : "" %>" placeholder="Nhập CCCD">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="address" class="form-label">
                                        <i class="fas fa-map-marker-alt"></i>
                                        Địa chỉ
                                    </label>
                                    <input type="text" id="address" name="address" class="form-input" value="<%= user != null ? user.getAddress() : "" %>" placeholder="Nhập địa chỉ">
                                </div>
                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save"></i>
                                        Cập nhật thông tin
                                    </button>
                                    <button type="button" class="btn btn-secondary" onclick="showPasswordModal()">
                                        <i class="fas fa-lock"></i>
                                        Đổi mật khẩu
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Right Column -->
                    <div class="right-column">
                        <!-- Recent Activities -->
                        <div class="activities-section">
                            <h2 class="section-title">
                                <i class="fas fa-history"></i>
                                Hoạt động gần đây
                            </h2>
                            <div class="activities-list">
                                <%
                                    if (recentActivities != null && !recentActivities.isEmpty()) {
                                        for (model.UserActivity activity : recentActivities) {
                                %>
                                    <div class="activity-item">
                                        <div class="activity-icon">
                                            <i class="<%= activity.getActivityType().equals("rental") ? "fas fa-car" : "fas fa-star" %>"></i>
                                        </div>
                                        <div class="activity-content">
                                            <div class="activity-text"><%= activity.getDescription() %></div>
                                            <div class="activity-time">
                                                <i class="fas fa-clock"></i>
                                                <%= userActivityDAO.getTimeAgo(activity.getActivityTime()) %>
                                            </div>
                                        </div>
                                    </div>
                                <%
                                        }
                                    } else {
                                %>
                                    <div class="empty-state">
                                        <div class="empty-icon">
                                            <i class="fas fa-inbox"></i>
                                        </div>
                                        <div class="empty-text">
                                            <h3>Chưa có hoạt động nào</h3>
                                            <p>Bắt đầu thuê xe để có hoạt động</p>
                                        </div>
                                    </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <div class="quick-actions-section">
                            <h2 class="section-title">
                                <i class="fas fa-bolt"></i>
                                Thao tác nhanh
                            </h2>
                            <div class="quick-actions-grid">
                                <a href="index.jsp#vehicles" class="quick-action-card">
                                    <div class="quick-action-icon">
                                        <i class="fas fa-search"></i>
                                    </div>
                                    <div class="quick-action-text">Tìm xe</div>
                                </a>
                                <a href="index.jsp#booking" class="quick-action-card">
                                    <div class="quick-action-icon">
                                        <i class="fas fa-calendar-plus"></i>
                                    </div>
                                    <div class="quick-action-text">Đặt xe</div>
                                </a>
                                <a href="#" class="quick-action-card" onclick="showPasswordModal()">
                                    <div class="quick-action-icon">
                                        <i class="fas fa-key"></i>
                                    </div>
                                    <div class="quick-action-text">Đổi mật khẩu</div>
                                </a>
                                <a href="logout" class="quick-action-card">
                                    <div class="quick-action-icon">
                                        <i class="fas fa-sign-out-alt"></i>
                                    </div>
                                    <div class="quick-action-text">Đăng xuất</div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- Password Change Modal -->
    <div id="passwordModal" class="modal" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">
                    <i class="fas fa-lock"></i>
                    Đổi mật khẩu
                </h3>
                <button type="button" class="close" onclick="hidePasswordModal()" aria-label="Đóng">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <form action="changePassword" method="post" class="password-form">
                <div class="form-group">
                    <label for="current_password" class="form-label">
                        <i class="fas fa-key"></i>
                        Mật khẩu hiện tại
                    </label>
                    <input type="password" id="current_password" name="current_password" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="new_password" class="form-label">
                        <i class="fas fa-lock"></i>
                        Mật khẩu mới
                    </label>
                    <input type="password" id="new_password" name="new_password" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="confirm_new_password" class="form-label">
                        <i class="fas fa-check-circle"></i>
                        Xác nhận mật khẩu mới
                    </label>
                    <input type="password" id="confirm_new_password" name="confirm_new_password" class="form-input" required>
                </div>
                <div class="modal-actions">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        Đổi mật khẩu
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="hidePasswordModal()">
                        <i class="fas fa-times"></i>
                        Hủy
                    </button>
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
            const modal = document.getElementById('passwordModal');
            modal.style.display = 'block';
            modal.setAttribute('aria-hidden', 'false');
            document.body.style.overflow = 'hidden';
        }

        function hidePasswordModal() {
            const modal = document.getElementById('passwordModal');
            modal.style.display = 'none';
            modal.setAttribute('aria-hidden', 'true');
            document.body.style.overflow = 'auto';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('passwordModal');
            if (event.target == modal) {
                hidePasswordModal();
            }
        }

        // Close modal with Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                hidePasswordModal();
            }
        });

        // Add smooth scrolling
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    </script>
</body>
</html> 