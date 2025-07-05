package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.regex.Pattern;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    
    // Constants
    private static final String SUCCESS_REDIRECT = "login.jsp?success=1";
    private static final String ERROR_REDIRECT = "register.jsp?error=";
    private static final String DEFAULT_ROLE = "customer";
    private static final String DEFAULT_STATUS = "active";
    
    // Validation patterns
    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
    private static final String PHONE_REGEX = "^[0-9]{10,11}$";
    private static final String IDENTITY_REGEX = "^[0-9]{12}$";
    private static final String USERNAME_REGEX = "^[a-zA-Z0-9_\\s]{3,100}$";
    
    // Logger
    private static final Logger LOGGER = Logger.getLogger(RegisterServlet.class.getName());
    
    // Minimum password length
    private static final int MIN_PASSWORD_LENGTH = 6;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LOGGER.info("Registration request received");
        
        try {
            // Set character encoding
            req.setCharacterEncoding("UTF-8");
            resp.setCharacterEncoding("UTF-8");
            
            // Get and sanitize form data
            String username = sanitizeInput(req.getParameter("user_name"));
            String email = sanitizeInput(req.getParameter("email"));
            String password = req.getParameter("user_password"); // Don't sanitize password
            String phoneNumber = sanitizeInput(req.getParameter("phone_number"));
            String address = sanitizeInput(req.getParameter("address"));
            String confirmPassword = req.getParameter("confirm_password"); // Don't sanitize password
            String identityNumber = sanitizeInput(req.getParameter("identity_number"));
            
            LOGGER.info("Form data extracted for user: " + email);
            
            // Comprehensive input validation
            String validationError = validateInputs(username, email, password, phoneNumber, address, confirmPassword, identityNumber);
            if (validationError != null) {
                LOGGER.warning("Validation failed: " + validationError + " for email: " + email);
                resp.sendRedirect(ERROR_REDIRECT + validationError);
                return;
            }
            
            // Check password match
            if (!password.equals(confirmPassword)) {
                LOGGER.warning("Password mismatch for email: " + email);
                resp.sendRedirect(ERROR_REDIRECT + "password_mismatch");
                return;
            }
            
            // Check email uniqueness
            if (UserDAO.isEmailExists(email)) {
                LOGGER.warning("Email already exists: " + email);
                resp.sendRedirect(ERROR_REDIRECT + "email_exists");
                return;
            }
            
            // Hash password
            String hashedPassword = hashPassword(password);
            if (hashedPassword == null) {
                LOGGER.severe("Password hashing failed for email: " + email);
                resp.sendRedirect(ERROR_REDIRECT + "system_error");
                return;
            }
            
            // Create User object
            User user = new User(username, email, hashedPassword, phoneNumber, identityNumber, address, DEFAULT_STATUS, DEFAULT_ROLE);
            
            LOGGER.info("User object created for: " + email);
            
            // Save to database
            boolean result = UserDAO.addUser(user);
            
            if (result) {
                LOGGER.info("User registration successful for: " + email);
                resp.sendRedirect(SUCCESS_REDIRECT);
            } else {
                LOGGER.warning("Database insert failed for: " + email);
                resp.sendRedirect(ERROR_REDIRECT + "insert_failed");
            }
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error during registration", e);
            resp.sendRedirect(ERROR_REDIRECT + "system_error");
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
    
    /**
     * Comprehensive input validation
     */
    private String validateInputs(String username, String email, String password, 
                                 String phoneNumber, String address, String confirmPassword, 
                                 String identityNumber) {
        
        // Username validation
        if (username == null || username.trim().isEmpty()) {
            return "empty_username";
        }
        if (!Pattern.compile(USERNAME_REGEX).matcher(username).matches()) {
            return "invalid_username";
        }
        
        // Email validation
        if (email == null || email.trim().isEmpty()) {
            return "empty_email";
        }
        if (!Pattern.compile(EMAIL_REGEX).matcher(email).matches()) {
            return "invalid_email";
        }
        
        // Password validation
        if (password == null || password.isEmpty()) {
            return "empty_password";
        }
        if (password.length() < MIN_PASSWORD_LENGTH) {
            return "weak_password";
        }
        
        // Phone number validation
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            return "empty_phone";
        }
        if (!Pattern.compile(PHONE_REGEX).matcher(phoneNumber).matches()) {
            return "invalid_phone";
        }
        
        // Address validation
        if (address == null || address.trim().isEmpty()) {
            return "empty_address";
        }
        if (address.length() < 5 || address.length() > 200) {
            return "invalid_address";
        }
        
        // Identity number validation
        if (identityNumber == null || identityNumber.trim().isEmpty()) {
            return "empty_identity";
        }
        if (!Pattern.compile(IDENTITY_REGEX).matcher(identityNumber).matches()) {
            return "invalid_identity";
        }
        
        return null; // All validations passed
    }
    
    /**
     * Hash password using SHA-256 with salt
     */
    public static String hashPassword(String password) {
        try {
            // Generate salt
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[16];
            random.nextBytes(salt);
            
            // Create MessageDigest instance for SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            
            // Add salt to digest
            md.update(salt);
            
            // Get the hashed password
            byte[] hashedPassword = md.digest(password.getBytes());
            
            // Convert to hex string
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedPassword) {
                sb.append(String.format("%02x", b));
            }
            
            // Return salt + hash
            StringBuilder result = new StringBuilder();
            for (byte b : salt) {
                result.append(String.format("%02x", b));
            }
            result.append(sb.toString());
            
            return result.toString();
            
        } catch (NoSuchAlgorithmException e) {
            LOGGER.log(Level.SEVERE, "SHA-256 algorithm not available", e);
            return null;
        }
    }
    
    /**
     * Verify password against stored hash
     */
    public static boolean verifyPassword(String password, String storedHash) {
        try {
            // Extract salt (first 32 characters)
            String saltHex = storedHash.substring(0, 32);
            String hashHex = storedHash.substring(32);
            
            // Convert salt back to bytes
            byte[] salt = new byte[16];
            for (int i = 0; i < 16; i++) {
                salt[i] = (byte) Integer.parseInt(saltHex.substring(i * 2, i * 2 + 2), 16);
            }
            
            // Hash the input password with the same salt
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] hashedPassword = md.digest(password.getBytes());
            
            // Convert to hex string
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedPassword) {
                sb.append(String.format("%02x", b));
            }
            
            // Compare
            return sb.toString().equals(hashHex);
            
        } catch (NoSuchAlgorithmException e) {
            LOGGER.log(Level.SEVERE, "SHA-256 algorithm not available", e);
            return false;
        }
    }
}
