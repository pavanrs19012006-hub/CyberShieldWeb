
package com.cybershield.servlet;

import com.cybershield.util.HibernateUtil;
import org.hibernate.Session;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/HibernateTestServlet")
public class HibernateTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (Session session =
                HibernateUtil.getSessionFactory().openSession()) {

            Object result = session.createNativeQuery("SELECT 1")
                                   .uniqueResult();

            response.getWriter().println(
                "<h2>Hibernate Connected Successfully!</h2>"
            );

            response.getWriter().println(
                "<p>Database: cybershield_db</p>"
            );

            response.getWriter().println(
                "<p>Connection Test: " + result + "</p>"
            );

        } catch (Exception e) {
            e.printStackTrace();

            response.getWriter().println(
                "<h2>Hibernate Connection Failed</h2>"
            );

            response.getWriter().println(
                "<p>" + e.getMessage() + "</p>"
            );
        }
    }
}
