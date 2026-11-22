
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CyberShield</title>

    <style>
        body {
            margin: 0;
            font-family: Arial;
            background: #0b1220;
            color: white;
        }

        nav {
            background: #17243a;
            padding: 20px 7%;
            display: flex;
            justify-content: space-between;
        }

        .logo {
            color: #38bdf8;
            font-size: 25px;
            font-weight: bold;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
        }

        .hero {
            text-align: center;
            padding: 100px 20px;
        }

        h1 {
            font-size: 45px;
        }

        span {
            color: #38bdf8;
        }

        p {
            color: #cbd5e1;
            font-size: 18px;
        }

        .btn {
            display: inline-block;
            background: #0284c7;
            padding: 13px 25px;
            margin: 20px 8px;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .features {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .card {
            background: #17243a;
            padding: 30px;
            width: 230px;
            text-align: center;
            border-radius: 10px;
        }

        footer {
            text-align: center;
            padding: 30px;
            color: #94a3b8;
        }
    </style>
</head>

<body>

<nav>
    <div class="logo">CyberShield</div>

    <div>
        <a href="index.jsp">Home</a>
        <a href="login.jsp">Login</a>
        <a href="register.jsp">Register</a>
    </div>
</nav>

<div class="hero">

    <h1>Welcome to <span>CyberShield</span></h1>

    <p>
        Smart Cyber Threat Detection and
        URL Security Analyzer
    </p>

    <a href="login.jsp" class="btn">Login</a>

    <a href="register.jsp" class="btn">Register</a>

</div>

<div class="features">

    <div class="card">
        <h3>URL Scanner</h3>
        <p>Analyze suspicious website URLs.</p>
    </div>

    <div class="card">
        <h3>Threat Detection</h3>
        <p>Identify potentially dangerous URLs.</p>
    </div>

    <div class="card">
        <h3>Scan History</h3>
        <p>View previously scanned URLs.</p>
    </div>

</div>

<footer>
    CyberShield - AJT Project
</footer>

</body>
</html>
