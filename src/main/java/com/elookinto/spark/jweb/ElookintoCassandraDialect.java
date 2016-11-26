/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elookinto.spark.jweb;

import org.apache.spark.sql.jdbc.JdbcDialect;

/**
 *
 * https://github.com/CK50/spark/blob/cac053696fef6fe326c9855ab57f13899a9e7e82/sql/core/src/main/scala/org/apache/spark/sql/jdbc/CassandraDialect.scala
 * @author zw251y
 */
public class ElookintoCassandraDialect  extends JdbcDialect {
    
    @Override
    public boolean canHandle(String url) {
        System.out.println("came here.."+ url.startsWith("jdbc:cassandra"));
        return url.startsWith("jdbc:cassandra");
    }
    @Override
    public String getTableExistsQuery (String table) {
        System.out.println("query?");
        return "SELECT * from " + table + " LIMIT 1";
    }
}
