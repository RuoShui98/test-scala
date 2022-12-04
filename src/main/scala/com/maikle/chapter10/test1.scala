//package com.maikle.chapter10
//
//abstract class Element{
//  def contents: Array[String]
//  def height = contents.length
//  def width =
//    if (height == 0) 0 else contents(0).length
//}
//
//
//object test1 {
//  def main(args: Array[String]): Unit = {
////    new UniformElement()
//  }
//
//}
//
//class UniformElement(
//                    ch:Char,
//                    override val width:Int,
//                    override val height:Int
//                    ) extends Element {
//  private val line = ch.toString * width
//  def contents: Array[String] = Array.fill(height)(line)
//}
