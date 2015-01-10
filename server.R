
library(shiny)
library(svgR)

source("sampleLoader.R")
#source("./samples//samplesList.R")
shinyServer(function(input,output, session){

  observe({
    # We'll use the input$controller variable multiple times, so save it as x
    # for convenience.
    the.category <- input$exCat
    # read in the list of choices
    catFiles<-readCatFiles(the.category) 
    
    # Change values for input$inRadio
    updateRadioButtons(session, "inRadio", 
                       label="Choose sample",
                       choices = catFiles
    )    
  })
  
  output$radioButtons = renderUI({
    nTabs = input$nTabs
    myTabs = lapply(paste('Tab', 1: nTabs), tabPanel)
    do.call(tabsetPanel, myTabs)
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
  output$rSource <-renderText({ #todo, read from file, so comments can be shown.
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