/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.elookinto.spark.jweb;

import java.util.ArrayList;
import java.util.List;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.Function;
import org.apache.spark.api.java.function.Function2;
import org.apache.spark.sql.SparkSession;

/**
 * This program can be run using the following commandline: java -cp
 * $SPARK_HOME/jars/*:/usr/hdp/current/hadoop-client/conf -Dhdp.version=current
 * org.apache.spark.examples.JavaSparkPi 10 One has to pack this into app.jar
 * and copy to $SPARK_HOME/jars/*.
 *
 * @author zw251y
 */
public class JavaSparkPiForCommandLine {

    public static void main(String[] args) throws Exception {
        System.out.println("??????");
        SparkSession spark = SparkSession
                .builder()
                //.master("yarn-client")
                .config("spark.hadoop.yarn.timeline-service.enabled", "false")
                .config("driver.java.options", "-Dhdp.version=current")
                .config("spark.yarn.am.extraJavaOptions", "-Dhdp.version=current")
                .config("spark.master", "yarn")
                .config("spark.submit.deployMode", "client")
                .appName("JavaSparkPi")
                .getOrCreate();

        JavaSparkContext jsc = new JavaSparkContext(spark.sparkContext());

        int slices = (args.length == 1) ? Integer.parseInt(args[0]) : 2;
        int n = 100000 * slices;
        List<Integer> l = new ArrayList<>(n);
        for (int i = 0; i < n; i++) {
            l.add(i);
        }

        JavaRDD<Integer> dataSet = jsc.parallelize(l, slices);

        int count = dataSet.map(new Function<Integer, Integer>() {
            @Override
            public Integer call(Integer integer) {
                double x = Math.random() * 2 - 1;
                double y = Math.random() * 2 - 1;
                return (x * x + y * y < 1) ? 1 : 0;
            }
        }).reduce(new Function2<Integer, Integer, Integer>() {
            @Override
            public Integer call(Integer integer, Integer integer2) {
                return integer + integer2;
            }
        });

        System.out.println("Pi is roughly " + 4.0 * count / n);

        spark.stop();
    }

}
