<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>VehicleRent - Thuê Xe Nhanh, Giá Tốt</title>
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

        .navbar.scrolled {
            background: rgba(245, 245, 245, 0.95);
            backdrop-filter: blur(10px);
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

        .welcome-message {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 1rem 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            text-align: center;
            animation: fadeInUp 0.8s ease;
        }

        .welcome-message h2 {
            margin-bottom: 0.5rem;
        }

        .welcome-message p {
            opacity: 0.9;
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, rgba(245, 245, 245, 0.9), rgba(232, 232, 232, 0.9)),
            url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 800"><rect fill="%23f5f5f5" width="1200" height="800"/><g fill="%23e8e8e8"><circle cx="200" cy="200" r="100" opacity="0.3"/><circle cx="1000" cy="600" r="150" opacity="0.2"/><circle cx="600" cy="100" r="80" opacity="0.4"/></g></svg>');
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: #333;
            position: relative;
        }

        .hero-content h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            animation: fadeInUp 1s ease;
        }

        .hero-content p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            animation: fadeInUp 1s ease 0.2s both;
        }

        .search-form {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: 20px;
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            justify-content: center;
            max-width: 800px;
            margin: 0 auto;
            animation: fadeInUp 1s ease 0.4s both;
            border: 2px solid #e8e8e8;
        }

        .search-input {
            flex: 1;
            min-width: 200px;
            padding: 1rem;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            background: rgba(255, 255, 255, 0.9);
        }

        .search-input:focus {
            outline: none;
            box-shadow: 0 0 20px rgba(232, 232, 232, 0.5);
        }

        .btn-search {
            padding: 1rem 2rem;
            background: #666;
            color: white;
            font-weight: bold;
            font-size: 1.1rem;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .btn-search:hover {
            background: #555;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }

        /* Featured Vehicles */
        .featured-vehicles {
            padding: 5rem 0;
            background: #f8f9fa;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        .section-title {
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 3rem;
            color: #333;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: #666;
            border-radius: 2px;
        }

        .vehicles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .vehicle-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            position: relative;
        }

        .vehicle-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.15);
        }

        .vehicle-image {
            width: 100%;
            height: 200px;
            background: linear-gradient(45deg, #f5f5f5, #e8e8e8);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #666;
            font-size: 3rem;
            position: relative;
            overflow: hidden;
        }

        .vehicle-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200"><circle cx="100" cy="100" r="80" fill="none" stroke="%23666666" stroke-width="2" opacity="0.2"/><circle cx="100" cy="100" r="60" fill="none" stroke="%23666666" stroke-width="2" opacity="0.1"/></svg>');
            background-size: cover;
        }

        .vehicle-info {
            padding: 1.5rem;
        }

        .vehicle-name {
            font-size: 1.3rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
            color: #333;
        }

        .vehicle-price {
            font-size: 1.5rem;
            color: #666;
            font-weight: bold;
            margin-bottom: 1rem;
        }

        .vehicle-features {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1rem;
            flex-wrap: wrap;
        }

        .feature-tag {
            background: #e9ecef;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            color: #666;
        }

        .vehicle-actions {
            display: flex;
            gap: 1rem;
        }

        .btn-detail {
            flex: 1;
            padding: 0.8rem;
            background: transparent;
            border: 2px solid #666;
            color: #666;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .btn-detail:hover {
            background: #666;
            color: white;
        }

        .btn-rent {
            flex: 1;
            padding: 0.8rem;
            background: #555;
            color: white;
            border-radius: 10px;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .btn-rent:hover {
            background: #333;
            transform: translateY(-2px);
        }

        /* Benefits Section */
        .benefits {
            padding: 5rem 0;
            background: white;
        }

        .benefits-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .benefit-card {
            text-align: center;
            padding: 2rem;
            border-radius: 20px;
            background: #f8f9fa;
            transition: all 0.3s ease;
        }

        .benefit-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
        }

        .benefit-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 1rem;
            background: linear-gradient(135deg, #f5f5f5, #e8e8e8);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: #666;
            border: 3px solid #d0d0d0;
        }

        .benefit-title {
            font-size: 1.3rem;
            font-weight: bold;
            margin-bottom: 1rem;
            color: #333;
        }

        .benefit-description {
            color: #666;
            line-height: 1.8;
        }

        /* Reviews Section */
        .reviews {
            padding: 5rem 0;
            background: #f8f9fa;
        }

        .reviews-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .review-card {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            position: relative;
            transition: all 0.3s ease;
        }

        .review-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.15);
        }

        .review-text {
            font-style: italic;
            color: #666;
            margin-bottom: 1.5rem;
            line-height: 1.8;
        }

        .reviewer {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .reviewer-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #f5f5f5, #e8e8e8);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #666;
            font-weight: bold;
            font-size: 1.2rem;
            border: 2px solid #d0d0d0;
        }

        .reviewer-info h4 {
            color: #333;
            margin-bottom: 0.2rem;
        }

        .reviewer-info p {
            color: #666;
            font-size: 0.9rem;
        }

        .stars {
            color: #ccc;
            margin-bottom: 1rem;
        }

        /* Footer */
        .footer {
            background: #333;
            color: white;
            padding: 3rem 0 1rem;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .footer-section h3 {
            margin-bottom: 1rem;
            color: #f5f5f5;
        }

        .footer-section ul {
            list-style: none;
        }

        .footer-section ul li {
            margin-bottom: 0.5rem;
        }

        .footer-section ul li a {
            color: #ccc;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-section ul li a:hover {
            color: #f5f5f5;
        }

        .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .social-links a {
            width: 40px;
            height: 40px;
            background: #666;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            background: #f5f5f5;
            color: #333;
            transform: translateY(-3px);
        }

        .footer-bottom {
            text-align: center;
            padding-top: 2rem;
            border-top: 1px solid #555;
            color: #ccc;
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .hero-content h1 {
                font-size: 2.5rem;
            }

            .search-form {
                flex-direction: column;
                padding: 1.5rem;
            }

            .search-input {
                min-width: 100%;
            }

            .vehicle-actions {
                flex-direction: column;
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

        /* Scroll to top button */
        .scroll-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            background: #666;
            color: white;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            display: none;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .scroll-top:hover {
            background: #f5f5f5;
            color: #333;
            transform: translateY(-5px);
        }

        .scroll-top.show {
            display: flex;
        }
    </style>
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
            <div class="vehicle-card">
                <div class="vehicle-image">🏍️</div>
                <div class="vehicle-info">
                    <h3 class="vehicle-name">Honda Lead 2023</h3>
                    <div class="vehicle-price">150.000₫/ngày</div>
                    <div class="vehicle-features">
                        <span class="feature-tag">Tự động</span>
                        <span class="feature-tag">Tiết kiệm xăng</span>
                        <span class="feature-tag">Mới</span>
                    </div>
                    <div class="vehicle-actions">
                        <button class="btn btn-detail">Chi tiết</button>
                        <button class="btn btn-rent"><a href="vehicledetail.jsp">Chi tiết</a> </button>
                    </div>
                </div>
            </div>

            <div class="vehicle-card">
                <div class="vehicle-image">🚗</div>
                <div class="vehicle-info">
                    <h3 class="vehicle-name">Toyota Vios 2022</h3>
                    <div class="vehicle-price">800.000₫/ngày</div>
                    <div class="vehicle-features">
                        <span class="feature-tag">4 chỗ</span>
                        <span class="feature-tag">Tự động</span>
                        <span class="feature-tag">Điều hòa</span>
                    </div>
                    <div class="vehicle-actions">
                        <button class="btn btn-detail">Chi tiết</button>
                        <button class="btn btn-rent">Thuê ngay</button>
                    </div>
                </div>
            </div>

            <div class="vehicle-card">
                <div class="vehicle-image">🚲</div>
                <div class="vehicle-info">
                    <h3 class="vehicle-name">Xe Đạp Touring</h3>
                    <div class="vehicle-price">50.000₫/ngày</div>
                    <div class="vehicle-features">
                        <span class="feature-tag">Thể thao</span>
                        <span class="feature-tag">Nhẹ</span>
                        <span class="feature-tag">Eco</span>
                    </div>
                    <div class="vehicle-actions">
                        <button class="btn btn-detail">Chi tiết</button>
                        <button class="btn btn-rent">Thuê ngay</button>
                    </div>
                </div>
            </div>

            <div class="vehicle-card">
                <div class="vehicle-image">🚙</div>
                <div class="vehicle-info">
                    <h3 class="vehicle-name">Ford Ranger 2023</h3>
                    <div class="vehicle-price">1.200.000₫/ngày</div>
                    <div class="vehicle-features">
                        <span class="feature-tag">Bán tải</span>
                        <span class="feature-tag">4WD</span>
                        <span class="feature-tag">Mạnh mẽ</span>
                    </div>
                    <div class="vehicle-actions">
                        <button class="btn btn-detail">Chi tiết</button>
                        <button class="btn btn-rent">Thuê ngay</button>
                    </div>
                </div>
            </div>
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
            <p>&copy; 2024 VehicleRent. Tất cả quyền được bảo lưu. | Chính sách bảo mật | Điều khoản sử