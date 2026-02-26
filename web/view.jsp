<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Study Web - Login</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI',Arial,sans-serif;
}

body{
    height:100vh;
    display:flex;
    background:linear-gradient(135deg,#dbeafe,#eff6ff);
}

/* LEFT SIDE */
.left-panel{
    width:45%;
    background:linear-gradient(160deg,#60a5fa,#3b82f6);
    color:white;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    text-align:center;
    padding:60px;
    position:relative;
    overflow:hidden;
}

/* glowing circle decor */
.left-panel::before{
    content:"";
    position:absolute;
    width:400px;
    height:400px;
    background:rgba(255,255,255,0.1);
    border-radius:50%;
    top:-120px;
    right:-120px;
}

.left-panel h1{
    font-size:36px;
    font-weight:700;
    margin-bottom:10px;
}

.left-panel p{
    opacity:0.9;
}

/* COUNTDOWN */
.countdown-box{
    margin-top:35px;
    background:rgba(255,255,255,0.15);
    backdrop-filter:blur(12px);
    padding:30px 45px;
    border-radius:30px;
    box-shadow:0 15px 40px rgba(0,0,0,0.15);
}

.countdown-days{
    font-size:56px;
    font-weight:800;
    letter-spacing:2px;
}

.countdown-sub{
    font-size:14px;
    margin-top:8px;
}

.motivation{
    margin-top:30px;
    max-width:320px;
    font-size:16px;
    line-height:1.6;
}

/* RIGHT SIDE */
.right-panel{
    flex:1;
    display:flex;
    justify-content:center;
    align-items:center;
}

/* VIP CARD */
.login-box{
    width:400px;
    padding:50px 40px;
    border-radius:30px;
    background:rgba(255,255,255,0.8);
    backdrop-filter:blur(15px);
    box-shadow:0 25px 60px rgba(59,130,246,0.25);
    transition:0.4s;
}

.login-box:hover{
    transform:translateY(-6px);
    box-shadow:0 35px 70px rgba(59,130,246,0.35);
}

.login-box h2{
    text-align:center;
    margin-bottom:35px;
    color:#1e40af;
    font-size:24px;
}

/* INPUT */
.input-group{
    margin-bottom:22px;
}

.input-group label{
    font-size:13px;
    color:#475569;
}

.input-group input{
    width:100%;
    padding:12px;
    margin-top:6px;
    border-radius:14px;
    border:1px solid #cbd5e1;
    outline:none;
    transition:0.3s;
}

.input-group input:focus{
    border-color:#3b82f6;
    box-shadow:0 0 10px rgba(59,130,246,0.4);
}

/* BUTTON */
.login-btn{
    width:100%;
    padding:14px;
    border:none;
    border-radius:25px;
    background:linear-gradient(135deg,#60a5fa,#2563eb);
    color:white;
    font-weight:600;
    font-size:15px;
    cursor:pointer;
    transition:0.3s;
}

.login-btn:hover{
    transform:translateY(-3px);
    box-shadow:0 12px 25px rgba(37,99,235,0.4);
}

.footer-text{
    text-align:center;
    margin-top:18px;
    font-size:12px;
    color:#64748b;
}

@media(max-width:900px){
    .left-panel{
        display:none;
    }
}
</style>
</head>

<body>

<div class="left-panel">
    <h1><i class="fa-solid fa-graduation-cap"></i> Study Web</h1>
    <p>Final Exam • May 26, 2026</p>

    <div class="countdown-box">
        <div id="days" class="countdown-days"></div>
        <div class="countdown-sub">days remaining</div>
    </div>

    <div class="motivation">
        You are closer than you think.  
        Stay disciplined. Stay focused.  
        Great results are built one day at a time.
    </div>
</div>

<div class="right-panel">
    <div class="login-box">
        <h2><i class="fa-solid fa-right-to-bracket"></i> Welcome Back</h2>

        <form action="login" method="POST">
            <div class="input-group">
                <label>Username</label>
                <input type="text" name="username" required>
            </div>

            <div class="input-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>

            <input type="submit" value="Login" class="login-btn">

            <div class="footer-text">
                Study Web © 2025
            </div>
        </form>
    </div>
</div>

<script>
const examDate = new Date("May 26, 2026 00:00:00").getTime();
const daysElement = document.getElementById("days");

function updateCountdown(){
    const now = new Date().getTime();
    const distance = examDate - now;

    if(distance <= 0){
        daysElement.innerHTML = "0";
        return;
    }

    const days = Math.ceil(distance / (1000 * 60 * 60 * 24));
    daysElement.innerHTML = days;
}

updateCountdown();
setInterval(updateCountdown,1000);
</script>

</body>
</html>