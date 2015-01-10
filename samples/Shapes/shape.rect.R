
#' @name    shape.rect
#' @title   A Simple Rectangle
#' @concepts  Shape
#' @family Shapes
#' @details
#' @description A blue filled rectangle
#' 
fn<-function(){
doc<-svgDoc.new()
doc[["root"]]( rect(id="rect.my", cxy=c(100, 100), wh=c(100, 100),  fill="blue"))
as.character(doc)
}
