testthat::test_that("The function computes properly messy data", {

    # A data frame containing one missing value
    df <- data.frame(
        product = c('SmartWatch', 'laptop', 'monitor', 'headphones', 'printer'),
        price_EUR = c(217, -517 ,'319', 'unknown price', 110)
    )

    # Expected price for a EUR discount of 20 %
    price_manual <- (217+110+319)*0.80

    testthat::expect_equal(
        object = total_price(df, currency = 'EUR'),
        expected = price_manual
    )
})
