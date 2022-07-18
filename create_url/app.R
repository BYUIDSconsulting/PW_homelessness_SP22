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
## our data
full <- full_data
funding <- spending_data

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = 'gdp_bea_cols', 
                  label = 'BEA (Bureau of Economic Analysis) - GDP',
                  choices = c('Year', 'gdp_per_state_per_year', 'state')),
      selectInput(inputId = 'tot_emp_bea_cols',
                  label = 'BEA (Bureau of Economic Analysis) - Total Employment',
                  choices = c('Year', 'num_of_jobs', 'state')),
      selectInput(inputId = 'census_cols',
                  label = 'Census',
                  choices = c("state","Year", "Estimate_Total_Male","Estimate_Total_Male_Under 5 years",
                              "Estimate_Total_Male_5 to 9 years", "Estimate_Total_Male_10 to 14 years",      
                              "Estimate_Total_Male_15 to 17 years", "Estimate_Total_Male_18 and 19 years",    
                              "Estimate_Total_Male_20 years", "Estimate_Total_Male_21 years",            
                              "Estimate_Total_Male_22 to 24 years","Estimate_Total_Male_25 to 29 years",      
                              "Estimate_Total_Male_30 to 34 years", "Estimate_Total_Male_35 to 39 years",       
                              "Estimate_Total_Male_40 to 44 years","Estimate_Total_Male_45 to 49 years")),
      selectInput(inputId = 'crime_cols',
                  label = 'Crime',
                  choices = c('state', 'violent_crime', 'murder_and_nonnegligent_manslaughter', 'rape', 'robbery', 'aggravated_assault', 'property_crime', 'burglary', 'larceny_theft', 'motor_vehicle_theft', 'arson', 'year')),
      selectInput(inputId = 'fund_cols',
                  label = 'Funding',
                  choices = c('Column 1', 'Column 2')),
      selectInput(inputId = 'hud_cols',
                  label = 'HUD (Dept. Housing and Urban Development)',
                  choices = c("state", "Number of CoCs","Overall Homeless","Sheltered ES Homeless","Sheltered TH Homeless","Sheltered Total Homeless",                      
                              "Unsheltered Homeless","Overall Homeless Individuals","Sheltered ES Homeless Individuals",
                              "Sheltered TH Homeless Individuals", "Sheltered Total Homeless Individuals", "Unsheltered Homeless Individuals",
                              "Overall Homeless People in Families","Sheltered ES Homeless People in Families",
                              "Sheltered TH Homeless People in Families","Sheltered Total Homeless People in Families",
                              "Unsheltered Homeless People in Families","Overall Homeless Family Households",
                              "Sheltered ES Homeless Family Households","Sheltered TH Homeless Family Households",
                              "Sheltered Total Homeless Family Households","Unsheltered Homeless Family Households", 
                              "Overall Chronically Homeless Individuals","Sheltered Total Chronically Homeless Individuals",
                              "Unsheltered Chronically Homeless Individuals","Overall Homeless Veterans","Sheltered Total Homeless Veterans",
                              "Unsheltered Homeless Veterans","Year")),
      selectInput(inputId = 'trello',
                        label = 'Pre-made Trelliscopes',
                        choices = c('Violent Crime over the Years by State', 'Murder over the Years by State',
                                    'Rape over the Years by State', 'Robbery over the Years by State', 
                                    'Aggravated Assailt over the Years by State', 
                                    'Property Crime over the Years by State', 'Burglary over the Years by State', 
                                    'Theft over the Years by State', 'Motor Vehicle Theft over the Years by State',
                                    'Arson over the Years by State')),
      actionButton(inputId = 'view_trells',
                   label = "View"), ## view_trells 
      h3('Create your own trelliscope'),
      textInput(inputId = 'x-axis',
                  label = 'X-Axis'),
      textInput(inputId = 'y-axis',
                label = 'Y-Axis'),
      textInput(inputId = 'facet',
                label = 'Facet By'),
      textInput(inputId = 'save_trell',
                label = 'Name to Save'),
      actionButton(inputId = 'trells',
                   label = 'Create Trelliscope')
    ), # sidebarPanel
     
    mainPanel(
      withSpinner(trelliscopeOutput(outputId = 'plot')),
      textOutput(outputId = 'trelliscope')
    ) # mainPanel
  ) # sidebarLayout
) # fluidPage

server <- function(input, output, session) {
  observeEvent(input$view_trells, {
    showModal(modalDialog(title = 'Link to Trelliscope:',
                          helpText(a('Click the link to view trelliscope', 
                                     href = paste0('file:///Users/Becca/Documents/Data%20Consulting/shiny trelliscope/create_url/www/index.html#display=', input$trello, '&nrow=2&ncol=2&arr=row&pg=1&labels=state&sort=state;asc&filter=&sidebar=-1&fv=',
                                                   target = 'blank'))),
              easyClose = TRUE))
    })
  }
  
  observeEvent(input$trells, {
    ## when the button is clicked, create the trelliscope in the shiny app
    output$plot <- renderTrelliscope({
      input$trells
      
      x_axis <<- input$x-axis
      y_axis <<- input$y-axis
      facet <<- input$facet
      save <<- input$save_trell
      
      trell <- ggplot(data = full, aes_string(x = x_axis, y = y_axis)) +
        geom_line() +
        geom_point() +
        theme_bw() +
        ylab(isolate(y_axis)) +
        facet_trelliscope(~ facet, nrow = 2, ncol = 2, name = save, 
                        path = '/Users/Becca/Documents/Data Consulting/shiny trelliscope/create_url/www')
      return(trell)
      
     # showModal(modalDialog(title = 'Link to New Trelliscope:',
    ##                        helpText(a('Click the link to view your trelliscope', 
    #                                 href = paste0('file:///Users/Becca/Documents/Data%20Consulting/shiny trelliscope/create_url/www/index.html#display=', isolate(input$save_trell), '&nrow=2&ncol=2&arr=row&pg=1&labels=state&sort=state;asc&filter=&sidebar=-1&fv=',
    #                                                 target = 'blank'))),
    #                        easyClose = TRUE))
  # trell
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
