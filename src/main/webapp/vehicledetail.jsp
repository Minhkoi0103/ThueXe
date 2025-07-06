<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.VehicleDAO" %>
<%@ page import="model.Vehicle" %>
<%@ page import="java.util.List" %>
<%
    String idStr = request.getParameter("id");
    Vehicle v = null;
    List<String> images = new java.util.ArrayList<>();
    if (idStr != null) {
        try {
            int id = Integer.parseInt(idStr);
            v = VehicleDAO.getVehicleById(id);
            images = VehicleDAO.getVehicleImages(id);
        } catch (Exception e) {
            v = null;
        }
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết phương tiện - VehicleRent</title>
    <link rel="stylesheet" href="css/index.css">
    <style>
        .vehicle-detail-container { max-width: 900px; margin: 40px auto 0 auto; background: #fff; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.08); padding: 2rem; display: flex; gap: 2rem; }
        .vehicle-detail-image { flex: 1; }
        .vehicle-detail-image img { width: 100%; border-radius: 16px; object-fit: cover; }
        .vehicle-detail-info { flex: 2; }
        .vehicle-detail-title { font-size: 2rem; font-weight: bold; margin-bottom: 1rem; }
        .vehicle-detail-price { font-size: 1.5rem; color: #666; font-weight: bold; margin-bottom: 1rem; }
        .vehicle-detail-features { margin-bottom: 1rem; }
        .vehicle-detail-features .feature-tag { margin-right: 0.5rem; }
        .vehicle-detail-label { color: #888; font-size: 1rem; }
        .vehicle-detail-actions { margin-top: 2rem; }
        .vehicle-detail-actions .btn { font-size: 1.1rem; margin-right: 1rem; }
        @media (max-width: 900px) {
            .vehicle-detail-container { flex-direction: column; }
        }
    </style>
</head>
<body>
    <nav class="navbar" id="navbar">
        <div class="nav-container">
            <a href="index.jsp" class="logo">🚗 VehicleRent</a>
            <ul class="nav-links">
                <li><a href="index.jsp#home">Trang chủ</a></li>
                <li><a href="vehicles.jsp">Tất cả xe</a></li>
                <li><a href="index.jsp#about">Giới thiệu</a></li>
                <li><a href="index.jsp#contact">Liên hệ</a></li>
            </ul>
        </div>
    </nav>
    <div style="padding-top:90px"></div>
    <div class="container">
        <% if (v == null) { %>
            <h2>Không tìm thấy phương tiện!</h2>
        <% } else { %>
        <div class="vehicle-detail-container">
            <div class="vehicle-detail-image">
                <% if (images.size() > 0) { %>
                    <img src="<%= images.get(0) %>" alt="<%= v.getVehicleName() %>" style="margin-bottom:10px;">
                    <% if (images.size() > 1) { %>
                        <div style="display:flex;gap:8px;">
                        <% for (int i = 1; i < images.size(); i++) { %>
                            <img src="<%= images.get(i) %>" alt="Ảnh phụ" style="width:80px;height:60px;object-fit:cover;border-radius:6px;">
                        <% } %>
                        </div>
                    <% } %>
                <% } else { %>
                    <img src="/images/no-image.png" alt="No image">
                <% } %>
            </div>
            <div class="vehicle-detail-info">
                <div class="vehicle-detail-title"><%= v.getVehicleName() %></div>
                <table style="width:100%;margin-bottom:1.5rem;border-collapse:collapse;">
                    <tr><td style="color:#888;width:140px;">ID:</td><td><%= v.getVehicleId() %></td></tr>
                    <tr><td style="color:#888;">Tên xe:</td><td><%= v.getVehicleName() %></td></tr>
                    <tr><td style="color:#888;">Loại xe:</td><td><%= v.getVehicleType() %></td></tr>
                    <tr><td style="color:#888;">Biển số:</td><td><%= v.getLicensePlate() %></td></tr>
                    <tr><td style="color:#888;">Giá thuê/ngày:</td><td><b style="color:#1a8917"><%= String.format("%,.0f₫", v.getRentalPrice()) %></b></td></tr>
                    <tr><td style="color:#888;">Trạng thái:</td><td><%= v.getAvailabilityStatus() %></td></tr>
                    <tr><td style="color:#888;">Địa chỉ:</td><td>(Bổ sung nếu có trường này)</td></tr>
                    <tr><td style="color:#888;">Mô tả:</td><td>(Bổ sung nếu có trường này)</td></tr>
                </table>
                <div class="vehicle-detail-actions">
                    <a href="booking.jsp?vehicleId=<%= v.getVehicleId() %>" class="btn btn-rent">Thuê ngay</a>
                    <a href="vehicles.jsp" class="btn btn-detail">Quay lại danh sách</a>
                </div>
            </div>
        </div>
        <% } %>
    </div>
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
</body>
</html> 