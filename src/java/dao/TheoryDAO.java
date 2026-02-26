package dao;

import model.*;
import java.sql.*;
import java.util.*;

public class TheoryDAO extends DBContext {

    public void insert(String title, String content, int topicId) {

        String sql =
            "INSERT INTO Theory(title, content, topicId) VALUES(?,?,?)";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, title);
            ps.setString(2, content);
            ps.setInt(3, topicId);

            ps.executeUpdate();

        } catch (Exception e) { e.printStackTrace(); }
    }

    public List<Theory> getByTopic(int topicId) {

        List<Theory> list = new ArrayList<>();
        String sql = "SELECT * FROM Theory WHERE topicId=?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, topicId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Theory(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getInt("topicId"),
                        rs.getString("filePath")
                ));
            }

        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }
    public void delete(int id) {

    String sql = "DELETE FROM Theory WHERE id=?";

    try (Connection con = getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, id);
        ps.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }
}
    public void insertWithFile(String title,
                           String content,
                           int topicId,
                           String filePath) {

    String sql = "INSERT INTO Theory(title, content, topicId, filePath) VALUES(?,?,?,?)";

    try (Connection con = getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, title);
        ps.setString(2, content);
        ps.setInt(3, topicId);
        ps.setString(4, filePath);

        ps.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }
}
}