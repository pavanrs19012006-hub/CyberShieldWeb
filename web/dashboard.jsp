
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CyberShield Dashboard</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #0b1220;
            color: white;
        }

        .navbar {
            background: #17243a;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar h2 {
            margin: 0;
            color: #38bdf8;
        }

        .logout {
            background: #dc2626;
            color: white;
            padding: 10px 18px;
            text-decoration: none;
            border-radius: 5px;
        }

        .container {
            padding: 40px;
            text-align: center;
        }

        .card {
            background: #17243a;
            padding: 30px;
            margin: 30px auto;
            max-width: 500px;
            border-radius: 12px;
        }

        h1 {
            color: #38bdf8;
        }
    </style>
</head>

<body>

<div class="navbar">
    <h2>CyberShield</h2>
    <a class="logout" href="LogoutServlet">Logout</a>
</div>

<div class="container">

    <h1>Welcome to CyberShield!</h1>

    <div class="card">
        <h2>Hello, <%= username %></h2>
        <p>Email: <%= email %></p>
        <p>You have successfully logged in.</p>
        <a href="scan.jsp">Scan a URL</a>
        <p>
    <a href="ScanHistoryServlet">View Scan History</a>
</p>
<p>
    <a href="ReportsServlet">View Security Reports</a>
</p>
        
    </div>

</div>

</body>
</html>
