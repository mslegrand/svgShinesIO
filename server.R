
library(shiny)
library(svgR)

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
     eval(parse(text=src))
     HTML(fn())
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