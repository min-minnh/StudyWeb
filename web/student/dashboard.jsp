<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
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
<title>Student Dashboard</title>

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

/* SIDEBAR - same as Theory */
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

/* HERO */
.hero{
    background:white;
    padding:40px;
    border-radius:25px;
    box-shadow:0 20px 40px rgba(59,130,246,0.15);
    margin-bottom:50px;
    position:relative;
    overflow:hidden;
}

/* subtle circle decor */
.hero::after{
    content:"";
    position:absolute;
    width:150px;
    height:150px;
    background:rgba(59,130,246,0.08);
    border-radius:50%;
    top:-50px;
    right:-50px;
}

.hero h2{
    margin:0;
    font-size:28px;
    color:#1e3a8a;
}

.hero p{
    margin-top:8px;
    color:#475569;
}

/* CARDS */
.cards{
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(280px,1fr));
    gap:35px;
}

.card-item{
    background:white;
    padding:35px;
    border-radius:25px;
    box-shadow:0 20px 40px rgba(59,130,246,0.15);
    transition:0.3s;
    position:relative;
    overflow:hidden;
}

.card-item:hover{
    transform:translateY(-8px);
    box-shadow:0 25px 50px rgba(59,130,246,0.25);
}

/* subtle circle */
.card-item::after{
    content:"";
    position:absolute;
    width:120px;
    height:120px;
    background:rgba(59,130,246,0.08);
    border-radius:50%;
    top:-40px;
    right:-40px;
}

.card-item i{
    font-size:26px;
    color:#3b82f6;
    margin-bottom:15px;
}

.card-item h3{
    margin:0 0 10px 0;
    font-size:20px;
    color:#1e40af;
}

.card-item p{
    color:#64748b;
}

.card-item a{
    display:inline-block;
    margin-top:18px;
    padding:8px 18px;
    border-radius:20px;
    background:#dbeafe;
    color:#1e3a8a;
    font-weight:600;
    text-decoration:none;
    transition:0.3s;
}

.card-item a:hover{
    background:#bfdbfe;
}
</style>
</head>

<body>

<div class="sidebar">
    <h3><i class="fa-solid fa-user-graduate"></i> Student</h3>

    <a href="dashboard.jsp" class="active">
        <i class="fa-solid fa-house"></i> Dashboard
    </a>

    <a href="vocabulary">
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

    <div class="hero">
        <h2><i class="fa-solid fa-hand-wave"></i> Hello ${sessionScope.user.username}</h2>
        <p>Pick a section and continue improving your English today ✨</p>
    </div>

    <div class="cards">

        <div class="card-item">
            <i class="fa-solid fa-book"></i>
            <h3>Vocabulary</h3>
            <p>Learn new words and strengthen your language skills step by step.</p>
            <a href="vocabulary">Explore →</a>
        </div>

        <div class="card-item">
            <i class="fa-solid fa-book-open"></i>
            <h3>Theory</h3>
            <p>Understand grammar clearly and apply it confidently.</p>
            <a href="theory">Read →</a>
        </div>

    </div>

</div>

</body>
</html>