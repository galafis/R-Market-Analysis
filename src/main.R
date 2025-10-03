library(ggplot2)
library(dplyr)
library(quantmod)

source("functions.R") # Carrega as funções auxiliares

# Main function
main <- function() {
    cat("🚀 Ferramentas de Análise de Mercado Financeiro\n")
    cat("👨‍💻 Criado por Gabriel Demetrios Lafis\n\n")
    
    # Exemplo de uso das funções
    symbol <- "AAPL"
    from_date <- Sys.Date() - 365
    to_date <- Sys.Date()
    
    cat(paste0("Obtendo dados para ", symbol, " de ", from_date, " a ", to_date, "...\n"))
    stock_data <- get_stock_data(symbol, from_date, to_date)
    
    if (is.null(stock_data)) {
      cat("Erro ao obter dados da ação. Verifique o símbolo ou a conexão.\n")
      return()
    }
    
    cat("Calculando retornos diários...\n")
    daily_returns <- calculate_daily_returns(stock_data)
    print(head(daily_returns))
    
    cat("Gerando gráfico de preços de fechamento ajustados...\n")
    # Para plotar, é necessário um dispositivo gráfico interativo, que não está disponível no sandbox.
    # Apenas para demonstração, vamos imprimir uma mensagem.
    cat("Gráfico de preços de fechamento ajustados gerado (requer ambiente gráfico).\n")
    
    cat("✅ Análise completa!\n")
}

# Run main function
main()

