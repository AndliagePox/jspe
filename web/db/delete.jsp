<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>数据库删除页面</title>
</head>

<jsp:useBean id="db" class="bean.Database" scope="application"/>

<%!
    private String num = "";
    private String errorMsg = "";

    private String checkData() {
        String re = "";
        Matcher matcher;
        matcher = Pattern.compile("[0-9]*").matcher(num);
        if (!matcher.matches()) {
            re += "num必须为数字<br>";
        }
        return re;
    }
%>

<%
    if (request.getMethod().equals("POST")) {
        num = request.getParameter("num");
        errorMsg = checkData();
        if (errorMsg.equals("")) {
            ResultSet rs;
            try {
                rs = db.executeSelect("select count(*) from product where num=" + num);
                rs.next();
                if (rs.getInt(1) != 0) {
                    db.executeUpdate("delete from product where num=" + num);
                    rs = db.executeSelect("select count(*) from product where num=" + num);
                    rs.next();
                    if (rs.getInt(1) == 0) {
                        out.println("<script>alert('删除数据成功！');</script>");
                    } else {
                        throw new Exception("未知错误，请前往控制台查看");
                    }
                } else {
                    errorMsg += "不存在编号为" + num + "的产品<br>";
                }
            } catch (Exception e) {
                errorMsg += "数据库异常：" + e.getMessage() + "<br>";
            }
        }
    }
%>

<body>
<div class="errorMsg" id="errorMsg" style="color: red"><%= errorMsg %></div>
<form action="delete.jsp" method="post" name="form" id="form">
    产品编号：<input type="number" name="num" id="num" value="<%= num %>"><br>
    <input type="submit" value="删除">
</form>
</body>
</html>
