package controller;

import dao.TheoryDAO;
import dao.TheoryTopicDAO;
import model.Theory;
import model.TheoryTopic;
import model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/theory")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 20,
        maxRequestSize = 1024 * 1024 * 50
)
public class AdminTheoryServlet extends HttpServlet {

    // Local Windows
    private static final String UPLOAD_PATH = "C:/uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        TheoryTopicDAO topicDAO = new TheoryTopicDAO();
        TheoryDAO theoryDAO = new TheoryDAO();

        String topicId = request.getParameter("topic");
        String deleteTopic = request.getParameter("deleteTopic");
        String deleteTheory = request.getParameter("deleteTheory");

        if (deleteTopic != null) {
            topicDAO.delete(Integer.parseInt(deleteTopic));
            response.sendRedirect("theory");
            return;
        }

        if (deleteTheory != null && topicId != null) {
            theoryDAO.delete(Integer.parseInt(deleteTheory));
            response.sendRedirect("theory?topic=" + topicId);
            return;
        }

        if (topicId == null) {

            List<TheoryTopic> topics = topicDAO.getAll();
            request.setAttribute("topics", topics);
            request.getRequestDispatcher("/admin/theory.jsp")
                    .forward(request, response);

        } else {

            List<Theory> list =
                    theoryDAO.getByTopic(Integer.parseInt(topicId));

            request.setAttribute("list", list);
            request.setAttribute("topicId", topicId);

            request.getRequestDispatcher("/admin/theoryDetail.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        TheoryTopicDAO topicDAO = new TheoryTopicDAO();
        TheoryDAO theoryDAO = new TheoryDAO();

        String topicName = request.getParameter("topicName");
        String topicId = request.getParameter("topicId");

        // Thêm chủ đề
        if (topicName != null && !topicName.trim().isEmpty()) {
            topicDAO.insert(topicName.trim());
            response.sendRedirect("theory");
            return;
        }

        // Thêm bài học
        if (topicId != null && !topicId.trim().isEmpty()) {

            String title = request.getParameter("title");
            String content = request.getParameter("content");

            Part filePart = request.getPart("file");
            String fileName = null;

            if (filePart != null && filePart.getSize() > 0) {

                String submittedFileName = filePart.getSubmittedFileName();
                fileName = System.currentTimeMillis() + "_" + submittedFileName;

                File uploadDir = new File(UPLOAD_PATH);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                filePart.write(UPLOAD_PATH + File.separator + fileName);

                System.out.println("File saved at: " + UPLOAD_PATH + "/" + fileName);
            }

            theoryDAO.insertWithFile(
                    title,
                    content,
                    Integer.parseInt(topicId),
                    fileName
            );

            response.sendRedirect("theory?topic=" + topicId);
        }
    }
}