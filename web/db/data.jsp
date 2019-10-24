<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>数据展示</title>
    <style>
        table { border: solid 2px black; }
        table td { border: solid 1px black; text-align: center;}
    </style>
</head>

<jsp:useBean id="db" class="bean.Database" scope="application"/>

<body>
<h2>数据库数据展示页面</h2>
本页面展示数据库中(本项目相关)的所有数据。<br>
(所以，这个效果即测试数据库连接，又包含了查询，nice)
<hr>
<p>表：test</p>
<table>
    <tr><td>id(int)</td></tr>
<%
    try {
        ResultSet rs = db.executeSQL("select * from test");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getInt("id") + "</td></tr>");
        }
    } catch (SQLException e) {
        out.print(e.getMessage());
    }
%>
</table>
</body>
</html>
