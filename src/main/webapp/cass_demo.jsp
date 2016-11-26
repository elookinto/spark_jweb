<%-- 
    Document   : test
    Created on : Oct 13, 2016, 11:34:06 AM
    Author     : Paul Z. Wu <zhou.wu@att.com>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"

        import="org.apache.spark.sql.spark,
        org.apache.spark.sql.*,
        java.io.*,
        com.elookinto.spark.jweb.*"
        %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cassandra Demo</title>
    </head>
    <body>
        <h1>Cassandra Demo!</h1>
         Do....
        <pre>
        
            cqlsh> CREATE KEYSPACE test WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
            cqlsh> create table test.cass_test (id int primary key, s text);
            cqlsh> insert into test.cass_test (id, s)  values (1, 'test');

        </pre>
        <%

            spark spark = SparkLocalServlet.spark;
            spark.read().format("org.apache.spark.sql.cassandra")
                    .option("keyspace", "test")
                    .option("table", "cass_test")
                    .load()
                    .createOrReplaceTempView("cass_test");

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            //System.setErr(new PrintStream(baos));
            //jdbcDF.foreach(r->{ out.println(r.getInt(0));});
            java.util.List<Row> list = spark.sql("select * from cass_test").collectAsList();
            for (Row r : list) {
                out.print(r.get(0) + " " + r.get(1) + "<br/>");
            }

            out.println(baos);
            //out.println("nice "  + ds.first().get(0));

        %>
    </body>
</html>
