package controller;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet("/view-file")
public class FileServlet extends HttpServlet {
    private static final String UPLOAD_PATH = "/home/uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fileName = request.getParameter("name");
        if (fileName == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        File file = new File(UPLOAD_PATH, fileName);
        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Xác định content type theo đuôi file
        if (fileName.endsWith(".pdf")) {
            response.setContentType("application/pdf");
        } else if (fileName.endsWith(".docx")) {
            response.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        } else if (fileName.endsWith(".doc")) {
            response.setContentType("application/msword");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        } else {
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        }

        response.setContentLength((int) file.length());
        FileInputStream in = new FileInputStream(file);
        OutputStream out = response.getOutputStream();
        byte[] buffer = new byte[4096];
        int bytesRead;
        while ((bytesRead = in.read(buffer)) != -1) {
            out.write(buffer, 0, bytesRead);
        }
        in.close();
        out.close();
    }
}