#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(knitr)

intro_main_content <- 
    uiOutput('markdown')



    intro_panel <- tabPanel(
      "Intro",
      titlePanel("Introduction"),
        # Your `map_main_content`
      
      intro_main_content
      )
    
    plot_sidebar_content <- sidebarPanel(
      sliderInput("year", label = "Filter Year", min = 1750, max = 2021, value = c(1750, 2021)),
      selectInput("date", "Select Year (1750-2021):", choices = sort(co2_emissions$year), multiple = TRUE, selected = co2_emissions$year)
    )
    
   plot_main_content <- mainPanel(
      plotOutput("co2_emissions_plot")
    )
    
    
    plot_panel <- tabPanel(
      "Plot",
      titlePanel("Interactive Page"),
      # A `sidebarLayout()` that contains...
      sidebarLayout(
        
        plot_sidebar_content,
        
        plot_main_content
      )
    )
  
        
ui <- navbarPage(
          "CO2 Emissions",
          intro_panel, 
          plot_panel
        )
