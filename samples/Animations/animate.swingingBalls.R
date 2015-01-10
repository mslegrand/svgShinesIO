
#' @name    animate.swingingBalls
#' @title   Swinging balls
#' @concepts  AnimateTransform
#' @family Animations
#' @details
#' @description Simulates the classic ball swing
#' 
fn<-function(){  
  cXY<-c(250,50) #bar center
  R<-150 #string length
  r<-10 #ball radius
  N<-4 # ( total num is 2N+1) 
  indices<-seq(-N,N)
  xx<-c(-N,N)*2*r+cXY[1]
  oneBall<-function(i){
    x<-i*2*r+cXY[1]
    g(id=paste("ball_",i,sep=""), 
      line(xy1=c(x,cXY[2]), xy2=c(x,cXY[2]+R), stroke="black"),
      circle(cxy=c(x,cXY[2]+R), 
             r=10, fill="red", stroke="black")
    )  
  }
  
  t<-seq(-1,1,length.out=11)
  h<-.8*(1-t^2)
  theta<-180*asin(h)/pi
  values1<-paste(theta,xx[1],cXY[2],sep=",",collapse="; ")
  values2<-paste(-theta,xx[2],cXY[2],sep=",",collapse="; ")
  
  doc<-svgDoc.new(wh=2*cXY+c(0,R))
  doc[["root"]](
    #cat("N=",N,"\n")
    rect(cxy=cXY, wh=c((1+N*2)*2*r, 2*r), 
         fill="grey",stroke="black"),
    lapply(indices, oneBall)
  )
  
  idN<-paste("ball",c(-4,4),sep="_")
  dt<-2
  doc[[idN[1]]](
    animateTransform(id="R",
                     attributeType="xml",
                     attributeName="transform",
                     type="rotate",
                     values=values1,
                     dur=dt,
                     begin="0;L.end"
    )
  )
  
  doc[[idN[2]]](
    animateTransform( id="L",
                      attributeType="xml",
                      attributeName="transform",
                      type="rotate",
                      values=values2,
                      dur=dt,
                      begin="R.end"
    )         
  )
  as.character(doc)
}
