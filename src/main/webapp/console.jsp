
<%@page contentType="text/html" pageEncoding="UTF-8"

        import="org.apache.spark.sql.SparkSession,
        org.apache.spark.sql.*,
        java.io.*,
        scala.tools.nsc.GenericRunnerSettings,
        com.elookinto.spark.web.*"
        
        %>

<%
     SparkSession sparkSession = SparkServlet.sparkSession;
      GenericRunnerSettings s= new GenericRunnerSettings( System.out ); 
    
%>