
#' @name    animate.pac.man
#' @title   Animate Pacman
#' @concepts  animateTransform, Shapes
#' @family Animations
#' @details
#' @description Pacman takes 3 bites
#'  
fn<-function(doc){
  cxy<-c(120, 120)
  r<-50
  dt<-.3
  dt.bite<-0.8*dt
  btime<-paste0(dt,";bite.end+",dt)
  eye<-list(r=max(1, r*.18), stroke=max(1, r*.14) ) 
  angle<- 70*pi/180
  angle0<- 1*pi/180
  closedMouth=list(
    M=c(0,0), 
    L=c(r*cos(angle0), r*sin(angle0)), 
    A=c(r,r,0, 1,1, r*cos(angle0), -r*sin(angle0)),
    Z=0)
  openMouth=list(
    M=c(0,0), 
    L=c(r*cos(angle), r*sin(angle)), 
    A=c(r,r,0, 1,1, (r+30)*cos(angle), -r*sin(angle) ),
    Z=0)
  svgR( 
    g( transform=list(translate=cxy-c(r,r) ),
       g(id="balls", 
         lapply(1:6, function(i) 
           circle( cxy=c(10+i*50,0),r=10, stroke="black", fill="red")),
         animateMotion(from=c(0,0), to=c(-50,0), 
                       dur=dt+dt.bite, begin=btime, repeatDur="indefinite"
         )
       ),
       path(id="pac.man", 
            d=closedMouth,
            fill="yellow",
            stroke="black", stroke.width=1,
            animate(id='bite', 
                    attributeName="d", attributeType="XML",
                    begin=btime, dur=dt,
                    to=openMouth      
            ) 
       ),
       circle(id="eye", cxy=-r*c(.1,.5), r=eye$r, 
              fill="#000", stroke="white", stroke.width=eye$stroke)                        
    ) 
  )
}
