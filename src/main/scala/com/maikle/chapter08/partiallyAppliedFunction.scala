package com.maikle.chapter08

object partiallyAppliedFunction {
  def main(args: Array[String]): Unit = {

    //
    val a = sum _
    //val b = sum

  }

  def sum(a:Int, b:Int, c:Int):Int = {
    a + b + c
  }


}
