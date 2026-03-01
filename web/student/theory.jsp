<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="model.TheoryTopic" %>

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
<title>Theory Topics</title>

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
    transition:0.3s;
    border-radius:8px;
    margin:4px 12px;
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

.page-header{
    margin-bottom:30px;
}

.page-header h2{
    font-size:clamp(20px,3vw,28px);
    color:#1e3a8a;
}

.page-header p{
    margin-top:8px;
    color:#475569;
    font-size:15px;
}

/* ========== GRID ========== */
.topic-grid{
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(260px,1fr));
    gap:22px;
}

/* ========== CARD ========== */
.topic-card{
    background:white;
    padding:28px;
    border-radius:20px;
    box-shadow:0 10px 30px rgba(59,130,246,0.12);
    transition:0.3s;
    position:relative;
    overflow:hidden;
}

.topic-card:hover{
    transform:translateY(-6px);
    box-shadow:0 20px 40px rgba(59,130,246,0.2);
}

.topic-card::after{
    content:"";
    position:absolute;
    width:100px; height:100px;
    background:rgba(59,130,246,0.07);
    border-radius:50%;
    top:-30px; right:-30px;
}

.topic-card i{
    font-size:22px;
    color:#3b82f6;
    margin-bottom:10px;
}

.topic-card h3{
    font-size:18px;
    color:#1e40af;
    margin-bottom:12px;
    line-height:1.4;
}

.topic-card a{
    display:inline-block;
    padding:8px 18px;
    border-radius:20px;
    background:#dbeafe;
    color:#1e3a8a;
    font-weight:600;
    text-decoration:none;
    transition:0.3s;
    font-size:14px;
}

.topic-card a:hover{background:#bfdbfe;}

/* ========== EMPTY ========== */
.empty{
    background:white;
    padding:40px;
    border-radius:20px;
    text-align:center;
    box-shadow:0 10px 25px rgba(0,0,0,0.07);
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

    .topic-grid{grid-template-columns:1fr 1fr;}
}

@media(max-width:480px){
    .topic-grid{grid-template-columns:1fr;}
}
</style>
</head>

<body>

<!-- Topbar mobile -->
<div class="topbar">
    <button class="menu-btn" onclick="toggleSidebar()">
        <i class="fa-solid fa-bars"></i>
    </button>
    <span><i class="fa-solid fa-book-open"></i> Theory</span>
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

    <div class="page-header">
        <h2><i class="fa-solid fa-book-open"></i> Theory Topics</h2>
        <p>Pick a topic and start learning something new today ✨</p>
    </div>

    <%
    List<TheoryTopic> topics = (List<TheoryTopic>) request.getAttribute("topics");
    if (topics != null && !topics.isEmpty()) {
    %>

    <div class="topic-grid">
    <% for (TheoryTopic t : topics) { %>
        <div class="topic-card">
            <i class="fa-solid fa-lightbulb"></i>
            <h3><%= t.getName() %></h3>
            <a href="theory?topic=<%= t.getId() %>">View Lessons →</a>
        </div>
    <% } %>
    </div>

    <% } else { %>

    <div class="empty">
        <i class="fa-regular fa-folder-open" style="font-size:28px;margin-bottom:10px;display:block;"></i>
        <p>No theory topics available yet.</p>
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
