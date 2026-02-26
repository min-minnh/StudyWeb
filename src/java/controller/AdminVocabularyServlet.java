package controller;

import dao.TopicDAO;
import dao.VocabularyDAO;
import model.Topic;
import model.User;
import model.Vocabulary;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/vocabulary")
public class AdminVocabularyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null || !user.getRole().equals("admin")) {
            response.sendRedirect("../login");
            return;
        }

        TopicDAO topicDAO = new TopicDAO();
        VocabularyDAO vocabDAO = new VocabularyDAO();

        String topicId = request.getParameter("topic");
        String deleteTopic = request.getParameter("deleteTopic");
        String deleteWord = request.getParameter("deleteWord");

        // XÓA CHỦ ĐỀ
        if (deleteTopic != null) {
            topicDAO.delete(Integer.parseInt(deleteTopic));
            response.sendRedirect("vocabulary");
            return;
        }

        // XÓA TỪ
        if (deleteWord != null && topicId != null) {
            vocabDAO.delete(Integer.parseInt(deleteWord));
            response.sendRedirect("vocabulary?topic=" + topicId);
            return;
        }

        // KHÔNG CÓ topic → HIỂN THỊ DANH SÁCH CHỦ ĐỀ
        if (topicId == null) {

            List<Topic> topics = topicDAO.getAll();
            request.setAttribute("topics", topics);
            request.getRequestDispatcher("/admin/vocabulary.jsp")
                   .forward(request, response);

        } else {

            // CÓ topic → HIỂN THỊ DANH SÁCH TỪ TRONG CHỦ ĐỀ
            List<Vocabulary> list =
                    vocabDAO.getByTopic(Integer.parseInt(topicId));

            request.setAttribute("list", list);
            request.setAttribute("topicId", topicId);
            request.getRequestDispatcher("/admin/words.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null || !user.getRole().equals("admin")) {
            response.sendRedirect("../login");
            return;
        }

        TopicDAO topicDAO = new TopicDAO();
        VocabularyDAO vocabDAO = new VocabularyDAO();

        String topicName = request.getParameter("topicName");
        String topicId = request.getParameter("topicId");

        // THÊM CHỦ ĐỀ
        if (topicName != null) {
            topicDAO.insert(topicName);
            response.sendRedirect("vocabulary");
            return;
        }

        // THÊM TỪ VÀO CHỦ ĐỀ
        if (topicId != null) {

            String word = request.getParameter("word");
            String meaning = request.getParameter("meaning");
            String example = request.getParameter("example");

            vocabDAO.insertByTopic(
                    word, meaning, example,
                    Integer.parseInt(topicId)
            );

            response.sendRedirect("vocabulary?topic=" + topicId);
        }
    }
}