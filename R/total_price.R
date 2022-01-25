#' Calculates the price of
#'
#' @param order is data frame of electronic products.
#' Products have prices in different currencies.
#' @param currency
#'
#' @importFrom  dplyr select
#' @import magrittr
#'
#' @return Sum of all products’ prices from the given order,
#' after applying a discount.
#'
#' @export
#'
#' @examples
total_price <- function(order, currency = "EUR") {

    # Discount to be applied
    discount <- 0

    if (currency == "EUR") {
        discount <- 0.2
    }

    if (currency == "USD") {
        discount <- 0.25
    }

    discount <- ifelse(Sys.Date() == as.Date("2020-11-27"),
                       0.5,
                       discount)

    # Select the Column of interest first depending on the currency:

    currency_column <- order %>% dplyr::select(
        base::paste0("price_", currency)
        )

    # If there are strings in the column such as 'none' or 'unknown' the rest
    # of the column will be real prices will be read as a string. To solve that:

    # Also used suprressWarning to avoid the Warning message

    suppressWarnings(
        currency_column <- base::as.integer(currency_column[,1])
    )

    # Keep only positive values from that column:

    currency_column <- currency_column[currency_column > 0]

    # Remove all non-integers (NAs, possible text)

    clean_currency_column <- currency_column[!is.na(currency_column)]

    total <- (clean_currency_column * (1 - discount)) %>% sum
    return(total)
}
