package com.leetcode

object Solution1779 {
  def main(args: Array[String]): Unit = {


  }

  def nearestValidPoint(x: Int, y: Int, points: Array[Array[Int]]): Int = {
    var best = Int.MaxValue
    var bestId = -1

    for (i <- 0 until points.length) {
      val arr = points(i)
      if (arr(0) == x) {
        val dist = Math.abs(y - arr(1))
        if (best < dist) {
          best = dist
          bestId = i
        }
      }else if (arr(1) == y) {
        val dist = Math.abs(x - arr(0))
        if (best < dist) {
          best = dist
          bestId = i
        }
      }
    }
    bestId
  }

}
