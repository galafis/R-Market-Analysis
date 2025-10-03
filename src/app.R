library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Análise de Mercado Financeiro"),
  sidebarLayout(
    sidebarPanel(
      helpText("Selecione uma ação para visualizar a análise."),
      selectInput("stock", 
                  label = "Escolha uma Ação:",
                  choices = c("AAPL", "GOOGL", "MSFT", "AMZN"),
                  selected = "AAPL"),
      sliderInput("period", 
                  label = "Período (dias):",
                  min = 30, max = 365, value = 90)
    ),
    mainPanel(
      plotOutput("stockPlot"),
      h4("Resumo da Análise"),
      verbatimTextOutput("summary")
    )
  )
)

server <- function(input, output) {
  
  # Dados simulados para demonstração
  get_stock_data <- reactive({
    req(input$stock, input$period)
    set.seed(123)
    dates <- seq(Sys.Date() - input$period, Sys.Date(), by = "day")
    prices <- cumprod(1 + rnorm(length(dates), mean = 0.001, sd = 0.01)) * 100
    data.frame(Date = dates, Price = prices)
  })
  
  output$stockPlot <- renderPlot({
    data <- get_stock_data()
    ggplot(data, aes(x = Date, y = Price)) +
      geom_line(color = "steelblue") +
      labs(title = paste("Preço da Ação de", input$stock), y = "Preço", x = "Data") +
      theme_minimal()
  })
  
  output$summary <- renderPrint({
    data <- get_stock_data()
    summary(data$Price)
  })
}

shinyApp(ui = ui, server = server)

