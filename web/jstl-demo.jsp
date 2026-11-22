
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>CyberShield JSTL Demo</title>
</head>
<body>

    <h1>CyberShield - JSTL and EL Demo</h1>

    <c:set var="username" value="Pavan Kumar" />

    <h2>Welcome, ${username}!</h2>

    <c:if test="${not empty username}">
        <p>JSTL is working successfully!</p>
    </c:if>

</body>
</html>
