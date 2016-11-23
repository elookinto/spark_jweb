<%-- 
    Document   : index
    Created on : Nov 23, 2016, 11:17:56 AM
    Author     : zw251y
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="java.io.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Index</title>
    </head>
    <body>
        <%
            File jsp = new File(request.getSession().getServletContext().getRealPath(request.getServletPath()));
            File dir = jsp.getParentFile();
            File[] list = dir.listFiles();
            for (File f : list) {
                if (f.getName().endsWith(".jsp")) {
                    out.print("<a href='" + f.getName() + "' >" + f.getName() + "</a> <br/>");
                }
            }

        %>
    </body>
</html>
