
#' @name    gradient.linear.repeat
#' @title   Repeating Linear Gradient
#' @concepts  Text, Gradient
#' @family Gradients
#' @details
#' @description Illustrates text filled with a radial gradient
#' 
fn<-function(){
svgR(wh=c(450,300),
    defs(
      linearGradient(id="my.grad",
        xy1=c(.1,.0), xy2=c(.1,.3),             
       stop(offset=0,stop.color='#1cbf80'),
       stop(offset=0.1,stop.color='#f8b480'),
       stop(offset=0.9,stop.color='#f43b4f0'),
       spreadMethod="repeat"
      )
    ),
    rect( cxy=c(200,150), #"Radial",
          #"font-size"=144, "font-weight"="bold",
          fill= "url( #my.grad )", stroke="blue",
          wh=c(200,200)
          
    )
)
}
