library(randomForest)
library(shiny)


options(shiny.maxRequestSize = 9* 1024^2)
# Read in the RF model


server <- function(input, output) {
    is_processing <- reactiveVal(FALSE)
    output$is_processing <- reactive({
        is_processing()
    })
    outputOptions(output, "is_processing", suspendWhenHidden = FALSE)
    # Define the function that will process the file
    generate <- function(featureFile) {
        #load RF model
        load("RF.model.Mar2023.dat")
        model = models[["full"]]
        #dat = read_table2(featureFile)
        dat = read.table(featureFile,header =T, as.is =T)
        pred_persistent <- predict(model, dat,  type='prob')
        pred_persistent [, 2]
    }

    observeEvent(input$process, {
        if (is.null(input$file)) return(NULL)
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
        # Set is_processing back to FALSE
        is_processing(FALSE)
    })
}

