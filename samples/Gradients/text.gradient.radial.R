
#' @name    text.gradient.radial
#' @title   Radial  Gradient  Text
#' @concepts  Text, Gradient
#' @family Gradients
#' @details
#' @description Illustrates text filled with a radial gradient
#' 
fn<-function(){
doc<-svgDoc.new(width=450, height=300)
doc[["root"]](
  defs( 
    radialGradient(id="my.grad",xy1=c(0,0), xy2=c(0,1), 
        colors=c( "rgb(0,0,192)","rgb(255,255,128)", "rgb(192,0,0)" )
    )
  ),
  text( xy=c(20,150), "Radial",
    "font-size"=144, "font-weight"="bold",
    fill= "url( #my.grad )", stroke="blue"        
  )
)
as.character(doc)
}
