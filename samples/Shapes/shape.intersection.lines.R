
#' @name    shape.intersection.lines
#' @title   Intersecting Lines
#' @concepts  Shape
#' @family Shapes
#' @details
#' @description Interesecting Lines
#' 
fn<-function(){
n<-18
r<-split(sample(50:180,3*n), rep(1:n)*3)
svgR( 
  lapply(1:n, 
    function(i){
      line(xy1=r[[i]][1]*c(-1,0), xy2=r[[i]][2]*c(1,0), 
        stroke=rrgb(), stroke.width=i%%3,
        transform=paste("translate(100,100) rotate(",r[[i]][3],") ")
      )
    }    
  )
)
}
