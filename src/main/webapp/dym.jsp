
<%
    
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
            
%>