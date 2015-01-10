
#' @name    animate.transform.rotate
#' @title   Animate Rotate
#' @concepts  animateTransform
#' @family Animations
#' @details
#' @description  Rectangle spinning indefinately
#' 
fn<-function(){
  doc<-svgDoc.new()
  doc[["root"]](
    g(rect( xy=c(150,20), wh=c(60,60), fill="blue"),
      animateTransform(
        attributeType="xml", 
        attributeName="transform", type="rotate",
        from=c(0,180,50), to=c(360,180,50),
        dur=4, repeatCount="indefinite")
    )              
  )
  as.character(doc)
}
