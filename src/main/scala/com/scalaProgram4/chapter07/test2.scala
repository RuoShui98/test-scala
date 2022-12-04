package com.scalaProgram4.chapter07

object test2 {
  def main(args: Array[String]): Unit = {
    println(multiTable())
  }

  def makeRowSeq(row: Int) = {
    for (col <- 1 to 10) yield {
      val prod = (row * col).toString
      val padding = " " * (4 - prod.length)
      padding + prod
    }

    "assabaas" +
      "asdvbxcds" +
      "\n"
  }

  def makeRow(row: Int) = makeRowSeq(row).mkString

  def multiTable() = {
    val tableSeq =
      for (row <- 1 to 10)
        yield makeRow(row)

    tableSeq.mkString("\n")
  }

}
