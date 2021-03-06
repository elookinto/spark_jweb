<%-- 
    Document   : test
    Created on : Oct 13, 2016, 11:34:06 AM
    Author     : Paul Z. Wu <zhou.wu@att.com>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"

        import="
        org.apache.spark.sql.*,
        java.io.*,
        com.elookinto.spark.jweb.*"
        %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Derby Spark Query demo </title>
    </head>
    <body>
        <h1>Spark Derby Demo</h1>
        <%
            out.println(this.getServletContext().getAttribute("now"));
            out.println("====<br/>");
            SparkSession spark = SparkSessionPool.POOL.borrowObject();
            try {
                final java.util.Properties connectionProperties = new java.util.Properties();

                final String dbTable = "t1";
                String _CONNECTION_URL = "jdbc:derby:derbyDB";
                String driver = "org.apache.derby.jdbc.EmbeddedDriver";

                Class.forName(driver)
                        .newInstance();
                Dataset<Row> jdbcDF
                        = spark.read()
                                .jdbc(_CONNECTION_URL, dbTable, connectionProperties);
                jdbcDF.createOrReplaceTempView("t1");
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                //System.setErr(new PrintStream(baos));
                //jdbcDF.foreach(r->{ out.println(r.getInt(0));});
                java.util.List<Row> list = jdbcDF.collectAsList();

                for (int i = 0; i < Math.min(10, list.size()); i++) {
                    out.print(list.get(i).get(0) + "<br/>");
                }
                jdbcDF.show();
                out.println(baos);
            } finally {
                SparkSessionPool.POOL.returnObject(spark);
            }
            //out.println("nice "  + ds.first().get(0));

        %>
    </body>
</html>
