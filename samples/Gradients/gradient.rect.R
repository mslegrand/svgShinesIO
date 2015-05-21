
#' @name    gradient.rect
#' @title Gradient Filled Rectangle
#' @family Gradients
#' @concepts  Gradient; Shapes
#' @details
#' @description Example of Rectangle with a gradient fill
fn<-function(){
svgR(
  defs( 
    linearGradient(id="my.grad",xy1=c("0%","0%"), xy2=c("0%","100%"), 
      colors=c( "rgb(255,255,0)", "rgb(255,0,0)" ) 
    ) 
  ), 
  rect(id="rect.my", xy=c(0,0), wh=c(85, 85) , 
       stroke="black", stroke.width=3, fill="url(#my.grad)" 
  )
)
}
