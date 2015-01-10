
#' @name    shape.ellipse
#' @title   A Simple Ellipse
#' @concepts  Shape
#' @family Shapes
#' @details
#' @description An orange filled ellipse.
#' 
fn<-function(){
doc<-svgDoc.new()
doc[["root"]]( ellipse(id="ellipse.my", cxy=c(100, 100), rxy=c(100,60), fill="orange" ) )
as.character(doc)
}
