<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Vocabulary" %>

<%
List<Vocabulary> correctList =
    (List<Vocabulary>) session.getAttribute("correctList");

List<Vocabulary> wrongList =
    (List<Vocabulary>) session.getAttribute("wrongList");

if(correctList == null) correctList = new java.util.ArrayList<>();
if(wrongList == null) wrongList = new java.util.ArrayList<>();

int total = correctList.size() + wrongList.size();
int correct = correctList.size();
int percent = total == 0 ? 0 : (correct * 100 / total);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test Result</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:linear-gradient(135deg,#a8edea,#fed6e3);
    padding:50px;
}

.container{
    max-width:900px;
    margin:auto;
}

.card{
    background:rgba(255,255,255,0.92);
    backdrop-filter:blur(10px);
    padding:35px;
    border-radius:20px;
    box-shadow:0 25px 50px rgba(0,0,0,0.15);
    margin-bottom:25px;
}

.title{
    font-size:28px;
    font-weight:700;
    margin-bottom:20px;
}

.stat{
    font-size:18px;
    margin:8px 0;
}

.correct{color:#16a34a;}
.wrong{color:#dc2626;}

.progress-bar{
    height:12px;
    background:#e5e7eb;
    border-radius:10px;
    margin-top:15px;
    overflow:hidden;
}

.progress-fill{
    height:100%;
    width:<%= percent %>%;
    background:#6366f1;
    transition:0.4s;
}

.list-item{
    padding:8px 0;
    font-size:16px;
}

.list-item i{
    margin-right:6px;
}

.btn-group{
    margin-top:25px;
    display:flex;
    gap:15px;
}

button, .link-btn{
    padding:12px 20px;
    border:none;
    border-radius:12px;
    font-weight:600;
    cursor:pointer;
    text-decoration:none;
    display:inline-flex;
    align-items:center;
    gap:6px;
    transition:0.2s;
}

.retry-btn{
    background:#6366f1;
    color:white;
}

.retry-btn:hover{
    box-shadow:0 10px 20px rgba(99,102,241,0.3);
    transform:translateY(-2px);
}

.back-btn{
    background:#f3f4f6;
    color:#333;
}

.back-btn:hover{
    background:#e5e7eb;
}
</style>
</head>
<body>

<div class="container">

<div class="card">
    <div class="title">
        <i class="fa-solid fa-chart-column"></i>
        Test Result
    </div>

    <div class="stat">Total: <b><%= total %></b></div>
    <div class="stat correct">
        <i class="fa-solid fa-circle-check"></i>
        Correct: <%= correct %>
    </div>
    <div class="stat wrong">
        <i class="fa-solid fa-circle-xmark"></i>
        Wrong: <%= wrongList.size() %>
    </div>

    <div class="progress-bar">
        <div class="progress-fill"></div>
    </div>

    <div style="margin-top:10px;">
        Score: <b><%= percent %>%</b>
        <% if(percent >= 80){ %>
            🎉 Excellent!
        <% } else if(percent >= 50){ %>
            👍 Good job!
        <% } else { %>
            💪 Keep practicing!
        <% } %>
    </div>
</div>

<div class="card">
    <h3><i class="fa-solid fa-circle-check"></i> Correct</h3>
    <% if(correctList.isEmpty()){ %>
        <p>No correct answers yet.</p>
    <% } %>
    <% for(Vocabulary v : correctList){ %>
        <div class="list-item correct">
            <i class="fa-solid fa-check"></i>
            <%= v.getWord() %> - <%= v.getMeaning() %>
        </div>
    <% } %>
</div>

<div class="card">
    <h3><i class="fa-solid fa-circle-xmark"></i> Wrong</h3>
    <% if(wrongList.isEmpty()){ %>
        <p>No wrong answers 🎉</p>
    <% } %>
    <% for(Vocabulary v : wrongList){ %>
        <div class="list-item wrong">
            <i class="fa-solid fa-xmark"></i>
            <%= v.getWord() %> - Correct: <%= v.getMeaning() %>
        </div>
    <% } %>
</div>

<div class="card btn-group">

<form action="${pageContext.request.contextPath}/student/vocabulary"
      method="get">
    <input type="hidden" name="topic"
           value="<%= session.getAttribute("topicId") %>">
    <input type="hidden" name="mode" value="inputTest">
    <button type="submit" class="retry-btn">
        <i class="fa-solid fa-rotate"></i>
        Làm lại
    </button>
</form>

<a href="vocabulary" class="link-btn back-btn">
    <i class="fa-solid fa-arrow-left"></i>
    Back to Topics
</a>

</div>

</div>

</body>
</html>