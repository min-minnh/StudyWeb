package controller;

import dao.TheoryDAO;
import dao.TheoryDAO;
import dao.TheoryTopicDAO;
import dao.TheoryTopicDAO;
import model.Theory;
import model.TheoryTopic;
import model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/student/theory")
public class StudentTheoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null || !user.getRole().equals("student")) {
            response.sendRedirect("../login");
            return;
        }

        TheoryTopicDAO topicDAO = new TheoryTopicDAO();
        TheoryDAO theoryDAO = new TheoryDAO();

        String topicId = request.getParameter("topic");

        // Không có topic → hiển thị danh sách chủ đề
        if (topicId == null) {

            List<TheoryTopic> topics = topicDAO.getAll();
            request.setAttribute("topics", topics);

            request.getRequestDispatcher("/student/theory.jsp")
                   .forward(request, response);

        } else {

            // Có topic → hiển thị bài học trong chủ đề
            List<Theory> list =
                    theoryDAO.getByTopic(Integer.parseInt(topicId));

            request.setAttribute("list", list);

            request.getRequestDispatcher("/student/theoryDetail.jsp")
                   .forward(request, response);
        }
    }
}