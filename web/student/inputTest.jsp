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
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Input Test</title>

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
    background:linear-gradient(135deg,#a8edea,#fed6e3);
    overflow:hidden;
}

/* floating animation */
@keyframes float{
    0%{transform:translateY(0px);}
    50%{transform:translateY(-8px);}
    100%{transform:translateY(0);}
}

@keyframes fadeIn{
    from{opacity:0;transform:translateY(15px);}
    to{opacity:1;transform:translateY(0);}
}

.card{
    background:rgba(255,255,255,0.92);
    backdrop-filter:blur(12px);
    width:520px;
    padding:45px;
    border-radius:25px;
    box-shadow:0 25px 50px rgba(0,0,0,0.15);
    text-align:center;
    animation:fadeIn 0.6s ease;
}

.word{
    font-size:40px;
    font-weight:700;
    margin-bottom:25px;
    color:#333;
    animation:float 3s ease-in-out infinite;
}

.word i{
    margin-right:8px;
    color:#6366f1;
}

input{
    width:100%;
    padding:14px;
    border-radius:12px;
    border:1px solid #ddd;
    font-size:16px;
    transition:0.2s;
}

input:focus{
    outline:none;
    border-color:#6366f1;
    box-shadow:0 0 0 3px rgba(99,102,241,0.2);
}

.btn-group{
    margin-top:25px;
    display:flex;
    gap:10px;
}

button{
    flex:1;
    padding:12px;
    border:none;
    border-radius:12px;
    font-weight:600;
    cursor:pointer;
    transition:0.2s;
    display:flex;
    align-items:center;
    justify-content:center;
    gap:6px;
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
}

.skip-btn:hover{
    background:#e5e7eb;
}

.progress{
    margin-top:20px;
    font-size:14px;
    color:#555;
}

.progress-bar{
    margin-top:10px;
    height:8px;
    background:#e5e7eb;
    border-radius:10px;
    overflow:hidden;
}

.progress-fill{
    height:100%;
    width:<%= (int)(((double)(index+1)/testList.size())*100) %>%;
    background:#6366f1;
    transition:0.3s;
}

.cheer{
    margin-top:15px;
    font-size:13px;
    color:#6b7280;
}
</style>
</head>

<body>

<div class="card">

<div class="word">
    <i class="fa-solid fa-bolt"></i>
    <%= current.getWord() %>
</div>

<form method="post"
      action="${pageContext.request.contextPath}/student/vocabulary"
      autocomplete="off">

<input type="text"
       name="answer"
       placeholder="Type the meaning ✍️"
       autocomplete="off">

<div class="btn-group">
    <button type="submit" name="action" value="submit"
            class="submit-btn">
        <i class="fa-solid fa-paper-plane"></i>
        Submit
    </button>

    <button type="submit" name="action" value="skip"
            class="skip-btn">
        <i class="fa-solid fa-forward"></i>
        Skip
    </button>
</div>

</form>

<div class="progress">
    Question <%= (index+1) %> / <%= testList.size() %>
</div>

<div class="progress-bar">
    <div class="progress-fill"></div>
</div>

<div class="cheer">
    🚀 Keep going! You're doing great!
</div>

</div>

</body>
</html>