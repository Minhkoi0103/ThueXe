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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    // Logger
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LOGGER.info("Login request received");
        
        try {
            // Set character encoding
            req.setCharacterEncoding("UTF-8");
            resp.setCharacterEncoding("UTF-8");
            
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            
            LOGGER.info("Login attempt for email: " + email);
            
            // Basic validation
            if (email == null || email.trim().isEmpty() || password == null || password.isEmpty()) {
                LOGGER.warning("Empty email or password provided");
                resp.sendRedirect("login.jsp?error=1");
                return;
            }
            
            // Check login with hashed password verification
            if (UserDAO.checkLoginWithHashedPassword(email, password)) {
                LOGGER.info("Login successful for email: " + email);
                
                // Get user information for session
                User user = UserDAO.getUserByEmail(email);
                if (user != null) {
                    // Create session and store user info
                    HttpSession session = req.getSession();
                    session.setAttribute("userEmail", user.getUserEmail());
                    session.setAttribute("userName", user.getUserName());
                    session.setAttribute("userRole", user.getUserRole());
                    session.setAttribute("userID", user.getUserID());
                    
                    LOGGER.info("Session created for user: " + user.getUserName() + " (ID: " + user.getUserID() + ")");
                }
                
                resp.sendRedirect("index.jsp");
            } else {
                LOGGER.warning("Login failed for email: " + email);
                resp.sendRedirect("login.jsp?error=1");
            }
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error during login", e);
            resp.sendRedirect("login.jsp?error=1");
        }
    }
}
