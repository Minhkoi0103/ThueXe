<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.UserStats" %>
<%@ page import="model.UserActivity" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ - VehicleRent</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/profile.css">
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
        
        // Get user statistics
        UserStats userStats = userDAO.getUserStats(userID);
        
        // Get recent activities
        List<UserActivity> recentActivities = userDAO.getUserRecentActivities(userID, 5);
        
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
                        <div class="user-role-small"><%= userRole %></div>
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
                            <div class="stat-number"><%= userStats.getTotalTrips() %></div>
                            <div class="stat-label">Chuyến đi</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number"><%= String.format("%.1f", userStats.getAverageRating()) %></div>
                            <div class="stat-label">Đánh giá</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number"><%= String.format("%.0f", userStats.getTotalSpent() / 1000000) %></div>
                            <div class="stat-label">Triệu VNĐ</div>
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
                <%
                    if (recentActivities.isEmpty()) {
                %>
                    <div class="no-activity">
                        <p>Chưa có hoạt động nào</p>
                    </div>
                <%
                    } else {
                        for (UserActivity activity : recentActivities) {
                %>
                    <div class="activity-item">
                        <div class="activity-icon"><%= activity.getActivityIcon() %></div>
                        <div class="activity-content">
                            <div class="activity-text"><%= activity.getDescription() %></div>
                            <div class="activity-time"><%= activity.getTimeAgo() %></div>
                        </div>
                    </div>
                <%
                        }
                    }
                %>
            </div>
        </div>
    </section>

    <!-- Password Change Modal -->
    <div id="passwordModal" class="modal">
        <div class="modal-content">
            <h3>Đổi mật khẩu</h3>
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
                <div class="modal-actions">
                    <button type="submit" class="btn-update">Đổi mật khẩu</button>
                    <button type="button" class="btn-logout" onclick="hidePasswordModal()">Hủy</button>
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