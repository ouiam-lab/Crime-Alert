<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crime Alert App</title>
    <!-- Add your CSS and Bootstrap links here -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        header {
            background-color: #343a40;
            color: white;
            padding: 10px;
            text-align: center;
        }

        .container {
            margin-top: 50px;
        }
    </style>
</head>

<body>

    <!-- Header Section -->
    <header>
        <h1>Welcome to Crime Alert</h1>
        <p>Enhancing Security for a Safer World</p>
        <div class="dropdown">
            <button class="btn btn-primary dropdown-toggle" type="button" id="registerDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Register
            </button>
            <div class="dropdown-menu" aria-labelledby="registerDropdown">
                <a class="dropdown-item" href="#" onclick="register('admin')">Register as Admin</a>
                <a class="dropdown-item" href="#" onclick="register('policier')">Register as Policier</a>
                <a class="dropdown-item" href="#" onclick="register('user')">Register as User</a>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="row justify-content-center">

            <!-- Login Section 45-->
            <div class="col-md-4 bg-white p-4 rounded">
                <h2 class="text-center mb-4">Login</h2>
                <form>
                    <!-- Login form elements go here -->
                    <div class="form-group">
                        <label for="loginForm">Username:</label>
                        <input type="text" class="form-control" id="loginForm" placeholder="Enter your username">
                    </div>
                    <!-- Add other login form elements -->
                    <button type="submit" class="btn btn-success btn-block">Login</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Add your JavaScript and Bootstrap scripts here -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        function register(role) {
            alert('Register as ' + role);
        }
    </script>
</body>

</html>
