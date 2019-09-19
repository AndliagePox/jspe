<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>登录失败页面</title>
    <meta http-equiv="refresh" content="5;url=login.jsp">
</head>
<body>
<h1>
    我是登录失败页面。
</h1>
<div class="jump" id="jump" style="color: red">将在 5s 后跳转到登录页面</div>

<script>
    var time = 5;
    setInterval(function () {
        time--;
        document.getElementById("jump").innerText = "将在 " + time + "s 后跳转到登录页面";
    }, 1000)
</script>
</body>
</html>
