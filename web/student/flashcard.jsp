<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Vocabulary" %>

<%
List<Vocabulary> list =
    (List<Vocabulary>) request.getAttribute("list");

if (list == null || list.isEmpty()) {
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>No Words</title>
</head>
<body style="font-family:Segoe UI; text-align:center; padding:100px;">
<h3>No words available.</h3>
<a href="vocabulary">← Back to Topics</a>
</body>
</html>

<%
return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Study Mode</title>

<style>
*{box-sizing:border-box;margin:0;padding:0;}

body{
    font-family:'Segoe UI',Arial,sans-serif;
    background:linear-gradient(135deg,#dbeafe,#bfdbfe);
    display:flex;
    flex-direction:column;
    align-items:center;
    justify-content:center;
    min-height:100vh;
    padding:20px;
    user-select:none;
}

.back-btn{
    position:fixed;
    top:20px;
    left:20px;
    z-index:100;
}

.back-btn a{
    text-decoration:none;
    padding:8px 18px;
    border-radius:25px;
    background:white;
    color:#1e3a8a;
    font-weight:600;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
    font-size:14px;
}

.progress{
    margin-bottom:20px;
    font-size:18px;
    color:#1e3a8a;
    font-weight:600;
}

/* Progress bar */
.progress-bar-wrap{
    width:min(500px, 85vw);
    height:6px;
    background:#bfdbfe;
    border-radius:10px;
    margin-bottom:25px;
    overflow:hidden;
}
.progress-bar-fill{
    height:100%;
    background:#3b82f6;
    border-radius:10px;
    transition:width 0.3s;
}

.card-container{
    perspective:1500px;
    width:min(600px, 92vw);
}

.card{
    width:100%;
    height:min(380px, 60vw, 400px);
    min-height:260px;
    position:relative;
    transform-style:preserve-3d;
    transition:transform 0.5s cubic-bezier(.4,2,.6,1), left 0.1s;
    cursor:pointer;
}

.card.flip{
    transform:rotateY(180deg);
}

/* Swipe animation */
.card.swipe-left{
    animation:swipeLeft 0.3s forwards;
}
.card.swipe-right{
    animation:swipeRight 0.3s forwards;
}

@keyframes swipeLeft{
    to{transform:translateX(-120%) rotateZ(-10deg);opacity:0;}
}
@keyframes swipeRight{
    to{transform:translateX(120%) rotateZ(10deg);opacity:0;}
}

.card-face{
    position:absolute;
    width:100%;
    height:100%;
    background:white;
    border-radius:24px;
    box-shadow:0 20px 50px rgba(0,0,0,0.12);
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    backface-visibility:hidden;
    padding:30px;
    text-align:center;
}

.front{
    font-size:clamp(28px, 6vw, 55px);
    font-weight:700;
    color:#1e3a8a;
}

.front .hint{
    font-size:13px;
    color:#94a3b8;
    margin-top:20px;
    font-weight:400;
}

.card-back{
    transform:rotateY(180deg);
}

.card-back .meaning{
    font-size:clamp(22px, 4.5vw, 42px);
    font-weight:600;
    margin-bottom:16px;
    color:#2563eb;
}

.card-back .example{
    font-size:clamp(14px, 2.5vw, 20px);
    color:#555;
    line-height:1.6;
}

.controls{
    margin-top:28px;
    display:flex;
    gap:14px;
    align-items:center;
    flex-wrap:wrap;
    justify-content:center;
}

button{
    padding:11px 28px;
    border:none;
    border-radius:25px;
    background:#3b82f6;
    color:white;
    font-weight:600;
    cursor:pointer;
    font-size:15px;
    box-shadow:0 4px 12px rgba(59,130,246,0.3);
    transition:background 0.2s, transform 0.1s;
}

button:active{transform:scale(0.96);}
button:hover{background:#2563eb;}

.hint-keys{
    margin-top:16px;
    font-size:13px;
    color:#64748b;
    text-align:center;
    line-height:1.8;
}

.hint-keys span{
    background:white;
    padding:2px 8px;
    border-radius:6px;
    font-weight:600;
    box-shadow:0 2px 6px rgba(0,0,0,0.1);
    margin:0 2px;
}

/* Swipe indicator */
.swipe-hint{
    position:absolute;
    top:50%;
    transform:translateY(-50%);
    font-size:40px;
    opacity:0;
    transition:opacity 0.2s;
    pointer-events:none;
}
.swipe-hint.left{right:20px;}
.swipe-hint.right{left:20px;}

@media(max-width:480px){
    .hint-keys{display:none;}
    .back-btn a{font-size:12px;padding:6px 12px;}
}
</style>
</head>

<body>

<div class="back-btn">
    <a href="vocabulary">← Back</a>
</div>

<div class="progress" id="progress">1 / <%= list.size() %></div>

<div class="progress-bar-wrap">
    <div class="progress-bar-fill" id="progressBar" style="width:<%= list.size() > 1 ? (100/list.size()) : 100 %>%"></div>
</div>

<div class="card-container">
    <div class="card" id="card" onclick="flipCard()">
        <div class="card-face front" id="front">
            <%= list.get(0).getWord() %>
            <div class="hint">Click to flip</div>
        </div>
        <div class="card-face card-back" id="back">
            <div class="meaning"><%= list.get(0).getMeaning() %></div>
            <div class="example"><%= list.get(0).getExample() == null ? "" : list.get(0).getExample() %></div>
        </div>
    </div>
</div>

<div class="controls">
    <button onclick="prev()">◀ Prev</button>
    <button onclick="next()">Next ▶</button>
</div>

<div class="hint-keys">
    <span>←</span><span>→</span> di chuyển &nbsp;|&nbsp; <span>Space</span> lật thẻ
</div>

<script>
let words = [];
<%
for (Vocabulary v : list) {
    String word    = v.getWord()    == null ? "" : v.getWord().replace("\\","\\\\").replace("\"","\\\"").replace("\n","").replace("\r","");
    String meaning = v.getMeaning() == null ? "" : v.getMeaning().replace("\\","\\\\").replace("\"","\\\"").replace("\n","").replace("\r","");
    String example = v.getExample() == null ? "" : v.getExample().replace("\\","\\\\").replace("\"","\\\"").replace("\n","").replace("\r","");
%>
words.push({word:"<%= word %>", meaning:"<%= meaning %>", example:"<%= example %>"});
<% } %>

let index = 0;
const card        = document.getElementById("card");
const frontEl     = document.getElementById("front");
const backEl      = document.getElementById("back");
const progressEl  = document.getElementById("progress");
const progressBar = document.getElementById("progressBar");

function updateCard(direction){
    // Swipe animation
    if(direction){
        card.classList.add(direction === 'next' ? 'swipe-left' : 'swipe-right');
        setTimeout(()=>{
            card.classList.remove('swipe-left','swipe-right','flip');
            setContent();
        }, 280);
    } else {
        setContent();
    }
}

function setContent(){
    const w = words[index];
    frontEl.innerHTML = w.word + '<div class="hint">Click / Space to flip</div>';
    backEl.innerHTML  = '<div class="meaning">'+w.meaning+'</div><div class="example">'+w.example+'</div>';
    progressEl.innerText = (index+1) + " / " + words.length;
    progressBar.style.width = ((index+1)/words.length*100) + "%";
}

function flipCard(){
    card.classList.toggle("flip");
}

function next(){
    index = (index+1) % words.length;
    updateCard('next');
}

function prev(){
    index = (index-1+words.length) % words.length;
    updateCard('prev');
}

// ⌨️ Keyboard
document.addEventListener("keydown", e => {
    if(e.key === "ArrowRight") next();
    else if(e.key === "ArrowLeft") prev();
    else if(e.key === " "){ e.preventDefault(); flipCard(); }
});

// 👆 Touch swipe
let touchStartX = 0;
let touchStartY = 0;

card.addEventListener("touchstart", e => {
    touchStartX = e.touches[0].clientX;
    touchStartY = e.touches[0].clientY;
}, {passive:true});

card.addEventListener("touchend", e => {
    const dx = e.changedTouches[0].clientX - touchStartX;
    const dy = e.changedTouches[0].clientY - touchStartY;

    // Chỉ xử lý swipe ngang, bỏ qua scroll dọc
    if(Math.abs(dx) > Math.abs(dy) && Math.abs(dx) > 50){
        if(dx < 0) next();
        else prev();
    } else if(Math.abs(dx) < 10 && Math.abs(dy) < 10){
        flipCard(); // tap nhẹ = lật
    }
});
</script>

</body>
</html>
