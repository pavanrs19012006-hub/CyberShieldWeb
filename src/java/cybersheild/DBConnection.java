
package cybersheild;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() throws SQLException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/cybershield_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                "root",
                ""
            );

            System.out.println("Database Connected Successfully!");
            return con;

        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found. Check Connector/J library.", e);
        }
    }
}
