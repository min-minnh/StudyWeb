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
<title>Study Mode</title>

<style>
body{
    margin:0;
    font-family:'Segoe UI',Arial,sans-serif;
    background:linear-gradient(135deg,#dbeafe,#bfdbfe);
    display:flex;
    flex-direction:column;
    align-items:center;
    justify-content:center;
    height:100vh;
}

.back-btn{
    position:absolute;
    top:30px;
    left:40px;
}

.back-btn a{
    text-decoration:none;
    padding:8px 18px;
    border-radius:25px;
    background:white;
    color:#1e3a8a;
    font-weight:600;
    box-shadow:0 8px 20px rgba(0,0,0,0.1);
}

.progress{
    margin-bottom:30px;
    font-size:18px;
    color:#1e3a8a;
    font-weight:600;
}

.card-container{
    perspective:1500px;
}

.card{
    width:900px;
    max-width:90vw;
    height:450px;
    position:relative;
    transform-style:preserve-3d;
    transition:transform 0.6s;
    cursor:pointer;
}

.card.flip{
    transform:rotateY(180deg);
}

.card-face{
    position:absolute;
    width:90%;
    height:70%;
    background:white;
    border-radius:25px;
    box-shadow:0 25px 50px rgba(0,0,0,0.15);
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    backface-visibility:hidden;
    padding:50px;
    text-align:center;
}

.front{
    font-size:55px;
    font-weight:700;
    color:#1e3a8a;
}

.card-back{
    transform:rotateY(180deg);
}

.card-back .meaning{
    font-size:42px;
    font-weight:600;
    margin-bottom:20px;
    color:#2563eb;
}

.card-back .example{
    font-size:20px;
    color:#555;
}

.controls{
    margin-top:40px;
}

button{
    padding:10px 26px;
    margin:0 10px;
    border:none;
    border-radius:25px;
    background:#3b82f6;
    color:white;
    font-weight:600;
    cursor:pointer;
}
</style>
</head>

<body>

<div class="back-btn">
<a href="vocabulary">← Back to Topics</a>
</div>

<div class="progress" id="progress">
1 / <%= list.size() %>
</div>

<div class="card-container">
<div class="card" id="card" onclick="flipCard()">

<div class="card-face front" id="front">
<%= list.get(0).getWord() %>
</div>

<div class="card-face card-back" id="back">
<div class="meaning">
<%= list.get(0).getMeaning() %>
</div>
<div class="example">
<%= list.get(0).getExample() == null ? "" : list.get(0).getExample() %>
</div>
</div>

</div>
</div>

<div class="controls">
<button onclick="prev()">Prev</button>
<button onclick="next()">Next</button>
</div>

<script>
let words = [];
<%
for (Vocabulary v : list) {

    String word = v.getWord() == null ? "" :
        v.getWord().replace("\\", "\\\\").replace("\"","\\\"");

    String meaning = v.getMeaning() == null ? "" :
        v.getMeaning().replace("\\", "\\\\").replace("\"","\\\"");

    String example = v.getExample() == null ? "" :
        v.getExample().replace("\\", "\\\\").replace("\"","\\\"");
%>
words.push({
    word: "<%= word %>",
    meaning: "<%= meaning %>",
    example: "<%= example %>"
});
<%
}
%>

let index = 0;
let card = document.getElementById("card");

function flipCard(){
    card.classList.toggle("flip");
}

function updateCard(){
    card.classList.remove("flip");
    document.getElementById("front").innerText = words[index].word;
    document.getElementById("back").innerHTML =
        '<div class="meaning">'+words[index].meaning+'</div>' +
        '<div class="example">'+words[index].example+'</div>';
    document.getElementById("progress").innerText =
        (index+1) + " / " + words.length;
}

function next(){
    index++;
    if(index >= words.length) index = 0;
    updateCard();
}

function prev(){
    index--;
    if(index < 0) index = words.length - 1;
    updateCard();
}
</script>

</body>
</html>