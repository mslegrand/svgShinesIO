
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(svgR)
library(stringr)
source("sampleLoader.R")


catChoice<-dir("samples")

shinyUI(pageWithSidebar(
  headerPanel("SVG Shines"),
  sidebarPanel(
    selectInput("exCat", "SVG Example Category:", catChoice),
    radioButtons( inputId= "inRadio", # ie. choice1
                  label="Choose:", # change to choose Shape...
                  choices=readCatFiles(catChoice[1])
    ),
    wellPanel(
      h3("Description"),
      h6(textOutput("description")),
      h5( "Concepts: "), 
      h6(textOutput("concepts"))
    )
  ),
  mainPanel(
    h3("Tested on Firefox, Safari, Chromium, and Google Chrome"),
    tabsetPanel(
      tabPanel("SVG Image",              
               htmlOutput("svghtml") 
               ),
      tabPanel("R Source Code",
               verbatimTextOutput("rSource")
      ),
      tabPanel("Generated SVG",
               verbatimTextOutput("raw")
               ),
      tabPanel("About",
        h2("About"),
        p("This work is based upon",
        strong(em("svgR")) , 
          "which is an experimental R package available on",
        a("github.", href='https://github.com/mslegrand/svgR'),
          "This app,",
        strong(em("shinySVG,")),
        "is also available on",
        a("github.", href='https://github.com/mslegrand/shinySVG')
        ),
        p("The implementation of svgR uses Duncan Lang's ",
          a("R XML package.", href="http://www.omegahat.org/RSXML/"),
          "available on",
          a("CRAN", href="http://cran.r-project.org/"),
          "The SVG specifications were obtained from",
          a("W3C.", href="http://www.w3.org/TR/SVG/Overview.html"),
          "but are also available in a more readable form at ",
          a("MDN.", href="https://developer.mozilla.org/en-US/docs/Web/SVG"),
          "The design of the svgR 
          package is inspired  by",
          a( "Hadely Wickham's DSL tutorial", href="http://adv-r.had.co.nz/dsl.html")
          ),
        p(),
        p(strong('Final Note:'), 
          'This is effort is still in flux and subject to change')
      )
    )
  )
))
