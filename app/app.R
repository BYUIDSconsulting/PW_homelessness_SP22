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
<<<<<<< HEAD:app/app.R
        h3('Create your own trelliscope'),
        selectInput(inputId = 'x_axis', 
                    label = 'What column do you want for the x-axis?',
                    choices = colnames(full),
                    selected = 'Year'),
        selectInput(inputId = 'y_axis',
                    label = 'What column do you want for the y-axis?',
                    choices = colnames(full),
                    selected = "violent_crime"),
        selectInput(inputId = 'facet',
                    label = 'What would you like to facet by?',
                    choices = c('state', 'Year'),
                    selected = "state"),
        textInput(inputId = 'save_trell', value = "crime",
                  label = 'Name to Save'),
        actionButton(inputId = 'trells',
                     label = 'Create Trelliscope'),
        h3('View Pre-made Trelliscopes'),
=======
>>>>>>> 3b1b2802962638031aae313c11744846f3ef2862:app.R
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
                                     href = paste0('~/www/index.html#display=', input$trello, '&nrow=2&ncol=2&arr=row&pg=1&labels=state&sort=state;asc&filter=&sidebar=-1&fv=',
                                                   target = 'blank'))),
                          easyClose = TRUE))
  })
  
  
  
  observeEvent(input$trells, {
    ## when the button is clicked, create the trelliscope in the shiny app
    print(getwd())
    output$plot <- renderTrelliscope({
      
      # text input for formulat in facet
      var <- paste("~", isolate(input$facet))
      print(var)
      
      full %>%
       group_by(.data[[isolate(input$facet)]]) %>%
       nest() %>%
       mutate(
         panel = map_plot(data, function(x) {
                            ggplot(data = x,
                              aes_string(
                                x = isolate(input$x_axis), 
                                y = isolate(input$y_axis))) +
                            geom_line() +
                            geom_point() +
                            theme_bw() +
                            ylab(isolate(input$y_axis)) }
         )) %>%
       ungroup() %>%
       trelliscope(
         name = isolate(input$save_trell),
         ncol = 2, nrow = 2, path = "www/", self_contained = TRUE)
      
      
      
      # ggplot(data = full, aes_string(x = isolate(input$x_axis), y = isolate(input$y_axis))) +
      #   geom_line() +
      #   geom_point() +
      #   theme_bw() +
      #   ylab(isolate(input$y_axis)) +
      #   facet_trelliscope(as.formula(var), nrow = 2, ncol = 2,
      #                     name = isolate(input$save_trell), self_contained = TRUE)
      # 
      # just to check.  Can be commented out when fixed.
      cat("hello", file = "www/outfile.txt", sep = "\n", append = TRUE)
      
    }) ## end of the trelliscope
    
  }) ## observeEvent for trells
  
}

<<<<<<< HEAD:app/app.R
=======
observeEvent(input$trells, {
## when the button is clicked, create the trelliscope in the shiny app

 output$plot <- renderTrelliscope({
    input$trells

  trell <- ggplot(data = full, aes_string(x = isolate(input$x_axis), y = isolate(input$y_axis))) +
    geom_line() +
    geom_point() +
    theme_bw() +
    ylab(isolate(input$y_axis)) +
    facet_trelliscope(~ isolate(input$facet), nrow = 2, ncol = 2, name = isolate(input$save_trell), 
                      path = '/Users/Becca/Documents/Data Consulting/homelessR/create_url/www')
       ggsave(trell)
  return(trell)
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

>>>>>>> 3b1b2802962638031aae313c11744846f3ef2862:app.R

# Run the application 
shinyApp(ui = ui, server = server)