<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
model.User user = (model.User) session.getAttribute("user");
if (user == null || !user.getRole().equals("student")) {
    response.sendRedirect("../login");
    return;
}

String topicId = request.getParameter("topic");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Choose Mode</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#dbeafe,#bfdbfe);
}

/* Container */
.container{
    text-align:center;
}

/* Title */
h2{
    font-size:32px;
    margin-bottom:50px;
    color:#1e3a8a;
}

/* Cards */
.mode-wrapper{
    display:flex;
    gap:50px;
    justify-content:center;
}

.card{
    background:white;
    padding:55px;
    width:300px;
    border-radius:28px;
    box-shadow:0 20px 40px rgba(0,0,0,0.1);
    transition:0.3s;
}

.card:hover{
    transform:translateY(-10px);
    box-shadow:0 35px 70px rgba(0,0,0,0.18);
}

.card i{
    font-size:42px;
    margin-bottom:20px;
    color:#3b82f6;
}

.card h3{
    font-size:22px;
    margin-bottom:10px;
}

.card p{
    color:#555;
    font-size:14px;
}

/* Button */
.card a{
    display:inline-block;
    margin-top:20px;
    padding:10px 26px;
    border-radius:25px;
    background:#3b82f6;
    color:white;
    text-decoration:none;
    font-weight:600;
    transition:0.3s;
}

.card a:hover{
    background:#2563eb;
    transform:translateY(-3px);
    box-shadow:0 12px 25px rgba(59,130,246,0.3);
}

/* Back Button */
.back{
    display:inline-flex;
    align-items:center;
    gap:8px;
    margin-top:50px;
    padding:10px 24px;
    border-radius:30px;
    background:white;
    color:#1e3a8a;
    text-decoration:none;
    font-weight:600;
    transition:0.3s;
    box-shadow:0 10px 20px rgba(0,0,0,0.1);
}

.back:hover{
    background:#eff6ff;
    transform:translateY(-3px);
    box-shadow:0 15px 30px rgba(0,0,0,0.15);
}
</style>
</head>

<body>

<div class="container">

<h2>💙 Choose Your Mode</h2>

<div class="mode-wrapper">

<div class="card">
    <i class="fa-solid fa-layer-group"></i>
    <h3>Study Mode</h3>
    <p>Flip flashcards and remember faster 🚀</p>
    <a href="vocabulary?topic=<%= topicId %>&mode=study">
        Start Study
    </a>
</div>

<div class="card">
    <i class="fa-solid fa-bolt"></i>
    <h3>Test Mode</h3>
    <p>Challenge yourself and level up 💪</p>
    <a href="vocabulary?topic=<%= topicId %>&mode=inputTest">
        Start Test
    </a>
</div>

</div>

<a class="back" href="vocabulary">
    <i class="fa-solid fa-arrow-left"></i>
    Back to Topics
</a>

</div>

</body>
</html>