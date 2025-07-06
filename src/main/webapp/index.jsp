<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.VehicleDAO" %>
<%@ page import="model.Vehicle" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>VehicleRent - Thuê Xe Nhanh, Giá Tốt</title>
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
    <%
        // Session management
        String userEmail = (String) session.getAttribute("userEmail");
        String userName = (String) session.getAttribute("userName");
        String userRole = (String) session.getAttribute("userRole");
        boolean isLoggedIn = userEmail != null && !userEmail.isEmpty();
        
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
    <nav class="navbar" id="navbar">
        <div class="nav-container">
            <a href="#" class="logo">🚗 VehicleRent</a>
            <ul class="nav-links">
                <li><a href="#home">Trang chủ</a></li>
                <li><a href="#vehicles">Phương tiện</a></li>
                <li><a href="#booking">Đặt xe</a></li>
                <li><a href="#about">Giới thiệu</a></li>
                <li><a href="#contact">Liên hệ</a></li>
            </ul>
            <div class="auth-buttons">
                <% if (isLoggedIn) { %>
                    <!-- Logged in state -->
                    <div class="user-info">
                        <div class="user-avatar"><%= userInitials.toUpperCase() %></div>
                        <div>
                            <div class="user-name"><%= userName %></div>
                            <small style="color: #666;"><%= userRole %></small>
                        </div>
                    </div>
                    <a href="profile.jsp" class="btn btn-profile">Hồ sơ</a>
                    <a href="logout" class="btn btn-logout">Đăng xuất</a>
                <% } else { %>
                    <!-- Not logged in state -->
                    <a href="login.jsp" class="btn btn-login">Đăng nhập</a>
                    <a href="register.jsp" class="btn btn-register">Đăng ký</a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero" id="home">
        <div class="hero-content">
            <% if (isLoggedIn) { %>
                <!-- Welcome message for logged in users -->
                <div class="welcome-message">
                    <h2>Chào mừng trở lại, <%= userName %>! 👋</h2>
                    <p>Sẵn sàng cho chuyến đi tiếp theo? Hãy khám phá các phương tiện mới nhất của chúng tôi.</p>
                </div>
            <% } %>
            
            <h1>Thuê Xe Nhanh - Giá Tốt - Giao Tận Nơi</h1>
            <p>Khám phá thành phố với đa dạng phương tiện - Xe máy, Ô tô, Xe đạp và nhiều hơn nữa</p>

            <form class="search-form" id="searchForm">
                <input type="text" class="search-input" placeholder="Địa điểm nhận xe" id="location">
                <input type="date" class="search-input" id="startDate">
                <input type="date" class="search-input" id="endDate">
                <select class="search-input" id="vehicleType">
                    <option value="">Loại xe</option>
                    <option value="motorbike">Xe máy</option>
                    <option value="car">Ô tô</option>
                    <option value="bicycle">Xe đạp</option>
                    <option value="truck">Xe tải</option>
                </select>
                <button type="submit" class="btn btn-search">🔍 Tìm xe</button>
            </form>
        </div>
    </section>

<!-- Featured Vehicles -->
<section class="featured-vehicles" id="vehicles">
    <div class="container">
        <h2 class="section-title">Phương Tiện Nổi Bật</h2>
        <div class="vehicles-grid">
            <%
                List<Vehicle> featuredVehicles = null;
                try {
                    featuredVehicles = VehicleDAO.getTop6MostRentedVehicles();
                } catch (Exception e) {
                    featuredVehicles = new ArrayList<>();
                }
                for (Vehicle v : featuredVehicles) {
            %>
            <div class="vehicle-card">
                <div class="vehicle-image">
                    <% 
                        String mainImage = "";
                        try {
                            mainImage = VehicleDAO.getMainVehicleImage(v.getVehicleId());
                        } catch (Exception e) {
                            mainImage = "/images/no-image.png";
                        }
                        if (mainImage == null || mainImage.isEmpty()) {
                            mainImage = "/images/no-image.png";
                        }
                    %>
                    <img src="<%= mainImage %>" alt="<%= v.getVehicleName() %>" style="width:100%;height:120px;object-fit:cover;">
                </div>
                <div class="vehicle-info">
                    <h3 class="vehicle-name"><%= v.getVehicleName() %></h3>
                    <div class="vehicle-price"><%= String.format("%,.0f₫/ngày", v.getRentalPrice()) %></div>
                    <div class="vehicle-features">
                        <span class="feature-tag"><%= v.getVehicleType() %></span>
                        <span class="feature-tag">Biển số: <%= v.getLicensePlate() %></span>
                        <span class="feature-tag">Tình trạng: <%= v.getAvailabilityStatus() %></span>
                    </div>
                    <div class="vehicle-actions">
                        <a href="vehicledetail.jsp?id=<%= v.getVehicleId() %>" class="btn btn-detail">Chi tiết</a>
                        <a href="vehicledetail.jsp?id=<%= v.getVehicleId() %>" class="btn btn-rent">Thuê ngay</a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <div style="text-align:center; margin-top:2rem;">
            <a href="vehicles.jsp" class="btn btn-register" style="font-size:1.1rem;">Xem thêm &rarr;</a>
        </div>
    </div>
</section>

<!-- Benefits -->
<section class="benefits" id="about">
    <div class="container">
        <h2 class="section-title">Tại Sao Chọn Chúng Tôi?</h2>
        <div class="benefits-grid">
            <div class="benefit-card">
                <div class="benefit-icon">🚚</div>
                <h3 class="benefit-title">Giao Xe Tận Nơi</h3>
                <p class="benefit-description">Chúng tôi giao xe trực tiếp đến địa chỉ của bạn, tiết kiệm thời gian và chi phí di chuyển</p>
            </div>
            <div class="benefit-card">
                <div class="benefit-icon">🚗</div>
                <h3 class="benefit-title">Đa Dạng Phương Tiện</h3>
                <p class="benefit-description">Từ xe máy đến ô tô, xe đạp, xe tải - đáp ứng mọi nhu cầu di chuyển của bạn</p>
            </div>
            <div class="benefit-card">
                <div class="benefit-icon">📞</div>
                <h3 class="benefit-title">Hỗ Trợ 24/7</h3>
                <p class="benefit-description">Đội ngũ chăm sóc khách hàng sẵn sàng hỗ trợ bạn mọi lúc, mọi nơi</p>
            </div>
            <div class="benefit-card">
                <div class="benefit-icon">📱</div>
                <h3 class="benefit-title">Đặt Xe Dễ Dàng</h3>
                <p class="benefit-description">Giao diện thân thiện, quy trình đặt xe nhanh chóng chỉ với vài thao tác đơn giản</p>
            </div>
        </div>
    </div>
</section>

<!-- Reviews -->
<section class="reviews">
    <div class="container">
        <h2 class="section-title">Khách Hàng Nói Gì Về Chúng Tôi</h2>
        <div class="reviews-container">
            <div class="review-card">
                <div class="stars">⭐⭐⭐⭐⭐</div>
                <p class="review-text">"Dịch vụ tuyệt vời! Xe giao đúng giờ, chất lượng tốt và giá cả hợp lý. Tôi sẽ sử dụng lại dịch vụ này."</p>
                <div class="reviewer">
                    <div class="reviewer-avatar">AN</div>
                    <div class="reviewer-info">
                        <h4>Nguyễn Văn An</h4>
                        <p>Doanh nhân</p>
                    </div>
                </div>
            </div>
            <div class="review-card">
                <div class="stars">⭐⭐⭐⭐⭐</div>
                <p class="review-text">"Thuê xe đi du lịch rất tiện lợi. Xe sạch sẽ, thủ tục nhanh gọn. Nhân viên hỗ trợ nhiệt tình."</p>
                <div class="reviewer">
                    <div class="reviewer-avatar">LH</div>
                    <div class="reviewer-info">
                        <h4>Lê Thị Hương</h4>
                        <p>Giáo viên</p>
                    </div>
                </div>
            </div>
            <div class="review-card">
                <div class="stars">⭐⭐⭐⭐⭐</div>
                <p class="review-text">"Ứng dụng dễ sử dụng, đặt xe nhanh chóng. Giá cả cạnh tranh, dịch vụ chuyên nghiệp."</p>
                <div class="reviewer">
                    <div class="reviewer-avatar">QT</div>
                    <div class="reviewer-info">
                        <h4>Trần Quốc Tuấn</h4>
                        <p>Kỹ sư IT</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer" id="contact">
    <div class="container">
        <div class="footer-content">
            <div class="footer-section">
                <h3>VehicleRent</h3>
                <p>Đối tác tin cậy cho mọi chuyến đi của bạn. Cam kết mang đến dịch vụ thuê xe chất lượng cao với giá cả hợp lý.</p>
                <div class="social-links">
                    <a href="#">📘</a>
                    <a href="#">📷</a>
                    <a href="#">🐦</a>
                    <a href="#">📺</a>
                </div>
            </div>
            <div class="footer-section">
                <h3>Dịch Vụ</h3>
                <ul>
                    <li><a href="#">Thuê xe máy</a></li>
                    <li><a href="#">Thuê ô tô</a></li>
                    <li><a href="#">Thuê xe đạp</a></li>
                    <li><a href="#">Thuê xe tải</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Hỗ Trợ</h3>
                <ul>
                    <li><a href="#">Câu hỏi thường gặp</a></li>
                    <li><a href="#">Hướng dẫn sử dụng</a></li>
                    <li><a href="#">Chính sách bảo hiểm</a></li>
                    <li><a href="#">Liên hệ hỗ trợ</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Liên Hệ</h3>
                <ul>
                    <li>📍 123 Đường ABC, Quận 1, TP.HCM</li>
                    <li>📞 (+84) 123-456-789</li>
                    <li>✉️ contact@vehiclerent.com</li>
                    <li>🕒 24/7 - Hỗ trợ không ngừng</li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 VehicleRent. Tất cả quyền được bảo lưu. | Chính sách bảo mật | Điều khoản sử dụng</p>
        </div>
    </div>
</footer>

<!-- Scroll to top button -->
<button class="scroll-top" id="scrollTop" onclick="scrollToTop()">↑</button>

<script>
// Navbar scroll effect
window.addEventListener('scroll', function() {
    const navbar = document.getElementById('navbar');
    if (window.scrollY > 50) {
        navbar.classList.add('scrolled');
    } else {
        navbar.classList.remove('scrolled');
    }
    
    // Show/hide scroll to top button
    const scrollTopBtn = document.getElementById('scrollTop');
    if (window.scrollY > 300) {
        scrollTopBtn.classList.add('show');
    } else {
        scrollTopBtn.classList.remove('show');
    }
});

// Scroll to top function
function scrollToTop() {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
}

// Smooth scrolling for navigation links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth'
            });
        }
    });
});

// Search form handling
document.getElementById('searchForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const location = document.getElementById('location').value;
    const startDate = document.getElementById('startDate').value;
    const endDate = document.getElementById('endDate').value;
    const vehicleType = document.getElementById('vehicleType').value;
    
    // Here you can add logic to handle the search
    console.log('Search:', { location, startDate, endDate, vehicleType });
    alert('Tính năng tìm kiếm đang được phát triển!');
});
</script>

</body>