//package com.maikle.chapter10
//import Element.elem
//
//abstract class Element{
//  def contents:Array[String]
//  def width =
//    if (height == 0) 0 else contents(0).length
//  def height = contents.length
//
////  def above(that: Element): Element = {
////    elem(this.contents ++ that.contents)
////  }
//}
//
//object Element {
//  private class ArrayElement(
//                              val contents: Array[String]
//                            ) extends Element
//
//  private class LineElement(s: String) extends Element {
//    val contents = Array(s)
//    override def width = s.length
//    override def height = 1
//  }
//
//  private class UniformElement(
//                              ch:Char,
//                              override val width:Int,
//                              override val height:Int
//                              ) extends Element {
//    private val line = ch.toString * width
//    val contents = Array.fill(height)(line)
//  }
//  def elem(contents: Array[String]): Unit = {
//    new ArrayElement(contents)
//  }
//
// // def elem(ch:Char, width:)
//
//}
