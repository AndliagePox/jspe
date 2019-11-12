<%@ page contentType="text/html;charset=UTF-8" %>

<jsp:useBean id="db" class="bean.Database" scope="application"/>

<%
    String sql;
    if (session.getAttribute("user") != null) {
        String bid = request.getParameter("bid");
        sql = "update book set reper = reper + 1 where bid = " + bid;
        db.executeUpdate(sql);
        sql = "update user set hold = 0 where uid = " + session.getAttribute("user");
        db.executeUpdate(sql);
        response.sendRedirect("user.jsp");
    } else {
        response.sendRedirect("index.jsp");
    }
%>
