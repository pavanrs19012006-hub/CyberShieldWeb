
package com.cybershield.servlet;

import com.cybershield.entity.UrlScan;
import com.cybershield.entity.ThreatResult;
import com.cybershield.entity.SecurityReport;
import com.cybershield.util.HibernateUtil;

import java.io.IOException;
import java.net.URL;
import java.util.Date;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet("/URLScanServlet")
public class URLScanServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Check whether the user is logged in
        HttpSession httpSession = request.getSession(false);

        if (httpSession == null ||
                httpSession.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get URL entered by user
        String urlText = request.getParameter("url");

        if (urlText == null || urlText.trim().isEmpty()
                || urlText.length() > 500) {

            request.setAttribute("error",
                    "Please enter a valid URL.");

            request.getRequestDispatcher("scan.jsp")
                    .forward(request, response);
            return;
        }

        urlText = urlText.trim();

        // Default scan result
        String riskLevel = "Low";
        String threatType = "No obvious suspicious pattern";
        String status = "Safe";

        // URL pattern analysis
        try {
            URL parsedUrl = new URL(urlText);

            String protocol = parsedUrl.getProtocol()
                    .toLowerCase(Locale.ROOT);

            if (!protocol.equals("http")
                    && !protocol.equals("https")) {

                throw new Exception(
                        "Only HTTP and HTTPS URLs are allowed.");
            }

            String host = parsedUrl.getHost()
                    .toLowerCase(Locale.ROOT);

            if (host.isEmpty()) {
                throw new Exception(
                        "URL must contain a valid hostname.");
            }

            // Check IP address based URLs
            if (host.matches(
                    "\\d{1,3}(\\.\\d{1,3}){3}")) {

                riskLevel = "High";
                threatType = "IP address based URL";
            }

            // Check possible URL spoofing
            if (urlText.contains("@")) {

                riskLevel = "High";
                threatType = "Possible URL spoofing";
            }

            // Check suspicious keywords
            if (urlText.toLowerCase(Locale.ROOT).matches(
                    ".*(login-verify|account-suspend|free-gift|password-reset|banking-secure).*")) {

                riskLevel = "High";
                threatType = "Suspicious keyword pattern";
            }

            // Check URL shorteners
            if (host.matches(
                    ".*(bit\\.ly|tinyurl\\.com|t\\.co)$")) {

                if (!riskLevel.equals("High")) {
                    riskLevel = "Medium";
                    threatType = "URL shortener detected";
                }
            }

            if (riskLevel.equals("High")
                    || riskLevel.equals("Medium")) {

                status = "Suspicious";
            }

        } catch (Exception e) {

            request.setAttribute("error",
                    "Invalid URL: " + e.getMessage());

            request.getRequestDispatcher("scan.jsp")
                    .forward(request, response);
            return;
        }

        // Get logged-in user's ID
        Object sessionUserId =
                httpSession.getAttribute("userId");

        int userId = ((Number) sessionUserId).intValue();

        Transaction transaction = null;

        // Save scan using Hibernate
        try (Session session =
                HibernateUtil.getSessionFactory().openSession()) {

            transaction = session.beginTransaction();

            // 1. Save URL scan
            UrlScan scan = new UrlScan();

            scan.setUserId(userId);
            scan.setUrl(urlText);
            scan.setScanDate(new Date());

            session.save(scan);
            session.flush();

            // 2. Save threat result
            ThreatResult threat = new ThreatResult();

            threat.setScanId(scan.getScanId());
            threat.setThreatType(threatType);
            threat.setRiskLevel(riskLevel);
            threat.setStatus(status);

            session.save(threat);

            // 3. Save security report
            SecurityReport report = new SecurityReport();

            report.setScanId(scan.getScanId());
            report.setReportTitle("URL Security Scan Report");

            report.setReportSummary(
                    "Scanned URL: " + urlText
                    + "\nResult: " + status
                    + "\nRisk Level: " + riskLevel
                    + "\nThreat Type: " + threatType
            );

            session.save(report);

            // 4. Save scan history
            session.createNativeQuery(
                    "INSERT INTO scan_history "
                    + "(scan_id, scan_status) "
                    + "VALUES (:scanId, :status)"
            )
            .setParameter("scanId", scan.getScanId())
            .setParameter("status", status)
            .executeUpdate();

            // Commit all database operations
            transaction.commit();

            // Send results to JSP
            request.setAttribute("scannedUrl", urlText);
            request.setAttribute("status", status);
            request.setAttribute("riskLevel", riskLevel);
            request.setAttribute("threatType", threatType);

            request.getRequestDispatcher("scan.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            if (transaction != null
                    && transaction.isActive()) {

                transaction.rollback();
            }

            e.printStackTrace();

            request.setAttribute("error",
                    "Unable to save scan. Please check server logs.");

            request.getRequestDispatcher("scan.jsp")
                    .forward(request, response);
        }
    }
}
