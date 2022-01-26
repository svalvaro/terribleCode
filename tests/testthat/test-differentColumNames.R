testthat::test_that("The function is recognises different
                    combinations of prices + currency ", {

    # Four data frames with different combinations of a column name.
    df1 <- data.frame(
        product = c('SmartWatch', 'laptop', 'monitor'),
        price_USD = c(249, 517 ,319)
    )

    df2 <- data.frame(
        product = c('SmartWatch', 'laptop', 'monitor'),
        price.USD = c(249, 517 ,319)
    )

    df3 <- data.frame(
        product = c('SmartWatch', 'laptop', 'monitor'),
        USD_price = c(249, 517 ,319)
    )

    df4 <- data.frame(
        product = c('SmartWatch', 'laptop', 'monitor'),
        USD.price = c(249, 517 ,319)
    )

    # Expected price for a USD discount of 25 %
    price_manual <- (249+517+319)*0.75


    # Test that the total_price for the four data frames is the same
    testthat::expect_equal(
        object = total_price(df1, currency = 'USD'),
        expected = price_manual
    )
    testthat::expect_equal(
        object = total_price(df2, currency = 'USD'),
        expected = price_manual
    )
    testthat::expect_equal(
        object = total_price(df3, currency = 'USD'),
        expected = price_manual
    )
    testthat::expect_equal(
        object = total_price(df4, currency = 'USD'),
        expected = price_manual
    )
})
