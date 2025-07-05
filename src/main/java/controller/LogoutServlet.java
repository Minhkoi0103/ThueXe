package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    
    // Logger
    private static final Logger LOGGER = Logger.getLogger(LogoutServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LOGGER.info("Logout request received");
        
        try {
            // Get current session
            HttpSession session = req.getSession(false);
            
            if (session != null) {
                // Get user info for logging
                String userEmail = (String) session.getAttribute("userEmail");
                String userName = (String) session.getAttribute("userName");
                
                // Invalidate session
                session.invalidate();
                
                LOGGER.info("User logged out: " + userName + " (" + userEmail + ")");
            }
            
            // Redirect to home page
            resp.sendRedirect("index.jsp");
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during logout", e);
            resp.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
} 