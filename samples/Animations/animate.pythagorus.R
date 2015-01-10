
#' @name    animate.pythagorus
#' @title   Pythagorus
#' @concepts  AnimateTransform
#' @family Animations
#' @details
#' @description Proof as story
#'   
fn<-function(){
  colors<-c("red","blue", "green", "orange")
  A=80
  B=60
  triPts<-matrix(c(c(0,0),c(A,0),c(0,-B),c(0,0)),2,4)
  trianglePts<-list(
    lower= triPts,
    upper=matrix(c(A,-B),2,4)-triPts
  )
  center<-c(150,150) # center
  triangleID<-paste0("triangle-",1:4)
  dur<-0.5
  
  addTriangle<-function(tri.id, tri.pts, opacity=1, fillColor="white"){
    g(  id=tri.id, opacity=opacity,
        lapply(1:3, 
               function(i){               
                 line(id=paste0(tri.id,"-",i), 
                      opacity=1,  stroke.width=2, 
                      stroke=colors[i],
                      xy1=tri.pts[,i], 
                      xy2=tri.pts[,i+1])           
               }                 
        ),
        polygon(points=tri.pts[,1:4], fill=fillColor, stroke="black", opacity=1)
    )      
  }
  
  doc<-svgDoc.new()
  doc[['root']](
    g(id = "textArea",  transform=list(translate=(center*c(0.8,0.3)))),
    g(id = "graphArea", transform=list(translate=center),
      rect(id="ASquared", wh=c(A,A), xy=-c(0,A), stroke="black", 
           fill="pink",  opacity=0),
      rect(id="BSquared", wh=c(B,B), xy=-c(B,0), stroke="black", 
           fill="lightgreen", opacity=0),
      rect(id="CSquared", wh=c(A+B,A+B), xy=-c(B,A), stroke="black", 
           stroke.width=3, fill=colors[4], opacity=0),  
      g(id="A", 
        addTriangle("triangle-I", trianglePts$lower, opacity=1),
        addTriangle("triangle-II", trianglePts$upper, opacity=0)
      ),
      g(id="B", opacity=0,
        addTriangle("triangle-III", trianglePts$lower, opacity=1),
        addTriangle("triangle-IV", trianglePts$upper, opacity=1)
      )
    )
  )
  
  
  story.new<-function(adoc, dt=2){
    doc=adoc
    delta=dt  
    indx<-0
    function(code){
      fnsList<-list(
        step=function(){
          indx<<-indx+1
        },
        btime=function(){
          indx*delta
        },
        displayText=function(txt, color="black", freeze=FALSE){
          txtId=paste0("txt-",indx )  
          doc[["textArea"]]( text(id=txtId, xy=c(0,0), opacity=0,           
                                  stroke=color, font.size=12,
                                  lapply(txt, function(tx){
                                    if(grepl("^\\^",tx)){
                                      tx<-gsub("^\\^","",tx)
                                      tspan(y=-6, tx, font.size=6)
                                    } else {
                                      tspan(y=0, tx)
                                    }}),
                                  if(!freeze){
                                    set(attributeName='opacity', to=1, begin=btime(), dur=delta)
                                  }  else {
                                    set(attributeName='opacity', to=1, begin=btime())
                                  }
          ))
        },
        wideStroke=function(id){
          doc[[id]](
            set(attributeName="stroke-width", attributeType="CSS", to=5, begin=btime(), dur=delta)
          )
        },
        setOpacity=function(id, value){
          doc[[id]](
            set(attributeName="opacity", attributeType="CSS", to=value, begin=btime(), dur=delta, fill="freeze")
          )  
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
        setFill=function(id, value){
          doc[[id]](set(attributeName="fill", attributeType="CSS", to=value, begin=btime() )
          )  
        }
      )
      
      eval(substitute(code), list2env(fnsList, parent.frame() ))
      tmp<-as.character(doc)
      tmp
    }
  }
  
  story<-story.new(doc)
  
  story({
    displayText('A right triangle')
    step()
    displayText('Side A', color=colors[1])
    wideStroke("triangle-I-1")
    
    step()
    displayText('Side B', color=colors[3])
    wideStroke("triangle-I-3")
    
    step()
    displayText('Side C', color=colors[2])
    wideStroke("triangle-I-2")
    
    step()
    displayText('An A by B rectangle ')
    setOpacity("triangle-II", 1)
    
    step()
    displayText('Copy')
    setOpacity("B", .5)
    moveTo("B", from=c(0,0), to=c(0,B))
    
    step()
    displayText('Rotate')
    setOpacity("B", 1)
    rotate("A", angles=c(0,-90), about=c(0,0))
    
    step()
    displayText(c('A ', '^2') , 'red')
    setOpacity("ASquared", 1)
    
    step()
    displayText(c('B','^2'), 'green')
    setOpacity("BSquared", 1)
    
    step()
    displayText(c('A', '^2',' + ','B', '^2'), 'brown')
    setOpacity("CSquared", 1)
    
    step()
    displayText(c('A', '^2',' + ','B', '^2'), 'brown')
    moveTo("triangle-III", from=c(0,0), to=c(-B,0))
    
    step()
    displayText(c('A', '^2',' + ','B', '^2'), 'brown')
    moveTo("triangle-IV", from=c(0,0), to=c(0,-A))
    
    step()
    displayText(c('A', '^2',' + ','B', '^2'), 'brown')
    moveTo("triangle-I", from=c(0,0), to=c(-B,A))
    
    step()
    displayText(c('A', '^2',' + ','B', '^2',' = ','C','^2'), 'blue', freeze=TRUE)
    setFill("CSquared", "lightblue" )  
  }
  )->tale
  
}
