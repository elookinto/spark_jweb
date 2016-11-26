
package com.elookinto.spark.jweb;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.jdbc.JdbcDialects;

/**
 *   
 *  Create the SparkSession for Yarn Client  with HortonWork installation
 * 
 *   classpath: $SPARK_HOME/jars/*:/usr/hdp/current/hadoop-client/conf:app.jar
 *   We may have to put the app.jar in the $SPARK_HOME/jars
 *   
 *   For reference:
 *   {@link  com.elookinto.spark.jweb.JavaSparkPiForCommandLine}
 * 
 * @author zw251y
 */
@WebServlet(name = "SparkClientServlet", urlPatterns = {"/SparkClientServlet"})
public class SparkClientServlet extends HttpServlet {

     static {
        JdbcDialects.registerDialect(new ElookintoCassandraDialect());
    }
    public static SparkSession sparkSession;

    @Override
    public void init() throws ServletException {
        super.init(); //To change body of generated methods, choose Tools | Templates.
        this.getServletContext().setAttribute("now", new java.util.Date());
        System.out.println(this.getServletContext().getAttribute("now"));
        sparkSession = SparkSession.builder()
                .config("spark.sql.warehouse.dir", "file:///tmp")
                .config("spark.hadoop.yarn.timeline-service.enabled", "false") //Some inconsistent with hadoop
                .config("driver.java.options", "-Dhdp.version=current")
                .config("spark.yarn.am.extraJavaOptions", "-Dhdp.version=current")
                .config("spark.master", "yarn")
                .config("spark.submit.deployMode", "client")
                .appName("Spark2JdbcDs").getOrCreate();
        try {
            Class.forName("com.github.adejanovski.cassandra.jdbc.CassandraDriver");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SparkClientServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SparkClientServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
