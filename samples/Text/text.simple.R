
#' @name    text.simple
#' @title   Basic Text
#' @concepts  Text
#' @family Text
#' @details
#' @description Illustrates a simple line of text
#' 
fn<-function(){
doc<-svgDoc.new()
doc[["root"]](text(id="my.text", x=50, y=50, "hello shiny!"))
as.character(doc)
}
