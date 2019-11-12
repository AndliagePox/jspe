<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <title>并不存在的图书馆 | 管理员页</title>
</head>

<jsp:useBean id="db" class="bean.Database" scope="application"/>

<body>
<%
    String sql;
    ResultSet admin;
    ResultSet result;
    if (session.getAttribute("admin") != null) {
        sql = "select * from admin where aid = " + session.getAttribute("admin");
        admin = db.executeSelect(sql);
        try {
            admin.next();
            out.write("<div class=\"welcome\">欢迎管理员： <b>" + admin.getString("name") + "</b></div>");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("index.jsp");
    }
%>

<hr>
<div class="table_title">
    快捷跳转
</div>
<div class="sgoto">
    <a href="#book">图书信息</a> /
    <a href="#user">用户信息</a>
</div>
<hr id="book">
<div class="table_title">
    图书信息
</div>
<table class="table_center">
    <tr>
        <th>book id</th>
        <th>书名</th>
        <th>库存</th>
        <th>总量</th>
        <th>操作</th>
    </tr>
    <%
        sql = "select * from book where bid <> 0";
        result = db.executeSelect(sql);
        try {
            while (result.next()) {
    %>
    <tr>
        <td>bid-<%= result.getInt("bid") %>
        </td>
        <td><%= result.getString("name") %>
        </td>
        <td><%= result.getInt("reper") %>
        </td>
        <td><%= result.getInt("gross") %>
        </td>
        <td>
            <a href="book_edit.jsp?bid=<%= result.getInt("bid") %>">修改信息</a>
        </td>
    </tr>
    <%
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
    <tr>
        <td colspan="7"><a href="book_edit.jsp?bid=0">添 加 新 的 图 书 条 目</a></td>
    </tr>
</table>

<hr id="user">
<div class="table_title">
    用户信息
</div>
<table class="table_center">
    <tr>
        <th>user id</th>
        <th>用户名</th>
        <th>持有书籍</th>
        <th>操作</th>
    </tr>
    <%
        sql = "select * from user where uid <> 0";
        result = db.executeSelect(sql);
        try {
            while (result.next()) {
    %>
    <tr>
        <td>uid-<%= result.getInt("uid") %>
        </td>
        <td><%= result.getString("name") %>
        </td>
        <td>
            <%
                int bid = result.getInt("hold");
                if (bid == 0)
                    out.write("无");
                else
                    out.write("bid-" + bid);
            %>
        </td>
        <td>
            <a href="user_edit.jsp?uid=<%= result.getInt("uid") %>">修改信息</a>
            <%
                if (bid == 0) {
                    out.write(" / <a href=\"user_rem.jsp?uid=" + result.getInt("uid") + "\">注销用户</a>");
                }
            %>
        </td>

    </tr>
    <%
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
</table>


</body>
</html>
