<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.crimealert.incident.Incident" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des incidents</title>
</head>
<body>

<h1>Liste des incidents</h1>

<c:forEach var="incident" items="${incidents}">
    <p>
        ID: ${incident.id}<br>
        Description: ${incident.description}<br>
        Localisation: ${incident.localisation}
    </p>
</c:forEach>

<c:if test="${empty incidents}">
    <p>Aucun incident à afficher.</p>
</c:if>

</body>
</html>
