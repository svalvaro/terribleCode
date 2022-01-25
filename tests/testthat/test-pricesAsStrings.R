testthat::test_that("The function recognises numbers as strings", {

    # A data frame containing one missing value
    df <- data.frame(
        product = c('SmartWatch', 'laptop', 'monitor'),
        price_USD = c('249', '517' ,319)
    )

    # Expected price for a USD discount of 25 %
    price_manual <- (249+319+517)*0.75

    testthat::expect_equal(
        object = total_price(df, currency = 'USD'),
        expected = price_manual
    )
})
