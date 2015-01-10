
#' @name    ubuntu1.logo
#' @title   Ubuntu Logo
#' @concepts  Filters, Shapes
#' @family Logos
#' @details
#' @description Illustrates the use of gradients and filters 
#' 
fn<-function(){  
  cXY<-c(0,0) # center
  S<-100 #seperation between centers
  
  R<-c(0.4,0.95)*S # arc radii: require 0< R[1]< R[2]
  r<-S * c(0.24,0.4) # require: 1-R[1]> r[2] >1-R[2] ( or R[1]<1-r[2]<R[2] ); 0<r[1]<r[2]
  Gap<-.1*S #space between arcs
  theta<-asin(Gap/R)
  XY1<-t(diag(R) %*% cbind(cos(theta),sin(theta))) + cXY #rows are the starting points of arc
  XY2<-t(diag(R) %*% cbind(cos(2*pi/3-theta),sin(2*pi/3-theta))) + cXY #rows are ending points of arc  
  d.eta= acos( (S^2 + r[2]^2 - (R[2]^2))/(2*S*r[2]) ) 
  eta<- -2*pi/3 + d.eta*c(-1,1)
  cxy<-cXY + S*c(cos(pi/3),sin(pi/3)) #center of satellite
  xy1<-cxy + t(r[2]*cbind(cos(eta), sin(eta)))
  
  
  doc<-svgDoc.new(width="12cm", height="12cm", viewBox="0 0 500 500", version=1.1)    
  doc[['root']](
    defs(
      filter(       id='filterShadow', height='150%',
                    feGaussianBlur( in1='SourceAlpha', stdDeviation=6, result='image1'  ),
                    feOffset( in1='image1', result='image2', dx=5, dy=5 ),
                    feComposite(in1='SourceGraphic', in2='image2', operator='over'  )
      ),
      filter(       id='emboss',
                    feGaussianBlur(  in1='SourceAlpha', stdDeviation=2, result='blur'      ),
                    feSpecularLighting(  in1='blur', surfaceScale=-3, style='lighting-color:white', specularConstant=1, 
                                         specularExponent=16, result='spec', kernelUnitLength=1,
                                         feDistantLight(azimuth=45, elevation=45)
                    ),
                    feComposite(  in1='spec', in2='SourceGraphic', operator='in', result='specOut'  )
      ),
      path( id="arc", d=list(M=XY1[,1], 
                             L=XY1[,2], 
                             A=c( c(R[2],R[2]), 0,  0, 1 , xy1[,2] ) , 
                             A=c( c(r[2],r[2]), 0,  0, 0 , xy1[,1] ) , 
                             A=c( c(R[2],R[2]), 0,  0, 1 , XY2[,2] ) ,                  
                             L=XY2[,1], 
                             A=c( c(R[1],R[1]), 0,  0, 0 , XY1[,1] ) ,
                             Z=0),
            stroke="black", stroke.width="3" ),
      circle(id="satellite", cxy=cxy, r=r[1], stroke="black"),     
      g( id='ubuntu',
         g(  transform=list(translate=c(200,200) ,rotate=0) , 
             use( "xlink:href"="#arc", fill="red"),
             use( "xlink:href"="#satellite", fill="yellow")
         ),
         g(  transform=list(translate=c(200,200) ,rotate=120) , 
             use( "xlink:href"="#arc", fill="yellow"),
             use( "xlink:href"="#satellite", fill="orange")
         ),
         g(  transform=list(translate=c(200,200) ,rotate=240) , 
             use( "xlink:href"="#arc", fill="orange"),
             use( "xlink:href"="#satellite", fill="red")
         )       
      )
    ), 
    use( "xlink:href"="#ubuntu",  filter='url(#filterShadow)'),
    use( "xlink:href"="#ubuntu",  filter='url(#emboss)')
  )
  as.character(doc)  
}
