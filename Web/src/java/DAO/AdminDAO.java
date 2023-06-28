package DAO;

import DBConnection.DatabaseConnection;
import Model.Admin;
import java.sql.*;

public class AdminDAO {

    private Connection conn;

    public AdminDAO() throws SQLException, ClassNotFoundException {
        conn = DatabaseConnection.getConnection();
    }

    public Admin getAdminByEmail(String email) throws SQLException, ClassNotFoundException {
        Admin ad = new Admin();
        PreparedStatement ps = conn.prepareStatement("select * from admin where Admin_Email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            ad.setEmail(rs.getString("Admin_Email"));
        }
        return ad;
    }
}
