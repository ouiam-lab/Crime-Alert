package com.crimealert.incident;

import java.util.Date;

public class Incident {
    private int id;
    private String description;
    private String localisation;
    private Date date;
    private byte[] imageData; // New field for storing image data

    public Incident(int id, String description, String localisation, Date date, byte[] imageData) {
        this.id = id;
        this.description = description;
        this.localisation = localisation;
        this.date = date;
        this.imageData = imageData;
    }

    public Incident() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocalisation() {
        return localisation;
    }

    public void setLocalisation(String localisation) {
        this.localisation = localisation;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public byte[] getImageData() {
        return imageData;
    }

    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }
}
