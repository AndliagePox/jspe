<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <title>并不存在的图书馆 | 用户页</title>
</head>

<jsp:useBean id="db" class="bean.Database" scope="application"/>

<body>
<%
    String sql;
    ResultSet user = null;
    ResultSet result;
    if (session.getAttribute("user") != null) {
        sql = "select * from user where uid = " + session.getAttribute("user");
        user = db.executeSelect(sql);
        try {
            user.next();
            out.write("<div class=\"welcome\">欢迎用户： <b>" + user.getString("name") + "</b></div>");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("index.jsp");
    }
%>

<hr>
<div class="table_title">
    当前借阅的书籍
</div>
<table class="table_center">
    <tr>
        <th>书名</th>
        <th>操作</th>
    </tr>
    <tr>
        <%
            try {
                if (user == null) {
                    return;
                }
                int hold = user.getInt("hold");
                if (hold == 0) {
                    out.write("<td colspan=\"2\">暂未借书</td>");
                } else {
                    sql = "select name from book where bid = " + hold;
                    result = db.executeSelect(sql);
                    result.next();
                    out.write("<td>" + result.getString("name") + "</td>");
                    out.write("<td><a href=\"return.jsp?bid=" + hold + "\">归还</a></td>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </tr>
</table>
<hr>
<div class="table_title">
    馆藏书籍信息
</div>
<table class="table_center">
    <tr>
        <th>书名</th>
        <th>库存</th>
        <th>总量</th>
        <th>操作</th>
    </tr>
    <%
        sql = "select * from book where bid <> 0 and gross <> 0";
        result = db.executeSelect(sql);
        try {
            while (result.next()) {
    %>
    <tr>
        <td><%= result.getString("name") %>
        </td>
        <td><%= result.getInt("reper") %>
        </td>
        <td><%= result.getInt("gross") %>
        </td>
        <td>
            <%
                if (user.getInt("hold") != 0 || result.getInt("reper") == 0) {
                    out.write("暂不可借阅");
                } else {
                    out.write("<a href=\"borrow.jsp?bid=" + result.getInt("bid") + "\">借阅</a>");
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
