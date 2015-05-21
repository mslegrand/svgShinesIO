
#' @name    text.box
#' @title   Boxed Text
#' @concepts  Text, Centering
#' @family Text
#' @details
#' @description Illustrates centering text on rectanlge
#' 
fn<-function(){   
  cxy=c(50,80); wh=c(60,15); "hello"
  font.size=paste(wh[2])
  

  svgR(
    g(id="my.group",
      rect( cxy=cxy, wh=wh,  fill="lightblue", stroke="black"),
      text( cxy=cxy-c(0,wh[2]/10),
            "hello", font.size=font.size, 
            text.anchor="middle",
            dominant.baseline ="middle" #red line at top of eo
      )      
    )
  )
}
