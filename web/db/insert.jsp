<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>数据库插入页面</title>
</head>

<jsp:useBean id="db" class="bean.Database" scope="application"/>

<%!
    private String num = "";
    private String name = "";
    private String date = "";
    private String price= "";
    private String errorMsg = "";

    private String checkData() {
        String re = "";
        Matcher matcher;
        matcher = Pattern.compile("[0-9]*").matcher(num);
        if (!matcher.matches()) {
            re += "num必须为数字<br>";
        }
        matcher = Pattern.compile("[0-9]*-[0-9]*-[0-9]*").matcher(date);
        if (!matcher.matches()) {
            re += "日期格式不正确<br>" + date;
        }
        matcher = Pattern.compile("[0-9]*.?[0-9]*").matcher(price);
        if (!matcher.matches()) {
            re += "价格格式不正确<br>";
        }
        return re;
    }
%>

<%
    if (request.getMethod().equals("POST")) {
        num = request.getParameter("num");
        name = request.getParameter("name");
        date = request.getParameter("date");
        price = request.getParameter("price");
        errorMsg = checkData();
        if (errorMsg.equals("")) {
            ResultSet rs;
            try {
                rs = db.executeSelect("select count(*) from product where num=" + num);
                rs.next();
                if (rs.getInt(1) == 0) {
                    db.executeUpdate("insert into product values(" + num + ", '" + name + "', '" + date + "', " + price + ")");
                    rs = db.executeSelect("select count(*) from product where num=" + num);
                    rs.next();
                    if (rs.getInt(1) == 1) {
                        out.println("<script>alert('添加数据成功！');</script>");
                    } else {
                        throw new Exception("未知错误，请前往控制台查看");
                    }
                } else {
                    errorMsg += "已存在编号为" + num + "的产品<br>";
                }
            } catch (Exception e) {
                errorMsg += "数据库异常：" + e.getMessage() + "<br>";
            }
        }
    }
%>

<body>
<div class="errorMsg" id="errorMsg" style="color: red"><%= errorMsg %></div>
<form action="insert.jsp" method="post" name="form" id="form">
    产品编号：<input type="number" name="num" id="num" value="<%= num %>"><br>
    产品名：<input type="text" name="name" id="name" value="<%= name %>"><br>
    生产日期：<input type="date" name="date" id="date" value="<%= date %>"><br>
    价格：<input type="text" name="price" id="price" value="<%= price %>"><br>
    <input type="submit" value="插入">
</form>
</body>
</html>
