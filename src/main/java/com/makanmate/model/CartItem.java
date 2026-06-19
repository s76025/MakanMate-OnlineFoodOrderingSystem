package com.makanmate.model;

public class CartItem {
    private MenuItem menuItem;
    private int quantity;
    private double subtotal;

    public CartItem(MenuItem menuItem, int quantity) {
        this.menuItem = menuItem;
        this.quantity = quantity;
        this.subtotal = menuItem.getPrice() * quantity;
    }

    public MenuItem getMenuItem() { return menuItem; }
    public int getQuantity() { return quantity; }
    public double getSubtotal() { return subtotal; }
}
