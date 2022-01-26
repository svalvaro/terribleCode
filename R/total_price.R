#' Calculates the price of an order of electronics.
#'
#' @param order is data frame of electronic products.
#' Products have prices in different currencies.
#' @param currency Currency of interest.
#'
#' @importFrom  dplyr select contains
#'
#' @return Sum of all products’ prices from the given order,
#' after applying a discount.
#'
#' @export
#'
#' @examples
total_price <- function(order, currency = "EUR") {

    # Check if order is a data.frame as expected. Stop if not.

    stopifnot('Data provided is not a data.frame' = is.data.frame(order))

    # Discount will be applied only to EUR and USD, on black friday is 50%

    if (Sys.Date() == as.Date("2020-11-27")) {
        discount <- 0.5
    } else if (currency == "EUR") {
        discount <- 0.2
    } else if (currency == "USD") {
        discount <- 0.25
    } else {
        discount <- 0
    }

    # Select the Column of interest first depending on the currency:
    # This selection is more robust since it will select:
    # price_USD, price.USD, price_USD, USD_price, USD...price, and more.

    currency_column <- dplyr::select(
        order,
        dplyr::contains('price') & dplyr::contains(currency)
    )

    # It is possible that the user provided a wrong currency or that the column
    # is just not present.

    if (length(currency_column) == 0) {
        stop('The prices for the provided currency were not found.')
    }

    # If there are strings in the column such as 'none' or 'unknown',
    # the real prices will be read as a string as well.
    # To solve that:

    suppressWarnings(
        currency_column <- as.integer(currency_column[,1])
    )

    # Keep only positive values from that column:

    currency_column <- currency_column[currency_column > 0]

    # Remove all non-integers (NAs, possible text)

    clean_currency_column <- currency_column[!is.na(currency_column)]

    # Sum the prices

    sum_prices <- sum(clean_currency_column)

    # Apply the discount if any

    total <- sum_prices * (1 - discount)

    return(total)
}
