
#' @name    intx2.Beveled.text
#' @title   Beveled Integral
#' @concepts  Filters emboss, bevel, mathsymbol
#' @family Text
#' @details
#' @description Illustrates both the use of mathSymbol and of filters
fn<-function(){
center<-c(145,10)
wh<-c(290,250) #dimensions of rectangle
integral<-mathSymbol("\\int")
doc<-svgDoc.new(width="12cm", height="12cm", viewBox="0 0 600 300", version=1.1)
doc[['root']](
  defs(
    filter( id='emboss',
      feGaussianBlur(in1='SourceAlpha', stdDeviation=2, result='blur'),
      feSpecularLighting(in1='blur', surfaceScale=-3, style='lighting-color:white', 
        specularConstant=1, specularExponent=16, result='spec', kernelUnitLength=1,
        feDistantLight(azimuth=45, elevation=45)
      ),
      feComposite(in1='spec', in2='SourceGraphic', operator='in', result='specOut')
    ),
    filter( id="bevel-shadow", xy=c("-50%","-50%"), wh=c("200%","200%"),
      feGaussianBlur(stdDeviation="1", result="blur"),    
      feOffset('in'="blur", dxy=c(1,1), result="blur1"),
      feOffset('in'="blur", dx=c(0,0), result="blur2"),           
      feComposite('in'="blur2", 'in2'="blur1", operator="arithmetic", 
        k2="1", k3="-1", result="diff1"
      ),
      feFlood(flood.color="back" ),
      feComposite('in2'="diff1", operator="in", result="diff1"),
      feComposite('in'="blur1", 'in2'="blur2", operator="arithmetic",  
        k2="1", k3="-1", result="diff2"
      ),
      feFlood(flood.color="white", flood.opacity="0.5" ),
      feComposite('in2'="diff2", operator="in", result="diff2"),
      feMorphology(operator="erode", radius=2, 'in'="SourceAlpha"),
      feGaussianBlur(stdDeviation=2, result="blur"),
      feOffset(dxy=c(3,3)),
      feComposite('in2'="SourceAlpha", operator="arithmetic", 
        k2="-1", k3="1", result="shadowDiff" 
      ),       
      feFlood(flood.color="black", flood.opacity=".8" ),
      feComposite('in2'="shadowDiff", operator="in", result="shadow"),
      feMerge(
        feMergeNode( 'in'="SourceGraphic"),
        feMergeNode( 'in'="shadow"),
        feMergeNode( 'in'="diff1"),
        feMergeNode( 'in'="diff2")
      )
    )  
  ),
  rect(id="tmp", cxy=center, wh=wh, stroke="black", fill="#8B4513"),
  rect(id="tmp", cxy=center, wh=wh, stroke="black", fill="#8B4513", filter="url(#emboss)"),
  text(cxy=center, font.size=80, font.weight="bold", 
    font.family="Arial",alignment.baseline='mathematical',
    stroke="black", fill="rgb(224,224,255)", filter="url(#bevel-shadow)",         
    tspan( font.size=96, integral),  
    tspan(" x"),
    tspan("2", baseline.shift="super",  font.size=40),
    tspan(" dx"),          
    cxy=center, font.size=80, font.weight="bold", font.family="Arial",
    stroke="black", fill="rgb(224,224,255)", filter="url(#bevel-shadow)"
  )
)
as.character(doc)  
}
