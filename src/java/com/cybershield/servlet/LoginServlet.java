
package com.cybershield.servlet;

import cybersheild.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private boolean verifyPassword(String password,
                                   String storedHash) throws Exception {

        String[] parts = storedHash.split(":");

        if (parts.length != 2) {
            return false;
        }

        byte[] salt = Base64.getDecoder().decode(parts[0]);
        byte[] originalHash = Base64.getDecoder().decode(parts[1]);

        PBEKeySpec spec = new PBEKeySpec(
            password.toCharArray(), salt, 120000, 256
        );

        SecretKeyFactory factory =
            SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");

        byte[] enteredHash = factory.generateSecret(spec).getEncoded();
        spec.clearPassword();

        return java.security.MessageDigest.isEqual(
            originalHash, enteredHash
        );
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null
                || email.trim().isEmpty() || password.isEmpty()) {

            request.setAttribute("error",
                    "Please enter email and password.");

            request.getRequestDispatcher("login.jsp")
                    .forward(request, response);
            return;
        }

        String sql = "SELECT user_id, username, password_hash "
                   + "FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                throw new ServletException(
                    "Database connection failed."
                );
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, email.trim());

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {

                        String storedHash = rs.getString("password_hash");

                        if (storedHash != null &&
                                verifyPassword(password, storedHash)) {

                            HttpSession session = request.getSession();
                            session.setAttribute("userId",
                                    rs.getInt("user_id"));
                            session.setAttribute("username",
                                    rs.getString("username"));
                            session.setAttribute("email", email.trim());

                            response.sendRedirect("dashboard.jsp");
                            return;
                        }
                    }
                }
            }

            request.setAttribute("error",
                    "Invalid email or password.");

            request.getRequestDispatcher("login.jsp")
                    .forward(request, response);

        } catch (ServletException e) {
            throw e;
        } catch (Exception e) {
            throw new ServletException("Login failed.", e);
        }
    }
}
