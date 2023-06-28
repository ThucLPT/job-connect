package DBConnection;

import java.sql.*;

public class DatabaseConnection {

    private static Connection connection;
    private static String url = "jdbc:mysql://localhost:3306/job";
    private static String username = "root";
    private static String password = "root";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        if (DatabaseConnection.connection == null) {
            try {
                connection = DriverManager.getConnection(url, username, password);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return connection;
    }

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        Connection conn = DatabaseConnection.getConnection();
    }
}
