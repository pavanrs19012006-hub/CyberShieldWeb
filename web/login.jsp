<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CyberShield - Login</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #0b1220;
            color: white;
        }

        .container {
            width: 350px;
            margin: 80px auto;
            padding: 30px;
            background: #17243a;
            border-radius: 12px;
        }

        h2 {
            text-align: center;
            color: #38bdf8;
        }

        input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            box-sizing: border-box;
            border: none;
            border-radius: 5px;
        }

        button {
            width: 100%;
            padding: 12px;
            margin-top: 15px;
            background: #0284c7;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background: #0369a1;
        }

        p {
            text-align: center;
            color: #cbd5e1;
        }

        .error {
            color: #ff6b6b;
        }

        a {
            color: #38bdf8;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>CyberShield Login</h2>

    <% if (request.getAttribute("error") != null) { %>
        <p class="error">
            <%= request.getAttribute("error") %>
        </p>
    <% } %>

    <form action="LoginServlet" method="post">

        <input type="email"
               name="email"
               placeholder="Enter Email"
               required>

        <input type="password"
               name="password"
               placeholder="Enter Password"
               required>

        <button type="submit">Login</button>

    </form>

    <p>Don't have an account?
        <a href="register.jsp">Register</a>
    </p>

    <p><a href="index.jsp">Back to Home</a></p>

</div>

</body>
</html>
