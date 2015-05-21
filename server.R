
library(shiny)
library(svgR)

baseTag<-FALSE # set this to TRUE if deploying on shinyapp.IO

shinyServer(function(input,output, session){

  observe({
    the.category <- input$exCat
    # read in the list of choices
    catFiles<-readCatFiles(the.category)     
    updateRadioButtons(session, "inRadio", 
                       label="Choose sample",
                       choices = catFiles
    )    
  })
  
  fileInfo <- reactive({ 
    fileName<-input$inRadio
    fi<-getFileInfo(fileName)
    fi
  })
   

#output section
output$svghtml<-renderUI({
  src<-fileInfo()$src
  svgFn<-eval(parse(text=src))
  as.character(svgFn())->svg
  if(baseTag==TRUE){
    # VERY UGLY KLUDGE for shinyapps.io server
    #  reason is the set the base tag and relative links 
    #  in SVG get misdirected when the base tag is set.
    #  The only way I know to combat this is to use absolute
    #  links in the SVG. But this means we 
    #  need to create absolute links to something, 
    #  so we can't simply rely on the in-memory construction,
    #  We are forced us to save a copy of the svg and  
    #  rewrite the relative urls to the location of that
    #  copy, just so that we can link to gradients, filters, 
    #  clip paths, etc. 
    # Apologies for the lack of elegance:(     saveToFile<-FALSE
    if(any(grepl("url\\( *#", svg)) || any(grepl('xlink:href="#', svg))) {
      fname<-paste0(fileInfo()$name, ".svg") 
      cat(svg, file=paste0('www/',fname))
      svg<-gsub('url\\( *#',paste0('url(',fname,'#'),svg)
      svg<-gsub('xlink:href="#',paste0('xlink:href="',fname,'#'),svg)
    }    
  }
  HTML(svg)
})
#   
  output$rSource <-renderText({ 
    fileInfo()$src
  }) 
# 
  output$description<- renderText({
    fileInfo()$concepts
  })
# 
  output$concepts<- renderText({
    fileInfo()$concepts
  })

  output$raw <- renderText({
  src<-fileInfo()$src
  eval(parse(text=src))
  fn()
  })
  
})