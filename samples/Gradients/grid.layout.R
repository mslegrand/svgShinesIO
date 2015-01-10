
#' @name    grid.layout
#' @title   Grid Layout
#' @concepts  Gradient; Element Generatio using lapply
#' @family Gradients
#' @details
#' @description Shows how to contruct a grid using lapply
#' 
fn<-function(){
doc<-svgDoc.new()
nx=20; ny=20
wh<-c(450,300)
w<-wh[1]; h<-wh[2]
doc[["root"]](
  defs( 
    linearGradient(id="my.grad",xy1=c("0%","0%"), xy2=c("0%","100%"), 
      colors=c( "rgb(196,196,255)", "rgb(10,10,96)" ) 
    ) 
  ), 
  g( id="gridLayout",
    rect(id="rect.my", xy=c(0,0), wh=wh, 
         stroke="black", stroke.width=3, fill="url(#my.grad)" 
    ),
  lapply( seq(1,w, length.out=nx), 
      function(x) line( xy1=c(x,0), xy2=c(x,h), stroke="white", stroke.width=1 ) 
  ),
  lapply( seq(1,h, length.out=ny),
    function(y)  line( xy1=c(0,y), xy2=c(w,y), stroke="white", stroke.width=1 ) 
  )
  )     
) 
as.character(doc)
}  
