
<%@page contentType="text/html" pageEncoding="UTF-8"

        import="org.apache.spark.sql.SparkSession,
        org.apache.spark.sql.*,
        java.io.*,
        scala.tools.nsc.GenericRunnerSettings,
        com.elookinto.spark.jweb.*"

        %>

<html>

    <body>
        <% String sql = request.getParameter("sql");
            if (sql == null || sql.trim().length() == 0) {
                sql = "select 3 as dummy";
            }
        %>




        <%
            SparkSession sparkSession = SparkLocalServlet.sparkSession.newSession();
            PrintStream ps = new PrintStream(response.getOutputStream());
            PrintStream stdout = System.out;
            
            System.setOut(ps);
            ps.append("<form> Sample: <input name='sql' value='" + sql + "' /> <input type='Submit'  /> </form>");
            ps.append(sql + "</br>");
            ps.print("<pre>");
            sparkSession.sql(sql).show();
            ps.print("</pre>");
            System.setOut(stdout);
        %>

    </body>
</html>