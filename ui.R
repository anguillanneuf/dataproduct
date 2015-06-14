library(shiny)

shinyUI(navbarPage("Smart Competitive Program Scheduler",
                   
                   # Tab 1: About
                   
                   tabPanel("About",
                            
                            mainPanel(
                                    includeMarkdown("include.md")
                            )),
        
                   # Tab 2: Plot and Data Table
                   
                   tabPanel("Plot",
                            
                            sidebarPanel(
                                  textInput("newshow", "New Show Name (necessary)"),
                                  sliderInput("m2to17","Male 2-17 VPVH", value = 5,
                                               min=1, max=16, step=0.1),
                                  sliderInput("m18to34","Male 18-34 VPVH", value = 8,
                                               min=2, max=33, step=0.1),
                                  sliderInput("m35to54","Male 35-54 VPVH", value = 18,
                                               min=7, max=40, step=0.1),
                                  sliderInput("m55to99","Male 55+ VPVH", value = 24,
                                               min=9, max=45, step=0.1),
                                  sliderInput("f2to17","Female 2-17 VPVH", value = 5,
                                               min=1, max=15, step=0.1),
                                  sliderInput("f18to34","Female 18-34 VPVH", value = 11,
                                               min=3, max=29, step=0.1),
                                  sliderInput("f35to54","Female 35-54 VPVH", value = 25,
                                               min=12, max=34, step=0.1),
                                  sliderInput("f55to99","Female 55-99 VPVH", value = 39,
                                               min=7, max=64, step=0.1),
                                  submitButton("Submit")
                            ),
                            
                            mainPanel(
                                   tabsetPanel(
                                           # Plot
                                           tabPanel(p(icon("dendro-heat"), "Plot"),
                                                    plotOutput("dendro_heat")),
                                           
                                           # Data
                                           tabPanel(p(icon("table"), "Data"),
                                                    DT::dataTableOutput(outputId="table"),
                                                    downloadButton("downloadData", "Download"))
                                   )
                            ))

        
))