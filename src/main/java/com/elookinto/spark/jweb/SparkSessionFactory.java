/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elookinto.spark.jweb;

import org.apache.commons.pool2.BasePooledObjectFactory;
import org.apache.commons.pool2.PooledObject;
import org.apache.commons.pool2.impl.DefaultPooledObject;
import org.apache.spark.sql.SparkSession;

/**
 *
 * @author zw251y
 */
public class SparkSessionFactory extends BasePooledObjectFactory<SparkSession> {

   public final static SparkSession spark
            = SparkSession.builder().config("spark.sql.warehouse.dir", "file:///tmp").master("local[*]").appName("Spark2JdbcDs").getOrCreate();

    ;
    @Override
    public SparkSession create() throws Exception {
        // TODO Auto-generated method stub
        return spark.newSession();
    }

    @Override
    public PooledObject<SparkSession> wrap(SparkSession sparkSession) {
        // TODO Auto-generated method stub
        return new DefaultPooledObject<SparkSession>(sparkSession);
    }

}
