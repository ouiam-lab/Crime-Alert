<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crime Alert - Home</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #ececec;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
        }

        .header {
            background-color: #2196F3;
            color: white;
            padding: 15px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            display: flex;
            justify-content: space-between;
            z-index: 1;
        }

        .navbar-brand {
            font-size: 24px;
            font-weight: bold;
            display: flex;
            align-items: center;
            color: white;
        }

        .navbar-brand img {
            width: 40px;
            height: 40px;
            margin-right: 10px;
        }

        .navbar-user {
            color: #fff;
            margin-right: 20px;
        }

        .main-content {
            display: flex;
            justify-content: space-between;
            padding: 20px;
        }

        .sidebar {
            background-color: #2196F3;
            color: white;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            justify-content: flex-start; /* Changed to flex-start */
            height: calc(100vh - 30px);
            width: 200px; /* Set a fixed width for the sidebar */
            margin-top: -20px;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            margin-bottom: 10px;
            padding: 15px;
            border-radius: 10px;
            transition: background-color 0.3s;
            display: flex;
            align-items: center;
        }

        .nav-link i {
            margin-right: 10px;
        }

        .nav-link:hover {
            background-color: #1565c0;
        }

        .content {
            width: 100%; /* Occupy the remaining width */
        }

        .recent-incidents {
            width: 100%;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .incident-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            flex: 0 0 30%;
            margin-bottom: 20px;
        }

        .incident-card img {
            width: 100%;
            max-height: 150px;
            object-fit: cover;
        }

        .incident-details {
            padding: 20px;
        }

        .incident-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .user-profile {
            display: flex;
            align-items: center;
        }

        .user-profile img {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .incident-actions {
            display: flex;
            justify-content: space-between;
        }

        .incident-rating {
            color: #f39c12;
        }

        .action-btn {
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .action-btn:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>

<div class="header">
    <div class="navbar-brand">
        <img src="https://placekitten.com/50/50" alt="Logo">
        <span>Crime Alert</span>
    </div>
    <div class="navbar-user">Hello, John Doe!</div>
</div>

<div class="main-content">
    <div class="sidebar">
        <a href="#" class="nav-link"><i class="fas fa-home"></i> Home</a>
       <a href="#" class="nav-link" onclick="navigateToIncidentJSP()">
    <i class="fas fa-flag"></i> Create Incident
</a>
        <a href="#" class="nav-link"><i class="fas fa-search"></i> Explore</a>
        <a href="#" class="nav-link"><i class="far fa-bookmark"></i> Save</a>
    </div>

    <main role="main" class="content">
        <h2 class="mb-4">Recent Incidents</h2>

        <div class="recent-incidents">
            <!-- Incident 1 -->
            <div class="incident-card">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2CKtxh_NBUiTce64fP6SLleCxbXo9-F-27w&usqp=CAU" alt="Incident Image">
                <div class="incident-details">
                    <div class="incident-header">
                        <div class="user-profile">
                            <img src="https://placekitten.com/30/30" alt="User Profile">
                            <span>John Doe</span>
                        </div>
                        <span>Date: 2023-11-23</span>
                    </div>
                    <p>Incident Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                    <p>Location: Example City</p>
                    <p class="incident-rating">
                        Rating:
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="far fa-star"></i>
                        <i class="far fa-star"></i>
                    </p>
                    <div class="incident-actions">
                        <button class="action-btn">Like</button>
                        <button class="action-btn">Comment</button>
                        <button class="action-btn">Share</button>
                    </div>
                </div>
            </div>

            <!-- Incident 2 -->
            <div class="incident-card">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSL0JK73Hu21EnnuOD7oj2rm7NtQ_M-F4VImQ&usqp=CAU" alt="Incident Image">
                <div class="incident-details">
                    <div class="incident-header">
                        <div class="user-profile">
                            <img src="https://placekitten.com/31/30" alt="User Profile">
                            <span>Jane Doe</span>
                        </div>
                        <span>Date: 2023-11-22</span>
                    </div>
                    <p>Incident Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                    <p>Location: Another City</p>
                    <p class="incident-rating">
                        Rating:
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="far fa-star"></i>
                    </p>
                    <div class="incident-actions">
                        <button class="action-btn">Like</button>
                        <button class="action-btn">Comment</button>
                        <button class="action-btn">Share</button>
                    </div>
                </div>
            </div>

            <!-- Incident 3 -->
            <div class="incident-card">
                <img src="data:image/jpeg;base64,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 alt="Incident Image">
                <div class="incident-details">
                    <div class="incident-header">
                        <div class="user-profile">
                            <img src="https://placekitten.com/32/30" alt="User Profile">
                            <span>Bob Doe</span>
                        </div>
                        <span>Date: 2023-11-21</span>
                    </div>
                    <p>Incident Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                    <p>Location: Yet Another City</p>
                    <p class="incident-rating">
                        Rating:
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="far fa-star"></i>
                    </p>
                    <div class="incident-actions">
                        <button class="action-btn">Like</button>
                        <button class="action-btn">Comment</button>
                        <button class="action-btn">Share</button>
                    </div>
                </div>
            </div>

            <!-- Continue adding incidents as needed -->

        </div>
    </main>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js"></script>

</body>
<script>  function navigateToIncidentJSP() {
    window.location.href = "incidentjsp.jsp";
}</script>
</html>
