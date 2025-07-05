package controller;

import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {
    
    // Logger
    private static final Logger LOGGER = Logger.getLogger(ChangePasswordServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LOGGER.info("Password change request received");
        
        try {
            // Set character encoding
            req.setCharacterEncoding("UTF-8");
            resp.setCharacterEncoding("UTF-8");
            
            // Check if user is logged in
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("userEmail") == null) {
                LOGGER.warning("Unauthorized password change attempt");
                resp.sendRedirect("login.jsp");
                return;
            }
            
            String userEmail = (String) session.getAttribute("userEmail");
            Long userID = (Long) session.getAttribute("userID");
            
            // Get form data
            String currentPassword = req.getParameter("current_password");
            String newPassword = req.getParameter("new_password");
            String confirmNewPassword = req.getParameter("confirm_new_password");
            
            LOGGER.info("Password change for user: " + userEmail);
            
            // Validation
            if (currentPassword == null || currentPassword.isEmpty() ||
                newPassword == null || newPassword.isEmpty() ||
                confirmNewPassword == null || confirmNewPassword.isEmpty()) {
                LOGGER.warning("Empty password fields for: " + userEmail);
                resp.sendRedirect("profile.jsp?error=empty_fields");
                return;
            }
            
            // Check if new passwords match
            if (!newPassword.equals(confirmNewPassword)) {
                LOGGER.warning("New password mismatch for: " + userEmail);
                resp.sendRedirect("profile.jsp?error=password_mismatch");
                return;
            }
            
            // Check password length
            if (newPassword.length() < 6) {
                LOGGER.warning("New password too short for: " + userEmail);
                resp.sendRedirect("profile.jsp?error=weak_password");
                return;
            }
            
            // Change password
            boolean success = UserDAO.changePassword(userID, currentPassword, newPassword);
            
            if (success) {
                LOGGER.info("Password changed successfully for: " + userEmail);
                resp.sendRedirect("profile.jsp?success=1");
            } else {
                LOGGER.warning("Password change failed for: " + userEmail);
                resp.sendRedirect("profile.jsp?error=invalid_password");
            }
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error during password change", e);
            resp.sendRedirect("profile.jsp?error=change_failed");
        }
    }
} 