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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Lesson Document</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
*{box-sizing:border-box;margin:0;padding:0;}

body{
    font-family:'Segoe UI',Arial,sans-serif;
    background:#f3f8ff;
    display:flex;
    min-height:100vh;
}

/* ========== SIDEBAR ========== */
.sidebar{
    width:240px;
    min-height:100vh;
    background:linear-gradient(180deg,#1e293b,#334155);
    color:white;
    padding-top:25px;
    flex-shrink:0;
    position:fixed;
    top:0; left:0;
    height:100%;
    overflow-y:auto;
    z-index:200;
    transition:transform 0.3s;
}

.sidebar h3{
    text-align:center;
    margin-bottom:35px;
    font-weight:700;
    font-size:18px;
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
    font-size:15px;
}

.sidebar a:hover{
    background:rgba(255,255,255,0.15);
    transform:translateX(6px);
}

.active{background:rgba(255,255,255,0.25);}

/* ========== TOPBAR ========== */
.topbar{
    display:none;
    position:fixed;
    top:0; left:0; right:0;
    height:56px;
    background:linear-gradient(90deg,#1e293b,#334155);
    color:white;
    align-items:center;
    padding:0 16px;
    gap:14px;
    z-index:300;
}

.topbar span{font-weight:700;font-size:17px;}

.menu-btn{
    background:none;
    border:none;
    color:white;
    font-size:22px;
    cursor:pointer;
    padding:4px 8px;
}

.overlay{
    display:none;
    position:fixed;
    inset:0;
    background:rgba(0,0,0,0.4);
    z-index:150;
}
.overlay.show{display:block;}

/* ========== CONTENT ========== */
.content{
    flex:1;
    margin-left:240px;
    padding:40px;
    overflow-y:auto;
}

.page-header h2{
    font-size:clamp(18px,3vw,26px);
    color:#1e3a8a;
    margin-bottom:16px;
}

.back-link{
    display:inline-block;
    margin-bottom:25px;
    padding:8px 16px;
    border-radius:20px;
    background:#dbeafe;
    color:#1e3a8a;
    text-decoration:none;
    font-weight:600;
    transition:0.3s;
    font-size:14px;
}

.back-link:hover{background:#bfdbfe;}

/* ========== CARD ========== */
.card{
    background:white;
    padding:25px 30px;
    border-radius:20px;
    box-shadow:0 10px 30px rgba(59,130,246,0.1);
    margin-bottom:25px;
}

/* ========== FORM ========== */
input[type=text],
textarea{
    width:100%;
    padding:12px 16px;
    border-radius:12px;
    border:1px solid #cbd5e1;
    margin-bottom:16px;
    outline:none;
    transition:0.3s;
    font-size:14px;
    font-family:inherit;
}

input[type=text]:focus,
textarea:focus{
    border-color:#3b82f6;
    box-shadow:0 0 8px rgba(59,130,246,0.25);
}

textarea{
    min-height:150px;
    line-height:1.6;
    resize:vertical;
}

.file-label{
    display:block;
    font-weight:600;
    color:#334155;
    margin-bottom:8px;
    font-size:14px;
}

input[type=file]{
    width:100%;
    margin-bottom:20px;
    font-size:14px;
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
    font-size:15px;
}

button:hover{
    background:#2563eb;
    box-shadow:0 8px 20px rgba(59,130,246,0.3);
}

/* ========== LESSON PREVIEW ========== */
.document-preview{
    background:white;
    border-radius:20px;
    box-shadow:0 10px 30px rgba(59,130,246,0.1);
    padding:25px 30px;
    margin-bottom:25px;
}

.document-preview h3{
    color:#1e40af;
    font-size:clamp(16px,2.5vw,20px);
    margin-bottom:12px;
}

.lesson-content{
    line-height:1.8;
    color:#374151;
    font-size:15px;
    margin-top:10px;
}

.pdf-wrapper{
    margin-top:20px;
    border-radius:16px;
    overflow:hidden;
    box-shadow:0 8px 25px rgba(0,0,0,0.1);
}

.pdf-wrapper iframe{
    width:100%;
    height:600px;
    border:none;
    display:block;
}

/* Mobile: dùng link thay iframe */
.pdf-link{
    display:none;
    margin-top:16px;
    padding:10px 20px;
    background:#dbeafe;
    color:#1e3a8a;
    border-radius:20px;
    text-decoration:none;
    font-weight:600;
    font-size:14px;
    text-align:center;
}

.delete-btn{
    display:inline-block;
    margin-top:18px;
    padding:8px 16px;
    border-radius:15px;
    background:#fee2e2;
    color:#b91c1c;
    text-decoration:none;
    font-weight:600;
    transition:0.3s;
    font-size:14px;
}

.delete-btn:hover{background:#fecaca;}

/* ========== RESPONSIVE ========== */
@media(max-width:768px){
    .topbar{display:flex;}

    .sidebar{
        transform:translateX(-100%);
        padding-top:70px;
    }

    .sidebar.open{transform:translateX(0);}

    .content{
        margin-left:0;
        padding:75px 14px 30px;
    }

    .card{padding:18px;}
    .document-preview{padding:18px;}

    /* Thay iframe bằng link trên mobile */
    .pdf-wrapper{display:none;}
    .pdf-link{display:block;}
}
</style>
</head>

<body>

<!-- Topbar mobile -->
<div class="topbar">
    <button class="menu-btn" onclick="toggleSidebar()">
        <i class="fa-solid fa-bars"></i>
    </button>
    <span><i class="fa-solid fa-file-lines"></i> Lesson</span>
</div>

<!-- Overlay -->
<div class="overlay" id="overlay" onclick="toggleSidebar()"></div>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <h3><i class="fa-solid fa-user-shield"></i> Admin</h3>
    <a href="dashboard.jsp"><i class="fa-solid fa-house"></i> Dashboard</a>
    <a href="vocabulary"><i class="fa-solid fa-book"></i> Vocabulary</a>
    <a href="theory" class="active"><i class="fa-solid fa-book-open"></i> Theory</a>
    <a href="#"><i class="fa-solid fa-pen"></i> Exercise</a>
    <a href="#"><i class="fa-solid fa-chart-column"></i> Result</a>
    <a href="../logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

<!-- Content -->
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
            <label class="file-label"><i class="fa-solid fa-file-pdf"></i> Upload Document:</label>
            <input type="file" name="file" accept=".pdf,.doc,.docx" />
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
        <h3><i class="fa-solid fa-book-open" style="color:#3b82f6;margin-right:8px;"></i><%= t.getTitle() %></h3>

        <div class="lesson-content"><%= t.getContent() %></div>

        <%
            if (t.getFilePath() != null && !t.getFilePath().trim().equals("")) {
                String fileUrl = request.getContextPath() + "/view-file?name=" + t.getFilePath();
        %>

        <!-- Desktop: iframe -->
        <div class="pdf-wrapper">
            <iframe src="<%= fileUrl %>"></iframe>
        </div>

        <!-- Mobile: link -->
        <a class="pdf-link" href="<%= fileUrl %>" target="_blank">
            <i class="fa-solid fa-file-pdf"></i> View PDF Document
        </a>

        <%
            }
        %>

        <a class="delete-btn"
           href="theory?topic=${topicId}&deleteTheory=<%= t.getId()%>"
           onclick="return confirm('Delete this lesson?');">
            <i class="fa-solid fa-trash"></i> Delete
        </a>
    </div>

    <%
            }
        } else {
    %>
    <div class="card"><p>No lessons available.</p></div>
    <%
        }
    %>

</div>

<script>
function toggleSidebar(){
    document.getElementById("sidebar").classList.toggle("open");
    document.getElementById("overlay").classList.toggle("show");
}
</script>

</body>
</html>
