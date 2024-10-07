<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer un incident</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <!-- Datepicker CSS -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- Datepicker JS -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <!-- Custom CSS -->
    <style>
        body {
            margin: 50px;
        }
    </style>
    <!-- Custom JavaScript -->
    <script>
        $(function() {
            // Initialise le datepicker
            $("#datepicker").datepicker({
                dateFormat: 'yy-mm-dd',
                changeMonth: true,
                changeYear: true
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <h2>Créer un incident</h2>
        <form action="incidentServlet" method="post">
            <div class="form-group">
                <label for="description">Description :</label>
                <input type="text" class="form-control" name="description" required>
            </div>
            <div class="form-group">
                <label for="localisation">Localisation :</label>
                <input type="text" class="form-control" name="localisation" required>
            </div>
            <div class="form-group">
                <label for="datepicker">Date :</label>
                <input type="text" class="form-control" id="datepicker" name="date">
            </div>
            <div class="form-group">
        <label for="image">Image :</label>
        <input type="file" class="form-control" name="image" accept="image/*">
    </div>
            <!-- Ajoutez d'autres champs au besoin -->

            <button type="submit" class="btn btn-primary">Créer incident</button>
        </form>
    </div>
</body>
</html>
