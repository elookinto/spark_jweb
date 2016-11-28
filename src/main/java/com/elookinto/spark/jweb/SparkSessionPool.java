
package com.elookinto.spark.jweb;

import org.apache.commons.pool2.BasePooledObjectFactory;
import org.apache.commons.pool2.PooledObject;
import org.apache.commons.pool2.impl.DefaultPooledObject;
import org.apache.commons.pool2.impl.GenericObjectPool;
import org.apache.commons.pool2.impl.GenericObjectPoolConfig;
import org.apache.spark.sql.SparkSession;

/**
 *
 *  Session Pool needed?
 * 
 * @author zw251y
 */
public class SparkSessionPool {

    final static GenericObjectPoolConfig config = new GenericObjectPoolConfig();

    static {
        config.setMaxIdle(1);
        config.setMaxTotal(10);
        config.setTestOnBorrow(true);
        config.setTestOnReturn(true);

    }
    public static final GenericObjectPool<SparkSession> POOL = new GenericObjectPool(new SparkSessionFactory(), config);

    public static void main(String s[]) throws Exception {
        POOL.borrowObject().sql("select 1").show();
    }
}

class SparkSessionFactory extends BasePooledObjectFactory<SparkSession> {

    @Override
    public SparkSession create() throws Exception {
        // TODO Auto-generated method stub
        return SparkLocalServlet.spark.newSession();
    }

    @Override
    public PooledObject<SparkSession> wrap(SparkSession sparkSession) {
        // TODO Auto-generated method stub
        return new DefaultPooledObject<SparkSession>(sparkSession);
    }

}
