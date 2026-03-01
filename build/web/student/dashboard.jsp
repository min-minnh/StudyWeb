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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Dashboard</title>

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

/* ========== HERO ========== */
.hero{
    background:white;
    padding:35px;
    border-radius:20px;
    box-shadow:0 10px 30px rgba(59,130,246,0.12);
    margin-bottom:35px;
    position:relative;
    overflow:hidden;
}

.hero::after{
    content:"";
    position:absolute;
    width:150px; height:150px;
    background:rgba(59,130,246,0.07);
    border-radius:50%;
    top:-50px; right:-50px;
}

.hero h2{
    font-size:clamp(20px,3vw,28px);
    color:#1e3a8a;
}

.hero p{
    margin-top:8px;
    color:#475569;
    font-size:15px;
}

/* ========== CARDS ========== */
.cards{
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(260px,1fr));
    gap:25px;
}

.card-item{
    background:white;
    padding:30px;
    border-radius:20px;
    box-shadow:0 10px 30px rgba(59,130,246,0.12);
    transition:0.3s;
    position:relative;
    overflow:hidden;
}

.card-item:hover{
    transform:translateY(-6px);
    box-shadow:0 20px 40px rgba(59,130,246,0.2);
}

.card-item::after{
    content:"";
    position:absolute;
    width:100px; height:100px;
    background:rgba(59,130,246,0.07);
    border-radius:50%;
    top:-30px; right:-30px;
}

.card-item i{font-size:26px;color:#3b82f6;margin-bottom:12px;}
.card-item h3{font-size:18px;color:#1e40af;margin-bottom:8px;}
.card-item p{color:#64748b;font-size:14px;line-height:1.6;}

.card-item a{
    display:inline-block;
    margin-top:16px;
    padding:8px 18px;
    border-radius:20px;
    background:#dbeafe;
    color:#1e3a8a;
    font-weight:600;
    text-decoration:none;
    transition:0.3s;
    font-size:14px;
}

.card-item a:hover{background:#bfdbfe;}

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

    .cards{grid-template-columns:1fr;}
}
</style>
</head>

<body>

<!-- Topbar mobile -->
<div class="topbar">
    <button class="menu-btn" onclick="toggleSidebar()">
        <i class="fa-solid fa-bars"></i>
    </button>
    <span><i class="fa-solid fa-user-graduate"></i> Student</span>
</div>

<!-- Overlay -->
<div class="overlay" id="overlay" onclick="toggleSidebar()"></div>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
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

<!-- Content -->
<div class="content">

    <div class="hero">
        <h2><i class="fa-solid fa-hand-wave"></i> Hello ${sessionScope.user.username} 👋</h2>
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

<script>
function toggleSidebar(){
    document.getElementById("sidebar").classList.toggle("open");
    document.getElementById("overlay").classList.toggle("show");
}
</script>

</body>
</html>
