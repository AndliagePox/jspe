<%@ page contentType="text/html;charset=UTF-8" %>

<jsp:useBean id="db" class="bean.Database" scope="application"/>

<%
    String sql;
    if (session.getAttribute("admin") != null) {
        sql = "delete from user where uid = " + request.getParameter("uid");
        db.executeUpdate(sql);
        response.sendRedirect("admin.jsp");
    } else {
        response.sendRedirect("index.jsp");
    }
%>
