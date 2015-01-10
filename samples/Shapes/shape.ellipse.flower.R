
#' @name    shape.ellipse.flower
#' @title   Simple flower
#' @concepts  Shape
#' @family Shapes
#' @details
#' @description Simple flower.
#' 
fn<-function(){
rndColor<-function(){
  paste0("rgb(",paste(sample.int(255,3),collapse=","),")")
}
rotate<-function(v){paste0("rotate(",paste(v,collapse=","),")")}
wh<-c(200,200)
doc<-svgDoc.new(wh=wh)
middle<-wh/2
doc[["root"]](   
  defs(
    ellipse(id='ellipse', cxy=middle+c(20,-5), 
      rxy=c(20,10), stroke="black", opacity=.8 
    )
  ),
  lapply(1:10, 
    function(i)
      use(xlink.href="#ellipse",  fill=rndColor(),
        transform = rotate(c(36*i, middle) )
      )
  )
)
as.character(doc)
}
