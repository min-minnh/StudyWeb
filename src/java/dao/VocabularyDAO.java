package dao;

import model.DBContext;
import model.Vocabulary;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class VocabularyDAO extends DBContext {

    // Thêm từ vựng
    public void insert(String word, String meaning, String example) {

        String sql = "INSERT INTO Vocabulary(word, meaning, example) VALUES (?, ?, ?)";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, word);
            ps.setString(2, meaning);
            ps.setString(3, example);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lấy toàn bộ danh sách
    public List<Vocabulary> getAll() {

        List<Vocabulary> list = new ArrayList<>();
        String sql = "SELECT * FROM Vocabulary";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Vocabulary v = new Vocabulary(
                        rs.getInt("id"),
                        rs.getString("word"),
                        rs.getString("meaning"),
                        rs.getString("example")
                );

                list.add(v);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public void delete(int id) {

    String sql = "DELETE FROM Vocabulary WHERE id=?";

    try (Connection con = getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, id);
        ps.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }
}
    public List<Vocabulary> getByTopic(int topicId) {

    List<Vocabulary> list = new ArrayList<>();
    String sql = "SELECT * FROM Vocabulary WHERE topicId=?";

    try (Connection con = getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, topicId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            list.add(new Vocabulary(
                    rs.getInt("id"),
                    rs.getString("word"),
                    rs.getString("meaning"),
                    rs.getString("example")
            ));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}
    public void insertByTopic(String word, String meaning,
                          String example, int topicId) {

    String sql =
        "INSERT INTO Vocabulary(word, meaning, example, topicId) VALUES(?,?,?,?)";

    try (Connection con = getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, word);
        ps.setString(2, meaning);
        ps.setString(3, example);
        ps.setInt(4, topicId);

        ps.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }
}
}