package DAO;

import DBConnection.DatabaseConnection;
import Model.*;
import java.sql.*;

public class FreelancerDAO {

    private Connection conn;

    public FreelancerDAO() throws Exception {
        conn = DatabaseConnection.getConnection();
    }

    public Freelancer getFreelancerByEmail(String email) throws SQLException, ClassNotFoundException {
        Freelancer f = new Freelancer();
        PreparedStatement ps = conn.prepareStatement("select * from freelancer where Freelancer_Email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            f.setFreelancerEmail(rs.getString("Freelancer_Email"));
            f.setSkill(rs.getString("Skill"));
        }
        return f;
    }

    public void addFreelancer(User u) throws SQLException, ClassNotFoundException {
        PreparedStatement ps = conn.prepareStatement("insert into freelancer(Freelancer_Email) values (?)");
        ps.setString(1, u.getEmail());
        ps.executeUpdate();
    }

    public void bid(Bid b) throws SQLException, ClassNotFoundException {
        PreparedStatement ps = conn.prepareStatement("INSERT INTO bid(ProjectID,Freelancer_Email,Amount) VALUES(?,?,?) ");
        ps.setInt(1, b.getProjectId());
        ps.setString(2, b.getFreelancerEmail());
        ps.setDouble(3, b.getAmount());
        ps.executeUpdate();
    }

    public void editBid(Bid b) throws SQLException {
        PreparedStatement ps = conn.prepareStatement("UPDATE bid SET Amount=? WHERE Freelancer_Email=? AND ProjectID=?");
        ps.setDouble(1, b.getAmount());
        ps.setString(2, b.getFreelancerEmail());
        ps.setInt(3, b.getProjectId());
        ps.executeUpdate();
    }

    public void editSkill(Freelancer f) throws SQLException {
        PreparedStatement ps = conn.prepareStatement("UPDATE freelancer SET Skill=? WHERE Freelancer_Email=?");
        ps.setString(1, f.getSkill());
        ps.setString(2, f.getFreelancerEmail());
        ps.executeUpdate();
    }

}
