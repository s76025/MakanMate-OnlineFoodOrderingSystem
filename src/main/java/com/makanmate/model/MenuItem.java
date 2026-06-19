package com.makanmate.model;

public class MenuItem {
    private int id;
    private String itemName;
    private String description;
    private String category;
    private double price;
    private String imageUrl;
    private boolean availability;

    public MenuItem() {
    }

    public MenuItem(int id, String itemName, String description, String category, double price, String imageUrl, boolean availability) {
        this.id = id;
        this.itemName = itemName;
        this.description = description;
        this.category = category;
        this.price = price;
        this.imageUrl = imageUrl;
        this.availability = availability;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public boolean isAvailability() { return availability; }
    public void setAvailability(boolean availability) { this.availability = availability; }
}
