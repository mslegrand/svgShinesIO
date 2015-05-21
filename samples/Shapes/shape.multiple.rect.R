
#' @name    shape.multiple.rect
#' @title   Multiple Rectangles
#' @concepts  Shape
#' @family Shapes
#' @details
#' @description Multiple Rectangles
#' 
fn<-function(){
svgR( 
  lapply(c(0,30,60),function(angle){
    rect(id="rect.my", cxy=c(0, 0), wh=c(60, 60), 
      stroke="black", fill="none",
      transform=paste("translate(100,100) rotate(",angle,") ")
    )
    }    
  )
)
}
