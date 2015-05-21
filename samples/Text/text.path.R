
#' @name    text.path
#' @title   Text Along a Path
#' @concepts  Text, Paths
#' @family Text
#' @details
#' @description Illustrates text along a path
#' 
fn<-function(){
  svgR(width="12cm", height="12cm", viewBox="0 0 600 300",
    defs( 
      path(id="MyPath", 
           #d = "M 60 0 L 120 0 L 180 60 L 180 120 L 120 180 L 60 180 L 0 120 L 0 60")
           d = list(M=c(60, 0),     L=c(120, 0), L=c(180, 60), 
                    L=c(180, 120), L=c(120,180), L=c(60,180), 
                    L=c(0,120), L=c(0, 60))
      ) 
    ), 
    text(  font.family="Verdana", font.size=20, fill="blue",
           textPath("Wow, too much beer!", 
                    "xlink:href"="#MyPath"
           )
    )
  )
}
