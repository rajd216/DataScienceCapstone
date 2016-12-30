 library(shiny)
library(shinyjs)
library(markdown)

# Define UI for application that draws a histogram
ui <- fluidPage(navbarPage(inverse=TRUE, "Data Science Capstone Course Project",
                tabPanel("Predict Next Words", tags$img(src = 'jhu.png'),
                br(),
                br(),  
                sidebarLayout(sidebarPanel(p("Date: ", span(date())),
                br(),
                br(),
                textInput("text", label = ('Enter a word or phrase'), value = ''),
                sliderInput('slider', 'Max. Number of Words', min = 0,  max = 10,  value = 5),
                HTML("Author: Rajesh D"),
                br(),
                br(),
                em("Note: After entering the words / phrase, 
                  please wait for few seconds to display the predicted / suggested words."),
                br(),
                br()),
                    mainPanel(h3("Predicted Words are shown here below:", style = 'color:blue', align = 'center'), 
                    br(),
                    dataTableOutput('table'),
                    br(),
                    h4(em("Note: When no words are entered, the most common words will be displayed.",
                      style = 'color:red'), align = 'center')
                      ) 
                    )
                  ),
                  tabPanel("About", mainPanel(tags$img(src = 'jhu.png')),
                  br(),
                  br(),
                  br(),
                  includeMarkdown("About.md"))
                  )
                )
              


source('predict.R')
source('main.R')
library(shiny)

server <- function(input, output) {
  output$jhu <- renderImage({})
  # Reactive for prediction function when input changes
  prediction =  reactive( {
    
    # Input
    inputText = input$text
    input1 =  Input(inputText)[1, ]
    input2 =  Input(inputText)[2, ]
    nSuggestion = input$slider
    
    # Predict
    prediction = Predict(input1, input2, n = nSuggestion)
  })
  
  # Output datatable ####
  output$table = renderDataTable(prediction() )
  }

# Run the application 
shinyApp(ui = ui, server = server)
