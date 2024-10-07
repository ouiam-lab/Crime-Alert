
package com.crimealert.incident;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/incidentServlet")
public class IncidentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IncidentDAO incidentDAO = new IncidentDAOImpl();

    private static final String DB_URL = "jdbc:mysql://localhost:3306/teste";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "OUIAM";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Add incident
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addIncident(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // List incidents
        listIncidents(request, response);
    }

    private void addIncident(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String description = request.getParameter("description");
        String localisation = request.getParameter("localisation");
        String dateString = request.getParameter("date");
        
        // Handle file upload
        Part filePart = request.getPart("image");
        InputStream fileContent = filePart.getInputStream();
        byte[] imageData = processFileUpload(fileContent);

        // Print image data length
        System.out.println("Image Data Length: " + (imageData != null ? imageData.length : 0));

        Date date = null;
        if (dateString != null && !dateString.isEmpty()) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            try {
                date = dateFormat.parse(dateString);
            } catch (ParseException e) {
                e.printStackTrace();
                // Handle the parsing exception as needed
            }
        }

        Incident nouvelIncident = new Incident();
        nouvelIncident.setDescription(description);
        nouvelIncident.setLocalisation(localisation);
        nouvelIncident.setDate(date);
        nouvelIncident.setImageData(imageData); // Set the image data

        ajouterIncidentEnBaseDeDonnees(nouvelIncident);

        response.sendRedirect("confirmation.jsp");
    }

    // Method to process file upload
    private byte[] processFileUpload(InputStream fileContent) throws IOException {
        int fileSize = fileContent.available();
        byte[] buffer = new byte[fileSize];
        fileContent.read(buffer);
        return buffer;
    }

    private void listIncidents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Incident> incidents = incidentDAO.listerIncidents();
            request.setAttribute("incidents", incidents);
            request.getRequestDispatcher("/incidente -list.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des incidents : " + e.getMessage());
            e.printStackTrace();
            // Handle the error, redirect to an error page, etc.
        }
    }

    private void ajouterIncidentEnBaseDeDonnees(Incident incident) {
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO incidents (description, localisation, date, image_data) VALUES (?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, incident.getDescription());
                statement.setString(2, incident.getLocalisation());

                if (incident.getDate() != null) {
                    statement.setDate(3, new java.sql.Date(incident.getDate().getTime()));
                } else {
                    statement.setNull(3, java.sql.Types.DATE);
                }

                // Set the image data
                statement.setBytes(4, incident.getImageData());

                statement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately (log, throw a custom exception, etc.)
        }
    }
}
