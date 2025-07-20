package com.cognizant.loan.model;

public class Loan {
    private String number;
    private String type;
    private double amount;

    public Loan() {}

    public Loan(String number, String type, double amount) {
        this.number = number;
        this.type = type;
        this.amount = amount;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }
}
