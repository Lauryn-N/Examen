library(shiny)
library(dplyr)
library(ggplot2)
library(DT)
library(bslib)
library(thematic)
library(reshape2)



ui <- fluidPage(
  
  theme = bs_theme(
    version = 5,
    bootswatch = "minty"
  ),
  
    titlePanel("Exploration des Diamants"),

    sidebarLayout(
        sidebarPanel(
          
          
          
          radioButtons("radio", label = h3("Colorier les points en rose ?"),
                       choices = list("Oui" = 1, "Non" = 2 ), 
                       selected = 1),
          
          hr(),
          fluidRow(column(2, verbatimTextOutput("value")))
          
          selectInput("Color_Input", "Choisir une couleur à filtrer :", choices = unique(diamonds$color), selected = "D"),
          
            sliderInput("price",
                        "Prix maximum :",
                        min = 300,
                        max = 20000,
                        value = 5000),
        ),
        
           
        mainPanel(
           plotOutput("diamondsplot")
        )
    )
)


server <- function(input, output) {
  
  thematic::thematic_shiny(font = "Minty")
  
    output$diamondsplot <- renderPlot({
      diamonds %>%
        filter(color == input$Color_Input) %>%    
        
        ggplot(aes(x = carat, y = price, color = color)) +
        geom_point(alpha = 0.6) +                
        labs(
          x = "Carat",
          y = "Price",
          title = paste("Diamants de couleur :", input$Color_Input)
        ) +
        theme_minimal()
    })
    
    output$value <- renderPrint({ input$radio })
}  
    
    



shinyApp(ui = ui, server = server)
