
#' @name  omega.inMarble
#' @title Omega in Marble
#' @family Filters
#' @concepts  Text,  Filters,
#' @details
#' @description Demonstrates the use of filters to produce a marble effect
fn<-function(){
doc<-svgDoc.new(wh=c(600,200))  
doc[["root"]](
  defs(
    filter( id="marble",
      feTurbulence( in1="SourceGraphic", type="turbulence", 
          baseFrequency=0.05, numOctaves=2, result="marb"
      )
    ),
    clipPath( id="clp1",  text(id="t2", xy=c(0,0), 
      mathSymbol("\\Omega"), stroke="black",
      stroke.width=1, font.size=250, font.weight="bold"
    )     
  )      
), 
  g( transform=list(translate=c(50,200)), 
    use(xlink.href="#t2", stroke="grey",
      fill="lightgrey" , transform=list(scale=c(1,0.4), skewX=-60) 
    ),
    g( transform=list(translate=c(5,-3)),
      use(xlink.href="#t2",fill="grey", stroke="black"),
      rect(xy=-c(0,200),wh=c(800,400), fill="blue",
        filter="url(#marble)", clip.path="url(#clp1)"
      )       
    ),
    use(xlink.href="#t2",fill="white", stroke="black"),
    rect(xy=-c(0,200),wh=c(800,400), 
      fill="white", filter="url(#marble)", clip.path="url(#clp1)"
    ),
    use(xlink.href="#t2", fill="none")
  )
) 
as.character(doc)  
}
