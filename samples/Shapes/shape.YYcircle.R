
#' @name    shape.YYcircle
#' @title   Yin-Yang
#' @concepts  Shape
#' @family Shapes
#' @details
#' @description 4 filled circles and a clip.
#' 
fn<-function(){
  doc<-svgDoc.new()
  doc[["root"]]( 
    clipPath(id="clipper", rect(xy=c(40,100),wh=c(120,60) )),
    circle(cxy=c(100, 100), r=60, fill="red" ), 
    circle( cxy=c(100, 100), r=60, fill="black", clip.path="url(#clipper)" ) , 
    circle(cxy=c(100+30,100),r=30, fill="red"),
    circle(cxy=c(100-30,100),r=30, fill="black")
  )
  as.character(doc)
}
