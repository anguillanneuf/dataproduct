library(shiny)

# Plotting
library(RColorBrewer); library(pheatmap); library(grid)

# Markdown
library(markdown)

# RenderDataTable
library(DT)

# After consulting in the Discussion Forum, I commented the codes used
# to simulate TV audience data.

# # Simulate a dataset with 50 TV shows of diffferent age and gender skew
#
# set.seed(1234)
#
# # Make sure all the numerical information is positive
#
# positives <- function(mn, std){
#       v <- rnorm(50, mn, std)
#       nb <- sum(v<0)
#       while (nb>0) {
#             v[v<0] <- rnorm(nb, mn, std)
#             nb <- sum(v<0)
#       }
#       v
# }
#
# data <- cbind(positives(4.88, 2.97), positives(7.53, 5.50),
#                  positives(17.79, 6.30), positives(23.96, 8.30),
#                  positives(4.86, 2.71), positives(10.64, 5.19),
#                  positives(25.41, 4.89), positives(39.43, 12.84))
#
# colnames(data) <- paste(rep(c("m", "f"), each=4),
#                         rep(c("2to17", "18to34", "35to54", "55to99")), sep="")
#
# rownames(data) <- paste("show", rep(1:50), sep=" ")
#
# save(data, file = "./data/data.RData")


# Load simulated TV audience data from the data file

load(file = "./data/data.RData")

# Set the color scheme of the heatmap

cc <- rev(brewer.pal(n = 11, name = "RdYlBu"))
pal <- colorRampPalette(cc)

# Define server logic required to generate the dendrogram-cum-heatmap

shinyServer(
        function(input, output){

        # Prepare data: update the dataset with user input data

        dataNew <- reactive({

                # User has to input a show name

                if (input$newshow != ""){
                v <- c(input$m2to17, input$m18to34, input$m35to54, input$m55to99,
                  input$f2to17, input$f18to34, input$f35to54, input$f55to99)
                new <- rbind(data,v)
                rownames(new)[51] <- input$newshow
                new
                }

                # Default plot without user input values
                else {data}
        })

        # Render plot: hierarchical clustering method

        output$dendro_heat <- renderPlot({
                pheatmap(dataNew(),
                         cluster_cols = FALSE,
                         color = pal(200),
                         treeheight_row = 200,
                         cellheight = 15,
                         border_color = "white",
                         main = "TV Programs Age/Gender Intel",
                         display_numbers=FALSE)
        }, height = 980)

        # Render data table and create download handler

        output$table <- renderDataTable(
                {dataNew()}, option=list(bFilter=FALSE, iDisplayLength=20))

        output$downloadData <- downloadHandler(
                filename = 'data.csv',
                content = function(file){
                        write.csv(dataNew(), file, row.names=TRUE)
                }
        )

}
)