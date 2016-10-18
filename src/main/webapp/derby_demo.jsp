<%-- 
    Document   : test
    Created on : Oct 13, 2016, 11:34:06 AM
    Author     : Paul Z. Wu <zhou.wu@att.com>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"

        import="org.apache.spark.sql.SparkSession,
        org.apache.spark.sql.*,
        java.io.*,
        com.elookinto.spark.web.*"
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
            out.println(this.getServletContext().getAttribute("now"));
            out.println("====<br/>");
            SparkSession sparkSession = SparkServlet.sparkSession;
            final java.util.Properties connectionProperties = new java.util.Properties();

            final String dbTable = "t1";
            String _CONNECTION_URL = "jdbc:derby:derbyDB;create=true";

            String driver = "org.apache.derby.jdbc.EmbeddedDriver";

            Class.forName(driver)
                    .newInstance();
            Dataset<Row> jdbcDF
                    = sparkSession.read()
                    .jdbc(_CONNECTION_URL, dbTable, connectionProperties);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            //System.setErr(new PrintStream(baos));
            //jdbcDF.foreach(r->{ out.println(r.getInt(0));});
            java.util.List<Row> list = jdbcDF.collectAsList();
            for(Row r:list) {
                out.print(r.get(0) +"<br/>");
            }
            jdbcDF.show();
            out.println(baos);
            //out.println("nice "  + ds.first().get(0));

        %>
    </body>
</html>