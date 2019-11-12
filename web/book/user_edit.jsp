<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <meta content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <title>并不存在的图书馆 | 编辑用户信息</title>
</head>

<jsp:useBean id="db" class="bean.Database" scope="application"/>

<body>
<%
    request.setCharacterEncoding("utf-8");
    String sql;
    String uid = request.getParameter("uid");
    String name = "";
    String password;
    ResultSet user;
    try {
        sql = "select * from user where uid = " + uid;
        user = db.executeSelect(sql);
        user.next();
        name = user.getString("name");
    } catch (SQLException e) {
        e.printStackTrace();
    }
    if (session.getAttribute("admin") != null) {
        if (request.getMethod().equals("POST")) {
            name = request.getParameter("input_name");
            password = request.getParameter("input_new_pswd");
            if (password.isEmpty()) {
                sql = "update user set name = '" + name + "'" + " where uid = " + uid;
            } else {
                sql = "update user set name = '" + name + "', password = '" + password + "' where uid = " + uid;
            }
            db.executeUpdate(sql);
            response.sendRedirect("admin.jsp");
        }
    } else {
        response.sendRedirect("index.jsp");
    }

%>

<div class="container">
    <div class="div_form">
        <form method="post" action="">
            <fieldset>
                <legend>用户信息</legend>
                <div class="item">
                    <label for="input_name">用户名:</label>
                    <input type="text" id="input_name" name="input_name" value="<%= name %>">
                </div>
            </fieldset>
            <fieldset>
                <legend>重置密码(如无需重置请勿填写)</legend>
                <div class="item">
                    <label for="input_new_pswd">新密码:</label>
                    <input type="password" name="input_new_pswd" id="input_new_pswd">
                </div>
            </fieldset>
            <div class="item">
                <input type="submit" name="submit" value="提交修改">
            </div>
            <input type="hidden" name="uid" value="<%= uid %>">
        </form>
    </div>
</div>
</body>
