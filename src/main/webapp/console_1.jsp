
<%@page contentType="text/html" pageEncoding="UTF-8"

        import=" 
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
            
            
                 Main m = new Main();

        %>

    </body>
</html>