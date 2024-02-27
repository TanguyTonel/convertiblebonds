#4
# Function to calculate the price of a convertible bond using Black-Scholes Model
convertible_bond_price <- function(S, X, r, T, sigma, V, t = 0) {
  d1 <- (log(S / X) + (r + 0.5 * sigma^2) * (T - t)) / (sigma * sqrt(T - t))
  d2 <- d1 - sigma * sqrt(T - t)
  
  bond_value <- V * exp(-r * (T - t))
  equity_value <- S * pnorm(d1) - X * exp(-r * (T - t)) * pnorm(d2)
  
  convertible_price <- bond_value + equity_value
  
  return(convertible_price)
}

# Example usage
# Current stock price
S <- 100
# Conversion price
X <- 90
# Risk-free interest rate (annual)
r <- 0.05
# Time to maturity (in years)
T <- 2
# Volatility of the underlying stock (annual)
sigma <- 0.2
# Par value of the bond
V <- 1000

# Calculate the price of the convertible bond
price <- convertible_bond_price(S, X, r, T, sigma, V)
print(paste("Convertible bond price:", round(price, 2)))