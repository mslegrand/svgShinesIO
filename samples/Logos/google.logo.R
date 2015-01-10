
#' @name    google.logo
#' @title   Google Logo
#' @concepts  Filters, Text
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
      filter(       id='embossWithShadow',
                    feGaussianBlur(  in1='SourceAlpha', stdDeviation=2, result='blur'),
                    feGaussianBlur(  in1='blur', dx="4", dy="4", result="shadowOut"),
                    feSpecularLighting(  in1='blur', surfaceScale=-3, style='lighting-color:white', specularConstant=1, 
                                         specularExponent=16, result='spec', kernelUnitLength=1,
                                         feDistantLight(azimuth=45, elevation=45)
                    ),
                    feComposite(  in1='spec', in2='SourceGraphic', operator='in', result='specOut'  ),
                    feComposite(  in1="SourceGraphic", in2="specOut", operator="arithmetic",
                                  k1=0, k2=1, k3=1, k4=0, result="embossOut"),
                    feMerge(feMergeNode(in1="shadowOut"), feMergeNode(in1="embossOut"))
      ),
      text( id="google",  x=20, y=100, font.size=72, font.weight='bold', 
            font.family = "Verdan",  
            tspan( 'G', fill='blue',   stroke="black" , rotate=3),
            tspan( 'o', fill='red',    stroke="black",  rotate=-20),
            tspan( 'o', fill='yellow', stroke="black", rotate=5),
            tspan( 'g', fill='blue',   stroke="black", rotate=-35),
            tspan( 'l', fill='green',  stroke="black", rotate=30 ),
            tspan( 'e', fill='red',    stroke="black", rotate=20)
      )
    ),
    g( 
      use( "xlink:href"="#google", filter='url(#embossWithShadow)') #now emboss the letters
    )
  )
  as.character(doc)  
}

