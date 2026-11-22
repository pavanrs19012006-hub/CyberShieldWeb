
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Object[]> reports =
        (List<Object[]>) request.getAttribute("reports");

    SimpleDateFormat formatter =
        new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
%>

<!DOCTYPE html>
<html>
<head>
    <title>CyberShield - Security Reports</title>

    <style>
        body {
            background: #0b1120;
            color: white;
            font-family: Arial, sans-serif;
            padding: 30px;
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

        .report {
            background: #26364f;
            padding: 20px;
            margin: 20px 0;
            border-radius: 8px;
            overflow-wrap: anywhere;
        }

        input, textarea {
            box-sizing: border-box;
            width: 100%;
            padding: 12px;
            border-radius: 6px;
            border: 1px solid #64748b;
            margin-top: 8px;
            background: #f8fafc;
            color: #111827;
            font-family: Arial, sans-serif;
        }

        textarea {
            height: 110px;
            resize: vertical;
        }

        button {
            padding: 11px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            color: white;
            font-size: 14px;
        }

        .update-btn {
            background: #0284c7;
        }

        .delete-btn {
            background: #dc2626;
        }

        a {
            color: #38bdf8;
            text-decoration: none;
        }

        .summary {
            white-space: pre-line;
            line-height: 1.6;
        }

        hr {
            border: 1px solid #475569;
            margin: 25px 0;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>CyberShield Security Reports</h1>

    <%
        if (reports != null && !reports.isEmpty()) {
            for (Object[] report : reports) {
    %>

    <div class="report">

        <h2><%= report[3] %></h2>

        <p>
            <strong>Report ID:</strong>
            <%= report[0] %>
        </p>

        <p>
            <strong>Scan ID:</strong>
            <%= report[1] %>
        </p>

        <p>
            <strong>Scanned URL:</strong>
            <%= report[2] %>
        </p>

        <p class="summary">
            <strong>Summary:</strong>
            <%= report[4] %>
        </p>

        <p>
            <strong>Generated At:</strong>
            <%= formatter.format(report[5]) %>
        </p>

        <hr>

        <h3>Edit Security Report</h3>

        <form action="ReportManageServlet" method="post">

            <input type="hidden"
                   name="action"
                   value="update">

            <input type="hidden"
                   name="reportId"
                   value="<%= report[0] %>">

            <label>Report Title:</label>

            <input type="text"
                   name="reportTitle"
                   value="<%= report[3] %>"
                   maxlength="150"
                   required>

            <br><br>

            <label>Report Summary:</label>

            <textarea name="reportSummary"
                      required><%= report[4] %></textarea>

            <br><br>

            <button type="submit" class="update-btn">
                Update Report
            </button>

        </form>

        <br>

        <form action="ReportManageServlet"
              method="post"
              onsubmit="return confirm('Are you sure you want to delete this report?');">

            <input type="hidden"
                   name="action"
                   value="delete">

            <input type="hidden"
                   name="reportId"
                   value="<%= report[0] %>">

            <button type="submit" class="delete-btn">
                Delete Report
            </button>

        </form>

    </div>

    <%
            }
        } else {
    %>

        <p>No security reports available.</p>

    <% } %>

    <p>
        <a href="dashboard.jsp">Back to Dashboard</a>
    </p>

</div>

</body>
</html>
