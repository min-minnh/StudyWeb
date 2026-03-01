<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Vocabulary" %>
<%
List<Vocabulary> testList =
    (List<Vocabulary>) session.getAttribute("testList");
Integer index =
    (Integer) session.getAttribute("testIndex");
if (testList == null || index == null) {
    response.sendRedirect("vocabulary");
    return;
}
Vocabulary current = testList.get(index);
int percent = (int)(((double)(index+1)/testList.size())*100);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Input Test</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
*{box-sizing:border-box;margin:0;padding:0;}

body{
    font-family:'Segoe UI',sans-serif;
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#a8edea,#fed6e3);
    padding:20px;
}

@keyframes float{
    0%,100%{transform:translateY(0);}
    50%{transform:translateY(-8px);}
}

@keyframes fadeIn{
    from{opacity:0;transform:translateY(15px);}
    to{opacity:1;transform:translateY(0);}
}

.card{
    background:rgba(255,255,255,0.92);
    backdrop-filter:blur(12px);
    width:min(520px, 100%);
    padding:clamp(25px, 5vw, 45px);
    border-radius:25px;
    box-shadow:0 20px 50px rgba(0,0,0,0.15);
    text-align:center;
    animation:fadeIn 0.6s ease;
}

/* Header với nút back */
.card-header{
    display:flex;
    align-items:center;
    justify-content:space-between;
    margin-bottom:25px;
}

.back-btn{
    text-decoration:none;
    padding:7px 14px;
    border-radius:20px;
    background:#f3f4f6;
    color:#374151;
    font-size:13px;
    font-weight:600;
    transition:0.2s;
}

.back-btn:hover{background:#e5e7eb;}

.card-title{
    font-size:14px;
    color:#6b7280;
    font-weight:600;
}

.word{
    font-size:clamp(28px, 7vw, 42px);
    font-weight:700;
    margin-bottom:25px;
    color:#333;
    animation:float 3s ease-in-out infinite;
    line-height:1.3;
}

.word i{
    margin-right:8px;
    color:#6366f1;
}

input{
    width:100%;
    padding:14px 16px;
    border-radius:12px;
    border:1px solid #ddd;
    font-size:16px;
    transition:0.2s;
    font-family:inherit;
}

input:focus{
    outline:none;
    border-color:#6366f1;
    box-shadow:0 0 0 3px rgba(99,102,241,0.2);
}

.btn-group{
    margin-top:16px;
    display:flex;
    gap:10px;
}

button{
    flex:1;
    padding:13px;
    border:none;
    border-radius:12px;
    font-weight:600;
    cursor:pointer;
    transition:0.2s;
    display:flex;
    align-items:center;
    justify-content:center;
    gap:6px;
    font-size:15px;
}

.submit-btn{
    background:#6366f1;
    color:white;
}

.submit-btn:hover{
    transform:translateY(-2px);
    box-shadow:0 10px 20px rgba(99,102,241,0.3);
}

.skip-btn{
    background:#f3f4f6;
    color:#374151;
}

.skip-btn:hover{background:#e5e7eb;}

.progress-info{
    margin-top:20px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    font-size:13px;
    color:#6b7280;
    margin-bottom:8px;
}

.progress-bar{
    height:8px;
    background:#e5e7eb;
    border-radius:10px;
    overflow:hidden;
}

.progress-fill{
    height:100%;
    width:<%= percent %>%;
    background:linear-gradient(90deg,#6366f1,#a78bfa);
    transition:0.3s;
    border-radius:10px;
}

.cheer{
    margin-top:16px;
    font-size:13px;
    color:#6b7280;
}

@media(max-width:400px){
    .btn-group{flex-direction:column;}
    button{width:100%;}
}
</style>
</head>
<body>

<div class="card">

    <!-- Header -->
    <div class="card-header">
        <a class="back-btn" href="vocabulary">
            <i class="fa-solid fa-arrow-left"></i> Back
        </a>
        <span class="card-title">Vocabulary Test</span>
        <span style="font-size:13px;color:#6b7280;font-weight:600;">
            <%= percent %>%
        </span>
    </div>

    <!-- Word -->
    <div class="word">
        <i class="fa-solid fa-bolt"></i>
        <%= current.getWord() %>
    </div>

    <!-- Form -->
    <form method="post"
          action="${pageContext.request.contextPath}/student/vocabulary"
          autocomplete="off">
        <input type="text"
               name="answer"
               placeholder="Type the meaning ✍️"
               autocomplete="off"
               autofocus>
        <div class="btn-group">
            <button type="submit" name="action" value="submit" class="submit-btn">
                <i class="fa-solid fa-paper-plane"></i> Submit
            </button>
            <button type="submit" name="action" value="skip" class="skip-btn">
                <i class="fa-solid fa-forward"></i> Skip
            </button>
        </div>
    </form>

    <!-- Progress -->
    <div class="progress-info">
        <span>Question <%= (index+1) %> / <%= testList.size() %></span>
        <span>🚀 Keep going!</span>
    </div>
    <div class="progress-bar">
        <div class="progress-fill"></div>
    </div>

    <div class="cheer">You're doing great! 💪</div>

</div>

</body>
</html>
