
#' @name    shape.ellipse.flower
#' @title   Simple flower
#' @concepts  Shape
#' @family Shapes
#' @details
#' @description Simple flower.
#' 
fn<-function(){
rotate<-function(v){paste0("rotate(",paste(v,collapse=","),")")}
wh<-c(200,200)
middle<-wh/2
svgR(wh=wh,
  defs(
    ellipse(id='ellipse', cxy=middle+c(20,-5), 
      rxy=c(20,10), stroke="black", opacity=.8 
    )
  ),
  lapply(1:10, 
    function(i)
      use(xlink.href="#ellipse",  fill=rrgb(),
        transform = rotate(c(36*i, middle) )
      )
  )
)
}
