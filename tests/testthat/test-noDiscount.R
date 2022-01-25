testthat::test_that("The function does not give discount in other currencies", {

    # It is especified that only the USD and EUR get a 25% and 20% discount

    df <- data.frame(
        product = c('SmartWatch', 'laptop', 'monitor'),
        price_CZK = c(6121, 12760, 7842)
    )

    # Expected price for without any discount applied
    price_manual <- (6121+12760+7842)

    testthat::expect_equal(
        object = total_price(df, currency = 'CZK'),
        expected = price_manual
    )
})
