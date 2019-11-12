<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8"%>

<html>
<head>
    <meta content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <title>并不存在的图书馆</title>
</head>

<jsp:useBean id="db" class="bean.Database" scope="application"/>

<body>
<%
    String username = "";
    String error_text = "";
    String login_type;
    if (request.getMethod().equals("POST")) {
        if (request.getParameter("submit_reg") != null) {
            response.sendRedirect("user_new.jsp");
        }
        username = request.getParameter("input_username");
        if (request.getParameter("input_username").isEmpty() || request.getParameter("input_password").isEmpty())
            error_text = "用户名或密码不能为空";
        else {
            if (request.getParameter("submit_user") == null)
                login_type = "admin";
            else
                login_type = "user";
            String sql = "select * from " + login_type + " where name = '" + request.getParameter("input_username") +
            "' and password = '" + request.getParameter("input_password") + "'";
            ResultSet result = db.executeSelect(sql);
            try {
                if (!result.next())
                    error_text = "用户名或密码错误";
                else {
                    session.setAttribute(login_type, result.getInt(1));
                    response.sendRedirect(login_type + ".jsp");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        out.write("<script type=\"text/javascript\">alert(\"" + error_text + "\");</script>");
    }
%>

<div class="container">
    <div class="div_form">
        <form method="post" action="">
            <fieldset>
                <legend>登录</legend>
                <div class="item">
                    <label for="input_username">用户名:</label>
                    <input type="text" name="input_username" id="input_username" value="<%= username %>">
                </div>
                <div class="item">
                    <label for="input_password">密码:</label>
                    <input type="password" name="input_password" id="input_password">
                </div>
            </fieldset>
            <div class="item">
                <input type="submit" name="submit_reg" value="用户注册">
                <input type="submit" name="submit_admin" value="管理员登录">
                <input type="submit" name="submit_user" value="用户登录">
            </div>
        </form>
    </div>
</div>
</body>
</html>