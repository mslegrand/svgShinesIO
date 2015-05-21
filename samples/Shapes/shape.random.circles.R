
#' @name    shape.random.circles
#' @title   Random Circles
#' @concepts  Shape
#' @family Shapes
#' @details
#' @description Random circles.
#' 
fn<-function(){
svgR( wh=c(200,200),
  lapply(1:10, function(i){
      circle(id="circle.my", cxy=sample.int(200,2), r=sample.int(30,1), 
        stroke=rrgb(), opacity=.8,  fill=rrgb() 
      )
    } 
  )
)
}
