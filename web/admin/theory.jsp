<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="model.TheoryTopic" %>
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
<title>Manage Theory Topics</title>

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
    font-size:clamp(20px,3vw,28px);
    color:#1e3a8a;
    margin-bottom:25px;
}

/* ========== CARD ========== */
.card{
    background:white;
    padding:25px 30px;
    border-radius:20px;
    box-shadow:0 10px 30px rgba(59,130,246,0.1);
    margin-bottom:25px;
}

/* ========== FORM ========== */
.form-row{
    display:flex;
    gap:12px;
    flex-wrap:wrap;
}

input[type=text]{
    flex:1;
    min-width:200px;
    padding:12px 16px;
    border-radius:12px;
    border:1px solid #cbd5e1;
    outline:none;
    font-size:15px;
    transition:0.3s;
}

input[type=text]:focus{
    border-color:#3b82f6;
    box-shadow:0 0 8px rgba(59,130,246,0.3);
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
    white-space:nowrap;
}

button:hover{
    background:#2563eb;
    box-shadow:0 8px 20px rgba(59,130,246,0.3);
}

/* ========== TABLE ========== */
.table-wrapper{overflow-x:auto;}

table{
    width:100%;
    border-collapse:collapse;
    min-width:300px;
}

thead{background:#dbeafe;}

th{
    padding:14px;
    text-align:left;
    color:#1e3a8a;
    font-weight:600;
    font-size:14px;
}

td{
    padding:14px;
    border-bottom:1px solid #e5e7eb;
    font-size:14px;
}

tr:hover{background:#f1f5ff;}

.view{
    padding:6px 14px;
    border-radius:15px;
    background:#dbeafe;
    color:#1e3a8a;
    text-decoration:none;
    font-weight:600;
    transition:0.3s;
    white-space:nowrap;
}

.view:hover{background:#bfdbfe;}

.delete{
    padding:6px 14px;
    border-radius:15px;
    background:#fee2e2;
    color:#b91c1c;
    text-decoration:none;
    font-weight:600;
    transition:0.3s;
    margin-left:8px;
    white-space:nowrap;
}

.delete:hover{background:#fecaca;}

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

    th:first-child, td:first-child{
        display:none; /* ẩn cột số thứ tự trên mobile */
    }
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
    <h3><i class="fa-solid fa-user-shield"></i> Admin</h3>

    <a href="dashboard.jsp">
        <i class="fa-solid fa-house"></i> Dashboard
    </a>
    <a href="vocabulary">
        <i class="fa-solid fa-book"></i> Vocabulary
    </a>
    <a href="theory" class="active">
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

<!-- Content -->
<div class="content">

    <div class="page-header">
        <h2><i class="fa-solid fa-book-open"></i> Manage Theory Topics</h2>
    </div>

    <!-- ADD TOPIC -->
    <div class="card">
        <form action="theory" method="POST">
            <div class="form-row">
                <input type="text" name="topicName" placeholder="Enter topic name..." required />
                <button type="submit">
                    <i class="fa-solid fa-plus"></i> Add Topic
                </button>
            </div>
        </form>
    </div>

    <!-- TOPIC TABLE -->
    <div class="card table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>No</th>
                    <th>Topic Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
            List<TheoryTopic> topics = (List<TheoryTopic>) request.getAttribute("topics");
            if (topics != null && !topics.isEmpty()) {
                int stt = 1;
                for (TheoryTopic t : topics) {
            %>
                <tr>
                    <td><%= stt++ %></td>
                    <td><%= t.getName() %></td>
                    <td>
                        <a class="view" href="theory?topic=<%= t.getId() %>">View</a>
                        <a class="delete"
                           href="theory?deleteTopic=<%= t.getId() %>"
                           onclick="return confirm('Delete this topic?');">Delete</a>
                    </td>
                </tr>
            <%
                }
            } else {
            %>
                <tr><td colspan="3">No topics available.</td></tr>
            <%
            }
            %>
            </tbody>
        </table>
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
