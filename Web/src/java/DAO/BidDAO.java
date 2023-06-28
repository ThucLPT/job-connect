package DAO;

import DBConnection.DatabaseConnection;
import Model.Bid;
import java.sql.*;
import java.util.*;

public class BidDAO {

    private Connection conn;

    public BidDAO() throws SQLException, ClassNotFoundException {
        conn = DatabaseConnection.getConnection();
    }

    public List<Bid> getBidByProjectID(int projectId) throws SQLException, ClassNotFoundException {
        List<Bid> bids = new ArrayList<Bid>();
        PreparedStatement ps = conn.prepareStatement("select * from bid where ProjectID = ?");
        ps.setInt(1, projectId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Bid b = new Bid();
            b.setFreelancerEmail(rs.getString("Freelancer_Email"));
            b.setAmount(rs.getDouble("Amount"));
            b.setProjectId(rs.getInt("ProjectID"));
            bids.add(b);
        }
        return bids;
    }

    public Bid getBidByProjectIDandFreelancerEmail(int projectId, String freelancerEmail) throws SQLException {
        Bid b = new Bid();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM bid WHERE ProjectID=? AND Freelancer_Email=?");
        ps.setInt(1, projectId);
        ps.setString(2, freelancerEmail);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            b.setAmount(rs.getDouble("Amount"));
            b.setFreelancerEmail(rs.getString("Freelancer_Email"));
            b.setProjectId(rs.getInt("ProjectID"));
        }
        return b;
    }
}
