library(quantmod)
library(ggplot2)
library(dplyr)

# Função para obter dados históricos de ações
get_stock_data <- function(symbol, from_date, to_date) {
  getSymbols(symbol, src = "yahoo", from = from_date, to = to_date, auto.assign = FALSE)
}

# Função para calcular retornos diários
calculate_daily_returns <- function(stock_data) {
  dailyReturn(stock_data)
}

# Função para plotar preços de fechamento ajustados
plot_adjusted_close <- function(stock_data, symbol) {
  chartSeries(stock_data, name = symbol, theme = "white", type = "line")
}

# Função para realizar uma análise de média móvel simples
add_simple_moving_average <- function(stock_data, n = 20) {
  addSMA(n = n, on = 1, col = "blue")
}

# Função para realizar uma análise de média móvel exponencial
add_exponential_moving_average <- function(stock_data, n = 20) {
  addEMA(n = n, on = 1, col = "red")
}

# Função para calcular e plotar o RSI
add_rsi <- function(stock_data, n = 14) {
  addRSI(n = n, maType = "EMA")
}

# Função para calcular e plotar o MACD
add_macd <- function(stock_data, fast = 12, slow = 26, signal = 9) {
  addMACD(fast = fast, slow = slow, signal = signal)
}

