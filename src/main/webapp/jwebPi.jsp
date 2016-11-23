<%-- 
    Document   : jwebPi
    Created on : Nov 22, 2016, 11:50:00 AM
    Author     : zw251y
--%>

<%@page import="com.elookinto.spark.jweb.SparkServlet"%>
<%@page import="com.elookinto.spark.jweb.JavaSparkPi"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% String sample = request.getParameter("sample");
         if (sample==null || sample.trim().length() ==0)
             sample = "2";
         %>
        <form>
            
            Sample: <input name="sample" value="<%=sample%>" />
            <input type="Submit"  />
        </form>
        <h1> Spark PI is: pi is roughly <%= JavaSparkPi.getPi(new String[]{}, SparkServlet.sparkSession) %> </h1>
        <form>
            
        </form>
    </body>
</html>
