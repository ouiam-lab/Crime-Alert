package com.crimealert.incident;

import java.sql.SQLException;
import java.util.List;

public interface IncidentDAO {
    void ajouterIncident(Incident incident) throws SQLException;
    Incident getIncidentParID(int id);
    List<Incident> listerIncidents();
    void mettreAJourIncident(Incident incident);
    void supprimerIncident(int id);
    // Autres méthodes liées aux incidents
}
