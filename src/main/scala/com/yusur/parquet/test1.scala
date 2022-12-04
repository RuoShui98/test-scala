package com.yusur.parquet

import org.apache.spark.sql.{DataFrame, DataFrameReader, Row, SparkSession}
import org.apache.spark.sql.types.{IntegerType, LongType, StringType, StructField, StructType}
object test1 {
  def main(args: Array[String]): Unit = {



    val spark: SparkSession = SparkSession.builder().appName("Test")
      .config("parquet.enable.dictionary","false")
      .config("parquet.block.size", "1073741824")
      .getOrCreate()

    val str = spark.conf.get("parquet.page.size")
    println(str)

    spark.sqlContext.getConf("parquet.page.size")
    spark.sqlContext.setConf("parquet.enable.dictionary", "false")
    spark.conf.set("parquet.enable.dictionary","false")


    val simpleSchema = StructType(Array(
      StructField("id",LongType,true),
      StructField("cid",LongType,true),
      StructField("did",LongType,true)
    ))

    val dfr = spark.read.option("header",value = true).schema(simpleSchema)


    val df: DataFrame = dfr.csv("file/table.csv")
    val tempV = df.createTempView("table1")

    val df3: DataFrame = spark.sql("select * from table1")

    df3.write.parquet("file/table_parquet")


  }

}
