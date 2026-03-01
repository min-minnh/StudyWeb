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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Lessons</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
*{box-sizing:border-box;margin:0;padding:0;}

body{
    font-family:'Segoe UI',Arial,sans-serif;
    background:#f0f7ff;
    display:flex;
    min-height:100vh;
}

/* ========== SIDEBAR ========== */
.sidebar{
    width:240px;
    min-height:100vh;
    background:linear-gradient(180deg,#93c5fd,#60a5fa);
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
    border-radius:8px;
    margin:4px 12px;
    transition:0.3s;
    font-size:15px;
}

.sidebar a:hover{
    background:rgba(255,255,255,0.25);
    transform:translateX(6px);
}

.active{background:rgba(255,255,255,0.35);}

/* ========== TOPBAR ========== */
.topbar{
    display:none;
    position:fixed;
    top:0; left:0; right:0;
    height:56px;
    background:linear-gradient(90deg,#60a5fa,#93c5fd);
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

.back-link{
    display:inline-block;
    padding:8px 18px;
    border-radius:25px;
    background:#dbeafe;
    color:#1e3a8a;
    font-weight:600;
    text-decoration:none;
    margin-bottom:25px;
    transition:0.3s;
    font-size:14px;
}

.back-link:hover{background:#bfdbfe;}

.page-header{
    margin-bottom:28px;
}

.page-header h2{
    font-size:clamp(20px,3vw,28px);
    color:#1e3a8a;
}

/* ========== LESSON CARD ========== */
.lesson-card{
    background:white;
    padding:clamp(20px,4vw,40px);
    border-radius:24px;
    box-shadow:0 15px 40px rgba(59,130,246,0.12);
    margin-bottom:30px;
    line-height:1.8;
    position:relative;
    overflow:hidden;
}

.lesson-card::after{
    content:"";
    position:absolute;
    width:120px; height:120px;
    background:rgba(59,130,246,0.07);
    border-radius:50%;
    top:-40px; right:-40px;
}

.lesson-card h3{
    font-size:clamp(18px,3vw,24px);
    color:#1e40af;
    margin-bottom:18px;
    text-align:center;
}

.lesson-content{
    color:#334155;
    font-size:clamp(14px,2vw,16px);
    line-height:1.8;
}

/* PDF Desktop */
.pdf-desktop{
    margin-top:25px;
    border-radius:20px;
    overflow:hidden;
    box-shadow:0 15px 35px rgba(0,0,0,0.1);
}

.pdf-desktop iframe{
    width:100%;
    height:650px;
    border:none;
    display:block;
}

/* PDF Mobile - link thay thế */
.pdf-mobile{
    display:none;
    margin-top:20px;
}

.pdf-mobile a{
    display:flex;
    align-items:center;
    justify-content:center;
    gap:8px;
    padding:13px 20px;
    background:#dbeafe;
    color:#1e3a8a;
    border-radius:14px;
    text-decoration:none;
    font-weight:600;
    font-size:15px;
    transition:0.2s;
}

.pdf-mobile a:hover{background:#bfdbfe;}

/* ========== EMPTY ========== */
.empty{
    background:white;
    padding:50px 30px;
    border-radius:20px;
    text-align:center;
    box-shadow:0 10px 30px rgba(0,0,0,0.07);
    color:#64748b;
}

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
        padding:75px 16px 30px;
    }

    /* Ẩn iframe, hiện link trên mobile */
    .pdf-desktop{display:none;}
    .pdf-mobile{display:block;}
}
</style>
</head>

<body>

<!-- Topbar mobile -->
<div class="topbar">
    <button class="menu-btn" onclick="toggleSidebar()">
        <i class="fa-solid fa-bars"></i>
    </button>
    <span><i class="fa-solid fa-book-open"></i> Lessons</span>
</div>

<!-- Overlay -->
<div class="overlay" id="overlay" onclick="toggleSidebar()"></div>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <h3><i class="fa-solid fa-user-graduate"></i> Student</h3>
    <a href="dashboard.jsp"><i class="fa-solid fa-house"></i> Dashboard</a>
    <a href="vocabulary"><i class="fa-solid fa-book"></i> Vocabulary</a>
    <a href="theory" class="active"><i class="fa-solid fa-book-open"></i> Theory</a>
    <a href="../logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

<!-- Content -->
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
            String fileUrl = (t.getFilePath() != null && !t.getFilePath().trim().equals(""))
                ? request.getContextPath() + "/view-file?name=" + t.getFilePath()
                : null;
    %>

    <div class="lesson-card">
        <h3><%= t.getTitle() %></h3>
        <div class="lesson-content"><%= t.getContent() %></div>

        <% if (fileUrl != null) { %>

        <!-- Desktop: iframe -->
        <div class="pdf-desktop">
            <iframe src="<%= fileUrl %>"></iframe>
        </div>

        <!-- Mobile: link -->
        <div class="pdf-mobile">
            <a href="<%= fileUrl %>" target="_blank">
                <i class="fa-solid fa-file-pdf"></i> View PDF Document
            </a>
        </div>

        <% } %>
    </div>

    <%
        }
    } else {
    %>

    <div class="empty">
        <i class="fa-regular fa-folder-open" style="font-size:30px;margin-bottom:12px;display:block;"></i>
        <p>No lessons available yet.</p>
    </div>

    <% } %>

</div>

<script>
function toggleSidebar(){
    document.getElementById("sidebar").classList.toggle("open");
    document.getElementById("overlay").classList.toggle("show");
}
</script>

</body>
</html>
