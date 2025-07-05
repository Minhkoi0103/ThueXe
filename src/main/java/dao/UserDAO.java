package dao;

import database.DBConnect;
import model.User;
import model.UserStats;
import model.UserActivity;
import controller.RegisterServlet;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

public class UserDAO {
    private static Connection connection;
    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());

    // Đảm bảo đã có kết nối
    private static void ensureConnection() {
        if (connection == null) {
            connection = DBConnect.getConnection();
        }
    }

    public static boolean isEmailExists(String email) {
        ensureConnection(); // Kết nối nếu chưa có

        if (connection == null) {
            LOGGER.severe("Không thể kết nối CSDL!");
            return false;
        }

        String sql = "SELECT user_id FROM Users WHERE user_email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            boolean exists = rs.next();
            LOGGER.info("Email check for " + email + ": " + (exists ? "exists" : "not exists"));
            return exists; // true nếu có bản ghi
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking email existence", e);
            return false;
        }
    }
    
    // Hàm kiểm tra đăng nhập với hashed password
    public static boolean checkLoginWithHashedPassword(String email, String password) {
        ensureConnection(); // Tự động kết nối nếu chưa có

        if (connection == null) {
            LOGGER.severe("Không thể kết nối CSDL!");
            return false;
        }

        String sql = "SELECT user_password FROM Users WHERE user_email = ? AND status = 'active'";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                String storedHash = rs.getString("user_password");
                boolean isValid = RegisterServlet.verifyPassword(password, storedHash);
                LOGGER.info("Password verification for " + email + ": " + (isValid ? "valid" : "invalid"));
                return isValid;
            } else {
                LOGGER.warning("User not found or inactive: " + email);
                return false;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error during login verification", e);
            return false;
        }
    }
    
    // Hàm kiểm tra đăng nhập cũ (để backward compatibility)
    public static boolean checkLogin(String email, String password) {
        ensureConnection(); // Tự động kết nối nếu chưa có

        if (connection == null) {
            LOGGER.severe("Không thể kết nối CSDL!");
            return false;
        }

        String sql = "SELECT * FROM Users WHERE user_email = ? AND user_password = ? AND status = 'active'";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            boolean isValid = rs.next();
            LOGGER.info("Legacy login check for " + email + ": " + (isValid ? "valid" : "invalid"));
            return isValid; // true nếu có user hợp lệ
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error during legacy login check", e);
            return false;
        }
    }

    public static boolean addUser(User user) {
        ensureConnection(); // đảm bảo đã kết nối CSDL

        if (connection == null) {
            LOGGER.severe("Không thể kết nối CSDL!");
            return false;
        }

        String sql = "INSERT INTO Users (user_name, user_email, user_password, phone_number, identity_number, address, status, user_role) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getUserName());
            stmt.setString(2, user.getUserEmail());
            stmt.setString(3, user.getUserPassword());
            stmt.setString(4, user.getPhoneNumber());
            stmt.setString(5, user.getIdentityNumber());
            stmt.setString(6, user.getAddress());
            stmt.setString(7, user.getStatus());
            stmt.setString(8, user.getUserRole());

            int rows = stmt.executeUpdate();
            boolean success = rows > 0;
            LOGGER.info("User insertion for " + user.getUserEmail() + ": " + (success ? "successful" : "failed"));
            return success; // true nếu thêm thành công
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding user to database", e);
            return false;
        }
    }
    
    // Lấy thông tin user từ email
    public static User getUserByEmail(String email) {
        ensureConnection();

        if (connection == null) {
            LOGGER.severe("Không thể kết nối CSDL!");
            return null;
        }

        String sql = "SELECT * FROM Users WHERE user_email = ? AND status = 'active'";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setUserID(rs.getLong("user_id"));
                user.setUserName(rs.getString("user_name"));
                user.setUserEmail(rs.getString("user_email"));
                user.setUserPass(rs.getString("user_password"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setIdentityNumber(rs.getString("identity_number"));
                user.setAddress(rs.getString("address"));
                user.setStatus(rs.getString("status"));
                user.setUserRole(rs.getString("user_role"));
                
                LOGGER.info("User retrieved for email: " + email);
                return user;
            } else {
                LOGGER.warning("User not found for email: " + email);
                return null;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving user by email", e);
            return null;
        }
    }
    
    // Cập nhật thông tin user
    public static boolean updateUserProfile(Long userID, String userName, String phoneNumber, String identityNumber, String address) {
        ensureConnection();

        if (connection == null) {
            LOGGER.severe("Không thể kết nối CSDL!");
            return false;
        }

        String sql = "UPDATE Users SET user_name = ?, phone_number = ?, identity_number = ?, address = ? WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, userName);
            stmt.setString(2, phoneNumber);
            stmt.setString(3, identityNumber);
            stmt.setString(4, address);
            stmt.setLong(5, userID);

            int rows = stmt.executeUpdate();
            boolean success = rows > 0;
            LOGGER.info("Profile update for user ID " + userID + ": " + (success ? "successful" : "failed"));
            return success;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating user profile", e);
            return false;
        }
    }
    
    // Đổi mật khẩu
    public static boolean changePassword(Long userID, String currentPassword, String newPassword) {
        ensureConnection();

        if (connection == null) {
            LOGGER.severe("Không thể kết nối CSDL!");
            return false;
        }

        // First, verify current password
        String sql = "SELECT user_password FROM Users WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                String storedHash = rs.getString("user_password");
                
                // Verify current password
                if (!RegisterServlet.verifyPassword(currentPassword, storedHash)) {
                    LOGGER.warning("Current password verification failed for user ID: " + userID);
                    return false;
                }
                
                // Hash new password
                String newHashedPassword = RegisterServlet.hashPassword(newPassword);
                if (newHashedPassword == null) {
                    LOGGER.severe("Password hashing failed for user ID: " + userID);
                    return false;
                }
                
                // Update password
                String updateSql = "UPDATE Users SET user_password = ? WHERE user_id = ?";
                try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
                    updateStmt.setString(1, newHashedPassword);
                    updateStmt.setLong(2, userID);
                    
                    int rows = updateStmt.executeUpdate();
                    boolean success = rows > 0;
                    LOGGER.info("Password change for user ID " + userID + ": " + (success ? "successful" : "failed"));
                    return success;
                }
            } else {
                LOGGER.warning("User not found for password change: " + userID);
                return false;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error changing password", e);
            return false;
        }
    }
    
    // Lấy thống kê của user
    public static UserStats getUserStats(Long userID) {
        ensureConnection();

        if (connection == null) {
            LOGGER.severe("Không thể kết nối CSDL!");
            return new UserStats(0, 0.0, 0, 0.0);
        }

        try {
            // Lấy tổng số chuyến đi
            String tripsSql = "SELECT COUNT(*) as total_trips FROM RentalOrders WHERE user_id = ? AND status = 'completed'";
            int totalTrips = 0;
            try (PreparedStatement stmt = connection.prepareStatement(tripsSql)) {
                stmt.setLong(1, userID);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    totalTrips = rs.getInt("total_trips");
                }
            }

            // Lấy điểm đánh giá trung bình và tổng số đánh giá
            String ratingSql = "SELECT AVG(rating) as avg_rating, COUNT(*) as total_reviews FROM Reviews WHERE user_id = ?";
            double averageRating = 0.0;
            int totalReviews = 0;
            try (PreparedStatement stmt = connection.prepareStatement(ratingSql)) {
                stmt.setLong(1, userID);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    averageRating = rs.getDouble("avg_rating");
                    totalReviews = rs.getInt("total_reviews");
                }
            }

            // Lấy tổng tiền đã chi
            String spentSql = "SELECT SUM(p.amount) as total_spent FROM Payments p " +
                            "JOIN RentalOrders r ON p.order_id = r.order_id " +
                            "WHERE r.user_id = ? AND p.status = 'success'";
            double totalSpent = 0.0;
            try (PreparedStatement stmt = connection.prepareStatement(spentSql)) {
                stmt.setLong(1, userID);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    totalSpent = rs.getDouble("total_spent");
                }
            }

            LOGGER.info("Stats retrieved for user ID " + userID + ": trips=" + totalTrips + 
                       ", rating=" + averageRating + ", reviews=" + totalReviews + ", spent=" + totalSpent);
            
            return new UserStats(totalTrips, averageRating, totalReviews, totalSpent);
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving user stats", e);
            return new UserStats(0, 0.0, 0, 0.0);
        }
    }
    
    // Lấy hoạt động gần đây của user
    public static List<UserActivity> getUserRecentActivities(Long userID, int limit) {
        ensureConnection();

        if (connection == null) {
            LOGGER.severe("Không thể kết nối CSDL!");
            return new ArrayList<>();
        }

        List<UserActivity> activities = new ArrayList<>();

        try {
            // Lấy hoạt động thuê xe
            String rentalSql = "SELECT r.order_id, r.start_time, v.vehicle_name " +
                             "FROM RentalOrders r " +
                             "JOIN Vehicles v ON r.vehicle_id = v.vehicle_id " +
                             "WHERE r.user_id = ? AND r.status = 'completed' " +
                             "ORDER BY r.start_time DESC LIMIT ?";
            
            try (PreparedStatement stmt = connection.prepareStatement(rentalSql)) {
                stmt.setLong(1, userID);
                stmt.setInt(2, limit);
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    UserActivity activity = new UserActivity();
                    activity.setActivityId(rs.getInt("order_id"));
                    activity.setUserId(userID.intValue());
                    activity.setActivityType("rental");
                    activity.setDescription("Thuê xe " + rs.getString("vehicle_name"));
                    activity.setActivityTime(rs.getTimestamp("start_time").toLocalDateTime());
                    activity.setVehicleName(rs.getString("vehicle_name"));
                    activities.add(activity);
                }
            }

            // Lấy hoạt động đánh giá
            String reviewSql = "SELECT r.review_id, r.review_time, r.rating, v.vehicle_name " +
                             "FROM Reviews r " +
                             "JOIN Vehicles v ON r.vehicle_id = v.vehicle_id " +
                             "WHERE r.user_id = ? " +
                             "ORDER BY r.review_time DESC LIMIT ?";
            
            try (PreparedStatement stmt = connection.prepareStatement(reviewSql)) {
                stmt.setLong(1, userID);
                stmt.setInt(2, limit);
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    UserActivity activity = new UserActivity();
                    activity.setActivityId(rs.getInt("review_id"));
                    activity.setUserId(userID.intValue());
                    activity.setActivityType("review");
                    activity.setDescription("Đánh giá xe " + rs.getString("vehicle_name"));
                    activity.setActivityTime(rs.getTimestamp("review_time").toLocalDateTime());
                    activity.setVehicleName(rs.getString("vehicle_name"));
                    activity.setRating(rs.getInt("rating"));
                    activities.add(activity);
                }
            }

            // Sắp xếp theo thời gian (mới nhất trước)
            activities.sort((a1, a2) -> a2.getActivityTime().compareTo(a1.getActivityTime()));

            // Giới hạn số lượng kết quả
            if (activities.size() > limit) {
                activities = activities.subList(0, limit);
            }

            LOGGER.info("Recent activities retrieved for user ID " + userID + ": " + activities.size() + " activities");
            return activities;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving user activities", e);
            return new ArrayList<>();
        }
    }
}
