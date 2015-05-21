
#' @name    animate.fill
#' @title   Warning
#' @concepts  Set, Animation
#' @family Animations
#' @details
#' @description Changing fill color
#' 
fn<-function(){
dt=0.1
svgR(
  circle(id="circle.my", cxy=c(100,100), r=50, fill="yellow",
    set(id="Yellow", 
      attributeName="fill", to="yellow", 
      begin="0;Blue.end", dur=dt
    ),          
    set(id="Blue", 
      attributeName="fill", to="blue", 
      begin="Yellow.end", dur=dt
    )          
  ),
  text(id="text.my", cxy=c(100,100), "Warning", fill="blue", 
       font.size=16, font.weight="bold",
    set( attributeName="fill", to="blue", 
        begin="0;Blue.end", dur=dt
    ),          
    set( attributeName="fill", to="yellow", 
        begin="Yellow.end", dur=dt
    )          
  ) 
)
}
