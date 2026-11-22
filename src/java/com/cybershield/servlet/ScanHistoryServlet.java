
package com.cybershield.servlet;

import com.cybershield.util.HibernateUtil;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;

@WebServlet("/ScanHistoryServlet")
public class ScanHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession httpSession = request.getSession(false);

        if (httpSession == null ||
                httpSession.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = ((Number) httpSession.getAttribute("userId"))
                .intValue();

        try (Session session =
                HibernateUtil.getSessionFactory().openSession()) {

            List<Object[]> history = session.createNativeQuery(
                "SELECT u.scan_id, u.url, h.scan_status, " +
                "h.viewed_at " +
                "FROM scan_history h " +
                "JOIN url_scans u ON h.scan_id = u.scan_id " +
                "WHERE u.user_id = :userId " +
                "ORDER BY h.viewed_at DESC"
            )
            .setParameter("userId", userId)
            .list();

            request.setAttribute("history", history);

            request.getRequestDispatcher("history.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Unable to load scan history."
            );
        }
    }
}
