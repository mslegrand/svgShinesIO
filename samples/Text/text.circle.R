
#' @name    text.circle
#' @title   Circled Text
#' @concepts  Text, Centering
#' @family Text
#' @details
#' @description Illustrates centering text on circle
#' 
fn<-function(){
cxy=c(50,50); r=12; txt="<"
svgR(
    circle(id="cir.my", cxy=cxy, r=r,  fill="lightgreen", stroke="black"),
      text(txt, cxy=cxy-c(0,r/10),  font.size=r, dominant.baseline ="middle")      
)
}
