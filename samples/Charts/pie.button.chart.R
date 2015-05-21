
#' @name    pie.button.chart
#' @title   Pie Chart Selector Button
#' @concepts  shapes, text
#' @family Charts
#' @details
#' @description Selector in shape of a pie chart
#' 
fn<-function(){
colors<-c("red","yellow", "lightblue", "lightgreen", "pink","brown", "orange")
labels<-LETTERS
N<-sample(3:7,1) #number of choices (<= number of colors)
rawData<-runif(N,10,30)
center<-c(100,100) #circle center
radius<-40
OD<-1.2 #expand factor
dur<-0.5 #how fast
#
percentages<-rawData/sum(rawData)
angles<-2*pi*cumsum(percentages)
angles<-c(0,angles )
pts<-cbind(cos(angles), sin(angles))*radius
midptAngles<-0.5*(angles[1:N]+angles[2:(N+1)])
textPos<-0.75*radius*cbind(cos(midptAngles),sin(midptAngles))
midpoints<-(OD-1)*radius*cbind(cos(midptAngles),sin(midptAngles))

svgR(
  text('Click on pie chart to activate', xy=c(20,20)),
  g( transform=list(translate=center),
    lapply(1:N, 
      function(i){
        g( id=paste0("RS",i),
          path( id=paste0('id',i),
            d=list(M=c(0,0), L=pts[i,], 
            A=c(radius, radius,0,
            0,1,pts[i+1,]),z=0), 
            fill=colors[i], stroke="black" 
          ),
          text( labels[i],cxy=(textPos[i,]), 
            stroke='black', stroke.width=0.4, 
            fill='white', font.size=12
          ),
          animateMotion( 
            from=c(0,0), to=midpoints[i,],
            begin=paste0("aniOver",i,".begin"), 
            restart="whenNotActive", dur=dur, 
            repeatCount=1, fill="freeze"
          ),
          animateMotion(
            to=c(0,0), from=midpoints[i,],
            begin=paste0("aniOut",i,".begin"),
            restart="whenNotActive", dur=dur, 
            repeatCount=1, fill="freeze"
          )          
        )            
      }                 
    ),
    lapply(1:N, 
      function(i){
        g( id=paste0("MV",i), 
          opacity=0,
          path( id=paste0('id',i),
            d=list(M=c(0,0), L=pts[i,], 
            A=c(radius, radius,0,
            0,1,pts[i+1,]),z=0), 
            fill=colors[i], stroke="black" 
          ),
          animateTransform(id = paste0("aniOut",i), 
            attributeName='transform', type="scale",
            from=c(OD,OD), to=c(1,1),
            begin="mouseout", 
            dur=dur, repeatCount=1, fill="freeze"
          ),           
          animateTransform(id = paste0("aniOver",i),                   
            attributeName='transform', type="scale",
            from=  c(1,1), to  = c(OD,OD), 
            begin="mouseover", #restart="whenNotActive", 
            dur=dur, repeatCount=1, fill="freeze"
          ), 
          onclick=paste("alert('",colors[i],"was chosen')"  )
        )
      }
    )
  )
)
}
