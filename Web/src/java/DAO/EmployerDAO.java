package DAO;

import Model.*;
import java.sql.*;
import DBConnection.DatabaseConnection;

public class EmployerDAO {

    private Connection conn;

    public EmployerDAO() throws SQLException, ClassNotFoundException {
        conn = DatabaseConnection.getConnection();
    }

    public Employer getEmployerByEmail(String email) throws SQLException, ClassNotFoundException {
        Employer e = new Employer();
        PreparedStatement ps = conn.prepareStatement("select * from employer where Employer_Email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            e.setEmail(rs.getString("Employer_Email"));
            e.setBalance(rs.getDouble("Balance"));
        }
        return e;
    }

    public Employer addFund(Employer e, double amount) throws SQLException, ClassNotFoundException {
        e.setBalance(e.getBalance() + amount);
        PreparedStatement ps = conn.prepareStatement("update employer set Balance = ? where Employer_Email = ?");
        ps.setDouble(1, e.getBalance());
        ps.setString(2, e.getEmail());
        ps.executeUpdate();
        return e;
    }

    public double getFund(String email) throws SQLException, ClassNotFoundException {
        Employer e = new Employer();
        PreparedStatement ps = conn.prepareStatement("select * from employer where Employer_Email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            e.setBalance(rs.getDouble("Balance"));
        }
        return e.getBalance();
    }

    public void addEmployer(User u) throws SQLException, ClassNotFoundException {
        PreparedStatement ps = conn.prepareStatement("insert into employer(Employer_Email) values (?)");
        ps.setString(1, u.getEmail());
        ps.executeUpdate();
    }
}
