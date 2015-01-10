
#' @name    r.logo
#' @title   R Logo
#' @concepts  Filters, Shapes
#' @family Logos
#' @details
#' @description Illustrates the use of multiple filters 
#' 
fn<-function(){
  doc<-svgDoc.new(width="12cm", height="12cm", viewBox="0 0 500 300", version=1.1)
  center<-c(200,10)
  cp<-function(x,y){ paste(c(x,y),"%", sep="")}
  doc[['root']](
    defs(
      filter(
        id="distLight", 
        filterUnits="boundingbox", 
        xy=c("-10%","-10%"), 
        wh=c("120%","120%"),
        feGaussianBlur( in1="SourceGraphic", stdDeviation=3, result="blur" ),
        feSpecularLighting( 
          in1="blur", 
          surfaceScale=30, 
          specularConstant=0.75,                
          specularComponent=20, 
          lighting.color="rgb(200,200,255)", 
          result="specOut",
          feDistantLight(azimuth=180+45, elevation=45)
        ),
        feComposite( in1="specOut", in2="SourceAlpha", operator="in", result="specOut2"),
        feComposite( in1="SourceGraphic", in2="specOut2", operator="arithmetic", 
                     k1=0, k2=1, k3=1, k4=0)     
      ),
      filter(
        id="distLight2", 
        filterUnits="boundingbox", 
        xy=c("10%","10%"), 
        wh=c("80%","80%"),
        feGaussianBlur( in1="SourceGraphic", stdDeviation=3, result="blur" ),
        feSpecularLighting( 
          in1="blur", 
          surfaceScale=30, 
          specularConstant=0.75,                
          specularComponent=20, 
          lighting.color="rgb(200,200,255)", 
          result="specOut",
          feDistantLight(azimuth=45, elevation=45)
        ),
        feComposite( in1="specOut", in2="SourceAlpha", operator="in", result="specOut2"),
        feComposite( in1="SourceGraphic", in2="specOut2", operator="arithmetic", 
                     k1=0, k2=1, k3=1, k4=0)     
      ),
      filter(
        id="distLight3", 
        filterUnits="boundingbox", 
        xy=c("-10%","-10%"), 
        wh=c("120%","120%"),
        feGaussianBlur( in1="SourceGraphic", stdDeviation=3, result="blur" ),
        feSpecularLighting( 
          in1="blur", 
          surfaceScale=30, 
          specularConstant=0.75,                
          specularComponent=20, 
          lighting.color="rgb(200,200,255)", 
          result="specOut",
          feDistantLight(azimuth=45, elevation=45)
        ),
        feComposite( in1="specOut", in2="SourceAlpha", operator="in", result="specOut2"),
        feComposite( in1="SourceGraphic", in2="specOut2", operator="arithmetic", 
                     k1=0, k2=1, k3=1, k4=0)     
      ),    
      filter(id="gaussblur",
             xy=c("-5%","-5%"), wh=c("110%","110%"), #insures +- 1/2 of width
             feGaussianBlur(stdDeviation="1.5", result="blur")    
      )
    ),   
    ellipse( cxy=center-c(50,20), rxy=c(120,75), fill="dark-grey" , filter="url(#distLight)"
    ),
    g(    ellipse( cxy=center-c(44,22), rxy=c(110,65), fill="white" 
    ),   
    ellipse( cxy=center-c(40,20), rxy=c(110,65), #fill="red" , 
             stroke.width=3,
             filter="url(#distLight)"
    ),
    ellipse( cxy=center-c(40,19), rxy=c(110,65), #fill="red" , 
             stroke.width=3,
             filter="url(#distLight3)"
    ),
    ellipse( cxy=center-c(35,21), rxy=c(100,55), fill="white", stroke.width=1,
             stroke="white"
    ),
    ellipse( cxy=center-c(30,20), rxy=c(90,53), fill="black", stroke.width=5,
             stroke="black", filter="url(#gaussblur)"
    ),
    filter="url(#gaussblur)" 
    
    ),
    ellipse( cxy=center-c(20,18), rxy=c(80,50), fill="white"
    ),
    text("R",  cxy=center, font.size=144, stroke="black", 
         stroke.width=20, 
         filter="url(#distLight)"),
    text("R",  cxy=center, font.size=144, stroke="black", 
         stroke.width=2, 
         fill="rgb(128,128,193)" ,
         filter="url(#distLight2)"
    )
  )
  as.character(doc) 
}
