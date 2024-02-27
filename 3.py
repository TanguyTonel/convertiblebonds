from QuantLib import EuropeanExercise, ConvertibleBond, SimpleQuote, QuoteHandle, YieldTermStructureHandle, BlackVolTermStructureHandle, RelinkableYieldTermStructureHandle, BlackConstantVol, BlackScholesProcess

# Set up QuantLib parameters

def bond_price_calculator(todays_date,expiry_date,face_value,stock_price,conversion_ratio,volatility,risk_free_rate):
    # QuantLib handles
    flat_rate = SimpleQuote(risk_free_rate)
    rate_handle = YieldTermStructureHandle(FlatForward(todays_date, QuoteHandle(flat_rate), Actual360()))
    vol_handle = BlackVolTermStructureHandle(BlackConstantVol(todays_date, UnitedStates(), QuoteHandle(SimpleQuote(volatility)), Actual360()))

    # Set up the convertible bond
    convertible_bond = ConvertibleBond(EuropeanExercise(expiry_date), conversion_ratio, flat_rate, rate_handle, vol_handle)

    # Set up the Black-Scholes process
    bs_process = BlackScholesProcess(QuoteHandle(SimpleQuote(stock_price)), rate_handle, vol_handle)

    # Set up the Black-Scholes calculator
    bs_calculator = BlackScholesCalculator(bs_process)

    # Calculate the convertible bond price
    bond_price = convertible_bond.cleanPrice(bs_calculator)
    return bond_price


todays_date = Date(1, 1, 2022)
expiry_date = Date(1, 1, 2024)
face_value = 1000.0
stock_price = 100.0
conversion_ratio = 5.0
volatility = 0.2
risk_free_rate = 0.03

bond_price = bond_price_calculator(todays_date,expiry_date,face_value,stock_price,conversion_ratio,volatility,risk_free_rate)

print(f"The price of the convertible bond is: {bond_price:.2f}")