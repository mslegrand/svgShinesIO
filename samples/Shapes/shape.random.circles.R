
#' @name    shape.random.circles
#' @title   Random Circles
#' @concepts  Shape
#' @family Shapes
#' @details
#' @description Random circles.
#' 
fn<-function(){
rndColor<-function(){
  paste0("rgb(",paste(sample.int(255,3),collapse=","),")")
}
doc<-svgDoc.new(wh=c(200,200))
doc[["root"]]( 
  lapply(1:10, function(i){
      circle(id="circle.my", cxy=sample.int(200,2), r=sample.int(30,1), 
        stroke=rndColor(), opacity=.8,  fill=rndColor() 
      )
    } 
  )
)
as.character(doc)
}
