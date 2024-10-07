<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Fruits List</title>
</head>
<body>

<h1>Fruits List</h1>

<%
    List<String> fruits = (List<String>) request.getAttribute("fruits");
    out.println("Debug: Fruits List - " + fruits);  // Add this line for debugging
    if (fruits != null && !fruits.isEmpty()) {
        for (String fruit : fruits) {
%>
            <p>
                <%= fruit %>
            </p>
<%
        }
    } else {
%>
        <p>No fruits to display.</p>
<%
    }
%>

</body>
</html>
