# Install and load the RQuantLib package
install.packages("RQuantLib")
library(RQuantLib)

# Set parameters
todays_date <- as.Date("2022-01-01")
expiry_date <- as.Date("2024-01-01")
face_value <- 1000
stock_price <- 100
conversion_ratio <- 5
volatility <- 0.2
risk_free_rate <- 0.03

# Create QuantLib date objects
todays_date_ql <- as.Date(todays_date)
expiry_date_ql <- as.Date(expiry_date)

# Set up QuantLib handles
flat_rate <- 0.03
rate_handle <- list(flat = flat_rate)
flat_vol <- volatility
vol_handle <- list(flat = flat_vol)

# Set up the convertible bond
convertible_bond <- list(
  maturityDate = expiry_date_ql,
  faceAmount = face_value,
  issueDate = todays_date_ql,
  exercise = EuropeanOption(type = "call", maturity = expiry_date_ql),
  underlyingId = "underlying",
  conversionRatio = conversion_ratio
)

# Price the convertible bond
bond_price <- bondOptionAnalysis(
  quote = stock_price,
  underlying_id = "underlying",
  option = convertible_bond,
  engine = list(
    AmericanConvertibleBond(
      valuationDate = todays_date_ql,
      riskFreeRate = rate_handle,
      dividendYield = 0,
      volatility = vol_handle
    )
  )
)

# Extract the clean price
clean_price <- bond_price$cleanValue

print(paste("The price of the convertible bond is:", clean_price))