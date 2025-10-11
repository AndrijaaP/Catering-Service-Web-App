package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBKonekcija {

    private static final String URL = 
        "jdbc:mysql://localhost:3306/ketering?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Europe/Belgrade";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC driver not found!", e);
        }
    }

    public static Connection getKonekcija() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

