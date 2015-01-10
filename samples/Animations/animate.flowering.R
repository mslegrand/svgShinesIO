     
#' @name    animate.flowering
#' @title   Animate Flowering
#' @concepts  AnimateTransform
#' @family Animations
#' @details
#' @description Another animation
#' 
fn<-function(){ 
doc<-svgDoc.new()
s.colors<-c("red","blue","yellow","green")
s.offset<-0.25*c(0,1,3,4)
idr<-paste0("ro",1:4)
vals<-c("#ffff80", "#ff8080", "#ff80ff", "#8080ff", "#80ffff", "#80ff80")
doc[['root']](
  defs( linearGradient(id='rhue', colors=c('red','blue','yellow','green'))),  
  ellipse( cxy=c(290,250), rxy=c(80,80),
    animate( attributeName='fill', dur=5, 
             values=vals, repeatCount='indefinite')
    ),
  g(id='penta',
    g( id='R1', transform=list(translate=c(200, 250)),
      ellipse( cxy=c(0,0), rxy=c(100,30), opacity=0.4, fill="url(#rhue)",
        animateTransform(attributeName="transform", type="rotate", 
          dur="7s", from="0", to="360", repeatCount="indefinite"
        ),
        animate(attributeName="cx", dur=8, values=c(-20, 120, -20), repeatCount="indefinite" ),
        animate(attributeName="ry", dur=3, values=c(10,60,10), repeatCount="indefinite")
      )                  
    ),
    lapply(1:4, function(i) 
      use(xlink.href='#R1', transform=list(rotate=c(i*30,300,250))) 
    )    
  ),
  lapply(1:4, function(i) 
    use(xlink.href='#penta', transform=list(rotate=c(i*72,290,250))) 
  )                           
)
as.character(doc)
}
