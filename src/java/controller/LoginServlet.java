package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.User;
import dao.UserDAO;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.checkLogin(username, password);

        if (user != null) {
            // Login thành công
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if (user.getRole().equals("admin")) {
                response.sendRedirect("admin/dashboard.jsp");
            } else {
                response.sendRedirect("student/dashboard.jsp");
            }
        } else {
            // Sai tài khoản
            request.setAttribute("error", "Sai username hoặc password!");
            request.getRequestDispatcher("view.jsp").forward(request, response);
        }
    }
}
