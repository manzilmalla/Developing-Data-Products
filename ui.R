
library(shiny)
library(markdown)


shinyUI(
    pageWithSidebar(
      headerPanel("Compound Interest Calculator"),
      
      sidebarPanel(
          h3('Standard Calculator'),
          numericInput('Principal', 'Principal Amount', 1000, min = 0, step = 1),
          
          sliderInput('Period', 'Duration:', min=1990, max=2050, step=1, value=c(2010, 2014),format="####"),uiOutput("evtypeControls"),
          
          sliderInput('Interest_Rate', 'Annual Interest Rate %:', min=0, max=10, step=0.1, value=5.0),
          selectInput('Compound_Int', 'Compound Interval:', c("Daily","Monthly", "Quarterly", "Half-Yearly", "Yearly")),
                    
          checkboxInput("inc_inflation", "Include Inflation", FALSE),
          
          sliderInput('Inflation_Rate', 'Inflation Rate %:', min=0, max=5, step=0.1, value=2.5),
          submitButton('Calculate'),
          hr()
  ),
  
  mainPanel(
      tabsetPanel(
    
        tabPanel('App',
          verbatimTextOutput("finaltext"),
    
          h4('Balance is:'),
          verbatimTextOutput("amount"),
    
          h4('Interest is:'),
          verbatimTextOutput("interest")
        ),
        tabPanel('About',
                 mainPanel(
                   includeMarkdown("about.md")
                 )       
        )
      )
  



)))