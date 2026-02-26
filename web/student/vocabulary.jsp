<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Topic" %>

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
<title>Vocabulary Topics</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<!--<style>
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    display:flex;
    height:100vh;
    background:linear-gradient(135deg,#eef2ff,#fdf2f8);
}

/* SIDEBAR */
.sidebar{
    width:240px;
    background:linear-gradient(180deg,#6366f1,#3b82f6);
    color:white;
    padding-top:20px;
}

.sidebar h3{
    text-align:center;
    margin-bottom:30px;
}

.sidebar a{
    display:flex;
    align-items:center;
    gap:12px;
    padding:14px 22px;
    color:white;
    text-decoration:none;
    transition:0.3s;
}

.sidebar a:hover{
    background:rgba(255,255,255,0.15);
    padding-left:28px;
}

.active{
    background:rgba(255,255,255,0.18);
}

/* CONTENT */
.content{
    flex:1;
    padding:60px;
    overflow-y:auto;
}

.page-header h2{
    margin:0;
    font-size:30px;
}

.page-header p{
    margin-top:10px;
    color:#6b7280;
}

/* GRID */
.topic-grid{
    margin-top:50px;
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(300px,1fr));
    gap:35px;
}

/* CARD */
.topic-card{
    position:relative;
    background:white;
    padding:40px;
    border-radius:25px;
    box-shadow:0 20px 40px rgba(0,0,0,0.08);
    transition:0.3s;
    text-align:center;
    overflow:hidden;
}

.topic-card::before{
    content:"";
    position:absolute;
    width:120px;
    height:120px;
    background:radial-gradient(circle,#6366f130,transparent);
    top:-40px;
    right:-40px;
    border-radius:50%;
}

.topic-card:hover{
    transform:translateY(-10px);
    box-shadow:0 30px 60px rgba(0,0,0,0.15);
}

.topic-card i{
    font-size:36px;
    color:#6366f1;
    margin-bottom:20px;
}

.topic-card h3{
    margin:15px 0;
    font-size:22px;
}

.topic-card a{
    display:inline-block;
    margin-top:20px;
    padding:10px 22px;
    border-radius:12px;
    background:#6366f1;
    color:white;
    text-decoration:none;
    font-weight:600;
    transition:0.2s;
}

.topic-card a:hover{
    background:#4f46e5;
    box-shadow:0 10px 20px rgba(99,102,241,0.3);
}

.empty{
    background:white;
    padding:50px;
    border-radius:20px;
    text-align:center;
    box-shadow:0 15px 35px rgba(0,0,0,0.08);
}
</style>-->
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
    transition:0.3s;
    border-radius:8px;
    margin:4px 12px;
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

/* HEADER */
.page-header{
    margin-bottom:40px;
}

.page-header h2{
    margin:0;
    font-size:28px;
    color:#1e3a8a;
}

.page-header p{
    margin-top:8px;
    color:#475569;
}

/* GRID */
.topic-grid{
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(280px,1fr));
    gap:30px;
}

/* CARD */
.topic-card{
    background:white;
    padding:35px;
    border-radius:25px;
    box-shadow:0 20px 40px rgba(59,130,246,0.15);
    transition:0.3s;
    position:relative;
    overflow:hidden;
}

.topic-card:hover{
    transform:translateY(-8px);
    box-shadow:0 25px 50px rgba(59,130,246,0.25);
}

/* subtle background circle */
.topic-card::after{
    content:"";
    position:absolute;
    width:120px;
    height:120px;
    background:rgba(59,130,246,0.08);
    border-radius:50%;
    top:-40px;
    right:-40px;
}

.topic-card h3{
    margin:0 0 12px 0;
    font-size:20px;
    color:#1e40af;
}

.topic-card i{
    font-size:22px;
    color:#3b82f6;
    margin-bottom:10px;
}

.topic-card a{
    display:inline-block;
    margin-top:15px;
    padding:8px 18px;
    border-radius:20px;
    background:#dbeafe;
    color:#1e3a8a;
    font-weight:600;
    text-decoration:none;
    transition:0.3s;
}

.topic-card a:hover{
    background:#bfdbfe;
}

/* EMPTY */
.empty{
    background:white;
    padding:40px;
    border-radius:25px;
    text-align:center;
    box-shadow:0 15px 30px rgba(0,0,0,0.08);
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

    <a href="vocabulary" class="active">
        <i class="fa-solid fa-book"></i> Vocabulary
    </a>

    <a href="theory">
        <i class="fa-solid fa-book-open"></i> Theory
    </a>

    <a href="../logout">
        <i class="fa-solid fa-right-from-bracket"></i> Logout
    </a>
</div>

<div class="content">

<div class="page-header">
    <h2><i class="fa-solid fa-layer-group"></i> Vocabulary Topics</h2>
    <p>Pick a topic and start mastering new words 🚀</p>
</div>

<%
List<Topic> topics =
    (List<Topic>) request.getAttribute("topics");

if (topics != null && !topics.isEmpty()) {
%>

<div class="topic-grid">

<%
for (Topic t : topics) {
%>

<div class="topic-card">
    <i class="fa-solid fa-brain"></i>
    <h3><%= t.getName() %></h3>

    <a href="vocabulary?topic=<%= t.getId() %>">
        Start Learning
    </a>
</div>

<%
}
%>

</div>

<%
} else {
%>

<div class="empty">
    No vocabulary topics available yet.
</div>

<%
}
%>

</div>

</body>
</html>