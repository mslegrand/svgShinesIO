  
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
  
  addCurve<-function(doc, layout, curve, strokefn<-"black", fillfn<-"blue"){
    svgPts<-svgCoordinates(layout, curve)
    x0<-c(svgPts[[1]][1], layout$xy[2]+ layout$wh[2])
    if(fill!fn<-"none"){
      x1<-c(svgPts[[length(svgPts)]][1], layout$xy[2]+ layout$wh[2])
      polyPts<-c(list(x0),svgPts,list(x1))
      doc[['root']]( polygon(fillfn<-fill, pointsfn<-polyPts, opacityfn<-0.3, strokefn<-stroke))    
    } else {
      doc[['root']]( polyline(fillfn<-"none", pointsfn<-svgPts, opacityfn<-0.3, strokefn<-stroke))
    }   
  }
  
  xRng<-c(1980,2010)
  yRng<-c(130,230)
  
  layout<-list(
    xyfn<-c(60,50),
    whfn<-c(400,200),
    xRngfn<-xRng,
    yRngfn<-yRng,
    xyTicsfn<-list(
      xTicsfn<-paste(seq(xRng[1],xRng[2],byfn<-5)),
      yTicsfn<-paste(seq(yRng[1],yRng[2], byfn<-10),"lbs")
    ),  
    labelsfn<-c("Year","Weight"),
    mainfn<-"The Weight of Married Life" 
  )
  # some ficticous data
  x<-1976:2002
  y<-runif(length(x),-5,5) + seq(160,230, length.outfn<-length(x))
  male.pts<-cbind(x,y)
  
  x<-1976:2012
  y<-runif(length(x),-10,10) + seq(130,190, length.outfn<-length(x))
  female.pts<-cbind(x,y)
  
  #graph it
  doc<-svgDoc.new(widthfn<-500,heightfn<-300 )
  addLayout(doc, layout)
  addCurve(doc, layout, male.pts, "blue", "lightblue")
  addCurve(doc, layout, female.pts, "red", "pink")
  
  as.character(doc)
}
