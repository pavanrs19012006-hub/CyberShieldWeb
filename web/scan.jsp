
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);

    if (userSession == null ||
        userSession.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String error = (String) request.getAttribute("error");
    String scannedUrl = (String) request.getAttribute("scannedUrl");
    String status = (String) request.getAttribute("status");
    String riskLevel = (String) request.getAttribute("riskLevel");
    String threatType = (String) request.getAttribute("threatType");
%>

<!DOCTYPE html>
<html>
<head>
    <title>CyberShield - URL Scanner</title>

    <style>
        body {
            margin: 0;
            padding: 40px;
            font-family: Arial, sans-serif;
            background: #0b1120;
            color: white;
        }

        .container {
            max-width: 650px;
            margin: 50px auto;
            padding: 35px;
            background: #17243b;
            border-radius: 12px;
        }

        h1 {
            color: #38bdf8;
            text-align: center;
        }

        p {
            color: #cbd5e1;
            line-height: 1.6;
        }

        input {
            width: 95%;
            padding: 14px;
            margin: 15px 0;
            border: none;
            border-radius: 6px;
        }

        button {
            width: 100%;
            padding: 14px;
            background: #0284c7;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background: #0369a1;
        }

        .result {
            margin-top: 25px;
            padding: 18px;
            background: #26364f;
            border-radius: 8px;
        }

        .error {
            color: #fca5a5;
        }

        .safe {
            color: #4ade80;
        }

        .suspicious {
            color: #f87171;
        }

        a {
            color: #38bdf8;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>CyberShield URL Scanner</h1>

    <p>
        Enter a website URL below to perform a basic
        security pattern analysis.
    </p>

    <form action="URLScanServlet" method="post">

        <input
            type="text"
            name="url"
            placeholder="https://example.com"
            maxlength="500"
            required>

        <button type="submit">Scan URL</button>

    </form>

    <% if (error != null) { %>
        <div class="result error">
            <strong>Error:</strong>
            <%= error %>
        </div>
    <% } %>

    <% if (status != null) { %>

        <div class="result">

            <h2>Scan Result</h2>

            <p>
                <strong>URL:</strong>
                <%= scannedUrl %>
            </p>

            <p>
                <strong>Status:</strong>

                <% if ("Safe".equals(status)) { %>
                    <span class="safe">Safe</span>
                <% } else { %>
                    <span class="suspicious">Suspicious</span>
                <% } %>
            </p>

            <p>
                <strong>Risk Level:</strong>
                <%= riskLevel %>
            </p>

            <p>
                <strong>Threat Type:</strong>
                <%= threatType %>
            </p>

            <p>
                <strong>Report:</strong>
                Generated and saved in the database.
            </p>

        </div>

    <% } %>

    <p>
        <a href="dashboard.jsp">Back to Dashboard</a>
    </p>

    <p>
        <small>
            Note: This is a basic pattern-based checker.
            A Safe result does not guarantee that a URL is harmless.
        </small>
    </p>

</div>

</body>
</html>
