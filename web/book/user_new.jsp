<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <meta content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <title>并不存在的图书馆 | 用户注册</title>
</head>

<jsp:useBean id="db" class="bean.Database" scope="application"/>

<body>
<%
    request.setCharacterEncoding("utf-8");
    String sql;
    String name;
    String password;
    if (request.getMethod().equals("POST")) {
        name = request.getParameter("input_name");
        password = request.getParameter("input_new_pswd");
        sql = "insert into user(name, password, hold) values('" + name + "', '" + password + "', 0)";
        db.executeUpdate(sql);
        response.sendRedirect("index.jsp");
    }
%>

<div class="container">
    <div class="div_form">
        <form method="post" action="">
            <fieldset>
                <legend>用户注册</legend>
                <div class="item">
                    <label for="input_name">用户名:</label>
                    <input type="text" id="input_name" name="input_name" value="">
                </div>
                <div class="item">
                    <label for="input_new_pswd">新密码:</label>
                    <input type="password" name="input_new_pswd" id="input_new_pswd">
                </div>
            </fieldset>
            <div class="item">
                <input type="submit" name="submit" value="注册">
            </div>
        </form>
    </div>
</div>
</body>

