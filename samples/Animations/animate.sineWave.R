     
#' @name    animate.sineWave
#' @title   Sine Wave
#' @concepts  AnimateTransform
#' @family Animations
#' @details
#' @description Sine Wave Generation
#' 
fn<-function(){ 
h<-50
r<-h/2
P<-2
w<-(2*pi*r)+h
dt<-10
N<-100
x<-seq(r-1,2*pi*r+r,length.out = N+1)
y<-r-r*sin( P*(0:(N))*(2*pi)/N )
points<-rbind(x,y)
ceiling(sum(sqrt(diff(x)*diff(x)+diff(y)*diff(y))))->path.len
spath<-structure(lapply(1:N, function(i)c(x[i],y[i])),names=c("M",rep("L",N-1)))
doc<-svgDoc.new( width=w+2, height=h+2)
doc[["root"]](
  rect(id="greenR", xy=c(-w,0), wh=c(w,h), 
    stroke="red", fill="lightgreen", opacity=.5,
    animate(attributeName="x", values=x-w, 
            begin="0", dur=dt,  repeatCount="indefinite"
    )
  ),
  rect(xy=c(0,0), wh=c(w,h), stroke="red", 
    fill="lightblue", opacity=.5,
    animate(attributeName="y", values=y, begin="0", 
      dur=dt,  repeatCount="indefinite"
    )
  ),
  line(xy1=c(1,h), xy2=c(w+1,h), stroke="black"),
  line(xy1=c(1,h/2), xy2=c(w+1,h/2), stroke="grey"),
  line(xy1=c(1,1), xy2=c(1,h), stroke="black") ,
  g( 
    circle(cxy=c(r,r),r=r, stroke="blue", fill="none"),
    g(
      line(xy1=c(r,r), xy2=c(1,r), stroke="lightblue"),
      circle(cxy=c(r,r), r=2, fill="blue"),
      circle(cxy=c(1,r), r=2, fill="blue"),
      animateTransform(attributeType="xml",
        attributeName="transform", type="rotate",
        from=c(0,r,r),to=c(P*360,r,r),
        dur=dt, repeatCount="indefinite"
      )
    ),
    animateMotion(id="simple.animate", 
      from=c(1,1), to=c(2*pi*r,1), 
      begin="0", dur=dt,  repeatCount="indefinite"
    )
  ),
  path(d=spath,  stroke="red", fill="none", stroke.width=2,
    stroke.dasharray=path.len, stroke.dashoffset=path.len,
    animate(attributeName="stroke.dashoffset", 
      from=path.len, to=0 , dur=dt,repeatCount="indefinite"
    )
  ),
  circle(
    stroke="black", fill="red", r=2, 
    animateMotion(path=spath, begin=0, 
      dur=dt, repeatCount="indefinite"
    )
  )
)
as.character(doc)
}
