library(testthat)
library(quantmod)
library(dplyr)

source("../src/functions.R")

# Mock data for testing
mock_stock_data <- function() {
  data <- data.frame(
    Date = seq(Sys.Date() - 5, Sys.Date(), by = "day"),
    AAPL.Open = c(150, 151, 152, 153, 154, 155),
    AAPL.High = c(152, 153, 154, 155, 156, 157),
    AAPL.Low = c(149, 150, 151, 152, 153, 154),
    AAPL.Close = c(151, 152, 153, 154, 155, 156),
    AAPL.Volume = c(100000, 110000, 120000, 130000, 140000, 150000),
    AAPL.Adjusted = c(151, 152, 153, 154, 155, 156)
  )
  xts_data <- xts(data[,-1], order.by = data$Date)
  colnames(xts_data) <- paste0("AAPL.", c("Open", "High", "Low", "Close", "Volume", "Adjusted"))
  return(xts_data)
}

# Test suite for functions.R
test_that("get_stock_data returns xts object", {
  # This test requires internet access to fetch real data
  # For a true unit test, one would mock the getSymbols call
  # For now, we'll test with a known symbol and expect an xts object
  stock_data <- get_stock_data("AAPL", Sys.Date() - 10, Sys.Date())
  expect_s3_class(stock_data, "xts")
  expect_true(NROW(stock_data) > 0)
})

test_that("calculate_daily_returns returns xts object of daily returns", {
  data <- mock_stock_data()
  returns <- calculate_daily_returns(data)
  expect_s3_class(returns, "xts")
  expect_true(NROW(returns) > 0)
  expect_true(all(is.numeric(returns)))
})

# Test for plot_adjusted_close is difficult in a headless environment
# test_that("plot_adjusted_close generates a plot", {
#   data <- mock_stock_data()
#   # This would typically involve checking for side effects like a plot being drawn
#   # or capturing a plot object, which is complex in a non-interactive R session.
#   # For now, we'll skip direct testing of plot generation.
#   expect_silent(plot_adjusted_close(data, "AAPL"))
# })

# Tests for add_simple_moving_average, add_exponential_moving_average, add_rsi, add_macd
# These functions modify the chartSeries object, which is not directly testable here.
# Their correctness would be verified by visual inspection of the plots or by checking
# the underlying data structures if they returned them.

cat("All tests completed (some plotting tests skipped due to headless environment).\n")

