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
<title>Theory Topics</title>

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

<div class="page-header">
    <h2><i class="fa-solid fa-book-open"></i> Theory Topics</h2>
    <p>Pick a topic and start learning something new today ✨</p>
</div>

<%
List<TheoryTopic> topics =
    (List<TheoryTopic>) request.getAttribute("topics");

if (topics != null && !topics.isEmpty()) {
%>

<div class="topic-grid">

<%
for (TheoryTopic t : topics) {
%>

<div class="topic-card">
    <i class="fa-solid fa-lightbulb"></i>
    <h3><%= t.getName() %></h3>

    <a href="theory?topic=<%= t.getId() %>">
        View Lessons →
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
    <i class="fa-regular fa-folder-open" style="font-size:28px;margin-bottom:10px;"></i>
    <p>No theory topics available yet.</p>
</div>

<%
}
%>

</div>

</body>
</html>