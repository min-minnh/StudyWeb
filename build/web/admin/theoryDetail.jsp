<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Theory" %>
<%
    model.User user = (model.User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("admin")) {
        response.sendRedirect("../login");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Lesson Document</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
body{
    margin:0;
    font-family:'Segoe UI',Arial,sans-serif;
    display:flex;
    height:100vh;
    background:#f3f8ff;
}

/* SIDEBAR */
.sidebar{
    width:240px;
    background:linear-gradient(180deg,#1e293b,#334155);
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
    transition:0.3s;
    border-radius:8px;
    margin:4px 12px;
}

.sidebar a:hover{
    background:rgba(255,255,255,0.15);
    transform:translateX(6px);
}

.active{
    background:rgba(255,255,255,0.25);
}

/* CONTENT */
.content{
    flex:1;
    padding:50px;
    overflow-y:auto;
}

/* HEADER */
.page-header h2{
    margin:0;
    font-size:28px;
    color:#1e3a8a;
}

.back-link{
    display:inline-block;
    margin:20px 0 35px 0;
    padding:8px 16px;
    border-radius:20px;
    background:#dbeafe;
    color:#1e3a8a;
    text-decoration:none;
    font-weight:600;
    transition:0.3s;
}

.back-link:hover{
    background:#bfdbfe;
}

/* CARD */
.card{
    background:white;
    padding:40px;
    border-radius:25px;
    box-shadow:0 20px 40px rgba(59,130,246,0.12);
    margin-bottom:40px;
}

/* FORM */
input[type=text],
textarea{
    width:100%;
    padding:12px;
    border-radius:12px;
    border:1px solid #cbd5e1;
    margin-bottom:18px;
    outline:none;
    transition:0.3s;
    font-size:14px;
}

input[type=text]:focus,
textarea:focus{
    border-color:#3b82f6;
    box-shadow:0 0 8px rgba(59,130,246,0.3);
}

textarea{
    min-height:180px;
    line-height:1.6;
}

input[type=file]{
    margin:15px 0 20px 0;
}

button{
    padding:12px 22px;
    border:none;
    border-radius:20px;
    background:#3b82f6;
    color:white;
    font-weight:600;
    cursor:pointer;
    transition:0.3s;
}

button:hover{
    background:#2563eb;
    box-shadow:0 10px 25px rgba(59,130,246,0.4);
}

/* DOCUMENT PREVIEW */
.document-preview{
    margin-bottom:40px;
    padding:35px;
    background:white;
    border-radius:25px;
    box-shadow:0 20px 40px rgba(59,130,246,0.12);
}

.document-preview h3{
    margin-top:0;
    color:#1e40af;
}

.document-preview iframe{
    width:100%;
    height:700px;
    border:none;
    border-radius:20px;
    box-shadow:0 15px 35px rgba(0,0,0,0.15);
    margin-top:25px;
}

/* DELETE */
.delete{
    display:inline-block;
    margin-top:20px;
    padding:6px 14px;
    border-radius:15px;
    background:#fee2e2;
    color:#b91c1c;
    text-decoration:none;
    font-weight:600;
    transition:0.3s;
}

.delete:hover{
    background:#fecaca;
}
</style>
</head>

<body>

<div class="sidebar">
    <h3><i class="fa-solid fa-user-shield"></i> Admin</h3>

    <a href="dashboard.jsp"><i class="fa-solid fa-house"></i> Dashboard</a>
    <a href="vocabulary"><i class="fa-solid fa-book"></i> Vocabulary</a>
    <a href="theory" class="active"><i class="fa-solid fa-book-open"></i> Theory</a>
    <a href="#"><i class="fa-solid fa-pen"></i> Exercise</a>
    <a href="#"><i class="fa-solid fa-chart-column"></i> Result</a>
    <a href="../logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

<div class="content">

    <div class="page-header">
        <h2><i class="fa-solid fa-file-lines"></i> Manage Lesson Document</h2>
    </div>

    <a class="back-link" href="theory">
        <i class="fa-solid fa-arrow-left"></i> Back to Topics
    </a>

    <!-- CREATE LESSON -->
    <div class="card">
        <form action="theory" method="POST" enctype="multipart/form-data">
            <input type="hidden" name="topicId" value="${topicId}" />

            <input type="text" name="title" placeholder="Lesson title..." required />

            <textarea name="content" placeholder="Write lesson content..."></textarea>

            <label><b>Upload PDF Document:</b></label>
            <input type="file" name="file" accept="application/pdf" />

            <button type="submit">
                <i class="fa-solid fa-upload"></i> Save Lesson
            </button>
        </form>
    </div>

    <!-- LESSON LIST -->
    <%
        List<Theory> list = (List<Theory>) request.getAttribute("list");

        if (list != null && !list.isEmpty()) {
            for (Theory t : list) {
    %>

    <div class="document-preview">
        <h3><%= t.getTitle() %></h3>

        <div style="margin-top:15px; line-height:1.8;">
            <%= t.getContent() %>
        </div>

        <%
            if (t.getFilePath() != null && !t.getFilePath().trim().equals("")) {
        %>

        <iframe
            src="<%= request.getContextPath()%>/view-file?name=<%= t.getFilePath()%>">
        </iframe>

        <%
            }
        %>

        <a class="delete"
           href="theory?topic=${topicId}&deleteTheory=<%= t.getId()%>"
           onclick="return confirm('Delete this lesson?');">
            <i class="fa-solid fa-trash"></i> Delete
        </a>

    </div>

    <%
            }
        } else {
    %>

    <div class="card">
        <p>No lessons available.</p>
    </div>

    <%
        }
    %>

</div>

</body>
</html>