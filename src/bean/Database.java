package bean;

import java.sql.*;

public class Database {
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_DATABASE = "jspe";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "123456";

    private static Connection connection = null;

    public Database() {}

    private Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                Class.forName(DB_DRIVER);
                connection = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/" + DB_DATABASE + "?useSSL=false&serverTimezone=GMT%2B8",
                        DB_USERNAME,
                        DB_PASSWORD
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }

    public ResultSet executeSQL(String sql) {
        try {
            Connection con = getConnection();
            Statement statement = con.createStatement();
            return statement.executeQuery(sql);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
