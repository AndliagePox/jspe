<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>数据展示页面</title>
    <style>
        table { border: solid 2px black; }
        table td { border: solid 1px black; text-align: center;}
    </style>
</head>

<jsp:useBean id="db" class="bean.Database" scope="application"/>

<%!
    private static final int PAGE_ITEM_COUNT = 5;
%>

<%
    int i;
    int curPageTest;
    int curPageProduct;
    int maxPageTest;
    int maxPageProduct;
    try {
        curPageTest = Integer.parseInt(request.getParameter("curPageTest"));
        curPageProduct = Integer.parseInt(request.getParameter("curPageProduct"));
    } catch (Exception e) {
        curPageTest = 1;
        curPageProduct = 1;
    }
    ResultSet rs;
    try {
        rs = db.executeSelect("select count(*) from test");
        rs.next();
        maxPageTest = rs.getInt(1) / PAGE_ITEM_COUNT + 1;
        rs = db.executeSelect("select count(*) from product");
        rs.next();
        maxPageProduct = rs.getInt(1) / PAGE_ITEM_COUNT + 1;
    } catch (Exception e) {
        maxPageTest = 1;
        maxPageProduct = 1;
        out.print(e.getMessage());
    }
%>

<body>
<h2>数据库数据展示页面</h2>
本页面展示数据库中(本项目相关)的所有数据。<br>
(所以，这个效果即测试数据库连接，又包含了查询，nice)
<hr>
表：test<br>
表结构：<br>
<table>
    <tr><td>字段名</td><td>数据类型</td><td>描述</td></tr>
    <tr><td>id</td><td>int</td><td>id值(没啥用，测试的)</td></tr>
</table>
数据展示：<br>
<table>
    <tr><td>id</td></tr>
<%
    try {
        rs = db.executeSelect("select * from test limit " + (curPageTest - 1) * PAGE_ITEM_COUNT + ", " + PAGE_ITEM_COUNT);
        while (rs.next()) {
            out.println("<tr><td>" + rs.getInt("id") + "</td></tr>");
        }
    } catch (SQLException e) {
        out.print(e.getMessage());
    }
%>
</table>
当前显示第<%= curPageTest %>页 共<%= maxPageTest %>页 跳转其他页：
<%
    for (i = 1; i <= maxPageTest; i++) {
        if (i != curPageTest) {
            out.println("<a href='data.jsp?curPageTest=" + i + "&curPageProduct=" + curPageProduct + "'>" + i + "</a> ");
        }
    }
%>

<br><hr>
表：product<br>
表结构：<br>
<table>
    <tr><td>字段名</td><td>数据类型</td><td>描述</td></tr>
    <tr><td>num</td><td>int</td><td>产品编号，主键</td></tr>
    <tr><td>name</td><td>varchar(64)</td><td>产品名称</td></tr>
    <tr><td>madeTime</td><td>datetime</td><td>产品生产日期</td></tr>
    <tr><td>price</td><td>float</td><td>产品价格</td></tr>
</table>
数据展示：<br>
<table>
    <tr><td>num</td><td>name</td><td>madeTime</td><td>price</td></tr>
    <%
        try {
            rs = db.executeSelect("select * from product limit " + (curPageProduct - 1) * PAGE_ITEM_COUNT + ", " + PAGE_ITEM_COUNT);
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("num") + "</td>");
                out.println("<td>" + rs.getString("name") + "</td>");
                out.println("<td>" + rs.getString("madeTime") + "</td>");
                out.println("<td>" + rs.getFloat("price") + "</td>");
                out.println("</tr>");
            }
        } catch (SQLException e) {
            out.print(e.getMessage());
        }
    %>
</table>
当前显示第<%= curPageProduct %>页 共<%= maxPageProduct %>页 跳转其他页：
<%
    for (i = 1; i <= maxPageProduct; i++) {
        if (i != curPageProduct) {
            out.println("<a href='data.jsp?curPageTest=" + curPageTest + "&curPageProduct=" + i + "'>" + i + "</a> ");
        }
    }
%>
</body>
</html>
