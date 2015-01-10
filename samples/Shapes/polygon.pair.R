
#' @name    polygon.pair
#' @title   Pair of Triangles
#' @concepts  Shape, Points
#' @family Shapes
#' @details
#' @description Two triangles: top has points given as a list, the bottom has points given as a matrix
#' 
fn<-function(){
doc<-svgDoc.new()
doc[["root"]](
  polygon(id="poly.list", 
    points=list(c(50,50)+10,  c(0,100)+10, c(100,100)+10),
    fill="lime", stroke="red", stroke.width=10
  ),
  polygon(id="poly.matrix", 
    points=matrix(c(50,50,  0,100, 100,100)+c(10,110), 2,3),
    fill="yellow", stroke="blue",stroke.width=10
  )
)
as.character(doc)
}
