
#' @name    gradient.radial.repeat
#' @title   Repeating Radial Gradient
#' @concepts  Text, Gradient
#' @family Gradients
#' @details
#' @description Illustrates text filled with a radial gradient
#' 
fn<-function(){
  doc<-svgDoc.new(width=450, height=300)
  doc[["root"]](
    defs(
      radialGradient(id="my.grad",
                     fxy=c(.2,.2), cxy=c(.5,.5),             
                     stop(offset=0,stop.color='#1cbf80'),
                     stop(offset=0.25,stop.color='#f8b480'),
                     stop(offset=0.4,stop.color='#f43b4f0'),
                     spreadMethod="repeat"
      )
    ),
    rect( cxy=c(200,150), #"Radial",
          #"font-size"=144, "font-weight"="bold",
          fill= "url( #my.grad )", stroke="blue",
          wh=c(250,250)
          
    )
  )
  as.character(doc)
}
