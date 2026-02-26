package dao;

import model.*;
import java.sql.*;
import java.util.*;

public class TheoryTopicDAO extends DBContext {

    public void insert(String name) {
        String sql = "INSERT INTO TheoryTopic(name) VALUES(?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void delete(int id) {
        String sql = "DELETE FROM TheoryTopic WHERE id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public List<TheoryTopic> getAll() {
        List<TheoryTopic> list = new ArrayList<>();
        String sql = "SELECT * FROM TheoryTopic";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new TheoryTopic(
                        rs.getInt("id"),
                        rs.getString("name")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }
}