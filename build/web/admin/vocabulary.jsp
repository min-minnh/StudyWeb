<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Topic" %>

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
<title>Manage Vocabulary Topics</title>

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
    margin:0 0 30px 0;
    font-size:28px;
    color:#1e3a8a;
}

/* CARD */
.card{
    background:white;
    padding:35px;
    border-radius:25px;
    box-shadow:0 20px 40px rgba(59,130,246,0.12);
    margin-bottom:35px;
}

/* FORM */
input[type=text]{
    padding:12px;
    width:320px;
    border-radius:12px;
    border:1px solid #cbd5e1;
    outline:none;
    margin-right:15px;
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
}

button:hover{
    background:#2563eb;
    box-shadow:0 10px 25px rgba(59,130,246,0.4);
}

/* TABLE */
.table-wrapper{
    overflow:hidden;
    border-radius:20px;
}

table{
    width:100%;
    border-collapse:collapse;
}

thead{
    background:#dbeafe;
}

th{
    padding:14px;
    text-align:left;
    color:#1e3a8a;
    font-weight:600;
}

td{
    padding:14px;
    border-bottom:1px solid #e5e7eb;
}

tr:hover{
    background:#f1f5ff;
}

/* ACTION */
.view{
    padding:6px 14px;
    border-radius:15px;
    background:#dbeafe;
    color:#1e3a8a;
    text-decoration:none;
    font-weight:600;
    transition:0.3s;
}

.view:hover{
    background:#bfdbfe;
}

.delete{
    padding:6px 14px;
    border-radius:15px;
    background:#fee2e2;
    color:#b91c1c;
    text-decoration:none;
    font-weight:600;
    transition:0.3s;
    margin-left:8px;
}

.delete:hover{
    background:#fecaca;
}
</style>
</head>

<body>

<div class="sidebar">
    <h3><i class="fa-solid fa-user-shield"></i> Admin</h3>

    <a href="dashboard.jsp">
        <i class="fa-solid fa-house"></i> Dashboard
    </a>

    <a href="vocabulary" class="active">
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

<div class="page-header">
    <h2><i class="fa-solid fa-book"></i> Manage Vocabulary Topics</h2>
</div>

<!-- ADD TOPIC -->
<div class="card">
    <form action="vocabulary" method="POST">
        <input type="text" name="topicName" placeholder="New Topic Name..." required />
        <button type="submit">
            <i class="fa-solid fa-plus"></i> Add Topic
        </button>
    </form>
</div>

<!-- TABLE -->
<div class="card table-wrapper">
<table>

<thead>
<tr>
    <th>ID</th>
    <th>Topic Name</th>
    <th>Action</th>
</tr>
</thead>

<tbody>

<%
List<Topic> topics = (List<Topic>) request.getAttribute("topics");

if (topics != null && !topics.isEmpty()) {
    for (Topic t : topics) {
%>

<tr>
    <td><%= t.getId() %></td>
    <td><%= t.getName() %></td>
    <td>
        <a class="view" href="vocabulary?topic=<%= t.getId() %>">
            View
        </a>
        <a class="delete"
           href="vocabulary?deleteTopic=<%= t.getId() %>"
           onclick="return confirm('Delete this topic?');">
            Delete
        </a>
    </td>
</tr>

<%
    }
} else {
%>

<tr>
    <td colspan="3">No topics available.</td>
</tr>

<%
}
%>

</tbody>
</table>
</div>

</div>

</body>
</html>