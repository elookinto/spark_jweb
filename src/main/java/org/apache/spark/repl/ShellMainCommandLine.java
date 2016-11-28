/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.apache.spark.repl;

import java.io.InputStream;
import java.io.StringBufferInputStream;
import org.apache.spark.sql.SparkSession;
import org.slf4j.Logger;
import scala.Function0;
 import scala.reflect.internal.AnnotationInfos;

/**
 *
 * @author Paul Z. Wu <zhou.wu@att.com>
 */
public class ShellMainCommandLine {
     public static void main(String s[]) throws Exception {
          System.setProperty("spark.master", "local[2]");
         SparkSession spark = SparkSession
                .builder()
                .appName("JavaSparkPi")
                .getOrCreate();
         spark.sql("select 1 ").show();
         spark.stop();
         Class.forName("org.apache.spark.internal.Logging");
         s = new String[]{"spark.master=local[2]"};
        
         //System.setProperty("classpath", "/Temp/spark-2.0.2-bin-hadoop2.7/jars/*.jar");
         System.out.println("testing");
         InputStream stdIn = System.in;
         InputStream is = new StringBufferInputStream("spark.sql(\"select 2 \").show()");
         
         System.setIn(is);
         System.setProperty("scala.usejavacp", "true");
        Main.main(s);
        
        is.close();
        Thread.currentThread().join();
    }
}
