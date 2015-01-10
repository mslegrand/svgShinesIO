 
#' @name    rstudio.logo
#' @title   RStudio Logo
#' @concepts  Text, Shapes, Filters
#' @family Logos
#' @details
#' @description Illustrates the use of gradients and filters 
#' 
fn<-function(){
doc<-svgDoc.new(width="12cm", height="12cm", viewBox="0 0 500 500", version=1.1)  
center<-c(200,200)
radius<-120
 
doc[['root']](
  defs( 
    radialGradient(id="grad1",
      cxy=c("50%","80%"),
      fxy=c("50%", "100%"),
      colors=c("rgb(255,255,255)", "rgb(0,64,128)"  )
    ),
    linearGradient(id="grad2",
      xy1=c("0%","10%"), xy2=c("0%","80%"), 
      colors=c("rgb(255,255,255)" , "rgb(64,128,196)")
    ),
    filter(id="gaussblur",
      xy=c("-5%","-5%"), wh=c("110%","110%"), #insures +- 1/2 of width
      feGaussianBlur(stdDeviation="1.5", result="blur")    
    )
  ),
  ellipse(cxy=center+c(0,radius), rxy=c(radius, 0.2*radius), 
    fill="grey", filter="url(#gaussblur)"
  ),
  g(      
    circle(id="c1", cxy=center, r=radius, 
      stroke="none", fill = "url(#grad1)" 
    ), 
    ellipse(cxy=center-c(0,radius/2), rxy=c(.6*radius, .5*radius), 
      fill="url(#grad2)",filter="url(#gaussblur)" 
    )          
  ),
  text("R", font.size=144,  font.family = "serif",
  cxy=center, fill="white")
)
as.character(doc)
}
