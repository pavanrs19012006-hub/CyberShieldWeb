
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

@WebServlet("/ReportsServlet")
public class ReportsServlet extends HttpServlet {

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

            List<Object[]> reports = session.createNativeQuery(
                "SELECT r.report_id, r.scan_id, u.url, " +
                "r.report_title, r.report_summary, r.generated_at " +
                "FROM security_reports r " +
                "JOIN url_scans u ON r.scan_id = u.scan_id " +
                "WHERE u.user_id = :userId " +
                "ORDER BY r.generated_at DESC"
            )
            .setParameter("userId", userId)
            .list();

            request.setAttribute("reports", reports);

            request.getRequestDispatcher("reports.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();

            response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Unable to load security reports."
            );
        }
    }
}
