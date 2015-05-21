
#' @name  omega.onPaper
#' @title Omega on paper
#' @family Filters
#' @concepts  Text,  Filters
#' @details
#' @description Demonstrates the use of filters to produce a paper background effect
fn<-function(){
svgR(wh=c(500,200),  
  defs(
    filter( id="roughpaper",
      feTurbulence( in1="SourceGraphic", type="fractalNoise", 
        baseFrequency=0.1, numOctaves=5, result="noise"
      ),
      feDiffuseLighting(in1="noise", lighting.color="khaki",
        surfaceScale=2, result="diffLight",
        feDistantLight(azimuth=45, elevation=35)
      )             
    )           
  ), 
  rect(xy=c(0,0),wh=c(500,200), filter="url(#roughpaper)"),
  text(id="t1", xy=c(20,130), 
    paste("Omega:", mathSymbol("\\Omega")), 
    stroke="black",stroke.width=1, font.size=100, 
    font.weight="bold", fill="white", opacity=0.4
  )     
)  
}
