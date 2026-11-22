
<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CyberShield - Register</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #0b1220;
            color: white;
        }

        .container {
            width: 350px;
            margin: 60px auto;
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

        .success {
            color: #4ade80;
        }

        a {
            color: #38bdf8;
            text-decoration: none;
        }
    </style>

    <script>
        function validateForm() {

            var name = document.forms["registerForm"]["name"].value;
            var email = document.forms["registerForm"]["email"].value;
            var password = document.forms["registerForm"]["password"].value;
            var confirmPassword = document.forms["registerForm"]["confirmPassword"].value;

            // Validate name
            if (!/^[a-zA-Z ]{3,50}$/.test(name.trim())) {
                alert("Please enter a valid name.");
                return false;
            }

            // Validate email
            if (!/^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }

            // Validate password
            if (password.length < 8) {
                alert("Password must contain at least 8 characters.");
                return false;
            }

            // Confirm password
            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                return false;
            }

            alert("Validation successful!");
            return true;
        }
    </script>

</head>

<body>

<div class="container">

    <h2>Create Account</h2>

    <% if (request.getAttribute("error") != null) { %>
        <p class="error">
            <%= request.getAttribute("error") %>
        </p>
    <% } %>

    <% if (request.getAttribute("success") != null) { %>
        <p class="success">
            <%= request.getAttribute("success") %>
        </p>
    <% } %>

    <form name="registerForm"
          action="RegisterServlet"
          method="post"
          onsubmit="return validateForm()">

        <input type="text"
               name="name"
               placeholder="Enter Full Name"
               required>

        <input type="email"
               name="email"
               placeholder="Enter Email"
               required>

        <input type="password"
               name="password"
               placeholder="Enter Password"
               minlength="8"
               required>

        <input type="password"
               name="confirmPassword"
               placeholder="Confirm Password"
               minlength="8"
               required>

        <button type="submit">Register</button>

    </form>

    <p>Already have an account?
        <a href="login.jsp">Login</a>
    </p>

    <p><a href="index.jsp">Back to Home</a></p>

</div>

</body>
</html>
