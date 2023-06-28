package DAO;

import DBConnection.DatabaseConnection;
import java.sql.*;
import Model.*;

public class ContractDAO {

    private Connection conn;

    public ContractDAO() throws SQLException, ClassNotFoundException {
        conn = DatabaseConnection.getConnection();
    }

    public Contract getContractByProjectID(int projectID) throws SQLException, ClassNotFoundException {
        Contract c = new Contract();
        PreparedStatement ps = conn.prepareStatement("select * from contract where Project_ID = ?");
        ps.setInt(1, projectID);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            c.setEmployerEmail(rs.getString("Employer_Email"));
            c.setFreelancerEmail(rs.getString("Freelancer_Email"));
            c.setProjectID(rs.getInt("Project_ID"));
            c.setRating(rs.getInt("Rating"));
            c.setReview(rs.getString("Review"));
        }
        return c;
    }

    public void addContract(Contract c) throws SQLException, ClassNotFoundException {
        PreparedStatement ps = conn.prepareStatement("insert into contract (Project_ID,Employer_Email,Freelancer_Email,Salary) values (?,?,?,?)");
        ps.setInt(1, c.getProjectID());
        ps.setString(2, c.getEmployerEmail());
        ps.setString(3, c.getFreelancerEmail());
        ps.setDouble(4, c.getSalary());
        ps.executeUpdate();
    }

    public void updateContract(Contract c) throws SQLException, ClassNotFoundException {
        PreparedStatement ps = conn.prepareStatement("update contract set Rating= ?, Status='completed', Review= ? where Project_ID= ?");
        ps.setDouble(1, c.getRating());
        ps.setString(2, c.getReview());
        ps.setInt(3, c.getProjectID());
        ps.executeUpdate();
    }

}
