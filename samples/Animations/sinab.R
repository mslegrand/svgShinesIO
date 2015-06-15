
#' @name    sinOfAPlusB
#' @title   sin(a+b)
#' @concepts  AnimateTransform
#' @family Animations
#' @details
#' @description Proof as story
#'   
fn=function(){
  begTxt<-c(20,30)
  begGrph<-c(20,45)
  center<-begGrph+c(60,70)
  alpha<-0.1*pi
  beta<-0.3*pi
  
  # point data
  angleColor<-c("pink","lightblue")
  sideID<-c('cos', 'hyp', 'sin')
  colors<-c(hyp="red",sin="blue", cos="green", "purple")
     
  #points to be used for triangles and arcs
  #origin is upper left
  alphaPts1<- matrix(c(c(0,0),c(cos(alpha),0), c(0,sin(alpha)), c(0,0)),2,4)
  alphaPts0<- matrix(c(cos(alpha),sin(alpha)),2,4)-alphaPts1
  betaPts1<-  matrix(c(c(0,0),c(cos(beta),0), c(0,-sin(beta)), c(0,0)),2,4)
  betaPts0<-  matrix(c(cos(beta),sin(alpha)),2,4)-betaPts1
  betaPts1<-  matrix(c(0,sin(alpha)+sin(beta)),2,4)+betaPts1
  
  # points for second backgroud
  pathOuter2<-list( 
    M=c(0,sin(alpha)),  
    L=c(cos(alpha),0),
    L=c(cos(alpha)+cos(beta), sin(beta)),
    L=c(cos(beta),sin(beta)+sin(alpha)),
    Z=0
  ) 
  
  ptsSAB1<- c(cos(alpha),0) 
  ptsSAB2<- c(0,sin(alpha)) + cos(alpha+beta)*c(cos(beta),sin(beta))
  ptsS3<-matrix(c(ptsSAB2,  c(0,sin(alpha)), c(cos(alpha),0), ptsSAB2),2,4)
  ptsS4<-matrix(
           c(ptsSAB2,  
           c(cos(beta),sin(alpha)+sin(beta)), 
           c(cos(alpha)+cos(beta), sin(beta)), 
           c(cos(alpha),0), 
           ptsSAB2), 
           2,5)

  # scales the points, should replace this
  scalePts<-function(x, f=120){
    if(inherits(x, "list")){
      x<-lapply(x, function(v)v*f)
    } else {
      x<-x*f
    }      
  }

  # builds arc for angle given pts of triangle
  pts2Arc<-function(pts, sweep, sf=30){
    norm<-function(v) sqrt(v%*%v)
    normalize<-function(v){ v/norm(v) }
    vn<-function(v1,v2,sf){ v1+sf*normalize(v2-v1) }
    vn1<-vn(pts[,2],pts[,3],sf)
    vn2<-vn(pts[,2],pts[,1],sf)
    r<-norm(vn2) #norm(vn2)/1000
    list( M=pts[,2], L=vn1, A=c(r,r,0,0,1-sweep,vn2), Z=0)
  }
  
  # builds tringale from given points
  addTriangle<-function(tri.id, tri.pts, sweep,  visibility='hidden'){
    tri.pts<-scalePts(tri.pts)
    g(  id=tri.id, visibility=visibility, fill="white",
        lapply(1:3, # the sides
               function(i){   #1=hyp, 2=sin, 3=cos            
                 line(id=paste0(tri.id,"-",sideID[i]), 
                      stroke.width=2, 
                      stroke=colors[[ sideID[i] ]],
                      xy1=tri.pts[,i], 
                      xy2=tri.pts[,i+1])           
               }                 
        ),
        polygon(id=paste0(tri.id,"-interior"),
              points=tri.pts[,1:4],  stroke="black"),
        path( id=paste0(tri.id,"-angle"),
              d=pts2Arc(tri.pts, sweep),
              fill=angleColor[1+sweep], 
              stroke="black" 
        )        
    )      
  }
  
  # Here we declare all objects to be animated
  doc<-svgR(wh=c(800,400))
  doc[['root']](
    g(id = "textArea1",  transform=list(translate=begTxt)),
    g(id = "textArea2",  transform=list(translate=begTxt+c(0,15))),
    g(id = "textArea3",  transform=list(translate=begTxt+c(0,30))),
    g(id = "graphArea",  transform=list(translate=c(160,60)),
      g(id='graphAreaR',
        rect(id="Outer", 
             xy=scalePts(c(0,0)), 
             wh=scalePts(c(cos(alpha)+cos(beta), sin(alpha)+sin(beta))) ,
             stroke="black", fill="khaki", visibility='hidden'),
        rect(id="sinacosb", 
             wh=scalePts(c(cos(beta),sin(alpha))), 
             xy=scalePts(c(cos(alpha),0)), stroke="black", 
             fill="pink", visibility='hidden'),
        rect(id="cosasinb", wh=scalePts(c(cos(alpha),sin(beta))), 
             xy=scalePts(c(0,sin(alpha))), stroke="black", 
             fill="lightblue",  visibility='hidden'),
        path(id='Outer2', d=scalePts(pathOuter2), visibility='hidden',
             stroke='red', stroke.width=2,
             fill='khaki'
        ),
        g(id='angles', visibility='hidden',
          path( id=paste0('alpha','-angle'),
                d=pts2Arc(scalePts(alphaPts0), 0),
                fill=angleColor[1], 
                opacity=0.2,
                stroke="black" 
          ),        
          path( id=paste0('beta','-angle'),
                d=pts2Arc(scalePts(betaPts0), 1),
                fill=angleColor[2], 
                opacity=0.2,
                stroke="black" 
          ) 
        ),
        g(id="A", 
          addTriangle("triangle-I",  alphaPts0, sweep=0, visibility='visible'),
          addTriangle("triangle-II", alphaPts1, sweep=0, visibility ='hidden')
        ),
        g(id="B", opacity=1,
          addTriangle("triangle-III", betaPts0, sweep=1,  visibility='hidden'),
          addTriangle("triangle-IV",  betaPts1, sweep=1, visibility='hidden')
        ),
        g(id='Outer3-2', visibility='hidden',
          polygon(id='Outer3-2-Poly',  
                  points=scalePts(ptsS4)[,1:4],
                  stroke='red', stroke.width=2,
                  fill='khaki'
          ),
          line(id='Outer3-2-upperLeg',
               xy1=scalePts(ptsS4[,3]),
               xy2=scalePts(ptsS4[,4]),
               stroke.width=2,
               stroke='red'
          )
        ),
        addTriangle("triangle-V",  matrix(ptsS3,2,4), sweep=0, visibility='hidden'),
        line(id='sinAplusB', visibility='hidden',
             xy1=scalePts(ptsSAB1),
             xy2=scalePts(ptsSAB2),
             stoke.width=3,
             stroke='purple')
      )     
    )
  )
  
  # here we define our animation routines
  story.new<-function(adoc, dt=2){
    doc=adoc
    delta=dt  
    indx<-0
    textAreaIds<-list(textArea1=NULL,textArea2=NULL,textArea3=NULL)
    function(code){
      fnsList<-list(
        step=function(inc=1){
          indx<<-indx+inc
        },
        
        btime=function(){
          indx*delta
        },
        
        displayText=function(txt, color="black"){ 
          if(!is.null(textAreaIds[[textArea]])){
            tid<-textAreaIds[[textArea]]
            doc[[tid]](
              set(attributeName="visibility", to='hidden', 
                  begin=btime(), fill="freeze")
            )
          }
          txtId=paste0("txt-",indx )  
          doc[[textArea]]( 
            text(id=txtId, xy=c(0,0), visibility='hidden',           
                 stroke=color, font.size=12,
                 lapply(txt, function(tx){
                   if(grepl("^\\\\",tx)){
                     tspan(mathSymbol(tx))
                   } else {
                     tspan(tx)
                   }}),
                 set(attributeName="visibility", to="visible", begin=btime())
            ))
          textAreaIds[[textArea]]<<-txtId
          txtId
        },
        
        moveTo=function(id, from, to){
          doc[[id]](
            animateMotion( from=from, to=to , begin=btime(), dur=delta, fill="freeze")
          )
        },
        
        rotate=function(id, angles, about=c(0,0)){
          doc[[id]](
            animateTransform( 
              attributeName="transform",
              type="rotate",
              from=c(angles[1], about ),
              to=c(angles[2], about),             
              begin=btime(), 
              dur=delta, 
              fill="freeze"
            ))
        },
        
        setFill=function(id, value, dur=delta){
          doc[[id]](set(attributeName="fill", attributeType="CSS", to=value, begin=btime() , dur=dur)
          )  
        },
        
        setStrokeDecoration=function(id, dur=delta){
          doc[[id]](
            set(attributeName="stroke-width", attributeType="CSS", to=5, 
              begin=btime(), dur=dur),             
            set(attributeName="stroke-dasharray", attributeType="CSS", to=5, 
              begin=btime(), dur=dur)
          )
        },
        
        setStroke=function(id, value, dur=delta){
          doc[[id]](
            set(attributeName="stroke", to=value, begin=btime(), dur=dur )
          )  
        },
        
        setVisibilty=function(id, value, dur=delta){
          doc[[id]](
              set(attributeName="visibility", to=value, begin=btime(), dur=dur )
          )  
        },
        
        setOpacity=function(id, value, dur=delta){
          doc[[id]](
              set(attributeName="opacity", attributeType="CSS", to=value, begin=btime(), dur=dur)             
          )
        }
      )      
      eval(substitute(code), list2env(fnsList, parent.frame() ))
      tmp<-as.character(doc)
      tmp
    }
  }
  
  story<-story.new(doc)
    
  # here we define our story
  story({
    textArea<-'textArea1'
    displayText('A right triangle')
    step()
    
    displayText(c('Angle ', '\\alpha' ), color='red')
    setFill('triangle-I-angle','red')
    step()
    
    displayText('Length=1', color=colors[1])
    setStrokeDecoration('triangle-I-hyp')
    step()
    
    displayText(c('sin( ','\\alpha',' )'),    color='blue')
    setStrokeDecoration('triangle-I-sin')
    step()
    
    displayText(c('cos( ', '\\alpha',' )'),color='green')
    setStrokeDecoration('triangle-I-cos')
    step()
    
    displayText('A second right triangle')
    setVisibilty('triangle-III','visible','indefinite')
    step()
    
    displayText(c('Angle ', '\\beta'), color='blue')
    setFill('triangle-III-angle','blue')
    step()
    
    displayText('Length=1', color=colors[1])
    setStrokeDecoration('triangle-III-hyp')
    step()
    
    displayText(c('sin( ', '\\beta' ,' )'),color='blue')
    setStrokeDecoration('triangle-III-sin')
    step()
    
    displayText(c('cos( ', '\\beta',' )' ),color='green')
    setStrokeDecoration('triangle-III-cos')
    step()
    
    displayText('Add a clone of the first triangle')
    setVisibilty('triangle-II','visible','indefinite')
    step()
    
    displayText('Add a clone of the second triangle')
    setVisibilty('triangle-IV','visible','indefinite')
    step()
    
    displayText('Slide the bottom to the right')
    moveTo('triangle-III', from=c(0,0), to=scalePts(c(cos(alpha) , 0)))
    moveTo('triangle-IV',  from=c(0,0), to=scalePts(c(cos(alpha) , 0)))
    step()
    
    displayText(c('sin( ', '\\alpha',' )'),    color='blue')
    setStrokeDecoration('triangle-I-sin')
    step()
    
    displayText(c('cos( ', '\\beta',' )'),    color='green')
    setStrokeDecoration('triangle-III-cos')
    step()
    
    displayText(  
      c('Area= sin( ','\\alpha',' )', '\\times', 'cos( ', '\\beta',' )'), 
      color='red'
    )
    setStrokeDecoration('triangle-I-sin')
    setStrokeDecoration('triangle-III-cos')
    setVisibilty('sinacosb', 'visible','indefinite')
    step()
    
    displayText(c('cos( ', '\\alpha' ,')'),    color='green')
    setStrokeDecoration('triangle-I-cos')
    step()
    
    displayText(c('sin( ', '\\beta',')'),    color='blue')
    setStrokeDecoration('triangle-IV-sin')
    step()
    
    displayText(  
      c('Area = cos( ', '\\alpha',' )','\\times',' sin( ', '\\beta'," )"
      ), color='blue'
    )
    setStrokeDecoration('triangle-I-cos')
    setStrokeDecoration('triangle-IV-sin')
    setVisibilty("cosasinb", 'visible','indefinite')
    step()
    
    displayText(  
      c('Area= sin(', '\\alpha', ') ', '\\times', ' cos(', '\\beta', ')',
        ' + ', 'cos(', '\\alpha', ') ', '\\times', ' sin(', '\\beta', ')'),
      color='brown'
    )
    setVisibilty("Outer", 'visible','indefinite')
    setVisibilty("sinacosb", 'hidden','indefinite')
    setVisibilty("cosasinb", 'hidden','indefinite')   
    step()
    
    moveTo("triangle-IV",  to=c(0,0), from=scalePts(c(cos(alpha) , 0)))
    step()
    
    setVisibilty('angles','visible','indefinite')
    moveTo("triangle-III",  from=scalePts(c(cos(alpha) , 0)), to=scalePts(c(cos(alpha) , -sin(alpha))))
    step()
    
    moveTo("triangle-I",  from=scalePts(c(0 , 0)), to=scalePts(c(cos(beta) , sin(beta))))
    step()
    
    textArea<-'textArea2'
    setVisibilty('Outer2','visible','indefinite')
    setVisibilty('Outer','hidden','indefinite')
    sapply(paste0("triangle-",c("I","II","III","IV")),
           function(id) setOpacity(id,0.3, dur='indefinite')
    )
    displayText(c('angle', '\\alpha'),color='red')
    setOpacity('alpha-angle',1)
    step()
    
    displayText(c('angle', '\\beta'),color='blue')
    setOpacity('beta-angle',1)
    step()
    
    displayText(c('angle', '\\alpha',' + ','\\beta'),color='black')
    setOpacity('alpha-angle',1, dur="indefinite")
    setOpacity('beta-angle',1, dur="indefinite")
    step()
    
    displayText('Rotate a little')
    rotate('graphAreaR', angles=c(0, -180*beta/pi), 
           about=scalePts(c((cos(alpha)+cos(beta))/2, (sin(alpha)+sin(beta))/2)))
    step()
    
    
    displayText('Drop a perpendicular')
    step(0.5)
    
    setVisibilty('sinAplusB','visible','indefinite')
    step()
    
    displayText('Length=1', color=colors[1])
    setStrokeDecoration('triangle-II-hyp')
    step()
    
    displayText(c('sin( ','\\alpha',' + ','\\beta' ,' )'), color='purple')
    setVisibilty('triangle-V-angle','hidden','indefinite')
    setVisibilty('triangle-V','visible','indefinite')
    setVisibilty('Outer3-2','visible','indefinite')
    setFill('triangle-V','lightyellow')
    setOpacity('triangle-V-interior',0.5,'indefinite')
    setStrokeDecoration('triangle-V-sin', 'indefinite')    
    setVisibilty("Outer2","hidden",'indefinite')
    step()

    setFill('triangle-V','khaki',"indefinite")
    step(0.5)

    
    displayText('But wait..')
    moveTo('triangle-V', from=scalePts(c(0,0)), 
       to=scalePts(c(cos(beta),sin(beta))))    
    step()
    
    setOpacity('triangle-V-interior',1,'indefinite')
    setStroke('triangle-V-hyp','khaki','indefinite')    
    setStroke('triangle-V-cos','red','indefinite')    
    step(.5) 
    
    displayText('Length=1', color=colors[1] )   
    setStrokeDecoration('Outer3-2-upperLeg', 'indefinite')    
    step()
    
    displayText(c('Area= 1 ','\\times','sin( ','\\alpha',' + ','\\beta' ,' )')
                ,'brown')
    setFill('Outer3-2-Poly','yellow')
    setFill('triangle-V-interior','yellow')
    step()
    
    textArea<-'textArea1'
    displayText( 'So' )
    textArea<-'textArea2'    
    displayText(    
      c('sin( ','\\alpha',' + ','\\beta' ,' )',
        ' = sin(', '\\alpha', ') ',  'cos(', '\\beta', ')',
        ' + ', 'cos(', '\\alpha', ') ',  'sin(', '\\beta', ')'),
      'brown'
    )      
  }
  )->tale
  
}

