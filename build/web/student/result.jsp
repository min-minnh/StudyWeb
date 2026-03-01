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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Test Result</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
*{box-sizing:border-box;margin:0;padding:0;}

body{
    font-family:'Segoe UI',sans-serif;
    background:linear-gradient(135deg,#a8edea,#fed6e3);
    min-height:100vh;
    padding:clamp(16px, 4vw, 50px);
}

.container{
    max-width:700px;
    margin:auto;
}

.card{
    background:rgba(255,255,255,0.92);
    backdrop-filter:blur(10px);
    padding:clamp(20px, 4vw, 35px);
    border-radius:20px;
    box-shadow:0 15px 40px rgba(0,0,0,0.12);
    margin-bottom:20px;
}

/* ========== SCORE CARD ========== */
.score-header{
    display:flex;
    align-items:center;
    gap:12px;
    margin-bottom:20px;
}

.score-header h2{
    font-size:clamp(20px,4vw,26px);
    color:#1e3a8a;
}

.score-circle{
    width:90px;
    height:90px;
    border-radius:50%;
    background:linear-gradient(135deg,#6366f1,#a78bfa);
    color:white;
    display:flex;
    flex-direction:column;
    align-items:center;
    justify-content:center;
    margin:0 auto 20px;
    box-shadow:0 8px 20px rgba(99,102,241,0.3);
}

.score-circle .pct{
    font-size:26px;
    font-weight:700;
    line-height:1;
}

.score-circle .lbl{
    font-size:11px;
    opacity:0.9;
}

.stats{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:12px;
    margin-bottom:18px;
}

.stat-box{
    background:#f8faff;
    border-radius:14px;
    padding:14px 10px;
    text-align:center;
}

.stat-box .num{
    font-size:22px;
    font-weight:700;
}

.stat-box .lbl{
    font-size:12px;
    color:#64748b;
    margin-top:3px;
}

.stat-box.total .num{color:#1e3a8a;}
.stat-box.ok .num{color:#16a34a;}
.stat-box.bad .num{color:#dc2626;}

.progress-bar{
    height:10px;
    background:#e5e7eb;
    border-radius:10px;
    overflow:hidden;
    margin-bottom:12px;
}

.progress-fill{
    height:100%;
    width:<%= percent %>%;
    background:linear-gradient(90deg,#6366f1,#a78bfa);
    border-radius:10px;
}

.cheer{
    text-align:center;
    font-size:15px;
    color:#374151;
    font-weight:600;
}

/* ========== LIST CARDS ========== */
.list-header{
    display:flex;
    align-items:center;
    gap:8px;
    font-size:17px;
    font-weight:700;
    margin-bottom:14px;
}

.list-item{
    padding:10px 0;
    font-size:14px;
    border-bottom:1px solid #f1f5f9;
    display:flex;
    align-items:flex-start;
    gap:8px;
    line-height:1.5;
}

.list-item:last-child{border-bottom:none;}
.list-item.correct{color:#16a34a;}
.list-item.wrong{color:#dc2626;}

/* ========== BUTTONS ========== */
.btn-group{
    display:flex;
    gap:12px;
    flex-wrap:wrap;
}

button, .link-btn{
    flex:1;
    min-width:140px;
    padding:13px 16px;
    border:none;
    border-radius:12px;
    font-weight:600;
    cursor:pointer;
    text-decoration:none;
    display:inline-flex;
    align-items:center;
    justify-content:center;
    gap:6px;
    transition:0.2s;
    font-size:15px;
}

.retry-btn{
    background:#6366f1;
    color:white;
}

.retry-btn:hover{
    box-shadow:0 8px 20px rgba(99,102,241,0.3);
    transform:translateY(-2px);
}

.back-btn{
    background:#f3f4f6;
    color:#333;
}

.back-btn:hover{background:#e5e7eb;}

@media(max-width:400px){
    .stats{grid-template-columns:repeat(3,1fr);}
    .btn-group{flex-direction:column;}
    button,.link-btn{min-width:unset;}
}
</style>
</head>
<body>

<div class="container">

    <!-- SCORE CARD -->
    <div class="card">
        <div class="score-header">
            <h2><i class="fa-solid fa-chart-column"></i> Test Result</h2>
        </div>

        <div class="score-circle">
            <span class="pct"><%= percent %>%</span>
            <span class="lbl">Score</span>
        </div>

        <div class="stats">
            <div class="stat-box total">
                <div class="num"><%= total %></div>
                <div class="lbl">Total</div>
            </div>
            <div class="stat-box ok">
                <div class="num"><%= correct %></div>
                <div class="lbl">Correct</div>
            </div>
            <div class="stat-box bad">
                <div class="num"><%= wrongList.size() %></div>
                <div class="lbl">Wrong</div>
            </div>
        </div>

        <div class="progress-bar">
            <div class="progress-fill"></div>
        </div>

        <div class="cheer">
            <% if(percent >= 80){ %>
                🎉 Excellent! Keep it up!
            <% } else if(percent >= 50){ %>
                👍 Good job! Almost there!
            <% } else { %>
                💪 Keep practicing! You'll get it!
            <% } %>
        </div>
    </div>

    <!-- CORRECT LIST -->
    <div class="card">
        <div class="list-header correct">
            <i class="fa-solid fa-circle-check"></i> Correct (<%= correctList.size() %>)
        </div>
        <% if(correctList.isEmpty()){ %>
            <p style="color:#64748b;font-size:14px;">No correct answers yet.</p>
        <% } %>
        <% for(Vocabulary v : correctList){ %>
            <div class="list-item correct">
                <i class="fa-solid fa-check" style="margin-top:3px;flex-shrink:0;"></i>
                <span><b><%= v.getWord() %></b> — <%= v.getMeaning() %></span>
            </div>
        <% } %>
    </div>

    <!-- WRONG LIST -->
    <div class="card">
        <div class="list-header wrong">
            <i class="fa-solid fa-circle-xmark"></i> Wrong (<%= wrongList.size() %>)
        </div>
        <% if(wrongList.isEmpty()){ %>
            <p style="color:#64748b;font-size:14px;">No wrong answers 🎉</p>
        <% } %>
        <% for(Vocabulary v : wrongList){ %>
            <div class="list-item wrong">
                <i class="fa-solid fa-xmark" style="margin-top:3px;flex-shrink:0;"></i>
                <span><b><%= v.getWord() %></b> — Correct: <%= v.getMeaning() %></span>
            </div>
        <% } %>
    </div>

    <!-- BUTTONS -->
    <div class="card btn-group">
        <form action="${pageContext.request.contextPath}/student/vocabulary" method="get" style="flex:1;display:flex;">
            <input type="hidden" name="topic" value="<%= session.getAttribute("topicId") %>">
            <input type="hidden" name="mode" value="inputTest">
            <button type="submit" class="retry-btn">
                <i class="fa-solid fa-rotate"></i> Làm lại
            </button>
        </form>

        <a href="vocabulary" class="link-btn back-btn">
            <i class="fa-solid fa-arrow-left"></i> Back to Topics
        </a>
    </div>

</div>

</body>
</html>
