
package com.cybershield.servlet;

import com.cybershield.model.SecurityReport;
import com.cybershield.util.HibernateUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet("/ReportManageServlet")
public class ReportManageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
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

        String action = request.getParameter("action");

        try {
            int reportId = Integer.parseInt(
                    request.getParameter("reportId"));

            Session session =
                    HibernateUtil.getSessionFactory().openSession();

            Transaction transaction = session.beginTransaction();

            try {
                SecurityReport report =
                        session.get(SecurityReport.class, reportId);

                if (report == null) {
                    response.sendError(404, "Report not found.");
                    transaction.rollback();
                    return;
                }

                Number count = (Number) session.createNativeQuery(
                    "SELECT COUNT(*) FROM url_scans " +
                    "WHERE scan_id = :scanId AND user_id = :userId"
                )
                .setParameter("scanId", report.getScanId())
                .setParameter("userId", userId)
                .getSingleResult();

                if (count.intValue() == 0) {
                    response.sendError(403, "Access denied.");
                    transaction.rollback();
                    return;
                }

                if ("update".equals(action)) {

                    String title = request.getParameter("reportTitle");
                    String summary = request.getParameter("reportSummary");

                    if (title == null || title.trim().isEmpty()
                            || summary == null || summary.trim().isEmpty()) {
                        response.sendError(400,
                                "Report title and summary are required.");
                        transaction.rollback();
                        return;
                    }

                    if (title.trim().length() > 150) {
                        response.sendError(400,
                                "Report title must be 150 characters or fewer.");
                        transaction.rollback();
                        return;
                    }

                    report.setReportTitle(title.trim());
                    report.setReportSummary(summary.trim());

                    session.update(report);

                } else if ("delete".equals(action)) {

                    session.delete(report);

                } else {
                    response.sendError(400, "Invalid action.");
                    transaction.rollback();
                    return;
                }

                transaction.commit();

                response.sendRedirect("ReportsServlet");

            } catch (Exception e) {
                if (transaction.isActive()) {
                    transaction.rollback();
                }
                throw e;

            } finally {
                session.close();
            }

        } catch (NumberFormatException e) {
            response.sendError(400, "Invalid report ID.");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500,
                    "Unable to manage the security report.");
        }
    }
}
