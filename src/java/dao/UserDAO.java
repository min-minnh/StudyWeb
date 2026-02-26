package dao;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DBContext;
import model.User;

public class UserDAO extends DBContext {

    public User checkLogin(String username, String password) {

        String sql = "SELECT * FROM Users WHERE username=? AND password=?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}