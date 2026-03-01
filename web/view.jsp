<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    min-height:100vh;
    display:flex;
    background:linear-gradient(135deg,#dbeafe,#eff6ff);
}

/* ===== LEFT SIDE ===== */
.left-panel{
    width:45%;
    background:linear-gradient(160deg,#60a5fa,#3b82f6);
    color:white;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    text-align:center;
    padding:60px 40px;
    position:relative;
    overflow:hidden;
}

.left-panel::before{
    content:"";
    position:absolute;
    width:350px;
    height:350px;
    background:rgba(255,255,255,0.1);
    border-radius:50%;
    top:-100px;
    right:-100px;
}

.left-panel h1{
    font-size:32px;
    font-weight:700;
    margin-bottom:10px;
}

.left-panel p{
    opacity:0.9;
}

/* Countdown */
.countdown-box{
    margin-top:30px;
    background:rgba(255,255,255,0.15);
    backdrop-filter:blur(12px);
    padding:25px 35px;
    border-radius:25px;
    box-shadow:0 15px 40px rgba(0,0,0,0.15);
}

.countdown-days{
    font-size:50px;
    font-weight:800;
}

.countdown-sub{
    font-size:14px;
    margin-top:6px;
}

.motivation{
    margin-top:25px;
    max-width:320px;
    font-size:15px;
    line-height:1.6;
}

/* ===== RIGHT SIDE ===== */
.right-panel{
    flex:1;
    display:flex;
    justify-content:center;
    align-items:center;
    padding:20px;
}

/* Login Box */
.login-box{
    width:420px;
    max-width:100%;
    padding:45px 35px;
    border-radius:28px;
    background:rgba(255,255,255,0.85);
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
    margin-bottom:30px;
    color:#1e40af;
    font-size:22px;
}

/* Input */
.input-group{
    margin-bottom:20px;
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

/* Button */
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
    margin-top:15px;
    font-size:12px;
    color:#64748b;
}

/* ===== Tablet ===== */
@media(max-width:1024px){
    .left-panel{
        width:50%;
        padding:40px 25px;
    }

    .countdown-days{
        font-size:42px;
    }
}

/* ===== Mobile ===== */
@media(max-width:900px){
    body{
        flex-direction:column;
    }

    .left-panel{
        width:100%;
        padding:35px 20px;
        min-height:280px;
    }

    .countdown-box{
        padding:18px 25px;
    }

    .countdown-days{
        font-size:36px;
    }

    .motivation{
        font-size:14px;
    }

    .right-panel{
        width:100%;
        padding:25px 15px;
    }

    .login-box{
        width:100%;
        padding:35px 25px;
        border-radius:24px;
    }

    .login-box h2{
        font-size:20px;
    }
}

/* ===== Small phone ===== */
@media(max-width:480px){
    .countdown-days{
        font-size:30px;
    }

    .login-btn{
        font-size:14px;
    }
}
</style>
</head>

<body>

<div class="left-panel">
    <h1><i class="fa-solid fa-graduation-cap"></i> Study Web</h1>
    <p>Final Exam ? May 26, 2026</p>

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