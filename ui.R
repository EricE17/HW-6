
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


shinyUI(fluidPage(
  
# Application title
  titlePanel("Climate Data Application"),
  
# Sidebar with user input controls
  sidebarLayout( 
    sidebarPanel( selectInput(inputId='site', 
                              label='Choose SNOTEL Site', 
                              choices=unique(snoteldata$Station), 
                              selected = NULL, 
                              multiple = FALSE,
                              selectize = TRUE, 
                              width = NULL, 
                              size = NULL),
# selectInput
#                  selectInput(inputId='rcp', 
#                              label='Choose RCP', 
#                              choices=c('RCP2_6', 'RCP4_5', 'RCP6_0', 'RCP8_5'), 
#                              selected = NULL, 
#                              multiple = FALSE,
#                              selectize = TRUE, 
#                              width = NULL, 
#                              size = NULL),
                  radioButtons(inputId = 'rcp',
                               label = "Choose RCP:",
                               choices = c('RCP2_6', 'RCP4_5', 'RCP6_0', 'RCP8_5'),
                               inline = TRUE,
                               selected = NULL),
  
# Copy the line below to make a date range selector
                  dateRangeInput("futuredates", label = "Future Date Range" ,
                                 start  = "2044-01-01",
                                 end    = "2056-12-31",
                                 min    = "2044-01-01",
                                 max    = "2056-12-31",
                                 format = "mm/dd/yy",
                                 separator = " - "),

#check box for future data                               
    checkboxInput("checkbox", label = "Display Observed Data", value = FALSE),

#submit button
    submitButton("Submit"),
    
    
#      Notes to user  
        helpText("Note:while the data view only shows", style = "color:red",
             "the specified number of observations based on future data range, the",
             "summary is based on the full dataset.")
    
  ),
  
  # Show outputs, text, etc. in the main panel
  mainPanel(
    h3(strong("User Guidlines"),style = "color:blue"),
    h5("Step 1: Choose a Site",style = "color:blue"),
    h5("Step 2: Choose one of the four RCPs",style = "color:blue"),
    h5("Step 3: Select a Future Data Range",style = "color:blue"),
    h5("Step 4: Check Display Observed Data",style = "color:blue"),
    h5("Step 5: Press the Submit Button",style = "color:blue"),

    # Output: Tabset w/ plot, summary, and table ----
    tabsetPanel(type = "tabs",
                tabPanel("Plot", plotOutput("futureplot")),
                tabPanel("Notes", plotOutput("Notes"))
    ),
                
    #Text to follow below mainPanel   
    textOutput("selected_rcp"),
    textOutput("summaryresults")
  )
)
))
