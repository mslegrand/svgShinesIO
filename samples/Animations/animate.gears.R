
#' @name    animate.gears
#' @title   Rotating Gears
#' @concepts  AnimateTransform
#' @family Animations
#' @details
#' @description Rotating gears
#' 
fn<-function(){
  gear.new<-function(N , gear=NULL, theta=NULL, 
                     r=NULL , cxy=c(0,0), 
                     delta=10, phase=0,
                     angularVelocity=0
  )
  {
    if(! is.null(gear)) {
      angularVelocity<- - gear$N*gear$angularVelocity/N
      delta<-gear$delta
      n_theta<- floor((theta - gear$phase)/(pi/gear$N))
      theta_prime<-(n_theta+1) * (pi/gear$N)
      phase<-gear$phase + theta_prime + pi
      if(n_theta%%2==1){ #new=peg, gear=gap
        phase<-phase + (pi/N)
      }
      r<-N*gear$r/gear$N
      cxy<-gear$cxy + 
        (r+delta+gear$r)*c( cos(theta_prime+gear$phase), 
                            - sin(theta_prime+gear$phase))  
    }
    R<-delta+r
    phi<-2*pi/(3*N)
    Phi<-phi*r/R
    eta<-phi - Phi/2 
    radii<-rep(c(r,r,R,R),N)
    angles<-rep(c(phi,eta,Phi,eta),N)
    angles<-angles[-length(angles)]
    angles<-c(phase-phi/2,angles)
    angles<-cumsum(angles)
    x<-radii*cos(angles)+cxy[1]
    y<- -radii*sin(angles)+cxy[2]
    
    tmp1<-rbind(c("M",rep("L",length(x)-1)), x, y)
    tmp2<-apply(tmp1, 2,function(x)paste(x,collapse=" "))
    tmp5<-c(tmp2," Z")
    pathD<-paste(tmp5, collapse=" ")     
    
    structure(list(r=r, N=N, phase=phase, cxy=cxy,
                   delta=delta, theta=theta, 
                   angularVelocity=angularVelocity, 
                   pathD=pathD),
              class="gear")
  } 
  
  
  g1<-gear.new(16,r=40, cxy=c(100,100), 
               angularVelocity=0.25, phase=0)
  g2<-gear.new(18,gear=g1, theta=0)
  g3<-gear.new(28,gear=g1, theta=-pi/2)
  g4<-gear.new(8, gear=g2, theta=-pi/3)
  
  decorate<-function(gear, N, theta0= 0, #pi/3, 
                     thickness=8, r=2*gear$delta, 
                     M=N+1,
                     R=gear$r - gear$delta)
  {
    dtheta<-(2*pi/N) 
    eta     = thickness / (2*r)  
    thetas   = seq(theta0,2*pi+theta0,  length.out=M)
    oneSeg<-function(theta){
      phi1<- theta   + thickness/(2*r) 
      Phi1<- theta   + thickness/(2*R) 
      phi2<- theta  + dtheta  - thickness/(2*r) 
      Phi2<- theta  + dtheta  - thickness/(2*R) 
      pt1<-gear$cxy + R*c(cos(Phi1),sin(Phi1))
      pt2<-gear$cxy + R*c(cos(Phi2),sin(Phi2))
      pt3<-gear$cxy + r*c(cos(phi2),sin(phi2))
      pt4<-gear$cxy + r*c(cos(phi1),sin(phi1))
      decor<-list(
        M=pt1,
        A=c(R,R,0,0,1, pt2),
        L=pt3,
        A=c(r,r,0,0,0, pt4),
        Z=1
      )    
    }
    tmp<-lapply(thetas, oneSeg)
  }
  
  g3Decor<-decorate(gear=g3, N=3, thickness=15)
  g2Decor<-decorate(gear=g2, N=5)
  
  wheelColor<-"rgb(168,128,64)"
  doc<-svgDoc.new(width=400, height=300)
  doc[["root"]](
    g( id="gear1",
       path( d=g1$pathD, fill=wheelColor,
             stroke="black",
             stroke.width="2"
       ),    
       circle( cxy=g1$cxy, r=g1$r-g1$delta,
               fill="rgb(168,128,64)", stroke="rgb(128,92,48)",
               stroke.width=5),
       animateTransform(attributeType="xml",
                        attributeName="transform",
                        type="rotate",
                        from=c(0, g1$cxy),
                        to=c(sign(g1$angularVelocity)*360, g1$cxy),
                        dur=abs(1/g1$angularVelocity),
                        repeatCount="indefinite")     
    ),
    g( id="gear2",
       path( d=g2$pathD, fill="rgb(168,128,64)",
             stroke="black",
             stroke.width="2"
       ), 
       lapply(g2Decor, function(gd){
         path(d=gd, stroke="black", fill="white")
       }), 
       circle( cxy=g2$cxy, r=(g2$r + g2$delta)/4,
               fill="rgb(168,128,64)", stroke="black"),
       animateTransform(attributeType="xml",
                        attributeName="transform",
                        type="rotate",
                        from=c(0, g2$cxy),
                        to=c(sign(g2$angularVelocity)*360, g2$cxy),
                        dur=abs(1/g2$angularVelocity),
                        repeatCount="indefinite")     
    ),
    g(id="gear3",
      path( d=g3$pathD, fill="rgb(168,128,64)",
            stroke="black",
            stroke.width="2"
      ),
      lapply(g3Decor, function(gd){
        path(d=gd, stroke="black", fill="white")
      }),
      animateTransform(attributeType="xml",
                       attributeName="transform",
                       type="rotate",
                       from=c(0, g3$cxy),
                       to=c(sign(g3$angularVelocity)*360, g3$cxy),
                       dur=abs(1/g3$angularVelocity),
                       repeatCount="indefinite")
    ),
    g(id="gear4",
      path( d=g4$pathD, fill="rgb(168,128,64)",
            stroke="black",
            stroke.width="2"
      ),
      animateTransform(attributeType="xml",
                       attributeName="transform",
                       type="rotate",
                       from=c(0, g4$cxy),
                       to=c(sign(g4$angularVelocity)*360, g4$cxy),
                       dur=abs(1/g4$angularVelocity),
                       repeatCount="indefinite")   
    )
    
  )
  as.character(doc)
}
