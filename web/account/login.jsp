<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>登录页面</title>
</head>
<body>
<h1>
    <% if (request.getParameter("jump") != null) { %>
        [jsp:forward跳转标识]
    <% } %>
</h1>
<form action="login.jsp" method="post" name="form" id="form">
    用户名：<input type="text" name="username" id="username"><br>
    密码：<input type="text" name="password" id="password"><br>
    <input type="submit" name="login" id="login" value="登录"><br>
</form>

<p>
    注：使用注册页面注册的用户(仅保留近期一个用户)进行登录，<br>
    或使用<br>
    用户名：pox<br>
    密码：123456<br>
    进行登录。
</p>
<%
    if (request.getMethod().equals("POST")) {
        boolean flag = true;
        String name = request.getParameter("username");
        String pswd = request.getParameter("password");
        if ((name == null || pswd == null) ||
                !(name.equals("pox") && pswd.equals("123456")
                || name.equals(session.getAttribute("username"))
                && pswd.equals(session.getAttribute("password")))) {
            flag = false;
        }
        if (flag) {
            response.sendRedirect("success.jsp");
        }  else {
            response.sendRedirect("failure.jsp");
        }
    }
%>
</body>
</html>
