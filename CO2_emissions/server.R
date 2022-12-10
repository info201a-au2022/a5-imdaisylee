#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

co2_emissions <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
co2_difference <- co2_emissions %>% group_by(year) %>% summarise(co2 = sum(co2, na.rm = TRUE)) %>% 
  select(year, co2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$markdown <- renderUI({
    HTML(markdown::markdownToHTML(knit('intro_a5.rmd', quiet = TRUE)))
  })
    
    output$co2_emissions_plot <- renderPlot({
        
      co2_difference <- co2_difference %>% filter(year %in% input$year[1]:input$year[2]) %>% filter(year %in% input$date)
      
        ggplot(co2_difference, aes(x = year, y = co2)) +
        geom_line(aes(group = 1)) +
        labs(title = "Total CO2 Emissions Per Year", x = "Year", y = "Amount of CO2 Emission")
        })

})
