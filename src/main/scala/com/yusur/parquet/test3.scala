package com.yusur.parquet

object test3 {

  def main(args: Array[String]): Unit = {
//    import spark.implicits._
//    val section = 10
//    val list = for (i <- 1 to section) yield TestUser(i, s"user_$i", scala.util.Random.nextInt(100))
//    val df = list.toDF()
//    df.write.parquet("./test")
  }



}
case class TestUser(id: Long, name: String, age: Long)
