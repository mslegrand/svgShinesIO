
#' @name    text.gradient.linear
#' @title   Linear Gradient Text
#' @concepts  Text, Gradient
#' @family Gradients
#' @details
#' @description Illustrates text filled with a linear gradient
#' 
fn<-function(){
doc<-svgDoc.new(width=450, height=300)
doc[["root"]](
  defs( 
    linearGradient(id="my.grad",
      xy1=c(0,.4), xy2=c(0,.9), 
      colors=c( "rgb(0,0,192)","rgb(255,255,128)", "rgb(192,0,0)" )
    )
  ), 
  text( xy=c(20,150), "Linear",
    "font-size"=144, "font-weight"="bold",
    fill= "url( #my.grad )", stroke="blue"    
  )
)
as.character(doc)
}
