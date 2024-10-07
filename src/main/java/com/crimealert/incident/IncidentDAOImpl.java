package com.crimealert.incident;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class IncidentDAOImpl implements IncidentDAO {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/teste";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "OUIAM";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("Error loading JDBC driver");
        }
    }

    @Override
    public void ajouterIncident(Incident incident) {
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO incidents (description, localisation, date,image_data) VALUES (?, ?, ?,?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, incident.getDescription());
                statement.setString(2, incident.getLocalisation());
                statement.setDate(3, new java.sql.Date(incident.getDate().getTime()));
                statement.setBytes(4, incident.getImageData());
                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Incident added successfully.");
                } else {
                    System.out.println("Failed to add incident.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error adding incident to the database");
        }
    }

    @Override
    public Incident getIncidentParID(int id) {
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT * FROM incidents WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, id);
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        return mapResultSetToIncident(resultSet);
                    } else {
                        System.out.println("Incident not found with ID: " + id);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error retrieving incident from the database");
        }
        return null;
    }

    @Override
    public List<Incident> listerIncidents() {
        List<Incident> incidents = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT id, description, localisation, date,image_data FROM incidents";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        int id = resultSet.getInt("id");
                        String description = resultSet.getString("description");
                        String localisation = resultSet.getString("localisation");
                        Date date = resultSet.getDate("date");
                        byte[] imageData = resultSet.getBytes("image_data");

                        System.out.println("ID: " + id + ", Description: " + description + ", Localisation: " + localisation + ", Date: " + date + ", Image Data Length: " + (imageData != null ? imageData.length : 0));


                        Incident incident = new Incident(id, description, localisation, date, imageData);
                        incidents.add(incident);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error listing incidents from the database");
        }

        return incidents;
    }

    @Override
    public void mettreAJourIncident(Incident incident) {
        // Implementer la mise a jour d'un incident dans la base de donnees
    }

    @Override
    public void supprimerIncident(int id) {
        // Implementer la suppression d'un incident dans la base de donnees
    }

    // Methode pour mapper un ResultSet a un objet Incident
    private Incident mapResultSetToIncident(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("id");
        String description = resultSet.getString("description");
        String localisation = resultSet.getString("localisation");
        byte[] imageData = resultSet.getBytes("image_data");
        // Utiliser getObject au lieu de getDate pour gerer les valeurs NULL
        java.sql.Date sqlDate = resultSet.getObject("date", java.sql.Date.class);
        Date date = (sqlDate != null) ? new Date(sqlDate.getTime()) : null;

        return new Incident(id, description, localisation, date, imageData);
    }

}
