
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Object[]> history =
        (List<Object[]>) request.getAttribute("history");

    SimpleDateFormat formatter =
        new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
%>

<!DOCTYPE html>
<html>
<head>
    <title>CyberShield - Scan History</title>
    <style>
        body {
            background: #0b1120;
            color: white;
            font-family: Arial, sans-serif;
            padding: 35px;
        }

        .container {
            max-width: 1000px;
            margin: 30px auto;
            background: #17243b;
            padding: 30px;
            border-radius: 12px;
        }

        h1 {
            color: #38bdf8;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }

        th, td {
            padding: 14px;
            border-bottom: 1px solid #40516b;
            text-align: left;
            overflow-wrap: anywhere;
        }

        th {
            background: #26364f;
        }

        a {
            color: #38bdf8;
            text-decoration: none;
        }

        .safe {
            color: #4ade80;
        }

        .suspicious {
            color: #f87171;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>CyberShield Scan History</h1>

    <table>
        <tr>
            <th>Scan ID</th>
            <th>URL</th>
            <th>Status</th>
            <th>Date and Time</th>
        </tr>

        <%
            if (history != null && !history.isEmpty()) {
                for (Object[] row : history) {
                    String status = String.valueOf(row[2]);
        %>

        <tr>
            <td><%= row[0] %></td>
            <td><%= row[1] %></td>
            <td class="<%= "Safe".equals(status)
                    ? "safe" : "suspicious" %>">
                <%= status %>
            </td>
            <td><%= formatter.format(row[3]) %></td>
        </tr>

        <%
                }
            } else {
        %>

        <tr>
            <td colspan="4">No scan history available.</td>
        </tr>

        <% } %>

    </table>

    <p>
        <a href="dashboard.jsp">Back to Dashboard</a>
    </p>

</div>

</body>
</html>
