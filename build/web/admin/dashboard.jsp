<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
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
<title>Admin Dashboard</title>

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
    letter-spacing:0.5px;
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

/* HERO */
.hero{
    background:white;
    padding:40px;
    border-radius:25px;
    box-shadow:0 20px 40px rgba(59,130,246,0.12);
    margin-bottom:50px;
    position:relative;
    overflow:hidden;
}

.hero::after{
    content:"";
    position:absolute;
    width:180px;
    height:180px;
    background:rgba(59,130,246,0.08);
    border-radius:50%;
    top:-60px;
    right:-60px;
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
    box-shadow:0 20px 40px rgba(59,130,246,0.12);
    transition:0.3s;
    position:relative;
    overflow:hidden;
}

.card-item:hover{
    transform:translateY(-8px);
    box-shadow:0 25px 50px rgba(59,130,246,0.22);
}

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
    font-size:28px;
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
    <h3><i class="fa-solid fa-user-shield"></i> Admin</h3>

    <a href="dashboard.jsp" class="active">
        <i class="fa-solid fa-house"></i> Dashboard
    </a>

    <a href="vocabulary">
        <i class="fa-solid fa-book"></i> Vocabulary
    </a>

    <a href="theory">
        <i class="fa-solid fa-book-open"></i> Theory
    </a>

    <a href="#">
        <i class="fa-solid fa-pen"></i> Exercise
    </a>

    <a href="#">
        <i class="fa-solid fa-chart-column"></i> Result
    </a>

    <a href="../logout">
        <i class="fa-solid fa-right-from-bracket"></i> Logout
    </a>
</div>

<div class="content">

    <div class="hero">
        <h2><i class="fa-solid fa-crown"></i> Welcome, Admin ${sessionScope.user.username}</h2>
        <p>Manage lessons, control content and keep the system running smoothly.</p>
    </div>

    <div class="cards">

        <div class="card-item">
            <i class="fa-solid fa-book"></i>
            <h3>Manage Vocabulary</h3>
            <p>Create, edit and organize vocabulary topics efficiently.</p>
            <a href="vocabulary">Manage →</a>
        </div>

        <div class="card-item">
            <i class="fa-solid fa-book-open"></i>
            <h3>Manage Theory</h3>
            <p>Add new lessons, upload files and maintain content quality.</p>
            <a href="theory">Manage →</a>
        </div>

        <div class="card-item">
            <i class="fa-solid fa-pen"></i>
            <h3>Manage Exercises</h3>
            <p>Create exercises and monitor student performance.</p>
            <a href="#">Manage →</a>
        </div>

    </div>

</div>

</body>
</html>