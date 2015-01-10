#' @name    line.chart
#' @title   Married Life
#' @concepts  shapes, text
#' @family Charts
#' @details
#' @description An XY Line chart
#' 
fn=function(){
  
  addLayout<-function(doc, layout){
    xy<-layout$xy
    wh<-layout$wh
    nxy<-sapply(layout$xyTics,length)
    dxy<-wh/(1+nxy)
    doc[["root"]](
      g( id="layout",
         rect(id="rect.my",  xy=xy, wh=wh, stroke="black", stroke.width=3, fill="none" ),
         lapply( 1:nxy[1], #verticle
                 function(i){ 
                   xy1=xy+i*dxy*c(1,0)
                   xy2=xy1+wh*c(0,1)               
                   line( xy1=xy1, xy2=xy2, stroke="grey" , stroke.dasharray="2,3" )
                 } 
         ),
         lapply( 1:nxy[2], #horizontal
                 function(i){ 
                   xy1=xy+i*dxy*c(0,1)
                   xy2=xy1+wh*c(1,0)
                   line( xy1=xy1, xy2=xy2, stroke="grey" , stroke.dasharray="2,3"  )
                 } 
         )      
      ),
      g(id="xTics", 
        lapply(1:nxy[1], function(i){
          cxy<-xy+i*dxy*c(1,0)+wh*c(0,1)+c(0,10)
          text(cxy=cxy, font.size=8, layout$xyTics[[1]][i] )
        }        
        )
      ),
      g(id="yTics", 
        lapply(1:nxy[2], function(i){
          cxy<-xy-i*dxy*c(0,1)+wh*c(0,1)-c(5,0)
          text(xy=cxy, layout$xyTics[[2]][i], font.size=8, text.anchor="end" )
        }        
        )
      ),
      g(id="decor",
        text(id="X.label", layout$labels[1], font.size=10,
             cxy=xy+wh*c(0.5,1)+c(0,30)
        ),
        
        text(id="Y.label", layout$labels[2], font.size=10,
             cxy=xy+wh*c(0,.5)-c(50,0),
             transform=list(rotate=c(-90, xy+wh*c(0,.5)-c(50,0)))
        ),
        text(id="Main", layout$main[1], font.size=15,
             cxy=xy+wh*c(0.5,0)-c(0,15)
        )
      )
    )
  }
  
  
  
  #' @param pts matrix whose are point to plot
  #' @return svg coords of points
  svgCoordinates<-function(layout, pts){
    xy<-layout$xy
    wh<-layout$wh
    nxy<-sapply(layout$xyTics,length)
    dxy<-wh/(1+nxy)*c(1,-1) 
    B<-rbind(xy+ wh*c(0,1)+dxy,xy+ wh*c(1,0)-dxy, xy+dxy*c(1,-1))  
    B<-cbind(B,1)
    XY<-rbind(cbind(layout$xRng, layout$yRng), c(layout$xRng[1], layout$yRng[2]))
    XY<-cbind(XY,1)
    A<-solve(XY,B)
    pts1<-cbind(pts,1)
    coords<-split( (pts1%*%A)[,1:2] , 1:nrow(pts1)) 
    coords
  }
  
  addCurve<-function(doc, layout, curve, stroke="black", fill="blue"){
    svgPts<-svgCoordinates(layout, curve)
    x0<-c(svgPts[[1]][1], layout$xy[2]+ layout$wh[2])
    if(fill!="none"){
      x1<-c(svgPts[[length(svgPts)]][1], layout$xy[2]+ layout$wh[2])
      polyPts<-c(list(x0),svgPts,list(x1))
      doc[['root']]( polygon(fill=fill, points=polyPts, opacity=0.3, stroke=stroke))    
    } else {
      doc[['root']]( polyline(fill="none", points=svgPts, opacity=0.3, stroke=stroke))
    }   
  }
  
  xRng<-c(1980,2010)
  yRng<-c(130,230)
  
  layout<-list(
    xy=c(60,50),
    wh=c(400,200),
    xRng=xRng,
    yRng=yRng,
    xyTics=list(
      xTics=paste(seq(xRng[1],xRng[2],by=5)),
      yTics=paste(seq(yRng[1],yRng[2], by=10),"lbs")
    ),  
    labels=c("Year","Weight"),
    main="The Weight of Married Life" 
  )
  # some ficticous data
  x<-1976:2002
  y<-runif(length(x),-5,5) + seq(160,230, length.out=length(x))
  male.pts<-cbind(x,y)
  
  x<-1976:2012
  y<-runif(length(x),-10,10) + seq(130,190, length.out=length(x))
  female.pts<-cbind(x,y)
  
  #graph it
  doc<-svgDoc.new(width=500,height=300 )
  addLayout(doc, layout)
  addCurve(doc, layout, male.pts, "blue", "lightblue")
  addCurve(doc, layout, female.pts, "red", "pink")
  
  as.character(doc)
}
