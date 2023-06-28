package DAO;

import Model.*;
import java.sql.*;
import java.util.*;
import DBConnection.DatabaseConnection;

public class UserDAO {

    private Connection conn;

    public UserDAO() throws SQLException, ClassNotFoundException {
        conn = DatabaseConnection.getConnection();
    }

    public List<User> getAllUsers() throws SQLException, ClassNotFoundException {
        List<User> users = new ArrayList<User>();
        try {
            PreparedStatement ps = conn.prepareStatement("select * from user");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User temp = new User();
                temp.setEmail(rs.getString("Email"));
                temp.setPassword(rs.getString("Password"));
                temp.setType(rs.getString("Type"));
                temp.setName(rs.getString("Name"));
                users.add(temp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public User getUserByEmail(String email) throws SQLException, ClassNotFoundException {
        User temp = new User();
        PreparedStatement ps = conn.prepareStatement("select * from user where Email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            temp.setEmail(rs.getString("Email"));
            temp.setPassword(rs.getString("Password"));
            temp.setType(rs.getString("Type"));
            temp.setName(rs.getString("Name"));
        }
        return temp;
    }

    public boolean containsEmail(String email) throws SQLException, ClassNotFoundException {
        PreparedStatement ps = conn.prepareStatement("select email from user where Email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        return rs.next();
    }

    public void addUser(User u) throws SQLException, ClassNotFoundException {
        PreparedStatement ps = conn.prepareStatement("insert into user(Email, Password, Name, Type) values (?, ?, ?, ?)");
        ps.setString(1, u.getEmail());
        ps.setString(2, u.getPassword());
        ps.setString(3, u.getName());
        ps.setString(4, u.getType());
        ps.executeUpdate();
    }

    public User editProfile(User u) throws SQLException, ClassNotFoundException {
        PreparedStatement ps = conn.prepareStatement("update user set Name =? ,Password = ? where Email = ?");
        ps.setString(1, u.getName());
        ps.setString(2, u.getPassword());
        ps.setString(3, u.getEmail());
        ps.executeUpdate();
        return u;
    }

    public List<User> getUserByName(String name) throws SQLException, ClassNotFoundException {
        List<User> users = new ArrayList<User>();
        PreparedStatement ps = conn.prepareStatement("select * from user where Name=?");
        ps.setString(1, name);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            User temp = new User();
            temp.setEmail(rs.getString("Email"));
            temp.setPassword(rs.getString("Password"));
            temp.setType(rs.getString("Type"));
            temp.setName(rs.getString("Name"));
            users.add(temp);
        }
        return users;
    }

    public void deleteUser(User u) throws SQLException, ClassNotFoundException {
        PreparedStatement ps = conn.prepareStatement("delete from user where Email=?");
        ps.setString(1, u.getEmail());
        ps.executeUpdate();
    }
}
