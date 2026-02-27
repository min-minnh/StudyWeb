package model;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {

    public Connection getConnection() {
        try {

            String url = "jdbc:sqlserver://34.87.45.229:1433;"
                    + "databaseName=EnglishDB;"
                    + "encrypt=true;"
                    + "trustServerCertificate=true;";

            String user = "sqlserver";
            String password = "1412kaitokid";

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(url, user, password);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}