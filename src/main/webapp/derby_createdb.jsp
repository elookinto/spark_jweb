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
        <title>Create dummy DB </title>
    </head>
    <body>
        <h1>Create some dummy DB: create table t1 (a timestamp).  </h1>
        <h1>  insert into t1 values (current_timestamp) </h1>
        <%
            String driver = "org.apache.derby.jdbc.EmbeddedDriver";

            Class.forName(driver)
                    .newInstance();

            String protocol = "jdbc:derby:";
            Connection conn = DriverManager.getConnection(protocol + "derbyDB;create=true");
            try {
                conn.createStatement().execute("create table t1 (a timestamp)  ");
            } catch (java.sql.SQLException e) {
                //In case it exists....
            }
            conn.createStatement().execute("insert into t1 values (current_timestamp)");
            ResultSet rs = conn.createStatement().executeQuery("select a from t1 order by a desc FETCH NEXT 10 ROWS ONLY");
            while (rs.next()) {
                out.println(rs.getTimestamp(1) + "<br/>");
            }
            //DriverManager.getConnection("jdbc:derby:derbyDB;shutdown=true");
        %>
    </body>
</html>
