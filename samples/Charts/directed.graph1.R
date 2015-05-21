
#' @name    directed.graph1
#' @title   Moving Directed Net
#' @concepts  Animate
#' @family Charts
#' @details
#' @description Using animate stokes to illustater direction
#' 
fn<-function(){
  N<-6
  top<-50
  bottom<-150
  xs<-(1:N)*60  
  colors<-c('lightgreen','orange','khaki','lightblue','pink','yellow', 'red')
  svgR(wh=c(600,200),
    lapply(1:(N-1), function(i){
      line(xy1=c(xs[i],top), xy2=c(xs[i],bottom), stroke="blue",
           stroke.width=5,
           stroke.dasharray=8, 
           stroke.dashoffset=16,
           animate(attributeName="stroke.dashoffset", from=16, to=0 , 
                   dur=0.5, repeatCount="indefinite")         
      )      
    }),
    lapply(1:(N-1), function(i){
      line(xy1=c(xs[i],top), xy2=c(xs[i+1],bottom), stroke="lightblue",
           stroke.width=5,
           stroke.dasharray=8, 
           stroke.dashoffset=16,
           animate(attributeName="stroke.dashoffset", from=16, to=0 , 
                   dur=0.5, repeatCount="indefinite")         
      )      
    }),
    lapply(1:(N-1), function(i){
      line(xy1=c(xs[i],bottom), xy2=c(xs[i+1],top), stroke="lightgreen",
           stroke.width=8,
           stroke.dasharray=5, 
           stroke.dashoffset=10,
           animate(attributeName="stroke.dashoffset", from=8, to=0 , 
                   dur=0.15, repeatCount="indefinite")         
      )      
    }),    
    lapply(1:(N), function(i){
      circle(id=paste0("circleT-",i), #opacity=0.5,
             cxy=c(xs[i], top), r=10, fill=colors[i+1], 
             stroke="black", stroke.width=4)}
    ),
    lapply(1:(N), function(i){
      circle(id=paste0("circleB-",i), #opacity=0.5,
             cxy=c(xs[i], bottom), r=10, fill=colors[i], 
             stroke="black", stroke.width=4)}
    )
  )  
}
