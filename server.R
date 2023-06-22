library(data.table)
library(randomForest)

# Read in the RF model
model <- readRDS("model.rds")

server <- function(input, output) {

  # Define the function that will process the file
  generate <- function(featureFile) {
    #load RF model
    load("RF.model.Mar2023.dat")
    model = models[["full"]]
    #dat = read_table2(featureFile)
    dat = read.table(featureFile,header =T, as.is =T)
    pred_persistent <- predict(model, dat,  type='prob')
    pred_persistent

    #return(paste("File processed: ", featureFile))
  }


   observeEvent(input$process, {
    if (is.null(input$file)) return(NULL)
    shinyjs::disable("process")
    # notify the user that the file is being processed
    showModal(modalDialog(
      title = "Please wait",
      "Your file is being processed ...",
      easyClose = FALSE
    ))

    # Read the file
    inFile <- input$file
    result <- generate(inFile$datapath)
    unlink(inFile$datapath)
    # Update the result output
    output$result <- renderPrint({
      result
    })

    # Re-enable the process button
    shinyjs::enable("process")

    # Remove the modal dialog
    removeModal()
  })
}
# 
# 
# shinyServer(function(input, output, session) {
# 
#   # Input Data
#   datasetInput <- reactive({
# 
#     df <- data.frame(
#       Name = c("Sepal Length",
#                "Sepal Width",
#                "Petal Length",
#                "Petal Width"),
#       Value = as.character(c(input$Sepal.Length,
#                              input$Sepal.Width,
#                              input$Petal.Length,
#                              input$Petal.Width)),
#       stringsAsFactors = FALSE)
# 
#     Species <- 0
#     df <- rbind(df, Species)
#     input <- transpose(df)
#     write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
# 
#     test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
# 
#     Output <- data.frame(Prediction=predict(model,test), round(predict(model,test,type="prob"), 3))
#     print(Output)
# 
#   })
# 
#   # Status/Output Text Box
#   output$contents <- renderPrint({
#     if (input$submitbutton>0) {
#       isolate("Calculation complete.")
#     } else {
#       return("Server is ready for calculation.")
#     }
#   })
# 
#   # Prediction results table
#   output$tabledata <- renderTable({
#     if (input$submitbutton>0) {
#       isolate(datasetInput())
#     }
#   })
# 
# })
