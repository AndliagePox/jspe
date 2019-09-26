<%@ page contentType="text/html;charset=UTF-8"%>
<html lang="zh">
<head>
    <title>注册(验证页面)</title>
    <script type="text/javascript" src="/js/register.js" charset="UTF-8"></script>
</head>

<%
    request.setCharacterEncoding("utf-8");
    int lab;
    try {
        lab = Integer.parseInt(request.getParameter("lab"));
    } catch (Exception e) {
        lab = Integer.MAX_VALUE;
    }
%>
<jsp:useBean id="user" class="bean.User" scope="session"/>
<jsp:useBean id="convert" class="bean.Convert"/>
<jsp:setProperty name="user" property="*"/>

<body>
<div class="errorMsg" id="errorMsg" style="color: red"></div>
<form action="register.jsp" method="post" name="form" id="form">
    <input type="hidden" name="lab" id="lab" value="<%= lab %>">
    用户名：<input type="text" name="username" id="username"><br>
    密码：<input type="text" name="password" id="password"><br>
    确认密码：<input type="text" name="confirm" id="confirm"><br>
    邮箱：<input type="text" name="email" id="email"><br>
    身份证：<input type="text" name="idCard" id="idCard"><br>
    <% if (lab >= 5) { %>
    淼哥不让我写那个有趣的复选，你猜为啥：<br>
    <input type="checkbox" name="questions" id="questions" value="他太菜了"> 他太菜了<br>
    <input type="checkbox" name="questions" id="questions" value="他女朋友太多了"> 他女朋友太多了<br>
    <input type="checkbox" name="questions" id="questions" value="整个宿舍就他有对象"> 整个宿舍就他有对象<br>
    <br>
    <% } %>
    <input type="button" name="check" id="check" onclick="checkForm()" value="检查所有输入">
    <% if (lab > 2) { %>
    <input type="button" name="re" id="re" onclick="register()" value="注册">
    <%
    }
    if (lab >= 5) {
    %>
    <input type="button" name="login" id="login" onclick="window.location.href='login.jsp'" value="前往登录页面">
    <% } %>
</form>
<br>
<%
    if (request.getMethod().equals("POST")) {
        session.setAttribute("username", request.getParameter("username"));
        session.setAttribute("password", request.getParameter("password"));
        out.write("<script>alert('注册成功！');</script>");
        if (lab == 4)
            response.sendRedirect("login.jsp");
        if (lab >= 5) {
%>
<hr>通过JavaBean保存的注册信息：
<p>
    用户名： <%= user.getUsername() %>
    <br>密码： <%= user.getPassword() %>
    <br>邮箱： <%= user.getEmail() %>
    <br>身份证： <%= user.getIdCard() %>
    <br>选择的选项： <%= convert.arr2Str(user.getQuestions()) %>
</p>
<%
            user.setQuestions(null);
        }
    }
%>

<% if (request.getParameter("jump") != null) { %>
    <jsp:forward page="login.jsp">
        <jsp:param name="jump" value="1"/>
    </jsp:forward>
<% } %>
</body>
</html>