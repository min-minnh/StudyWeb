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
import java.util.*;

@WebServlet("/student/vocabulary")
public class StudentVocabularyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !user.getRole().equals("student")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String mode = request.getParameter("mode");
        String topicId = request.getParameter("topic");

        TopicDAO topicDAO = new TopicDAO();
        VocabularyDAO vocabDAO = new VocabularyDAO();

        // Không có topic → hiển thị danh sách topic
        if (topicId == null) {
            List<Topic> topics = topicDAO.getAll();
            request.setAttribute("topics", topics);
            request.getRequestDispatcher("/student/vocabulary.jsp")
                   .forward(request, response);
            return;
        }

        List<Vocabulary> list =
                vocabDAO.getByTopic(Integer.parseInt(topicId));

        // ===== STUDY =====
        if ("study".equals(mode)) {
            request.setAttribute("list", list);
            request.getRequestDispatcher("/student/flashcard.jsp")
                   .forward(request, response);
            return;
        }

        // ===== BẮT ĐẦU TEST =====
        if ("inputTest".equals(mode)) {

            Collections.shuffle(list);

            session.setAttribute("testList", list);
            session.setAttribute("testIndex", 0);
            session.setAttribute("correctList", new ArrayList<Vocabulary>());
            session.setAttribute("wrongList", new ArrayList<Vocabulary>());
            session.setAttribute("topicId", topicId);

            response.sendRedirect(
                request.getContextPath()
                + "/student/vocabulary?mode=doingTest&topic=" + topicId
            );
            return;
        }

        // ===== ĐANG LÀM TEST =====
        if ("doingTest".equals(mode)) {

            List<Vocabulary> testList =
                    (List<Vocabulary>) session.getAttribute("testList");

            Integer index =
                    (Integer) session.getAttribute("testIndex");

            if (testList == null || index == null) {
                response.sendRedirect(
                    request.getContextPath() + "/student/vocabulary"
                );
                return;
            }

            if (index >= testList.size()) {
                request.getRequestDispatcher("/student/result.jsp")
                       .forward(request, response);
                return;
            }

            request.getRequestDispatcher("/student/inputTest.jsp")
                   .forward(request, response);
            return;
        }

        // DEFAULT
        request.setAttribute("list", list);
        request.setAttribute("topicId", topicId);
        request.getRequestDispatcher("/student/words.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<Vocabulary> testList =
                (List<Vocabulary>) session.getAttribute("testList");

        Integer index =
                (Integer) session.getAttribute("testIndex");

        List<Vocabulary> correctList =
                (List<Vocabulary>) session.getAttribute("correctList");

        List<Vocabulary> wrongList =
                (List<Vocabulary>) session.getAttribute("wrongList");

        String topicId =
                (String) session.getAttribute("topicId");

        if (testList == null || index == null) {
            response.sendRedirect(
                request.getContextPath() + "/student/vocabulary"
            );
            return;
        }

        Vocabulary current = testList.get(index);
        String action = request.getParameter("action");
if ("submit".equals(action)) {

    String answer = request.getParameter("answer");

    String userAnswer = answer == null ? "" : answer;
    String correctAnswer = current.getMeaning();

    userAnswer = userAnswer.trim().replaceAll("\\s+", " ").toLowerCase();
    correctAnswer = correctAnswer.trim().replaceAll("\\s+", " ").toLowerCase();

    if (userAnswer.equals(correctAnswer)) {
        correctList.add(current);
    } else {
        wrongList.add(current);
    }

    index++;

} else if ("skip".equals(action)) {

    // Skip luôn tính là sai
    wrongList.add(current);
    index++;
}

        session.setAttribute("testIndex", index);

        response.sendRedirect(
            request.getContextPath()
            + "/student/vocabulary?mode=doingTest&topic=" + topicId
        );
    }
}