
package com.cybershield.servlet;

import cybersheild.DBConnection;
import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Base64;
import java.util.regex.Pattern;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private String hashPassword(String password) throws Exception {
        byte[] salt = new byte[16];
        new SecureRandom().nextBytes(salt);

        PBEKeySpec spec = new PBEKeySpec(
                password.toCharArray(), salt, 120000, 256);

        SecretKeyFactory factory =
                SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");

        byte[] hash = factory.generateSecret(spec).getEncoded();
        spec.clearPassword();

        return Base64.getEncoder().encodeToString(salt) + ":" +
               Base64.getEncoder().encodeToString(hash);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // 1. Check empty fields
        if (username == null || email == null ||
                password == null || confirmPassword == null ||
                username.trim().isEmpty() || email.trim().isEmpty() ||
                password.isEmpty() || confirmPassword.isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        username = username.trim();
        email = email.trim();

        // 2. Validate username
        if (!Pattern.matches("[a-zA-Z ]{3,50}", username)) {
            request.setAttribute("error",
                    "Name must contain 3-50 letters and spaces only.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 3. Validate email
        if (!Pattern.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$", email)) {
            request.setAttribute("error", "Please enter a valid email address.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 4. Validate password length
        if (password.length() < 8) {
            request.setAttribute("error",
                    "Password must contain at least 8 characters.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 5. Check password confirmation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        String sql = "INSERT INTO users (username, email, password_hash) VALUES (?, ?, ?)";

        try {
            String passwordHash = hashPassword(password);

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, username);
                ps.setString(2, email);
                ps.setString(3, passwordHash);

                ps.executeUpdate();
            }

            request.setAttribute("success",
                    "Registration successful! Please login.");
            request.getRequestDispatcher("register.jsp").forward(request, response);

        } catch (SQLException e) {

            if (e.getErrorCode() == 1062) {
                request.setAttribute("error",
                        "This email is already registered.");
            } else {
                throw new ServletException("Database error during registration.", e);
            }

            request.getRequestDispatcher("register.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Registration failed.", e);
        }
    }
}
