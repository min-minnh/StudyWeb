<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Theory" %>

<%
    model.User user = (model.User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("student")) {
        response.sendRedirect("../login");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Lessons</title>

        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

        <style>
            body{
                margin:0;
                font-family:'Segoe UI',Arial,sans-serif;
                display:flex;
                height:100vh;
                background:#f0f7ff;
            }

            /* SIDEBAR */
            .sidebar{
                width:240px;
                background:linear-gradient(180deg,#93c5fd,#60a5fa);
                color:white;
                padding-top:25px;
            }

            .sidebar h3{
                text-align:center;
                margin-bottom:35px;
                font-weight:700;
            }

            .sidebar a{
                display:flex;
                align-items:center;
                gap:12px;
                padding:14px 22px;
                color:white;
                text-decoration:none;
                border-radius:8px;
                margin:4px 12px;
                transition:0.3s;
            }

            .sidebar a:hover{
                background:rgba(255,255,255,0.25);
                transform:translateX(6px);
            }

            .active{
                background:rgba(255,255,255,0.35);
            }

            /* CONTENT */
            .content{
                flex:1;
                padding:50px;
                overflow-y:auto;
            }

            /* BACK BUTTON */
            .back-link{
                display:inline-block;
                padding:8px 18px;
                border-radius:25px;
                background:#dbeafe;
                color:#1e3a8a;
                font-weight:600;
                text-decoration:none;
                margin-bottom:30px;
                transition:0.3s;
            }

            .back-link:hover{
                background:#bfdbfe;
            }

            /* HEADER */
            .page-header{
                margin-bottom:40px;
            }

            .page-header h2{
                margin:0;
                font-size:28px;
                color:#1e3a8a;
            }

            /* LESSON CARD */
            .lesson-card{
                background:white;
                padding:45px;
                border-radius:30px;
                box-shadow:0 25px 50px rgba(59,130,246,0.15);
                margin-bottom:45px;
                line-height:1.8;
                position:relative;
                overflow:hidden;
            }

            .lesson-card::after{
                content:"";
                position:absolute;
                width:140px;
                height:140px;
                background:rgba(59,130,246,0.08);
                border-radius:50%;
                top:-50px;
                right:-50px;
            }

            .lesson-card h3{
                text-align:center;
                font-size:30px;
                color:#1e40af;
                margin-bottom:25px;
            }

            .lesson-card div{
                color:#334155;
                font-size:16px;
            }

            /* PDF VIEWER */
            .pdf-viewer{
                margin-top:35px;
                border-radius:25px;
                overflow:hidden;
                box-shadow:0 20px 45px rgba(0,0,0,0.12);
            }

            /* EMPTY */
            .empty{
                background:white;
                padding:50px;
                border-radius:30px;
                text-align:center;
                box-shadow:0 20px 40px rgba(0,0,0,0.08);
                color:#64748b;
            }
        </style>
    </head>

    <body>

        <div class="sidebar">
            <h3><i class="fa-solid fa-user-graduate"></i> Student</h3>

            <a href="dashboard.jsp">
                <i class="fa-solid fa-house"></i> Dashboard
            </a>

            <a href="vocabulary">
                <i class="fa-solid fa-book"></i> Vocabulary
            </a>

            <a href="theory" class="active">
                <i class="fa-solid fa-book-open"></i> Theory
            </a>

            <a href="../logout">
                <i class="fa-solid fa-right-from-bracket"></i> Logout
            </a>
        </div>

        <div class="content">

            <a class="back-link" href="theory">
                <i class="fa-solid fa-arrow-left"></i> Back to Topics
            </a>

            <div class="page-header">
                <h2><i class="fa-solid fa-book-open"></i> Lessons</h2>
            </div>

            <%
                List<Theory> list = (List<Theory>) request.getAttribute("list");

                if (list != null && !list.isEmpty()) {

                    for (Theory t : list) {
            %>

            <div class="lesson-card">

                <h3><%= t.getTitle()%></h3>

                <div>
                    <%= t.getContent()%>
                </div>

                <%
                    if (t.getFilePath() != null && !t.getFilePath().trim().equals("")) {
                %>

                <div class="pdf-viewer">
                    <iframe
                        src="<%= request.getContextPath()%>/view-file?name=<%= t.getFilePath()%>"
                        style="width:100%; height:700px; border:none;">
                    </iframe>
                </div>

                <%
                    }
                %>

            </div>

            <%
                }

            } else {
            %>

            <div class="empty">
                <i class="fa-regular fa-folder-open" style="font-size:30px;margin-bottom:15px;"></i>
                <p>No lessons available yet.</p>
            </div>

            <%
                }
            %>

        </div>

    </body>
</html>