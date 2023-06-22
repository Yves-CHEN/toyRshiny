library(shiny)

ui <- fluidPage(
  # Create a file input component to upload the file
  fileInput("file", "Upload your file",
            accept = c(
              "text/csv",
              "text/comma-separated-values,text/plain",
              ".gz",
              ".csv")
            ),
  # Create a button to trigger the processing
  actionButton("process", "Process the file"),

  # Create an area to show the results
  verbatimTextOutput("result")
)

#
#
## Training set
#TrainSet <- read.csv("training.csv", header = TRUE)
#TrainSet <- TrainSet[,-1]
#
#pageWithSidebar(
#
#  # Page header
#  headerPanel('Iris Predictor'),
#
#  # Input values
#  sidebarPanel(
#    HTML("<h3>Input parameters</h4>"),
#    sliderInput("Sepal.Length", label = "Sepal Length", value = 5.0,
#                min = min(TrainSet$Sepal.Length),
#                max = max(TrainSet$Sepal.Length)
#    ),
#    sliderInput("Sepal.Width", label = "Sepal Width", value = 3.6,
#                min = min(TrainSet$Sepal.Width),
#                max = max(TrainSet$Sepal.Width)),
#    sliderInput("Petal.Length", label = "Petal Length", value = 1.4,
#                min = min(TrainSet$Petal.Length),
#                max = max(TrainSet$Petal.Length)),
#    sliderInput("Petal.Width", label = "Petal Width", value = 0.2,
#                min = min(TrainSet$Petal.Width),
#                max = max(TrainSet$Petal.Width)),
#
#    actionButton("submitbutton", "Submit", class = "btn btn-primary")
#  ),
#
#  mainPanel(
#    tags$label(h3('Status/Output')), # Status/Output Text Box
#    verbatimTextOutput('contents'),
#    tableOutput('tabledata') # Prediction results table
#
#  )
#)
