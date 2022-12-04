package com.yusur.parquet

import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.types.{LongType, StructField, StructType}

object test2 {
  def main(args: Array[String]): Unit = {

    val spark: SparkSession = SparkSession
      .builder()
      .appName("Test")
      .config("parquet.enable.dictionary","false")
      .master("local")
      .getOrCreate()



//    case class TestUser(id: Long, name: String, age: Long)
//
//    import spark.implicits._
//    val section = 10
//    val list = for (i <- 1 to section) yield TestUser(i, s"user_$i", scala.util.Random.nextInt(100))
//    val df = list.toDF()
//    df.write.parquet("file")




  }

}
