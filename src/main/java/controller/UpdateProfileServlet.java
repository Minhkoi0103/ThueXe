package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {
    
    // Logger
    private static final Logger LOGGER = Logger.getLogger(UpdateProfileServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LOGGER.info("Profile update request received");
        
        try {
            // Set character encoding
            req.setCharacterEncoding("UTF-8");
            resp.setCharacterEncoding("UTF-8");
            
            // Check if user is logged in
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("userEmail") == null) {
                LOGGER.warning("Unauthorized profile update attempt");
                resp.sendRedirect("login.jsp");
                return;
            }
            
            String userEmail = (String) session.getAttribute("userEmail");
            Long userID = (Long) session.getAttribute("userID");
            
            // Get form data
            String userName = sanitizeInput(req.getParameter("user_name"));
            String phoneNumber = sanitizeInput(req.getParameter("phone_number"));
            String identityNumber = sanitizeInput(req.getParameter("identity_number"));
            String address = sanitizeInput(req.getParameter("address"));
            
            LOGGER.info("Profile update for user: " + userEmail);
            
            // Validation
            if (userName == null || userName.trim().isEmpty()) {
                LOGGER.warning("Empty username provided for: " + userEmail);
                resp.sendRedirect("profile.jsp?error=invalid_username");
                return;
            }
            
            // Update user information
            boolean success = UserDAO.updateUserProfile(userID, userName, phoneNumber, identityNumber, address);
            
            if (success) {
                // Update session with new information
                session.setAttribute("userName", userName);
                
                LOGGER.info("Profile updated successfully for: " + userEmail);
                resp.sendRedirect("profile.jsp?success=1");
            } else {
                LOGGER.warning("Profile update failed for: " + userEmail);
                resp.sendRedirect("profile.jsp?error=update_failed");
            }
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error during profile update", e);
            resp.sendRedirect("profile.jsp?error=update_failed");
        }
    }
    
    /**
     * Sanitize input to prevent XSS attacks
     */
    private String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }
        return input.trim()
                   .replaceAll("<", "&lt;")
                   .replaceAll(">", "&gt;")
                   .replaceAll("\"", "&quot;")
                   .replaceAll("'", "&#x27;")
                   .replaceAll("&", "&amp;");
    }
} 