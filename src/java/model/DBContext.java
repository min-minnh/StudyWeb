package model;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {

    public Connection getConnection() {
        try {
            String url = "jdbc:sqlserver://localhost\\SQLEXPRESS:1433;"
                    + "databaseName=EnglishDB;"
                    + "encrypt=true;"
                    + "trustServerCertificate=true";

            String user = "sa";
            String password = "123"; 

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(url, user, password);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}