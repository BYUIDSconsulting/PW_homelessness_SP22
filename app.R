library(shiny)
library(tidyverse)
library(plotly)
library(dplyr)
library(readr)
library(shinycssloaders)
library(trelliscopejs)
library(shinythemes)
library(shinydashboard)
library(readr)
library(homelessR)

hud <- hud_data
bea <- left_join(gdp_data, total_employment_data)
census <- census_data
full <- full_data
  
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        h3('Create your own trelliscope'),
        selectInput(inputId = 'x_axis', 
                    label = 'What column do you want for the x-axis?',
                    choices = colnames(full)),
        selectInput(inputId = 'y_axis',
                    label = 'What column do you want for the y-axis?',
                    choices = colnames(full)),
        selectInput(inputId = 'facet',
                    label = 'What would you like to facet by?',
                    choices = c('state', 'Year')),
        textInput(inputId = 'save_trell',
                  label = 'Name to Save'),
        actionButton(inputId = 'trells',
                     label = 'Create Trelliscope'),
        h3('View Pre-made Trelliscopes'),
        selectInput(inputId = 'trello',
                    label = 'Pre-made Trelliscopes',
                    choices = c('Violent Crime over the Years by State', 'Murder over the Years by State',
                                'Rape over the Years by State', 'Robbery over the Years by State', 
                                'Aggravated Assailt over the Years by State', 
                                'Property Crime over the Years by State', 'Burglary over the Years by State', 
                                'Theft over the Years by State', 'Motor Vehicle Theft over the Years by State',
                                'Arson over the Years by State')),
        actionButton(inputId = 'view_trells',
                     label = "View") ## view_trells 
      ), # sidebarPanel
      
      mainPanel(
        withSpinner(trelliscopeOutput(outputId = 'plot')),
        textOutput(outputId = 'description_funding_graph')
      ) # mainPanel
    ) # sidebarLayout
  ) # fluidPage

server <- function(input, output, session) {
  observeEvent(input$view_trells, {
    showModal(modalDialog(title = 'Link to Trelliscope:',
                          helpText(a('Click the link to view trelliscope', 
                                     href = paste0('~/homelessR/create_url/www/index.html#display=', input$trello, '&nrow=2&ncol=2&arr=row&pg=1&labels=state&sort=state;asc&filter=&sidebar=-1&fv=',
                                                   target = 'blank'))),
                          easyClose = TRUE))
  })
}

observeEvent(input$trells, {
## when the button is clicked, create the trelliscope in the shiny app

 output$plot <- renderTrelliscope({
    input$trells

  trell <- ggplot(data = full, aes_string(x = isolate(input$x-axis), y = isolate(input$y-axis))) +
    geom_line() +
    geom_point() +
    theme_bw() +
    ylab(input$column) +
    facet_trelliscope(~ input$facet, nrow = 2, ncol = 2, name = input$save_trell, 
                      path = '~/homelessR/create_url/www')

  trell <- ggplot(data = full, aes_string(x = isolate(input$x_axis), y = isolate(input$y_axis))) +
    geom_line() +
    geom_point() +
    theme_bw() +
    ylab(isolate(input$y_axis)) +
    facet_trelliscope(~ isolate(input$facet), nrow = 2, ncol = 2, name = isolate(input$save_trell), 
                      path = '/Users/Becca/Documents/Data Consulting/homelessR/create_url/www')

       ggsave(trell)
 trell
#crime %>%
#  group_by(input$facet) %>% 
#  nest() %>%
#  mutate(
#    panel = map_plot(data, ~
#                       ggplot(data = crime, aes_string(x = input$x-axis, y = input$y-axis)) +
#                       geom_line() +
#                       gemo_point() +
#                       theme_bw() +
#                       ylab(input$column)
#    )) %>%
#  ungroup() %>%
#  trelliscope(name = "Crime and Homelessness", ncol = 2, nrow = 2, self_contained = TRUE)
#)
 }) ## end of the trelliscope

}) ## observeEvent for trells


# Run the application 
shinyApp(ui = ui, server = server)
