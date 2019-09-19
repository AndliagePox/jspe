<%@ page contentType="text/html;charset=UTF-8"%>
<html lang="zh">
<head>
    <title>注册(验证页面)</title>
    <script type="text/javascript" src="/js/register.js" charset="UTF-8"></script>
</head>
<body>
<%
    if (request.getMethod().equals("POST")) {
        session.setAttribute("username", request.getParameter("username"));
        session.setAttribute("password", request.getParameter("password"));
        response.sendRedirect("login.jsp");
    }
%>
<div class="errorMsg" id="errorMsg" style="color: red"></div>
<form action="register.jsp" method="post" name="form" id="form">
    用户名：<input type="text" name="username" id="username"><br>
    密码：<input type="text" name="password" id="password"><br>
    确认密码：<input type="text" name="confirm" id="confirm"><br>
    邮箱：<input type="text" name="email" id="email"><br>
    身份证：<input type="text" name="idCard" id="idCard"><br>
    <input type="button" name="check" id="check" onclick="checkForm()" value="检查所有输入">

    <%
        String lab = request.getParameter("lab");
        if (lab == null || !lab.equals("2")){
    %>
    <input type="button" name="re" id="re" onclick="register()" value="注册"><br>
    <% } %>
</form>
<% if (request.getParameter("jump") != null) { %>
    <jsp:forward page="login.jsp">
        <jsp:param name="jump" value="1"/>
    </jsp:forward>
<% } %>
</body>
</html>