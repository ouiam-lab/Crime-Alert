<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Crime Alert Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            padding: 20px;
            background-color: #f8f9fa;
        }

        .container {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-top: 20px;
        }

        .chart-container {
            margin-top: 20px;
            display: none; /* Initialement masqué */
        }

        .incident-table th, .incident-table td {
            text-align: center;
        }

        .action-buttons {
            margin-top: 20px;
        }

        .change-status-modal .modal-dialog {
            max-width: 400px;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Navbar -->
        <nav class="navbar navbar-dark bg-dark">
            <span class="navbar-brand mb-0 h1">Crime Alert Dashboard</span>
        </nav>

        <div class="row">
            <!-- Sidebar -->
            <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
                <div class="position-sticky">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="#" id="dashboardLink">
                                Tableau de Bord
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" id="statisticsLink">
                                Statistiques
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                Utilisateurs
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                Incidents
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Contenu principal -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Tableau de Bord</h1>
                </div>

                <!-- Liste des Incidents -->
                <div id="incidentTableContainer">
                    <h2>Liste des Incidents</h2>
                    <table class="table incident-table">
                        <!-- Votre structure de tableau ici -->
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Description</th>
                                <th scope="col">Localisation</th>
                                <th scope="col">Date</th>
                                <th scope="col">Statut</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">1</th>
                                <td>Description de l'incident</td>
                                <td>Localisation de l'incident</td>
                                <td>2023-01-01</td>
                                <td>En attente</td>
                                <td>
                                    <button type="button" class="btn btn-success btn-sm btn-change-status" data-toggle="modal" data-target="#changeStatusModal">Changer Statut</button>
                                </td>
                            </tr>
                            <!-- Ajoutez d'autres lignes ici -->
                        </tbody>
                    </table>
                </div>

                <!-- Graphique des Statistiques -->
                <div id="chartContainer" class="chart-container">
                    <canvas id="incidentChart"></canvas>
                </div>

                <!-- Boutons d'action -->
                <div class="action-buttons">
                    <button type="button" class="btn btn-primary" id="addIncidentBtn">Ajouter un Incident</button>
                    <button type="button" class="btn btn-danger">Déconnexion</button>
                </div>
            </main>
        </div>
    </div>

    <!-- Modal pour changer le statut -->
    <div class="modal fade" id="changeStatusModal" tabindex="-1" role="dialog" aria-labelledby="changeStatusModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="changeStatusModalLabel">Changer le Statut</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <label for="newStatus">Nouveau Statut :</label>
                    <select id="newStatus" class="form-select">
                        <option value="En attente">En attente</option>
                        <option value="En cours">En cours</option>
                        <option value="Résolu">Résolu</option>
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                    <button type="button" class="btn btn-primary" id="confirmStatusChange">Confirmer</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Votre JavaScript personnalisé ici -->
    <script>
        $(document).ready(function () {
            // Exemple de structure du tableau des incidents
            var incidentsTable = `
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Description</th>
                        <th scope="col">Localisation</th>
                        <th scope="col">Date</th>
                        <th scope="col">Statut</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th scope="row">1</th>
                        <td>Description de l'incident</td>
                        <td>Localisation de l'incident</td>
                        <td>2023-01-01</td>
                        <td>En attente</td>
                        <td>
                            <button type="button" class="btn btn-success btn-sm btn-change-status" data-toggle="modal" data-target="#changeStatusModal">Changer Statut</button>
                        </td>
                    </tr>
                    <!-- Ajoutez d'autres lignes ici -->
                </tbody>
            `;

            // Remplacez le contenu de la table avec la structure définie ci-dessus
            $('.incident-table').html(incidentsTable);

            // Graphique des Statistiques
            var data = {
                labels: ['En attente', 'En cours', 'Résolu'],
                datasets: [{
                    label: 'Statut des Incidents',
                    data: [10, 5, 20],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(75, 192, 192, 1)',
                    ],
                    borderWidth: 1,
                }],
            };

            var options = {
                scales: {
                    y: {
                        beginAtZero: true,
                    },
                },
            };

            var ctx = document.getElementById('incidentChart').getContext('2d');
            var myChart = new Chart(ctx, {
                type: 'bar',
                data: data,
                options: options,
            });

            // Afficher le tableau des incidents et masquer le graphique des statistiques au chargement de la page
            $('#chartContainer').hide();

            // Lorsque vous cliquez sur le lien "Tableau de Bord", affichez le tableau et masquez le graphique
            $('#dashboardLink').click(function () {
                $('#incidentTableContainer').show();
                $('#chartContainer').hide();
            });

            // Lorsque vous cliquez sur le lien "Statistiques", affichez le graphique et masquez le tableau
            $('#statisticsLink').click(function () {
                $('#incidentTableContainer').hide();
                $('#chartContainer').show();
            });

            // Lorsque vous cliquez sur le bouton "Changer Statut" dans le tableau
            $('.btn-change-status').click(function () {
                // Affichez le modal de changement de statut
                $('#changeStatusModal').modal('show');
            });

            // Lorsque vous cliquez sur le bouton "Confirmer" dans le modal de changement de statut
            $('#confirmStatusChange').click(function () {
                var newStatus = $('#newStatus').val();
                // Mettez à jour le statut dans le tableau
                $('.incident-table tbody tr:first-child').find('td:nth-child(5)').text(newStatus);
                // Fermez le modal
                $('#changeStatusModal').modal('hide');
            });
        });
    </script>
</body>
</html>
