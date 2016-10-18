<%-- 
    Document   : derby
    Created on : Oct 16, 2016, 12:11:56 PM
    Author     : Paul Z. Wu <zhou.wu@att.com>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import = "java.sql.*" 
        %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            String driver = "org.apache.derby.jdbc.EmbeddedDriver";

            Class.forName(driver)
                    .newInstance();
            
              String protocol = "jdbc:derby:";
              Connection conn = DriverManager.getConnection(protocol + "derbyDB;create=true");
              //conn.createStatement().execute("create table t1 (a int) if not exsits ");
              conn.createStatement().execute("insert into t1 values (2)");
              ResultSet rs = conn.createStatement().executeQuery("select a from t1");
              while(rs.next()) {
                  out.println(rs.getInt(1));
              }
              //DriverManager.getConnection("jdbc:derby:derbyDB;shutdown=true");
        %>
    </body>
</html>
