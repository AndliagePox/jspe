<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <title>并不存在的图书馆 | 编辑图书信息</title>
</head>

<jsp:useBean id="db" class="bean.Database" scope="application"/>

<body>
<%
    request.setCharacterEncoding("utf-8");
    String sql;
    String bid = request.getParameter("bid");
    String name = "";
    String reper = "";
    String gross = "";
    ResultSet book;
    try {
        sql = "select * from book where bid = " + bid;
        book = db.executeSelect(sql);
        book.next();
        name = book.getString("name");
        reper = book.getString("reper");
        gross = book.getString("gross");
    } catch (SQLException e) {
        e.printStackTrace();
    }
    if (session.getAttribute("admin") != null) {
        if (request.getMethod().equals("POST")) {
            name = request.getParameter("input_name");
            reper = request.getParameter("input_reper");
            gross = request.getParameter("input_gross");
            if (bid.equals("0")) {
                sql = "insert into book (name, reper, gross) values ('" + name + "', " + reper + ", " + gross + ")";
            } else {
                sql = "update book set name = '" + name + "', reper = " + reper + ", gross = " + gross + " where bid = " + bid;
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
                <legend>图书信息</legend>
                <div class="item">
                    <label for="input_name">书名:</label>
                    <input type="text" name="input_name" id="input_name" value="<%= name %>">
                </div>
                <div class="item">
                    <label for="input_reper">库存:</label>
                    <input type="number" name="input_reper" id="input_reper" value="<%= reper %>">
                </div>
                <div class="item">
                    <label for="input_gross">总量:</label>
                    <input type="number" name="input_gross" id="input_gross" value="<%= gross %>">
                </div>
            </fieldset>
            <div class="item">
                <input type="submit" name="submit" value="提交修改">
            </div>
            <input type="hidden" name="bid" value="<%= bid %>">
        </form>
    </div>
</div>
</body>
