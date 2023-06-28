package Model;

public class Employer {

    private String email;
    private double balance;

    public Employer() {
    }

    public Employer(String email, double balance) {
        this.email = email;
        this.balance = balance;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

}
