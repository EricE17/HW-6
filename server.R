
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


shinyServer(function(input, output) {
  
  futureavg <- reactive({
    futuredata <- subset(prcp_proj,Station==input$site & 
                           Date >= input$futuredates[1] &
                           Date <= input$futuredates[2])
    futuremean <- mean(futuredata[,input$rcp])
    return(futuremean)
  })
  observedavg <- reactive({
    observeddata <- subset(snoteldata,Station==input$site)
    observedmean <- mean(observeddata[,"DailyPrecip"], na.rm = TRUE)
    return(observedmean)
  })
  
  output$selected_rcp <- renderText({
    paste('Viewing climate data at', input$site, 'between',
          input$futuredates[1], 'and', input$futuredates[2], 'for', input$rcp)
  })  
  output$futureplot <- renderPlot({ plotdata <- subset(prcp_proj,Station==input$site &
                                                         Date >= input$futuredates[1] &
                                                         Date <= input$futuredates[2])
  
  output$summaryresults <- renderText({
    paste("Average Observed Precipitation:", observedavg(), "Average Future Precipitation:", futureavg())
  })
  
  
  if (input$checkbox==TRUE){
    
    ggplot()+
      geom_line(data=plotdata, aes(x=plotdata$Date, y=plotdata[,input$rcp]),color='red')+
      geom_line(data=snoteldata, aes(x=Date, y=DailyPrecip), color='black')
  }else{
    
    ggplot()+
      geom_line(data=plotdata,aes(x=plotdata$Date, y=plotdata[,input$rcp]))
  }
  })
})
